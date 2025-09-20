variable "region" {
  type    = string
  default = "ap-northeast-3"   # Changed to Osaka region
}

variable "vpc_id" {
  type    = string
  default = "vpc-00ffe463659a905fd"
}

variable "subnet_id" {
  type    = string
  default = "subnet-0ebe6dc14cd0b7262"   # Your subnet ID we found earlier
}

variable "key_name" {
  type    = string
  default = "afriture_lab_key"
}

variable "public_key_path" {
  type    = string
  default = "~/.ssh/afriture_lab_key.pub"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"   # Free tier eligible
}