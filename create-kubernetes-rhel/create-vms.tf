provider "aws" {
  region = "us-east-1"
  access_key = "AKIAYSFDJGKOI3IUXY7Y"
  secret_key = "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"
}
resource "aws_instance" "master-node" {
  ami = "ami-05a5f6298acdb05b6"
  instance_type = "t3.medium"
  vpc_security_group_ids = [ aws_security_group.websg.id, aws_security_group.sshsg.id, aws_security_group.kubernetes-ip.id ]
  user_data = <<-EOF
                #!/bin/bash
                sudo useradd ansible
                sudo mkdir -p /home/ansible
                sudo chown ansible:ansible /home/ansible 
                sudo mkdir -p /home/ansible/.ssh
                sudo touch /home/ansible/.ssh/authorized_keys
                sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDKrCiVg6ExNlj+TB/bbOBkXtHkbKR5/A6uYVr20pPrdvM26bkhFvnrfrGFnK7s0GLFfnpLhvH4ryy+d8nP9YcQpxCx4ROfNxYFMmHvHOI+MAUT+Ib6/HyDeYsQAp6MQ+LAcvVehTCMmzM0/sK2Y+d7Kyf2PwNx3BZcjvgsUOexqVHhCXcdmy8tMyT1B3m1zx/fHCdjdy+5walhtKB6UdZkP7MwzBHOp9yUenJxXFQPXxJZXA9N90ys+b6qWn994j63u0vOzw9C7jquliskmHFJyvEv1/avjq4JTKxlOoSWTtUawgPbGj2oBrG6tKI98MIFlgT0ntKAUSsTSKIaxUs+sND82BSAqMO8pOxewPxTMgwcdnzAa3X1a3CFJOF44mClRkEJCm/8eD+b6tdZ5suudAfzIjXSyAn5j7O8WTfWeUnHBLrf9prOCGtw2EXkCb0uPwtr0XiEaypS3C6M06ESzhqanLgA4RWhiAJOLlsR0Ybl8ux49+s4uj4vzhtr6Yk= ansible@MacBook-Pro-de-Mario.local" >> /home/ansible/.ssh/authorized_keys
                sudo chown ansible:ansible /home/ansible/.ssh 
                sudo chown ansible:ansible /home/ansible/.ssh/authorized_keys
                sudo usermod -aG wheel ansible
                sudo echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
                EOF
    tags = {
      Name = "Control-Plane"
    }
}

resource "aws_instance" "worker-node1" {
  ami = "ami-05a5f6298acdb05b6"
  instance_type = "t3.medium"
  vpc_security_group_ids = [ aws_security_group.websg.id, aws_security_group.sshsg.id ]
  user_data = <<-EOF
                #!/bin/bash
                sudo useradd ansible
                sudo mkdir -p /home/ansible
                sudo chown ansible:ansible /home/ansible 
                sudo mkdir -p /home/ansible/.ssh
                sudo touch /home/ansible/.ssh/authorized_keys
                sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDKrCiVg6ExNlj+TB/bbOBkXtHkbKR5/A6uYVr20pPrdvM26bkhFvnrfrGFnK7s0GLFfnpLhvH4ryy+d8nP9YcQpxCx4ROfNxYFMmHvHOI+MAUT+Ib6/HyDeYsQAp6MQ+LAcvVehTCMmzM0/sK2Y+d7Kyf2PwNx3BZcjvgsUOexqVHhCXcdmy8tMyT1B3m1zx/fHCdjdy+5walhtKB6UdZkP7MwzBHOp9yUenJxXFQPXxJZXA9N90ys+b6qWn994j63u0vOzw9C7jquliskmHFJyvEv1/avjq4JTKxlOoSWTtUawgPbGj2oBrG6tKI98MIFlgT0ntKAUSsTSKIaxUs+sND82BSAqMO8pOxewPxTMgwcdnzAa3X1a3CFJOF44mClRkEJCm/8eD+b6tdZ5suudAfzIjXSyAn5j7O8WTfWeUnHBLrf9prOCGtw2EXkCb0uPwtr0XiEaypS3C6M06ESzhqanLgA4RWhiAJOLlsR0Ybl8ux49+s4uj4vzhtr6Yk= ansible@MacBook-Pro-de-Mario.local" >> /home/ansible/.ssh/authorized_keys
                sudo chown ansible:ansible /home/ansible/.ssh 
                sudo chown ansible:ansible /home/ansible/.ssh/authorized_keys
                sudo usermod -aG wheel ansible
                sudo echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
                EOF
    tags = {
      Name = "Worker Node1"
    }
}

resource "aws_instance" "worker-node2" {
  ami = "ami-05a5f6298acdb05b6"
  instance_type = "t3.medium"
  vpc_security_group_ids = [ aws_security_group.websg.id, aws_security_group.sshsg.id ]
  user_data = <<-EOF
                #!/bin/bash
                sudo useradd ansible
                sudo mkdir -p /home/ansible
                sudo chown ansible:ansible /home/ansible 
                sudo mkdir -p /home/ansible/.ssh
                sudo touch /home/ansible/.ssh/authorized_keys
                sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDKrCiVg6ExNlj+TB/bbOBkXtHkbKR5/A6uYVr20pPrdvM26bkhFvnrfrGFnK7s0GLFfnpLhvH4ryy+d8nP9YcQpxCx4ROfNxYFMmHvHOI+MAUT+Ib6/HyDeYsQAp6MQ+LAcvVehTCMmzM0/sK2Y+d7Kyf2PwNx3BZcjvgsUOexqVHhCXcdmy8tMyT1B3m1zx/fHCdjdy+5walhtKB6UdZkP7MwzBHOp9yUenJxXFQPXxJZXA9N90ys+b6qWn994j63u0vOzw9C7jquliskmHFJyvEv1/avjq4JTKxlOoSWTtUawgPbGj2oBrG6tKI98MIFlgT0ntKAUSsTSKIaxUs+sND82BSAqMO8pOxewPxTMgwcdnzAa3X1a3CFJOF44mClRkEJCm/8eD+b6tdZ5suudAfzIjXSyAn5j7O8WTfWeUnHBLrf9prOCGtw2EXkCb0uPwtr0XiEaypS3C6M06ESzhqanLgA4RWhiAJOLlsR0Ybl8ux49+s4uj4vzhtr6Yk= ansible@MacBook-Pro-de-Mario.local" >> /home/ansible/.ssh/authorized_keys
                sudo chown ansible:ansible /home/ansible/.ssh 
                sudo chown ansible:ansible /home/ansible/.ssh/authorized_keys
                sudo usermod -aG wheel ansible
                sudo echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
                EOF
    tags = {
      Name = "Worker Node2"
    }
}


resource "aws_security_group" "sshsg" {
  name = "ssh-sg01"
  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = [ "0.0.0.0/0" ]
  }

    // Allows egress traffic to all ports 
   egress {
    protocol   = "-1"
    from_port  = 0
    to_port    = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "websg" {
  name = "web-sg01"
  ingress {
    protocol = "tcp"
    from_port = 8080
    to_port = 8080
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

resource "aws_security_group" "kubernetes-ip" {
  name = "kubernetessg"
  ingress {
    protocol = "tcp"
    from_port = 6443
    to_port = 6443
    cidr_blocks = [ "172.31.0.0/16" ]
  }
}
output "instance_ips" {
  value = aws_instance.master-node.public_dns
}

output "instance_ips_w2" {
  value = aws_instance.worker-node2.public_dns
}

output "instance_ips_w1" {
  value = aws_instance.worker-node1.public_dns
}