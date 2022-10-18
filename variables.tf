variable "aws_access_key" {
  type        = string
  default = "<your aws access key>"
  description = "AWS Access Key. Programmable API access key needed for creating the site"
}

variable "aws_secret_key" {
  type        = string
  default = "<your aws secret>"
  description = "AWS Secret Access Key. Programmable API secret access key needed for creating the site"
}

variable "aws_region" {
  type        = string
  default = "<aws-region>"
  description = "AWS Region where Site will be created"
}

variable "api_url" {
    type = string
    default = "https://<tenant-name>.console.ves.volterra.io/api"
}
variable "prefix" {
  type        = string
  description = "CE Name. Also used as a prefix in names of related resources."
  default     = "<your CE name>"
}

variable "aws_az" {
  type        = string
  description = "AWS Availability Zone in which the site will be created"
  default     = "<your aws AZ>"
}

variable "aws_vpc_cidr" {
  type        = string
  description = "AWS VPC CIDR, that will be used to create the vpc while creating the site"
  default     = "<your aws cidr>"
}

variable "site_disk_size" {
  type        = number
  description = "Disk size in GiB"
  default     = 80
}

variable "aws_instance_type" {
  type        = string
  description = "AWS instance type used for the Volterra site"
  default     = "t3.2xlarge"
}

variable "aws_subnet_ce_cidr" {
  type        = map(string)
  description = "Map to hold different CE cidr with key as name of subnet"
  default = {
    "outside"  = "<your aws cidr for outside>"
  }
}


variable "ssh_public_key" {
  type        = string
  description = "SSH Public Key"
  default     = "<your public key"
}
