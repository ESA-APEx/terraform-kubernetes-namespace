variable "name" {
  type        = string
  description = "The name of the namespace"
}

variable "labels" {
  type        = map(string)
  description = "Labels to add to the namespace"
}

variable "annotations" {
  type        = map(string)
  description = "Annotations to add to the namespace"
}
