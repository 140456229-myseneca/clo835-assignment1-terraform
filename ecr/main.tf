resource "aws_ecr_repository" "ecr-app" {
  name                 = "clo835_assignment1"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "ecr-db" {
  name                 = "clo835-assignment1-db"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}