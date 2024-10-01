#!/bin/bash

# Set variables
REGION="us-east-1"
STAGE="dev"
SERVICE_NAME="awd-web-hook-service"
USER_POOL_ID=$(aws cognito-idp list-user-pools --max-results 60 --query "UserPools[?Name=='${SERVICE_NAME}-${STAGE}-user-pool'].Id" --output text --region $REGION)
REST_API_ID=$(aws apigateway get-rest-apis --query "items[?name=='${SERVICE_NAME}-${STAGE}'].id" --output text --region $REGION)

echo "Deleting resources for ${SERVICE_NAME} in ${STAGE} stage..."

# Delete Lambda function
echo "Deleting Lambda function..."
aws lambda delete-function --function-name ${SERVICE_NAME}-${STAGE}-hello --region $REGION

# Delete API Gateway
if [ ! -z "$REST_API_ID" ]; then
    echo "Deleting API Gateway..."
    aws apigateway delete-rest-api --rest-api-id $REST_API_ID --region $REGION
fi

# Delete Cognito User Pool Client
echo "Deleting Cognito User Pool Client..."
CLIENT_ID=$(aws cognito-idp list-user-pool-clients --user-pool-id $USER_POOL_ID --query "UserPoolClients[?ClientName=='${SERVICE_NAME}-${STAGE}-client'].ClientId" --output text --region $REGION)
aws cognito-idp delete-user-pool-client --user-pool-id $USER_POOL_ID --client-id $CLIENT_ID --region $REGION

# Delete Cognito User Pool Domain
echo "Deleting Cognito User Pool Domain..."
aws cognito-idp delete-user-pool-domain --domain ${SERVICE_NAME}-${STAGE}-domain --user-pool-id $USER_POOL_ID --region $REGION

# Delete Cognito Resource Server
echo "Deleting Cognito Resource Server..."
aws cognito-idp delete-resource-server --user-pool-id $USER_POOL_ID --identifier "awd.datacom.com" --region $REGION

# Delete Cognito User Pool
echo "Deleting Cognito User Pool..."
aws cognito-idp delete-user-pool --user-pool-id $USER_POOL_ID --region $REGION

# Delete IAM Role
echo "Deleting IAM Role..."
aws iam delete-role --role-name ${SERVICE_NAME}-${STAGE}-api-gateway-role --region $REGION

echo "Resource deletion complete. Please check AWS Console to confirm all resources have been removed."