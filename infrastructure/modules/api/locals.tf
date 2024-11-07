locals {
  lambdas = {
    addData = {
      directory_name  = "add_data_lambda"
      graphQlAPIType  = "Mutation"
      graphQlAPIfield = "addData"
      lambdaPermissions = [
        "lambda:invokeFunction"
      ]
    }
    querySimpleData = {
      directory_name  = "query_simple_data_lambda"
      graphQlAPIType  = "Query"
      graphQlAPIfield = "getSimpleData"
      lambdaPermissions = [
        "lambda:invokeFunction"
      ]
  } }
}
