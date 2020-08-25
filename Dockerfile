FROM node:10.15.3-alpine

RUN apk update
RUN apk add --no-cache tini git yarn

ARG APP_DIR

RUN mkdir -p ${APP_DIR}/build && \
    mkdir -p ${APP_DIR}/node_modules && \
    mkdir -p /home/node/.cache/yarn && \
    chown node:node -R ${APP_DIR} /home/node

ENV NODE_ENV="development"
RUN yarn && yarn seed

EXPOSE 3000

ENTRYPOINT ["/sbin/tini", "--"]

USER node
CMD ["yarn", "start"]
