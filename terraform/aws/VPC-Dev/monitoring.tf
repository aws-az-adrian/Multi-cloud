# Flow Logs de VPC Dev hacia CloudWatch Logs
resource "aws_cloudwatch_log_group" "ll-test-flowlogs_CloudWatch-back" {
  name              = "/aws/vpc/flowlogs/Dev"
  retention_in_days = 7
}
resource "aws_iam_role" "ll-test-flowlogs_role-back" {
  name = "ll-test-flowlogs_role-back"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "vpc-flow-logs.amazonaws.com" },
      Action   = "sts:AssumeRole"
    }]
  })
}
#Permite que los flow logs de VPC-Dev escriban en CloudWatch
resource "aws_iam_role_policy" "ll-test-flowlogs_policy-back" {
  name = "ll-test-flowlogs_policy-back"
  role = aws_iam_role.ll-test-flowlogs_role-back.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      Resource = "${aws_cloudwatch_log_group.ll-test-flowlogs_CloudWatch-back.arn}:*"
    }]
  })
}

resource "aws_flow_log" "ll-test-flowlogs-back" {
  log_destination = aws_cloudwatch_log_group.ll-test-flowlogs_CloudWatch-back.arn
  iam_role_arn    = aws_iam_role.ll-test-flowlogs_role-back.arn
  traffic_type    = "ALL"
  vpc_id          = data.terraform_remote_state.Networking.outputs.vpc_id_dev
  tags = {
    Name = "ll-test-flowlogs-back"
  } 
}
