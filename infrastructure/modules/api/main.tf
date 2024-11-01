resource "aws_appsync_graphql_api" "api" {
  name   = "barebones-api"
  schema = file("modules/api/schema.graphql")

  authentication_type = "AMAZON_COGNITO_USER_POOLS"

  user_pool_config {
    user_pool_id        = aws_cognito_user_pool.barebones.id
    app_id_client_regex = aws_cognito_user_pool_client.barebones.id
    default_action      = "ALLOW"
  }
}

resource "aws_appsync_datasource" "datasource" {
  api_id = aws_appsync_graphql_api.api.id
  name   = "barebones"
  type   = "NONE"
}


resource "aws_appsync_resolver" "resolver" {
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
  "name": "Foobar"
}
EOF
}
