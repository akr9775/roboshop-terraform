data "aws_security_group" "allow-all" {
  name = "allow-all"
}

resource "aws_instance" "frontend" {
  ami           = data.aws_ami.ami.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [data.aws_security_group.allow-all.id]

  tags = {
    Name = "frontend"
  }

}

resource "null_resource" "provisioner" {

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.frontend.private_ip
    }

    inline = [
      "rm -rf roboshop-shell",
      "git clone https://github.com/akr9775/roboshop-shell.git",
      "cd roboshop-shell",
      "sudo bash frontend.sh"
    ]
  }
}