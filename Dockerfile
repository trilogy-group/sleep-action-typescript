ARG WORKSPACE_DIR="/workspace/invocables-typescript"
ARG RUNTIME_DIR="/workspace/invocables-typescript/.devflows"

FROM node:12-buster as build-image
ARG WORKSPACE_DIR
RUN mkdir -p ${WORKSPACE_DIR}
RUN apt-get update && \
    apt-get install -y \
    g++ \
    make \
    cmake \
    unzip \
    libcurl4-openssl-dev 
WORKDIR ${WORKSPACE_DIR}
COPY package.json ./package.json
RUN npm install aws-lambda-ric@1.1.0
RUN npm install node-fetch@2.6.1
RUN npm install
RUN ls

FROM node:12-buster
RUN npm i -g typescript@4.3.5 ts-node
ARG WORKSPACE_DIR
ARG RUNTIME_DIR
WORKDIR ${WORKSPACE_DIR}
COPY --from=build-image ${WORKSPACE_DIR} ${WORKSPACE_DIR}
RUN npm i -D express@4.17.1 @types/node@14.14.31 @types/express@4.17.13
RUN npm i aws-sdk
RUN apt-get update && \
    apt-get install -y \
    curl \
    jq \
    redis-tools
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install
COPY . .
RUN tsc
RUN tsc .devflows/*.ts
RUN chmod 755 ./.devflows/mini-proxy
RUN chmod 755 ./.devflows/entry.sh
# Add an extension from the local directory into /opt
COPY ./.devflows/extensions/ /opt/extensions/
RUN chmod -R 755 /opt/extensions/logs-extension
WORKDIR ${RUNTIME_DIR}
EXPOSE 8000
ENTRYPOINT ["./entry.sh"]
CMD ["echo"]

