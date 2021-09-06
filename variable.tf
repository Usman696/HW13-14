variable "instance_type" {}

variable "region" {}

variable "server_port" {
    description = "The port the server will use for HTTP requests"
    type = number
    default = 80
}

variable "another_server_port" {
    description = "Another port the server can use for HTTP requests"
    type = number
    default = 443
}

variable "name" {}

variable "owner" {}

variable "project" {}
