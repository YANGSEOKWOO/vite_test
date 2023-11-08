# Build stage
FROM krmp-d2hub-idock.9rum.cc/goorm/node:16 AS build
WORKDIR /usr/src/app
COPY krampoline/package*.json ./
RUN yarn install --immutable --immutable-cache --check-cache  # npm ci 대신 yarn install --frozen-lockfile 사용
COPY krampoline/ ./
RUN yarn build  # npm run build 대신 yarn build 사용

# Run stage
FROM krmp-d2hub-idock.9rum.cc/goorm/node:16
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/dist ./dist
RUN yarn global add serve  # npm install -g serve 대신 yarn global add serve 사용
EXPOSE 5173
CMD ["serve", "-s", "dist"]
