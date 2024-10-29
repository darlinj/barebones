# This is a simple react app with an appsync graphQL backend that is authenticated using cognito

This app is:

1. A barebones react app written in Typescript
1. A serverless backend based on Appsync with lambda resolvers
1. Authenticated by a Cognito user pool
1. Deployed by terraform

# Getting started

## Set your AWS credentials

Either:

1. Set the AWS credentials as environment variables
1. Set the AWS credentials in your `~/.aws/credentials` file and set up your AWS_PROFILE environment variable

## AWS credentials as environment variables

```
export AWS_ACCESS_KEY_ID="ASIA..."
export AWS_SECRET_ACCESS_KEY="iZZn1..."
export AWS_SESSION_TOKEN="IQoJb3..."
```

You may not need the `AWS_SESSION_TOKEN` if you are using simple IAM users

## AWS credentials as in `~/.aws/credentials`

In you ~/.aws/credentials file:

```
...

[my_profile]
aws_access_key_id=AKIA...
aws_secret_access_key=ulg...
```

Then

```
export AWS_PROFILE=my_profile
```

## Once only - create the bucket to store the terraform state in:

Terraform can store it's state info in numerous places. In this example we use an S3 bucket. The name needs to be globally unique so you will need to use a different name from below

```
aws s3 mb s3://terraform-state-store-barebones-xyz
```

edit the `./infrastructure/providers.tf` file to point to the bucket created above:

```
  backend "s3" {
    bucket = "YOUR BUCKET NAME HERE"
    key = "YOUR_S3_KEY" #This is like the directory that you want the state stored in.  It can be useful if you want to store other things in this bucket
    region = "YOUR REGION"
  }
```

# Install dependencies

## Install Terraform locally

[Terraform installation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## Install node locally

[Node installation](https://nodejs.org/en/learn/getting-started/how-to-install-nodejs)
