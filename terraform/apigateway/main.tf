resource "aws_apigatewayv2_api" "main" {
  name          = var.name
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "main" {
  api_id      = aws_apigatewayv2_api.main.id
  name        = var.env
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "main" {
  for_each = var.lambda_integrations

  api_id                 = aws_apigatewayv2_api.main.id
  integration_type       = "AWS_PROXY"
  integration_method     = "POST"
  integration_uri        = each.value
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "main" {
  for_each = var.lambda_integrations

  api_id    = aws_apigatewayv2_api.main.id
  route_key = "POST /${each.key}"
  target    = "integrations/${aws_apigatewayv2_integration.main[each.key].id}"
}