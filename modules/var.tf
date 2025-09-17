variable "env" {
  description = "The environment name (e.g., dev, staging, prod)"
}

variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "project" {
  description = "The project name"
}

variable "ami" {
  description = "The Amazon Machine Image (AMI) ID"
}

variable "instance_type" {
  description = "The type of instance to use"
}

variable "length" {
  description = "The length value to use (e.g., for count)"
}

variable "subnet_id" {
  description = "The ID of the subnet"
}

variable "key_name" {
  description = "The key name for SSH access"
}

variable "ssh_ports" {
  description = "The ports to open for SSH access"
}

variable "ssh_cidr_block" {
  description = "The CIDR block to allow SSH access from"
}

variable "web_cidr_blocks" {
  description = "The CIDR blocks to allow web access from"
}

variable "web_ports" {
  description = "The ports to open for web access"
}

variable "volume_size" {
  description = "The size of the EBS volume in GB"
}

variable "volume_type" {
  description = "The type of the EBS volume"
}

variable "encrypted" {
  description = "Whether to encrypt the EBS volume"
  type        = bool
  default     = false
}

variable "delete_on_termination" {
  description = "Whether to delete the volume on termination"
  type        = bool
  default     = true
}

variable "load_balancer" {
  description = "Whether to create the load balancer and related resources"
  type        = bool
  default     = false
}

variable "eip" {
  description = "Whether to create the eip"
  type        = bool
  default     = false
}

variable "iam_role" {
  description = "IAM role for ec2"
  default     = ""
}
