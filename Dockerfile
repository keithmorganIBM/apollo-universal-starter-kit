FROM node:10.15.3-alpine

RUN apk update
RUN apk add --no-cache tini git

WORKDIR /home/node/app

COPY ./ .

RUN mkdir -p  build && \
    mkdir -p  node_modules && \
    mkdir -p  ./.cache/yarn && \
    chown node:node -R ${APP_DIR} /home/node

ENV NODE_ENV="development"
USER node

RUN pwd
RUN ls -al
RUN yarn && yarn seed

EXPOSE 3000

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["yarn", "start"]
