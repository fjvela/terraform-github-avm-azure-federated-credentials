variable "region" {

}

variable "tags" {

}

variable "location" {

}

variable "resource_group_name" {

}

variable "github_organization_name" {
  description = "Name of the GitHub organization"
  default     = "fjvela"
}

variable "branches" {
  description = "List of git branches to add as subject to the federated identity credential"
  default = [
    "main"
  ]
}
variable "uid_role_assigment" {
  type = list(object({
    scope                            = string
    role_definition_name             = string
    skip_service_principal_aad_check = bool
    })
  )
}

variable "github_repository_name" {
  description = "Name of the repository to setup the secrets needed"
  default     = "blog-demo-federated-identity-credential"
}
