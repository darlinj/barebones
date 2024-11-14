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

In your ~/.aws/credentials file:

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

# Install dependencies

## Install Terraform locally

[Terraform installation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## Install node locally

[Node installation](https://nodejs.org/en/learn/getting-started/how-to-install-nodejs)

# Getting started

## Get the code

```
git clone git@github.com:darlinj/barebones.git yourproject
```

## Replace the origin

Replace the origin so you can add an origin push code to your repo

```
git remove origin/main
git remote add origin git@github.com:darlinj/myproject.git
```

## create the bucket to store the terraform state in:

Terraform can store it's state info in numerous places. In this example we use an S3 bucket. The name needs to be globally unique so you will need to use a different name from below

```
aws s3 mb s3://terraform-state-store-barebones-xyz
```

edit the `./infrastructure/providers.tf` file to point to the bucket created above:

```
  backend "s3" {
    bucket = "YOUR BUCKET NAME HERE"
    key = "YOUR_S3_KEY" #This is the "directory" that you want the state stored in.  It can be useful if you want to store other things in this bucket
    region = "YOUR REGION"
  }
```

## Install npm packages

In the root of the project run

```
npm i
cd apps/website
npm i
```

## Rename from Barebones to yourAppName

Search for all occurrences of Barebones and replace with the name of your app

## Register your root domain and create your Hosted zone

1. Register a domain (preferably in Route53) - Menu is `Registered domains` in route53
1. Create a hosted zone in Route53
1. Point the registered domain name servers at the hosted zones NS record DNS servers
1. Change the domain_name variable in `./infrastructure/prod.tfvars` and `./infrastructure/dev.tfvars` to match the domain that you have created

## Build and deploy

```
npm run deploy_infra -- prod
npm run build -- prod
npm run deploy_website -- prod
```

# Adding API calls

To add a new API call:

1. Copy one of the directories ending `_lambda` in `/apps`
1. Update the `./infrastructure/modules/api/schema.graphql` to add the API call you need
1. Update `./infrastructure/modules/api/locals.tf` to add another member to the map
1. Deploy the API using `npm run deploy_infra -- <yourEnv>` from the root of the project where yourEnv is the environment you want to deploy to
1. You should now be able to go to the AppSync console and see the new API call and do test queries
1. Edit the lambda to do whatever you need it to do
1. Set the AppID field in ./apps/website/.graphqlconfig.yml to the ID of your API. This can be found via the AWS console or via the CLI
1. `cd apps/website` and run `npm run codegen`. This creates the types for the API in the website directory
1. Edit the website to do whatever you need it to do

# To add a new deployment environment

Copy `infrastructure/prod.tfvars` to an file named the new environment e.g. `myenv.tfvars`

Change the file:

```
# This is the hosting domain.  This should be set up to point to a hosted zone in route53 with the same name asa the domain.
# This plan will create a new A record in the hosted zone that points to the created cloud front distribution
domain_name = "somedomain.com"
# This is the subdomain that will be added to the domain name to produce the domain for this web site.
domain_prefix = "myenv"
common_tags = {
  Project = "Barebones project"
}
```

then run:

```
npm run deploy_all -- myenv
```
