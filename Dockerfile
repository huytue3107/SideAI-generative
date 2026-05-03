FROM node:20-alpine AS base
WORKDIR /app

# Install dependencies
FROM base AS deps
COPY package*.json ./
COPY packages/sideai-workflow/packages/workflow-builder/package*.json ./packages/sideai-workflow/packages/workflow-builder/
COPY packages/sideai-agents/packages/agents/package*.json ./packages/sideai-agents/packages/agents/
COPY packages/studio/package*.json ./packages/studio/
RUN npm install

# Build sub-packages
FROM deps AS builder
COPY . .
RUN npm run build:packages
RUN npm run build

# Production runner
FROM base AS runner
ENV NODE_ENV=production
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

EXPOSE 3000
CMD ["npm", "start"]
