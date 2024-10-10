variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags which should be assigned to the User Assigned Identity."
  default     = {}
}

variable "location" {
  type        = string
  description = "(Required) The Azure Region where the User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Specifies the name of the Resource Group within which this User Assigned Identity should exist. Changing this forces a new User Assigned Identity to be created."
}

variable "github_organization_name" {
  type        = string
  description = "Name of the GitHub organization"
}

variable "branches" {
  type        = list(string)
  description = "List of git branches to add as subject to the federated identity credential"
  default     = []
}

variable "environments" {
  type        = list(string)
  description = "List of environments to add as subject to the federated identity credential"
  default     = []
}

variable "uid_role_assigment" {
  type = list(object({
    scope                = string
    role_definition_name = string
    })
  )
  description = <<DESCRIPTION
  A list of roles to assign to the User Managed Identity created
  - (Required) The scope at which the Role Assignment applies to, such as /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333, /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup, or /subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup/providers/Microsoft.Compute/virtualMachines/myVM, or /providers/Microsoft.Management/managementGroups/myMG. Changing this forces a new resource to be created.
  - (Required) The name of a built-in Role. Changing this forces a new resource to be created.
  DESCRIPTION
  default     = []
}

variable "github_repository_name" {
  type        = string
  description = "Name of the repository to setup the secrets needed"
}
