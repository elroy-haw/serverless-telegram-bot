output "function" {
  value = {
    function_name = aws_lambda_function.main.function_name
    invoke_arn    = aws_lambda_function.main.invoke_arn
    arn           = aws_lambda_function.main.arn
  }
}

output "role" {
  value = {
    id  = aws_iam_role.main.id,
    arn = aws_iam_role.main.arn
  }
}