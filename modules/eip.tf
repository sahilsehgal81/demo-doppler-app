resource "aws_eip" "elastic_ip_frontend" {
  count    = var.eip ? length(aws_instance.frontend) : 0
  instance = aws_instance.frontend[count.index].id

  tags = {
    Name = "${var.env}-${var.project}"
  }
}
