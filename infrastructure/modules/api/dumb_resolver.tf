
resource "aws_appsync_datasource" "datasource" {
  api_id = aws_appsync_graphql_api.api.id
  name   = "dumb_datasource"
  type   = "NONE"
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