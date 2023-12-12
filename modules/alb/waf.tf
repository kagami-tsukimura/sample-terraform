resource "aws_wafv2_ip_set" "allow_cidr_waf" {
  name               = "web-application-ip-addresses"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = var.allow_waf_cidr
}

resource "aws_wafv2_web_acl" "example_acl" {
  name  = "web-application-alb-waf"
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${aws_wafv2_ip_set.allow_cidr_waf.name}-Waf-Metric"
    sampled_requests_enabled   = true
  }

  rule {
    name     = aws_wafv2_ip_set.allow_cidr_waf.name
    priority = 1

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.allow_cidr_waf.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${aws_wafv2_ip_set.allow_cidr_waf.name}-Waf-Metric"
      sampled_requests_enabled   = true
    }
  }

}

resource "aws_wafv2_web_acl_association" "WafWebAclAssociation" {
  resource_arn = aws_lb.alb_waf.arn
  web_acl_arn  = aws_wafv2_web_acl.example_acl.arn
  depends_on = [
    aws_wafv2_web_acl.example_acl,
  ]
}
