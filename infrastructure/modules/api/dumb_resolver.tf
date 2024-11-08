
resource "aws_appsync_datasource" "datasource" {
  api_id = aws_appsync_graphql_api.api.id
  name   = "dumb_datasource${var.name_postfix}"
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
  "name": "This data can be seen by anyone"
}
EOF
}
