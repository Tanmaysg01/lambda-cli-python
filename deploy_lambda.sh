# deploy_lambda.sh
#!/bin/bash

# Variables
FUNCTION_NAME="lambda-cli-function"
S3_BUCKET="shell-lambda-bucket-001"
ZIP_FILE="hello.zip"

# Create a deployment package
zip -r $ZIP_FILE hello.py

# Upload the deployment package to S3
aws s3 cp $ZIP_FILE s3://$S3_BUCKET/

# Create an IAM role for the Lambda function
aws iam create-role \
  --role-name $IAM_ROLE_NAME \
  --assume-role-policy-document '{"Version": "2012-10-17","Statement": [{"Effect": "Allow","Principal": {"Service": "lambda.amazonaws.com"},"Action": "sts:AssumeRole"}]}'

# Attach the AWSLambdaBasicExecutionRole policy to the IAM role (adjust policies as needed)
aws iam attach-role-policy \
  --role-name $IAM_ROLE_NAME \
  --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole


# Create or update the Lambda function
aws lambda create-function \
  --function-name $FUNCTION_NAME \
  --runtime python3.8 \
  --role arn:aws:iam::your-account-id:role/$IAM_ROLE_NAME \
  --handler lambda_function.lambda_handler \
  --code S3Bucket=$S3_BUCKET,S3Key=$ZIP_FILE

# Clean up - Remove the deployment package
rm $ZIP_FILE
