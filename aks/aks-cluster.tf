data "azurerm_resource_group" "ebook-tutorial" {
  name = "ebook-tutorial"
}
data "azurerm_key_vault" "ebook" {
  name                = "ebook"
  resource_group_name = data.azurerm_resource_group.ebook-tutorial.name
}

data "azurerm_key_vault_secret" "client-id" {
  name         = "client-id"
  key_vault_id = data.azurerm_key_vault.ebook.id
}

data "azurerm_key_vault_secret" "client-secret" {
  name         = "client-secret"
  key_vault_id = data.azurerm_key_vault.ebook.id
}

resource "azurerm_kubernetes_cluster" "ebook-cluster" {
  name                = "ebook-aks"
  location            = data.azurerm_resource_group.ebook-tutorial.location
  resource_group_name = data.azurerm_resource_group.ebook-tutorial.name
  dns_prefix          = "ebook-k8s"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = data.azurerm_key_vault_secret.client-id.value
    client_secret = data.azurerm_key_vault_secret.client-secret.value
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    environment = "Demo"
  }
}


#{ cmd + option + error
#  "appId": "8a2afed7-922a-4b79-8d6d-61ffc0143516",
#  "displayName": "azure-cli-2021-10-08-02-46-43",
#  "name": "8a2afed7-922a-4b79-8d6d-61ffc0143516",
#  "password": "TCi3G1kBFvKANwVYXpqib8FrFem_-0CaHC",
#  "tenant": "cf123846-52f3-43cf-8f6c-30c24ab62186"
#}