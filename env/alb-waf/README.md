# WAF を ALB にアタッチした 環境

WAF のテスト環境。  
ALB に WAF をアタッチしている。
`locals.tf`の `allow_waf_cidr` に設定した IP アドレスのみアクセス可能。

```terraform: locals.tf
  allow_waf_cidr      = ["0.0.0.0/1", "128.0.0.0/1"]
```
