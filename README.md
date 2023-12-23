# Terraform Sample Code

## 前提

- Ubuntu22.04を前提とする。
- 他OSの場合は適宜読み替えて実行する。
- Terraformはインストール済みとする。

## 事前準備

## AWS CLIのインストール

- 以下のコマンドでバージョンが返ってこない場合、AWS CLIをインストールする。

  ```bash
  aws --version
  ```

- AWS公式ページを参考に、AWS CLIをインストールする。
- 参考：<https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/getting-started-install.html>

  ```bash
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  ```

## アクセスキーの発行

1. IAMユーザーのアクセスキー権限があるユーザーで、AWSコンソールにサインインする。
2. セキュリティ認証情報のアクセスキーから、アクセスキーを作成する。

## Credentialの設定

- アクセスキーとシークレットキーを設定。
  - 以下コマンドで永続設定済み。

```bash:
echo 'export TF_VAR_aws_access_key=YOUR_ACCESS_KEY' >> ~/.bashrc
echo 'export TF_VAR_aws_secret_key=YOUR_SECRET_KEY' >> ~/.bashrc
source ~/.bashrc

aws configure --profile sample
AWS Access Key ID [None]: YOUR_ACCESS_KEY
AWS Secret Access Key [None]: YOUR_SECRET_KEY
Default region name [None]: ap-northeast-1
Default output format [None]: json
```

## キーペアの作成

- EC2のキーペアを`iac-key`で生成。
  - RSA
  - OPEN SSH

## S3とDynamoDBの作成

- tfstateファイルの管理に必要。
- S3のバケット名は、`backend.tf`の変数`bucket`の値と同じにすること。
- DynamoDBのテーブル名は、`backend.tf`の変数`dynamodb_table`の値と同じにすること。
  - パーティションキーは`LockID`で`文字列`とする。

## 実行

`env/<各ディレクトリ>`にmain.tfがあるため起動したい環境に移動。

```bash:
cd env/alb-waf
```

terraformコマンドを実行。

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
