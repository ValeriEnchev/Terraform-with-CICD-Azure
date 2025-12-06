terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.54.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
  backend "azurerm" {
    resource_group_name  = "StorageRG"
    storage_account_name = "storagevenchev70"
    container_name       = "taskboardcontainer"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {
  }
  subscription_id = var.subscription_id
}

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_resource_group" "arg" {
  name     = "${var.resource_group_name}-${random_integer.ri.result}"
  location = var.resource_group_location
}

resource "azurerm_service_plan" "asp" {
  name                = "${var.app_service_plan_name}-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.arg.name
  location            = azurerm_resource_group.arg.location
  os_type             = var.app_service_plan_os_type
  sku_name            = var.app_service_plan_sku_name
}

resource "azurerm_linux_web_app" "alwa" {
  name                = "${var.app_service_name}-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.arg.name
  location            = azurerm_service_plan.asp.location
  service_plan_id     = azurerm_service_plan.asp.id

  connection_string {
    name  = "DefaultConnection"
    type  = "SQLAzure"
    value = "Data Source=tcp:${azurerm_mssql_server.sql.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.database.name};User ID=${azurerm_mssql_server.sql.administrator_login};Password=${azurerm_mssql_server.sql.administrator_login_password};Trusted_Connection=False; MultipleActiveResultSets=True;"
  }

  site_config {
    application_stack {
      dotnet_version = var.app_service_dotnet_version
    }
    always_on = var.app_service_always_on
  }
}

resource "azurerm_mssql_server" "sql" {
  name                         = "${var.sql_server_name}-${random_integer.ri.result}"
  resource_group_name          = azurerm_resource_group.arg.name
  location                     = azurerm_resource_group.arg.location
  version                      = var.sql_server_version
  administrator_login          = var.sql_administrator_login
  administrator_login_password = var.sql_administrator_password
}

resource "azurerm_mssql_database" "database" {
  name                 = "${var.sql_database_name}-${random_integer.ri.result}"
  server_id            = azurerm_mssql_server.sql.id
  collation            = var.sql_database_collation
  license_type         = "LicenseIncluded"
  max_size_gb          = var.sql_database_max_size_gb
  sku_name             = var.sql_database_sku_name
  zone_redundant       = var.sql_database_zone_redundant
  geo_backup_enabled   = var.sql_database_geo_backup_enabled
  storage_account_type = var.sql_database_storage_account_type

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_mssql_firewall_rule" "FirewallRule1" {
  name             = var.firewall_rule_name
  server_id        = azurerm_mssql_server.sql.id
  start_ip_address = var.firewall_rule_start_ip_address
  end_ip_address   = var.firewall_rule_end_ip_address
}


resource "azurerm_app_service_source_control" "github" {
  app_id                 = azurerm_linux_web_app.alwa.id
  repo_url               = var.github_repo_url
  branch                 = var.github_branch
  use_manual_integration = true
}
