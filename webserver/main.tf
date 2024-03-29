provider "aws" {
  region = "us-east-1"
}

# Get availability_zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Create the Prod VPC
data "aws_vpc" "vpc" {
  default = true
}

# public subnets
data "aws_subnets" "subnets_public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}


# Data source for AMI id
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# data "terraform_remote_state" "get_remote_data" { 
#   backend = "s3"
#   config = {
#     bucket = "clo835-assignment-1"               
#     key    = "network/terraform.tfstate"
#     region = "us-east-1"                          
#   }
# }

# Provision WebServers in public subnets
resource "aws_instance" "ec2_instances_webservers" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.web_key.key_name
  subnet_id                   = data.aws_subnets.subnets_public.ids[0]
  security_groups             = [aws_security_group.web_sg.id]
  iam_instance_profile        = "LabInstanceProfile"
  associate_public_ip_address = true
  user_data                   = file("user_data.sh")

  tags = merge(var.default_tags,
    {
      "Name" = "${var.prefix}-WebServer"
    }
  )
}


# Adding SSH key to Amazon EC2
resource "aws_key_pair" "web_key" {
  key_name   = "${var.prefix}"
  public_key = file("${var.prefix}.pub")
}

resource "aws_security_group" "web_sg" {
  name        = "allow_http_ssh"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = data.aws_vpc.vpc.id
  
  ingress {
    description      = "Allow HTTP Connection"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow SSH Connection"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress {
    description      = "Allow Custom TCP for ports 8081, 8082, 8083 From Everywhere"
    from_port        = 8081
    to_port          = 8083
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
 
  }
  
  tags = merge(var.default_tags, {
    "Name" = "${var.prefix}-SG-webserver"
    }
  )
}
