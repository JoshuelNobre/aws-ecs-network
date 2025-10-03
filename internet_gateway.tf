resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Environment = var.environment,
    Name        = format("%s-igw", var.project_name)
  }
}