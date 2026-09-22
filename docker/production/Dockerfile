# ============================================
# SUMO BACKEND - PRODUCTION
# ============================================

# Change Node version according to your project
FROM node:20-alpine

# Application directory
WORKDIR /app

# Copy package files
COPY backend/package*.json ./

# Install production dependencies only
RUN npm ci --omit=dev

# Copy application source
COPY backend/ .

# Application port
EXPOSE 7050

# Production environment
ENV NODE_ENV=production

# Start application
CMD ["npm", "start"]