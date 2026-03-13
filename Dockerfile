FROM node:20-alpine  AS build

WORKDIR /app 

COPY package*.json ./ 



RUN npm ci  --omit=dev

COPY . .

FROM node:20-alpine 

RUN apk add --no-cache curl 
WORKDIR /app 

RUN addgroup -S appgroup && adduser -S appuser -G appgroup 



COPY --from=build /app/node_modules ./node_modules 
COPY --from=build  /app .

RUN chown -R appuser:appgroup /app
USER appuser 

EXPOSE 3000 
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD curl -f http://localhost:3000/health || exit 1

CMD ["node", "app.js"]