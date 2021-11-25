variable "whitelist" {
    type = list(string)
}
variable "web_image_id" {
    type = string
}
variable "web_instance_type" {
    type = string
}

variable "course_id" {
    type = string
}

variable "key_name" {
    type = string
}

provider "aws" {
    profile = "default"
    region  = "eu-central-1"
}

resource "aws_instance" "train" {
    ami                    = var.web_image_id
    instance_type          = var.web_instance_type
    vpc_security_group_ids = [aws_security_group.train.id]
    user_data              = file("init-script.sh")
    key_name               = var.key_name

    tags = {
        "course" = var.course_id
    }
}

resource "aws_security_group" "train" {
    name        = "training"
    description = "port ranges containers"

    ingress {
        from_port   = 9000
        to_port     = 9050
        protocol    = "tcp"
        cidr_blocks = var.whitelist
    }
    ingress {
        from_port   = 10000
        to_port     = 10050
        protocol    = "tcp"
        cidr_blocks = var.whitelist
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = var.whitelist

    }

    tags = {
        "course" = var.course_id
    }
}

resource "aws_eip" "train" {
  instance = aws_instance.train.id
  tags = {
        "course" = var.course_id
    }
}

resource "aws_eip_association" "train" {
  instance_id   = aws_instance.train.id
  allocation_id = aws_eip.train.id
}
