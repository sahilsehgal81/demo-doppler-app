resource "aws_security_group" "frontend-sg" {
  name   = "${var.env}-${var.project}"
  vpc_id = var.vpc_id

  dynamic "ingress" {
       for_each = var.ssh_ports
         iterator = port
       content  {
             from_port   = port.value
             to_port     = port.value
             protocol    = "tcp"
             cidr_blocks = var.ssh_cidr_block

       }

  }

  dynamic "ingress" {
       for_each = var.web_ports
         iterator = port
       content  {
             from_port   = port.value
             to_port     = port.value
             protocol    = "tcp"
             cidr_blocks = var.web_cidr_blocks

       }

  }


  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env}-${var.project}"
  }
}
