variable "internal_port" {
  description = "Port exposed by the container"
  type        = number
  default     = 9876
}

variable "external_port" {
  description = "Port exposed on the host"
  type        = number
  default     = 5432
}

variable "container_name" {
  description = "Name of the Docker container"
  type        = string
  default     = "Alta3ResearchWebService"
}

