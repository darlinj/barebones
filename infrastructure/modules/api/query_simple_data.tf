
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


resource "aws_appsync_resolver" "get_simple_data" {
  api_id      = aws_appsync_graphql_api.api.id
  type        = "Query"
  field       = "getSimpleData"
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
