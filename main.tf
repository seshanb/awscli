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
    response=$(sudo su ec2-user -c "aws ssm create-document --content '{\"schemaVersion\":\"2.2\",\"description\":\"Install Python\",\"mainSteps\":[{\"action\":\"aws:runShellScript\",\"name\":\"InstallPython\",\"inputs\":{\"runCommand\":[\"sudo yum install -y python3\"]}}]}' --name \"install-python\" --document-type \"Command\"")
    echo "SSM Document Creation Response: $response"

    response=$(sudo su ec2-user -c "aws ssm send-command --document-name \"install-python\" --targets '[{\"Key\":\"InstanceIds\",\"Values\":[\"${aws_instance.example_instance.id}\"]}]'")
    echo "SSM Command Execution Response: $response"
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
