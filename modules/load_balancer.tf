resource "aws_lb" "nlb" {
  count                = var.load_balancer ? 1 : 0
  name                 = "${var.env}"
  load_balancer_type   = "network"
  enable_cross_zone_load_balancing = true

  subnet_mapping {
    subnet_id = var.subnet_id
  }
}

resource "aws_lb_listener" "listener-80" {
  count                = var.load_balancer ? 1 : 0
  load_balancer_arn    = aws_lb.nlb[0].arn
  protocol             = "TCP"
  port                 = 80

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web[0].arn
  }
}

resource "aws_lb_listener" "listener-443" {
  count                = var.load_balancer ? 1 : 0
  load_balancer_arn    = aws_lb.nlb[0].arn
  protocol             = "TCP"
  port                 = 443

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web[0].arn
  }
}

resource "aws_lb_target_group" "web" {
  count                = var.load_balancer ? 1 : 0
  port                 = 80
  protocol             = "TCP"
  vpc_id               = var.vpc_id
  target_type          = "ip"

  depends_on = [
    aws_lb.nlb
  ]
}

resource "aws_lb_target_group_attachment" "web1" {
  count                = var.load_balancer ? length(aws_instance.frontend) : 0
  target_group_arn     = aws_lb_target_group.web[0].arn
  target_id            = aws_instance.frontend[count.index].private_ip
  port                 = 80
}

