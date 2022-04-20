module "hasura" {
  source           = "./cloud-run"
  name             = "app-talentz-dev"
  project_id = "talentz-portal"
  project_number = "979311751876"
  region =   "us-central1"
  image = "gcr.io/talentz-portal/hasura-graphql-engine:v2.5.0"
  min_scale = 1
  max_scale = 2
  public_access = true
}
