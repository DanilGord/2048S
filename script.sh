#!/bin/bash

# build ecr
cd /Users/mac/2048S/demo2/module/ecr
terraform init
terraform plan
terraform apply -auto-approve

# export Uri ECR
export ECR=$(aws ecr describe-repositories --query 'repositories[0].[repositoryUri]' --output text)

sed -i "" "s~image_2048S~$ECR~g" /Users/mac/2048S/demo2/module/cluster/variable.tf

# docker push on ECRclI 
cd /Users/mac/2048S
aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin ${ECR}
docker build -t ${ECR}:latest -f /Users/mac/2048S/Dockerfile /Users/mac/2048S
docker push ${ECR}:latest

# build cluster
cd /Users/mac/2048S/demo2/module/cluster
terraform init
terraform plan
terraform apply -auto-approve
