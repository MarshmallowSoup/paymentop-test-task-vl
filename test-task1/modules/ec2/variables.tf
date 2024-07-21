variable "project_name" {
  default     = "test-task"
  description = "Project name"
}

variable "env" {
  default     = "dev"
  description = "Environment name"
}

variable "ami" {
  description = "AMI of EC2 machine"
  type        = string
}

variable "instance_type" {
  default     = "t3.micro"
  description = "Instance type of EC2 instance"
}

variable "ssh_key_pub" {
  description = "SSH key to connect to EC2"
  type        = string
  sensitive   = true
}

variable "volume_type" {
  default     = "gp2"
  description = "Volume type of EC2 instance"
  type        = string
}

variable "volume_size" {
  default     = 8
  type        = number
  description = "Volume size of EC2 instance"
}

variable "vpc_id" {
  description = "VPC ID where EC2 instance will be deployed"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where EC2 instance will be deployed"
  type        = string
}

variable "ingress_rules" {
  description = "The ingress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    description = string
    cidr_blocks = string
  }))
  default = []
}
