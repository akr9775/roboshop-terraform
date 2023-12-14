resource "aws_instance" "web" {
  ami           = data.aws_ami.ami.id
  instance_type = "t2.micro"

  tags = {
    Name = "frontend"
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = self.private_ip
    }

    inline = [
      "rm -rf roboshop-shell"
      "git clone https://github.com/akr9775/roboshop-shell.git",
      "cd roboshop-shell",
      "sudo bash frontend.sh"
    ]
  }
}