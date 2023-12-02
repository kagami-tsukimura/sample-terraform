# Terraform Sample Code

## 事前準備

## Credentialの設定

- アクセスキーとシークレットキーを設定。
  - 以下コマンドで永続設定済み。

```bash:
echo 'export TF_VAR_aws_access_key=YOUR_ACCESS_KEY' >> ~/.bashrc
echo 'export TF_VAR_aws_secret_key=YOUR_SECRET_KEY' >> ~/.bashrc
source ~/.bashrc
```

## キーペアの作成

- EC2のキーペアを`iac-key`で生成。
  - RSA
  - OPEN SSH

## 実行

```bash:
terraform init
terraform plan
terraform apply
```

## Webサーバに接続

### HTTPから接続

1. AWSのコンソールからEC2インスタンスに遷移。
2. `iac-instance`のパブリックIPv4アドレスをコピー。
3. ブラウザで`http://<パブリックIPv4アドレス>`を実行。

- HTTPSは証明書がないため接続できない。

### SSHから接続

1. ターミナルを起動。
2. キーペアの.pemファイルのディレクトリに遷移。
3. 以下のコマンドを実行。

```bash:
ssh -i iac-key.pem ec2-user@<パブリックIPv4アドレス>
```

- `permission denied`が発生する場合は、.pemファイルを自分のみ読み込み可に権限を変更する。

```bash:
chmod 400 iac-key.pem
```
