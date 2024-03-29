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
  default     = "Assignment"
  type        = string
  description = "Name prefix"
}
