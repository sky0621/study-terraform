resource "aws_vpc" "ex" {
  cidr_block = "10.0.0.0/16"    # 後から変更不可！
  enable_dns_support = true # AWSのDNSサーバによる名前解決
  enable_dns_hostnames = true   # VPC内リソースにパブリックDNSホスト名を割り当て
  tags = {
    Name = "ex"
  }
}
