resource "aws_cognito_user_pool" "barebones" {
  name = "barebones-user-pool"
}

resource "aws_cognito_user_pool_client" "barebones" {
  name            = "barebones-user-pool-client"
  user_pool_id    = aws_cognito_user_pool.barebones.id
  generate_secret = false
}
