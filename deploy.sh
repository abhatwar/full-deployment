#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

ENVIRONMENT="${1:-staging}"
ACTION="${2:-deploy}"

if [[ "$ENVIRONMENT" != "staging" && "$ENVIRONMENT" != "production" ]]; then
  echo "Usage: ./deploy.sh [staging|production] [deploy|rollback]"
  exit 1
fi

if [[ "$ACTION" != "deploy" && "$ACTION" != "rollback" ]]; then
  echo "Usage: ./deploy.sh [staging|production] [deploy|rollback]"
  exit 1
fi

AWS_REGION="ap-south-1"
PROJECT_NAME="nearby"
ECR_REPOSITORY="${PROJECT_NAME}-${ENVIRONMENT}"
EKS_CLUSTER_NAME="${PROJECT_NAME}-${ENVIRONMENT}-eks"
IMAGE_NAME="nearby-backend"
APP_DIR="${APP_DIR:-.}"

if [[ "$ACTION" == "deploy" ]]; then
  # AWS CLI credentials must be configured on the runner; never put access keys in this script.
  AWS_ACCOUNT_ID="${AWS_ACCOUNT_ID:-$(aws sts get-caller-identity \
    --region "$AWS_REGION" \
    --query Account \
    --output text)}"

  if [[ ! "$AWS_ACCOUNT_ID" =~ ^[0-9]{12}$ ]]; then
    echo "AWS_ACCOUNT_ID must be a 12-digit AWS account ID."
    exit 1
  fi

  IMAGE_TAG="${ENVIRONMENT}-$(date +%Y%m%d-%H%M%S)"

  echo "========================================"
  echo "Deploying environment: ${ENVIRONMENT}"
  echo "Image tag: ${IMAGE_TAG}"
  echo "========================================"

  if [[ ! -f "docker/${ENVIRONMENT}/Dockerfile" ]]; then
    echo "Dockerfile not found: docker/${ENVIRONMENT}/Dockerfile"
    exit 1
  fi

  docker build \
    -f "docker/${ENVIRONMENT}/Dockerfile" \
    -t "${IMAGE_NAME}:${IMAGE_TAG}" \
    "${APP_DIR}"

  aws ecr get-login-password --region "${AWS_REGION}" \
    | docker login --username AWS --password-stdin "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

  IMAGE_URI="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}:${IMAGE_TAG}"
  docker tag "${IMAGE_NAME}:${IMAGE_TAG}" "$IMAGE_URI"
  docker push "$IMAGE_URI"

  if [[ ! -d "kubernative/overlays/${ENVIRONMENT}" ]]; then
    echo "Kubernetes overlay not found: kubernative/overlays/${ENVIRONMENT}"
    exit 1
  fi

  aws eks update-kubeconfig \
    --region "$AWS_REGION" \
    --name "$EKS_CLUSTER_NAME"

  kubectl kustomize --load-restrictor LoadRestrictionsNone \
    "kubernative/overlays/${ENVIRONMENT}" \
    | kubectl apply -f -
  kubectl set image deployment/nearby-backend \
    "nearby-backend=${IMAGE_URI}"
  kubectl rollout status deployment/nearby-backend --timeout=180s

  echo "Deployment for ${ENVIRONMENT} completed successfully."
else
  echo "========================================"
  echo "Rolling back environment: ${ENVIRONMENT}"
  echo "========================================"

  kubectl rollout undo deployment/nearby-backend
  kubectl rollout status deployment/nearby-backend --timeout=180s

  echo "Rollback for ${ENVIRONMENT} completed successfully."
fi
