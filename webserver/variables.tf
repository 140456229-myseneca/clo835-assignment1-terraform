# Default tags
variable "default_tags" {
  default = {
    "Owner" = "mamad",
    "App"   = "Assignment1",
    "Course" = "CLO835"
  }
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}

variable "prefix" {
  default     = "clo835-assignment"
  type        = string
  description = "Name prefix"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "type of the ec2 instance"
  type        = string
}