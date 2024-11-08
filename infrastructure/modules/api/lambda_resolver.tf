
resource "aws_iam_policy" "lambda_policy" {
  for_each    = local.lambdas
  name        = "${each.key}_policy${var.name_postfix}"
  description = "Allows access to running a the ${each.key} lambda function"
  tags        = var.common_tags
  policy = jsonencode(({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : each.value.lambdaPermissions,
        "Resource" : [
          "${module.lambdas[each.key].lambda_function_arn}",
          "${module.lambdas[each.key].lambda_function_arn}:*"
        ]
      }
    ]
  }))
}

resource "aws_iam_role" "lambda_role" {
  for_each = local.lambdas
  name     = "${each.key}_role${var.name_postfix}"

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

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  for_each   = local.lambdas
  role       = aws_iam_role.lambda_role[each.key].name
  policy_arn = aws_iam_policy.lambda_policy[each.key].arn
}

resource "aws_appsync_datasource" "lambda_datasource" {
  for_each = local.lambdas
  api_id   = aws_appsync_graphql_api.api.id
  name     = "${each.key}_datasource${var.name_postfix}"
  type     = "AWS_LAMBDA"

  lambda_config {
    function_arn = module.lambdas[each.key].lambda_function_arn
  }

  service_role_arn = aws_iam_role.lambda_role[each.key].arn
}


resource "aws_appsync_resolver" "lambda_resolver" {
  for_each    = local.lambdas
  api_id      = aws_appsync_graphql_api.api.id
  type        = each.value.graphQlAPIType
  field       = each.value.graphQlAPIfield
  data_source = aws_appsync_datasource.lambda_datasource[each.key].name

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
