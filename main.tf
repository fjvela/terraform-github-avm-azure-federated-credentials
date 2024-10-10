resource "azurerm_user_assigned_identity" "uid" {
  name                = "gh-${var.github_organization_name}-${var.github_repository_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_role_assignment" "uid_role_assigment" {
  for_each = { for role in var.uid_role_assigment : "${role.scope}-${role.role_definition_name}" => role }

  principal_id                     = azurerm_user_assigned_identity.uid.principal_id
  principal_type                   = "ServicePrincipal"
  scope                            = each.value.scope
  role_definition_name             = each.value.role_definition_name
  skip_service_principal_aad_check = true
}

resource "azurerm_federated_identity_credential" "federated_identity_credential_branches" {
  for_each = toset(var.branches)

  name                = "gh-${var.github_organization_name}-${var.github_repository_name}-${each.value}"
  resource_group_name = var.resource_group_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = "https://token.actions.githubusercontent.com"
  parent_id           = azurerm_user_assigned_identity.uid.id
  subject             = "repo:${var.github_organization_name}/${var.github_repository_name}:ref:refs/heads/${each.value}"
}

resource "azurerm_federated_identity_credential" "federated_identity_credential_environments" {
  for_each = toset(var.environments)

  name                = "gh-${var.github_organization_name}-${var.github_repository_name}-${each.value}"
  resource_group_name = var.resource_group_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = "https://token.actions.githubusercontent.com"
  parent_id           = azurerm_user_assigned_identity.uid.id
  subject             = "repo:${var.github_organization_name}/${var.github_repository_name}:environment:${each.value}"
}

# GitHub Setup
data "github_repository" "this" {
  name = var.github_repository_name
}

resource "github_actions_secret" "azure_client_id" {
  repository      = data.github_repository.this.name
  secret_name     = "AZURE_CLIENT_ID"
  plaintext_value = azurerm_user_assigned_identity.uid.client_id
}

resource "github_actions_secret" "azure_tenant_id" {
  repository      = data.github_repository.this.name
  secret_name     = "AZURE_TENANT_ID"
  plaintext_value = data.azurerm_subscription.current.tenant_id
}

resource "github_actions_secret" "azure_subscription_id" {
  repository      = data.github_repository.this.name
  secret_name     = "AZURE_SUBSCRIPTION_ID"
  plaintext_value = data.azurerm_subscription.current.subscription_id
}
