resource "aws_instance" "example_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name

  tags = {
    Name = "ExampleInstance"
  }
}

data "template_file" "install_python_script" {
  template = <<-EOF
    #!/bin/bash
    aws ec2 describe-instances
  EOF
}

resource "local_file" "install_python_script" {
  filename         = "${path.module}/install_python.sh"
  content          = data.template_file.install_python_script.rendered
  file_permission  = "0777"
}

output "ssm_document_creation_response" {
  value = local_file.install_python_script.content
}

output "ssm_command_execution_response" {
  value = local_file.install_python_script.content
}
