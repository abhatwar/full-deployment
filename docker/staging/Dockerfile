# ============================================
# SUMO BACKEND - STAGING
# ============================================

# Change Node version according to your project
FROM node:20-alpine

# Application directory
WORKDIR /app

# Copy package files
COPY backend/package*.json ./

# Install dependencies
RUN npm ci

# Copy application source
COPY backend/ .

# Application port
EXPOSE 7050

# Staging environment
ENV NODE_ENV=staging

# Start application
CMD ["npm", "start"]