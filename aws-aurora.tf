# ============================================================
# AURORA DB SUBNET GROUP
# ============================================================

resource "aws_db_subnet_group" "lab03_aurora" {
  name = "lab03-aurora-subnet-group"

  subnet_ids = [
    aws_subnet.lab03_public_subnet.id,
    aws_subnet.lab03_test_subnet.id,
    aws_subnet.lab03_prod_subnet.id
  ]

  tags = {
    Name = "LAB03-Aurora-Subnet-Group"
  }
}


# ============================================================
# AURORA DEV
# ============================================================

resource "aws_rds_cluster" "lab03_dev" {
  cluster_identifier = "lab03-aurora-dev"
  engine             = "aurora-postgresql"

  master_username = "postgres"
  master_password = "Postgres1234!"

  database_name = "paylite"

  db_subnet_group_name   = aws_db_subnet_group.lab03_aurora.name
  vpc_security_group_ids = [aws_security_group.lab03_sg.id]

  skip_final_snapshot = true

  tags = {
    Name = "LAB03-Aurora-DEV"
  }
}

resource "aws_rds_cluster_instance" "lab03_dev" {
  identifier         = "lab03-aurora-dev-instance"
  cluster_identifier = aws_rds_cluster.lab03_dev.id

  instance_class = "db.t3.medium"
  engine         = "aurora-postgresql"

  publicly_accessible = true

  tags = {
    Name = "LAB03-Aurora-DEV-Instance"
  }
}


# ============================================================
# AURORA TEST
# ============================================================

resource "aws_rds_cluster" "lab03_test" {
  cluster_identifier = "lab03-aurora-test"
  engine             = "aurora-postgresql"

  master_username = "postgres"
  master_password = "Postgres1234!"

  database_name = "paylite"

  db_subnet_group_name   = aws_db_subnet_group.lab03_aurora.name
  vpc_security_group_ids = [aws_security_group.lab03_sg.id]

  skip_final_snapshot = true

  tags = {
    Name = "LAB03-Aurora-TEST"
  }
}

resource "aws_rds_cluster_instance" "lab03_test" {
  identifier         = "lab03-aurora-test-instance"
  cluster_identifier = aws_rds_cluster.lab03_test.id

  instance_class = "db.t3.medium"
  engine         = "aurora-postgresql"

  publicly_accessible = true

  tags = {
    Name = "LAB03-Aurora-TEST-Instance"
  }
}


# ============================================================
# AURORA PROD
# ============================================================

resource "aws_rds_cluster" "lab03_prod" {
  cluster_identifier = "lab03-aurora-prod"
  engine             = "aurora-postgresql"

  master_username = "postgres"
  master_password = "Postgres1234!"

  database_name = "paylite"

  db_subnet_group_name   = aws_db_subnet_group.lab03_aurora.name
  vpc_security_group_ids = [aws_security_group.lab03_sg.id]

  skip_final_snapshot = true

  tags = {
    Name = "LAB03-Aurora-PROD"
  }
}

resource "aws_rds_cluster_instance" "lab03_prod" {
  identifier         = "lab03-aurora-prod-instance"
  cluster_identifier = aws_rds_cluster.lab03_prod.id

  instance_class = "db.t3.medium"
  engine         = "aurora-postgresql"

  publicly_accessible = true

  tags = {
    Name = "LAB03-Aurora-PROD-Instance"
  }
}