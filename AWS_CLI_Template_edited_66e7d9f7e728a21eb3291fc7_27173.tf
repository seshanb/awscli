module "AWS_CLI_Template_edited_66e7d9f7e728a21eb3291fc7_27173" {
  source        = "git::https://github.com/seshanb/awscli.git?ref=main"
  ami_id        = "ami-0123456789abcdef0"
  instance_type = "t2.micro"
  key_pair_name = "your_key_pair_name"
}