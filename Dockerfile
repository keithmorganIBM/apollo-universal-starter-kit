FROM node:10.15.3-alpine

##RUN apk add --no-cache tini git

USER node

ARG APP_DIR
ENV PORT="${PORT:-8080}"
ENV NODE_ENV="development"

RUN mkdir -p ${APP_DIR}/build && \
    mkdir -p ${APP_DIR}/node_modules && \
    mkdir -p /home/node/.cache/yarn && \
    chown node:node -R ${APP_DIR} /home/node && \
    yarn && \
    (test -f dev-db.sqlite3 || yarn seed)

EXPOSE "${PORT}"
CMD ["yarn watch"]
