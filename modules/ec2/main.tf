data "aws_ami" "app_ami" {
      most_recent = true
    
      filter {
            name   = "name"
            values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
          }
}


resource "aws_instance" "ec2" {
  ami             = data.aws_ami.app_ami.id
  instance_type   = var.instance_type
  key_name        = "flavien"
  tags            = {
        Name=var.tag
    }
  security_groups = ["${var.sg}"]
  root_block_device {
    delete_on_termination = true
  }
provisioner "remote-exec" {
     inline = [
"sudo apt update && sudo apt install -y nginx-light git && cd /var/www/html && sudo rm -rf * && sudo git clone https://github.com/diranetafen/static-website-example.git ."
     ]

   connection {
     type = "ssh"
     user = "ubuntu"
     private_key = file("~/.ssh/id_ed25519")
     host = self.public_ip
   }
   }
}



