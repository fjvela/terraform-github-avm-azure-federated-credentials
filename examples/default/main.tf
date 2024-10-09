resource "azurerm_resource_group" "rg" {
  name     = module.naming.resource_group.name_unique
  location = local.region
  tags     = local.tags
}

module "test" {
  source              = "../../"
  region              = local.region
  tags                = local.tags
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  uid_role_assigment = [
    {
      scope                            = data.azurerm_subscription.current.id
      role_definition_name             = "Reader",
      skip_service_principal_aad_check = true
    }
  ]
}
