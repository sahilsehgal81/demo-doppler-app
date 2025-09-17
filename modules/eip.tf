resource "aws_eip" "elastic_ip_frontend" {
  count    = var.eip ? length(aws_instance.frontend) : 0
  instance = aws_instance.frontend[count.index].id
  vpc      = true

  tags = {
    Name = "${var.env}-${var.project}"
  }
}
