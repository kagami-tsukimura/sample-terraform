# WAF を ALB にアタッチした 環境

WAF のテスト環境。  
ALB に WAF をアタッチしている。
`locals.tf`の `allow_waf_cidr` に設定した IP アドレスのみアクセス可能。
