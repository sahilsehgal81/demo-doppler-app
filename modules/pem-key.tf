resource "tls_private_key" "pem" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "pem" {
  key_name   = var.key_name
  public_key = tls_private_key.pem.public_key_openssh
}

resource "local_file" "pem_key" {
  filename = "${aws_key_pair.pem.key_name}.pem"
  content  = tls_private_key.pem.private_key_pem
}

# Create a secret in AWS Secrets Manager
resource "aws_secretsmanager_secret" "pem_secret" {
  name        = "${var.key_name}-private-key"
  description = "Private key for ${var.key_name}"
}

# Store the private key in the secret
resource "aws_secretsmanager_secret_version" "pem_secret_version" {
  secret_id     = aws_secretsmanager_secret.pem_secret.id
  secret_string = tls_private_key.pem.private_key_pem
}
