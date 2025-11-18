
variable "server_http_port" {
  description = "The Port for the server"
  type        = number
  default     = 80
}

variable "region" {
  description = "region specified here"
  type        = string
  default     = "ap-south-1"
}

variable "tester_ip" {
  description = "Variable for storing tester's ip"
  type        = string
}
