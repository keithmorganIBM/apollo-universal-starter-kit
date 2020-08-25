FROM node:10.15.3-alpine

RUN apk update
RUN apk add --no-cache tini git yarn

WORKDIR /home/node/app

ARG APP_DIR

RUN mkdir -p ${APP_DIR}/home/node/build && \
    mkdir -p ${APP_DIR}/home/node/node_modules && \
    mkdir -p ${APP_DIR}/home/node/.cache/yarn && \
    chown node:node -R ${APP_DIR} /home/node

ENV NODE_ENV="development"

RUN cd /home/node/app && yarn && yarn seed
RUN pwd
RUN ls -al

EXPOSE 3000

ENTRYPOINT ["/sbin/tini", "--"]

USER node
CMD ["yarn", "start"]
