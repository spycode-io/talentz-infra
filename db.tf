module "hasura-db" {
  source           = "GoogleCloudPlatform/sql-db/google"
  name             = "talentz"
  database_version = "POSTGRES_11"
}