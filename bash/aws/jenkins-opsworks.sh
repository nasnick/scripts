#!/bin/bash
apt-get install -y jq 
export AWS_DEFAULT_REGION=us-east-1
LAYER=Layer ID
STACK=Stack ID
APP_ID=APP ID
export INSTANCES=`aws opsworks describe-instances --region us-east-1 --layer-id $LAYER  | jq -r '.Instances[].InstanceId' | tr "n" " "`

if [ $Update_custom_cookbook = 'true' ]; then
UPDATE_COOKBOOK_ID=`aws opsworks create-deployment --region us-east-1 --stack-id $STACK --command "{"Name":"update_custom_cookbooks"}" --instance-id $INSTANCES | jq -r '.DeploymentId'`
echo $deployment_id

UPDATE_STATUS=$(aws opsworks describe-deployments --deployment-id $UPDATE_COOKBOOK_ID | jq -r '.Deployments[0].Status')
while [ $UPDATE_STATUS = "running" ]
do
 echo update custom cokobook is $UPDATE_STATUS
 sleep 7
 UPDATE_STATUS=$(aws opsworks describe-deployments --deployment-id $UPDATE_COOKBOOK_ID | jq -r '.Deployments[0].Status')
done

if [ $UPDATE_STATUS = "failed" ]
then
 echo "build failed"
 exit 1
fi
fi

DEPLOY_ID=`aws opsworks create-deployment --region us-east-1 --stack-id $STACK  --app-id $APP_ID --command "{"Name":"deploy"}" --instance-id $INSTANCES | jq -r '.DeploymentId'`
echo $deployment_id
DEPLOY_STATUS=$(aws opsworks describe-deployments --deployment-id $DEPLOY_ID | jq -r '.Deployments[0].Status')
while [ $DEPLOY_STATUS = "running" ]
do
  echo $DEPLOY_STATUS
  sleep 5
  DEPLOY_STATUS=$(aws opsworks describe-deployments --deployment-id $DEPLOY_ID | jq -r '.Deployments[0].Status')
done
if [ $DEPLOY_STATUS = "failed" ]
then
  echo "build failed"
  exit 1
fi




Access Key ID:
AKIAJBOOHZRTHUQB2FRA
Secret Access Key:
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
