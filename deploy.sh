#!/bin/bash
SERVICE_NAME="node-app"
IMAGE_VERSION="v${BUILD_NUMBER}"
TASK_FAMILY="node-app"

# Create a new task definition for this build
sed -e "s;%CURRENT_BUILD%;${IMAGE_VERSION};g" node.json > node-v_${BUILD_NUMBER}.json
aws ecs register-task-definition --family node-app --cli-input-json file://node-v_${BUILD_NUMBER}.json --region ap-south-1

# Update the service with the new task definition and desired count
TASK_REVISION=`aws ecs describe-task-definition --task-definition node-app --region ap-south-1 | egrep "revision" | tr "/" " " | awk '{print $2}' | sed 's/"$//'`
DESIRED_COUNT=`aws ecs describe-services --services ${SERVICE_NAME} --region ap-south-1 | egrep "desiredCount" | tr "/" " " | awk '{print $2}' | sed 's/,$//'`
echo $DESIRED_COUNT
# if [ $DESIRED_COUNT -eq 0 ]; then
#     DESIRED_COUNT=1
# fi
DESIRED_COUNT=1
echo $DESIRED_COUNT
aws ecs update-service --cluster nodeapp --service ${SERVICE_NAME} --task-definition ${TASK_FAMILY}:${TASK_REVISION} --desired-count ${DESIRED_COUNT} --region ap-south-1