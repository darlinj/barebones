
resource "aws_iam_policy" "add_data_policy" {
  name        = "add-data-policy"
  description = "Allows access to running a single lambda function"
  tags        = var.common_tags
  policy = jsonencode(({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "lambda:invokeFunction"
        ],
        "Resource" : [
          "${module.add_data.lambda_function_arn}",
          "${module.add_data.lambda_function_arn}:*"
        ]
      }
    ]
  }))
}

resource "aws_iam_role" "add_data_role" {
  name = "add_data_role"

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

resource "aws_iam_role_policy_attachment" "add_data_policy_attachment" {
  role       = aws_iam_role.add_data_role.name
  policy_arn = aws_iam_policy.add_data_policy.arn
}

resource "aws_appsync_datasource" "add_data_lambda" {
  api_id = aws_appsync_graphql_api.api.id
  name   = "add_data_datasource"
  type   = "AWS_LAMBDA"

  lambda_config {
    function_arn = module.add_data.lambda_function_arn
  }

  service_role_arn = aws_iam_role.add_data_role.arn
}


resource "aws_appsync_resolver" "add_data_resolver" {
  api_id      = aws_appsync_graphql_api.api.id
  type        = "Mutation"
  field       = "addData"
  data_source = aws_appsync_datasource.add_data_lambda.name

  request_template = <<EOF
{
    "version" : "2017-02-28",
    "operation": "Invoke",
    "payload": $util.toJson($context.arguments)
}
EOF

  response_template = <<EOF
$ctx.result.body
EOF
}
