variable "project_id" {
  description = "Project ID"
  type        = string
}

variable "region" {
  description = "Your region"
  type        = string
}

variable "zone" {
  description = "Your zone"
  type        = string
}

variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}