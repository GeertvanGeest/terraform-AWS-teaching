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

variable "volume_size" {
    type = number
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

    root_block_device {
        volume_size = var.volume_size
        delete_on_termination = true
    }

    tags = {
        "course" = var.course_id
    }
}

resource "aws_security_group" "train" {
    name        = "training"
    description = "port ranges containers"

    ingress {
        from_port   = 7000
        to_port     = 7050
        protocol    = "tcp"
        cidr_blocks = var.whitelist
    }

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

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
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
