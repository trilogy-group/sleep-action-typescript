#!/bin/bash

IMAGE_TAG='main-local-arm64'
ECR_REGISTRY='346945241475.dkr.ecr.us-east-1.amazonaws.com'
ECR_REPOSITORY='devflows/trilogy-group/sleep-action-typescript'

export AWS_PROFILE=saml

aws s3 cp s3://devflows-function-framework/typescript/.dockerignore ./.devflows/.dockerignore
aws s3 cp s3://devflows-function-framework/typescript/entry.sh ./.devflows/entry.sh
aws s3 cp s3://devflows-function-framework/typescript/init.sh ./.devflows/init.sh
aws s3 cp s3://devflows-function-framework/typescript/server.ts ./.devflows/server.ts
aws s3 cp s3://devflows-function-framework/typescript/action-server.ts ./.devflows/action-server.ts
aws s3 cp s3://devflows-function-framework/typescript/index.ts ./.devflows/index.ts
aws s3 cp s3://devflows-function-framework/arm64/extensions/logs-extension ./.devflows/extensions/logs-extension
aws s3 cp s3://devflows-function-framework/arm64/mini-proxy/mini-proxy ./.devflows/mini-proxy

docker buildx --no-cache --push \
	--platform linux/arm64 \
	--tag ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG} \
	-f Dockerfile .

