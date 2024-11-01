resource "aws_appsync_graphql_api" "api" {
  name   = "barebones-api"
  schema = file("modules/api/schema.graphql")

  authentication_type = "AMAZON_COGNITO_USER_POOLS"

  user_pool_config {
    user_pool_id   = aws_cognito_user_pool.cognito.id
    default_action = "ALLOW"
  }

  additional_authentication_provider {
    authentication_type = "API_KEY"
  }

}

resource "aws_appsync_api_key" "api_key" {
  api_id  = aws_appsync_graphql_api.api.id
  expires = "2050-01-01T00:00:00Z"
}

resource "aws_appsync_datasource" "datasource" {
  api_id = aws_appsync_graphql_api.api.id
  name   = "dumb_datasource"
  type   = "NONE"
}

resource "aws_iam_policy" "lambda1_policy" {
  name        = "lambda1-policy"
  description = "Allows access to running a single lambda function"
  policy = jsonencode(({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "lambda:invokeFunction"
        ],
        "Resource" : [
          "${module.lambda_function.lambda_function_arn}",
          "${module.lambda_function.lambda_function_arn}:*"
        ]
      }
    ]
  }))
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "appsync.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda1_policy.arn
}

resource "aws_appsync_datasource" "lambda" {
  api_id = aws_appsync_graphql_api.api.id
  name   = "lambda1"
  type   = "AWS_LAMBDA"

  lambda_config {
    function_arn = module.lambda_function.lambda_function_arn
  }

  service_role_arn = aws_iam_role.lambda_exec.arn
}



resource "aws_appsync_resolver" "private_resolver" {
  api_id      = aws_appsync_graphql_api.api.id
  type        = "Query"
  field       = "getPublicData"
  data_source = aws_appsync_datasource.datasource.name

  request_template = <<EOF
{
  "version": "2017-02-28",
  "payload": {
    "id": "$ctx.args.id"
  }
}
EOF

  response_template = <<EOF
{
  "id": $ctx.args.id,
  "name": "Public Data"
}
EOF
}

resource "aws_appsync_resolver" "public_resolver" {
  api_id      = aws_appsync_graphql_api.api.id
  type        = "Query"
  field       = "getData"
  data_source = aws_appsync_datasource.datasource.name

  request_template = <<EOF
{
  "version": "2017-02-28",
  "payload": {
    "id": "$ctx.args.id"
  }
}
EOF

  response_template = <<EOF
{
  "id": $ctx.args.id,
  "name": "Private Data"
}
EOF
}


resource "aws_appsync_resolver" "get_lambda_data" {
  api_id      = aws_appsync_graphql_api.api.id
  type        = "Query"
  field       = "getLambdaData"
  data_source = aws_appsync_datasource.lambda.name

  request_template = <<EOF
{
  "version": "2017-02-28",
  "operation": "Invoke",
  "payload": {}
}
EOF

  response_template = <<EOF
$ctx.result.body
EOF
}
