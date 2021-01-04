resource "aws_lambda_function" "main" {
  function_name    = var.function_name
  handler          = var.handler
  role             = aws_iam_role.main.arn
  runtime          = var.runtime
  filename         = var.package_name
  source_code_hash = filebase64sha256("${path.module}/src/${replace(var.function_name, "-", "_")}.py")
  # hash not updating in state file: https://github.com/terraform-providers/terraform-provider-aws/issues/7385

  dynamic environment {
    for_each = length(var.environment_variables) == 0 ? [] : [1]
    content {
      variables = var.environment_variables
    }
  }
}

resource "aws_iam_role" "main" {
  name               = "${var.function_name}-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "basic_exec_attach" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.main.name
}