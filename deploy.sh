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
AWS_ACCOUNT_ID="123456789012"
ECR_REPOSITORY="sumo-backend"
IMAGE_NAME="sumo-backend"

if [[ "$ACTION" == "deploy" ]]; then
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
    .

  aws ecr get-login-password --region "${AWS_REGION}" \
    | docker login --username AWS --password-stdin "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

  IMAGE_URI="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}:${IMAGE_TAG}"
  docker tag "${IMAGE_NAME}:${IMAGE_TAG}" "$IMAGE_URI"
  docker push "$IMAGE_URI"

  if [[ ! -d "kubernative/overlays/${ENVIRONMENT}" ]]; then
    echo "Kubernetes overlay not found: kubernative/overlays/${ENVIRONMENT}"
    exit 1
  fi

  kubectl apply -k "kubernative/overlays/${ENVIRONMENT}"
  kubectl rollout status deployment/sumo-backend --timeout=180s

  echo "Deployment for ${ENVIRONMENT} completed successfully."
else
  echo "========================================"
  echo "Rolling back environment: ${ENVIRONMENT}"
  echo "========================================"

  kubectl rollout undo deployment/sumo-backend
  kubectl rollout status deployment/sumo-backend --timeout=180s

  echo "Rollback for ${ENVIRONMENT} completed successfully."
fi
