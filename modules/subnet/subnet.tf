resource "aws_subnet" "subnet" {
  vpc_id     = var.vpc_id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet-terragrunt-${var.environment}"
  }
}
