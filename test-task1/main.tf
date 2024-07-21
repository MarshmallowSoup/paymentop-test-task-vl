module "ec2_instance" {
  source         = "./modules/ec2"  
  ami            = "ami-0abcdef1234567890" 
  ssh_key_pub    = "SSH_KEY"  
  subnet_id      = module.vpc.public_subnets[0]
  vpc_id         = module.vpc.vpc_id

  env            = "test"
  ingress_rules  = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "HTTP"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  instance_type  = "t3.micro"
  project_name   = "paymentop"
  volume_size    = 10
  volume_type    = "gp2"
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.9.0"

  name = format("%v-%v-vpc", var.project_name, var.env )

  cidr = "10.1.0.0/22"

  azs              = data.aws_availability_zones.ireland.names
  public_subnets   = ["10.1.1.0/25", "10.1.1.128/25"]
  private_subnets  = ["10.1.2.0/25", "10.1.2.128/25"]
  database_subnets = ["10.1.3.0/25", "10.1.3.128/25"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  enable_vpn_gateway     = false
  enable_dns_hostnames   = true
  enable_dns_support     = true
  create_vpc             = true
  create_igw             = true

  vpc_tags = {
    Name = format("%v-vpc", var.env)
  }

}
