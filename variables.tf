variable "key_name" {
  type        = string
  description = "The name for ssh key"
  default = "mykeypairsergey"
}

variable "cluster_name" {
  type        = string
  description = "The name of AWS ECS cluster"
  default = "om-cluster"
}