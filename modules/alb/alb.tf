resource "aws_lb" "alb_waf" {
  load_balancer_type = "application"
  name               = "alb-waf"
  security_groups    = ["${var.security_group_id}"]
  subnets            = var.public_subnet_ids
}
