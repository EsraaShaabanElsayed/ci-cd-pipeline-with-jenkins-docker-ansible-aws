resource "aws_iam_role" "ec2_ssm_role" {
  name = "ec2-ssm-role"
assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}
# Attach SSM policy to the role
resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      
}

# Create an IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_ssm_instance_profile" {
  name = "ec2-ssm-instance-profile"
  role = aws_iam_role.ec2_ssm_role.name
}

# Security Group allowing SSH and port 5000
resource "aws_security_group" "allow_5000" {
  name        = "allow_5000"
  description = "Allow  port 5000 inbound traffic"

  
  ingress {
    from_port   = 5050
    to_port     = 5050
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Update to restrict access if needed
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Provision an EC2 instance with the updated security group
resource "aws_instance" "ec2_instance" {
  ami           = "ami-0fff1b9a61dec8a5f"  # Update with the appropriate AMI ID for your region
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_ssm_instance_profile.name

  vpc_security_group_ids = [aws_security_group.allow_5000.id]
  


  tags = {
    Name = "ssm-managed-ec2-instance"
  }

  # User data to install SSM agent if not pre-installed
  user_data = <<-EOF
    #!/bin/bash
    apt install -y amazon-ssm-agent
    systemctl enable amazon-ssm-agent
    systemctl start amazon-ssm-agent
    sudo apt-get update -y
    sudo apt-get install -y python3 python3-pip

# Install Boto3
pip3 install boto3
  EOF
}


data "aws_vpc" "default"{
  default = true
}






# resource "aws_ssm_parameter" "ssh_key" {
#   name        = "/myapp/ssh_key"
#   description = "SSH key for EC2 access"
#   type        = "SecureString"
#   value       = tls_private_key.ssh_key.private_key_pem
# }
