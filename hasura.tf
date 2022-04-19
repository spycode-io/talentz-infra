module "hasura" {
  source           = "./cloud-run"
  name             = "app-talentz-dev"
  project_id = "talentz-portal"
  region =   "us-central1"
  image = "hasura/graphql-engine:v2.5.0.cli-migrations-v3"
  min_scale = 1
  max_scale = 2
  public_access = true
}
