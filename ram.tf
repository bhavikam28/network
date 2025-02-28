# Creates a Resource Access Manager (RAM) Resource Share
resource "aws_ram_resource_share" "subnet_share" {
  name                      = var.ram_name
  allow_external_principals = false

  tags = {
    Name = var.ram_name
  }
}

# Associates Private Subnets to RAM
resource "aws_ram_resource_association" "private_subnets" {
  count              = length(var.private_subnets)
  resource_arn       = aws_subnet.private_subnets[count.index].arn
  resource_share_arn = aws_ram_resource_share.subnet_share.arn
}

# Associates Public Subnets to RAM
resource "aws_ram_resource_association" "public_subnets" {
  count              = length(var.public_subnets)
  resource_arn       = aws_subnet.public_subnets[count.index].arn
  resource_share_arn = aws_ram_resource_share.subnet_share.arn
}

# Share resources with the Sandbox OU
resource "aws_ram_principal_association" "ram_principal_association" {
  principal          = var.ou_arn
  resource_share_arn = aws_ram_resource_share.subnet_share.arn
}