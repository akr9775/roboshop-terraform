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

resource "aws_route53_record" "frontend" {
  zone_id = "Z068357614KDH6BL7CVGP"
  name    = "frontend-dev.akrdevopsb72.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.frontend.private_ip]
}

resource "aws_instance" "catalogue" {
  ami           = data.aws_ami.ami.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [data.aws_security_group.allow-all.id]

  tags = {
    Name = "catalogue"
  }

}

resource "null_resource" "provisioner" {

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.catalogue.private_ip
    }

    inline = [
      "rm -rf roboshop-shell",
      "git clone https://github.com/akr9775/roboshop-shell.git",
      "cd roboshop-shell",
      "sudo bash catalogue.sh"
    ]
  }
}

resource "aws_route53_record" "catalogue" {
  zone_id = "Z068357614KDH6BL7CVGP"
  name    = "catalogue-dev.akrdevopsb72.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.catalogue.private_ip]
}

resource "aws_instance" "mongodb" {
  ami           = data.aws_ami.ami.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [data.aws_security_group.allow-all.id]

  tags = {
    Name = "mongodb"
  }

}

resource "null_resource" "provisioner" {

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.mongodb.private_ip
    }

    inline = [
      "rm -rf roboshop-shell",
      "git clone https://github.com/akr9775/roboshop-shell.git",
      "cd roboshop-shell",
      "sudo bash mongodb.sh"
    ]
  }
}

resource "aws_route53_record" "mongodb" {
  zone_id = "Z068357614KDH6BL7CVGP"
  name    = "catalogue-dev.akrdevopsb72.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.mongodb.private_ip]
}