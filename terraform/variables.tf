variable "region" {
  type = string
  description = "this is the region ec2 will be deployed "
}
variable "public_key" {
  description = "The public SSH key"
  type        = string
}
