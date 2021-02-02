
# ==================== test-lambda IAM ==========================

data "aws_iam_policy_document" "lambda-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "test_lambda" {
  name = "${var.project_name}-test-lambda"

  assume_role_policy = data.aws_iam_policy_document.lambda-assume-role-policy.json

  tags = {
    Name    = "lambda role - ${terraform.workspace}"
    Project = var.project_name
  }
}

resource "aws_iam_role_policy" "sqs_recieve_policy" {
  name = "${var.project_name}-sqs-recieve-policy"
  role = aws_iam_role.test_lambda.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "SQS:*",
          "S3:*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy_attachment" "lamdba-secrets-manager-role-attach" {
  role       = aws_iam_role.test_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

resource "aws_iam_role_policy_attachment" "lambda-execution-role-attach" {
  role       = aws_iam_role.test_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda-db-role-attach" {
  role       = aws_iam_role.test_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda-ssm-role-attach" {
  role       = aws_iam_role.test_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}
