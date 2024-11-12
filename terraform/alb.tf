resource "aws_lb" "ecs-alb" {
  name               = "ty-ecs-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ty-sg.id]
  subnets            = toset(module.vpc.public_subnets)

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "ecs-alb-tg" {
  name        = "ty-ecs-target-group"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  health_check {
    path      = "/"
    protocol  = "HTTP"
    interval = 300
  } 
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.ecs-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs-alb-tg.arn
  }
}