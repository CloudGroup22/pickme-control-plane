# Create a security group for the RDS instance
resource "aws_security_group" "rds-sg" {
  name   = "rds-security-group"
  vpc_id = aws_vpc.pickme_vpc.id

  # Allow incoming traffic from any source on the RDS port
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "ingress" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.rds-sg.id
  source_security_group_id = aws_security_group.rds-sg.id
}

# Create the RDS instance
resource "aws_db_instance" "pickme_db" {
  identifier              = "tfpickmefood"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0.28"
  instance_class          = "db.t3.micro"
  db_name                 = "pickmedb"
  username                = "pickme_admin"
  password                = "pickme123#"
  vpc_security_group_ids  = [aws_security_group.rds-sg.id]
  db_subnet_group_name = aws_db_subnet_group.pickme-subnet.name
  publicly_accessible = true
  skip_final_snapshot = true
  # Enable deletion protection to prevent accidental deletion
#  deletion_protection = true
}