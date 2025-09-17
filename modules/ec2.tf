
# EC2 instance resource for frontend application
resource "aws_instance" "frontend" {
  ami           = var.ami # AMI ID for the instance
  instance_type = var.instance_type # Instance type (e.g., t3.medium)
  count = var.length # Number of instances to launch
  subnet_id                   = var.subnet_id # Subnet to launch instance in
  vpc_security_group_ids      = [aws_security_group.frontend-sg.id] # Attach security group
  associate_public_ip_address = true # Assign public IP
  key_name                    = aws_key_pair.pem.key_name # SSH key name

  # Root EBS volume configuration
  root_block_device {
    volume_size           = var.volume_size # EBS volume size
    volume_type           = var.volume_type # EBS volume type
    encrypted             = var.encrypted # Encrypt the volume
    delete_on_termination = var.delete_on_termination # Delete volume on termination
  }
  
  iam_instance_profile   = var.iam_role # IAM role for the instance

  tags = {
    Name = "${var.env}-${var.project}" # Tag for identification
  }
}
