$(aws ecr get-login --no-include-email --region ap-south-1)

docker build -t node-app .

docker tag node-app:latest 390161664430.dkr.ecr.ap-south-1.amazonaws.com/node-app:latest

docker tag node-app:latest 390161664430.dkr.ecr.ap-south-1.amazonaws.com/node-app:v$BUILD_NUMBER

docker push 390161664430.dkr.ecr.ap-south-1.amazonaws.com/node-app:latest

docker push 390161664430.dkr.ecr.ap-south-1.amazonaws.com/node-app:v$BUILD_NUMBER