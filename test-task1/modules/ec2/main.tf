data "aws_ami" "latest_ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "ec2_sg" {
  name_prefix = format("%v-%v-sg", var.project_name, var.env)
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      description = ingress.value.description
      cidr_blocks = [ingress.value.cidr_blocks]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "main" {
  ami           = var.ami != "" ? var.ami : data.aws_ami.latest_ubuntu.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh_key
  subnet_id     = var.subnet_id

  vpc_security_group_ids = [aws_security_group.ec2_sg.name]


  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  tags = {
    Name = format("%v-%v-instance", var.project_name, var.env)
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = format("%v-%v-key", var.project_name, var.env)
  public_key = var.ssh_key_pub
}