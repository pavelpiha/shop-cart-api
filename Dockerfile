FROM node:14-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm install && npm cache clean --force
COPY . .
RUN npm run build

FROM node:14-alpine
ENV NODE_ENV=production
WORKDIR /app
COPY --from=build app/package*.json ./
RUN npm install
COPY --from=build app/dist ./dist/
ENV PORT=4000
EXPOSE 4000
CMD ["node", "./dist/main.js"]
