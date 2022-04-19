module "hasura-db" {
  source           = "github.com/terraform-google-modules/terraform-google-sql-db//modules/postgresql"
  name             = "db-talentz-dev"
  database_version = "POSTGRES_11"
  project_id = "talentz-portal"
  region =   "us-central1"
  zone =   "us-central1-c"
}
