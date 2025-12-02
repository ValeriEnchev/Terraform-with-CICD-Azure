# •	Resource group name
variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}
# •	Resource group location
variable "resource_group_location" {
  description = "The location of the resource group."
  type        = string
}
# •	App service plan name
variable "app_service_plan_name" {
  description = "The name of the app service plan."
  type        = string
}
# •	App service name
variable "app_service_name" {
  description = "The name of the app service."
  type        = string
}
# •	SQL server name
variable "sql_server_name" {
  description = "The name of the SQL server."
  type        = string
}
# •	SQL database name
variable "sql_database_name" {
  description = "The name of the SQL database."
  type        = string
}
# •	SQL administrator login username
variable "sql_administrator_login" {
  description = "The SQL administrator login username."
  type        = string
}
# •	SQL administrator password
variable "sql_administrator_password" {
  description = "The SQL administrator login password."
  type        = string
  sensitive   = true
}
# •	Firewall rule name  
variable "firewall_rule_name" {
  description = "The name of the firewall rule."
  type        = string
}
# •	GitHub repo URL
variable "github_repo_url" {
  description = "The URL of the GitHub repository."
  type        = string
}
# •	GitHub branch
variable "github_branch" {
  description = "The branch of the GitHub repository."
  type        = string
}
# •	Random integer upper limit
variable "random_integer_upper_limit" {
  description = "The upper limit for the random integer."
  type        = number
  default     = 10000
}
# •	SQL database collation
variable "sql_database_collation" {
  description = "The collation of the SQL database."
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}
# •	SQL database license type
variable "sql_database_license_type" {
  description = "The license type of the SQL database."
  type        = string
  default     = "LicenseIncluded"
}
# •	SQL database max size in GB
variable "sql_database_max_size_gb" {
  description = "The maximum size of the SQL database in GB."
  type        = number
  default     = 2
}
# •	SQL database SKU name
variable "sql_database_sku_name" {
  description = "The SKU name of the SQL database."
  type        = string
  default     = "S0"
}
# •	SQL database zone redundancy
variable "sql_database_zone_redundant" {
  description = "Whether the SQL database is zone redundant."
  type        = bool
  default     = false
}
# •	SQL database geo backup enabled
variable "sql_database_geo_backup_enabled" {
  description = "Whether geo backup is enabled for the SQL database."
  type        = bool
  default     = false
}
# •	SQL database storage account type
variable "sql_database_storage_account_type" {
  description = "The storage account type of the SQL database."
  type        = string
  default     = "Local"
}
# •	App service .NET version
variable "app_service_dotnet_version" {
  description = "The .NET version for the app service."
  type        = string
  default     = "6.0"
}
# •	App service always on
variable "app_service_always_on" {
  description = "Whether the app service is always on."
  type        = bool
  default     = false
}
# •	App service plan OS type
variable "app_service_plan_os_type" {
  description = "The OS type of the app service plan."
  type        = string
  default     = "Linux"
}
# •	App service plan SKU name
variable "app_service_plan_sku_name" {
  description = "The SKU name of the app service plan."
  type        = string
  default     = "F1"
}
# •	SQL server version
variable "sql_server_version" {
  description = "The version of the SQL server."
  type        = string
  default     = "12.0"
}

# •	Firewall rule start IP address
variable "firewall_rule_start_ip_address" {
  description = "The start IP address for the firewall rule."
  type        = string
}
# •	Firewall rule end IP address
variable "firewall_rule_end_ip_address" {
  description = "The end IP address for the firewall rule."
  type        = string
}
# •	Database connection string template
variable "database_connection_string_template" {
  description = "The template for the database connection string."
  type        = string
  default     = "Data Source=tcp:%s,1433;Initial Catalog=%s;User ID=%s;Password=%s;Trusted_Connection=False; MultipleActiveResultSets=True;"
}
# subscription id 
variable "subscription_id" {
  description = "The Azure subscription ID."
  type        = string
}
