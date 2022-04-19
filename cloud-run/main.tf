# data "google_project" "project" {
# }

resource "google_cloud_run_service" "this" {
  
  name     = var.name
  location = var.region

  template {
    spec {
      containers {
        image = var.image

        dynamic "env" {
          for_each = var.env_vars
          content {
            name  = env.value.name
            value = env.value.value
          }
        }

        dynamic "env" {
          for_each = var.secret_refs
          content {
            name = env.value.name
            value_from {
              secret_key_ref {
                name = env.value.secret_id
                key  = env.value.key
              }
            }
          }
        }

        dynamic "ports" {
          for_each = var.ports
          content {
            name           = ports.value.name
            container_port = ports.value.container_port
          }
        }
      }
    }

    metadata {
      annotations = merge( 
        var.annotations,
        {
          #"run.googleapis.com/ingress"       = var.public_access ? "all" : "internal"
          "autoscaling.knative.dev/minScale" = var.min_scale
          "autoscaling.knative.dev/maxScale" = var.max_scale
        }
      )
    }
  }
  
  autogenerate_revision_name = true

  traffic {
    percent         = 100
    latest_revision = true
  }

  lifecycle {
    ignore_changes = [
      metadata.0.annotations,
    ]
  }
}

# resource "google_cloud_run_service_iam_member" "allUsers" {
#   service  = google_cloud_run_service.this.name
#   location = google_cloud_run_service.this.location
#   role     = "roles/run.invoker"
#   member   = "allUsers"
# }

# resource "google_secret_manager_secret_iam_member" "secret_access" {
#   count = length(var.secret_refs)
#   secret_id = var.secret_refs[count.index].secret_id
#   role      = "roles/secretmanager.secretAccessor"
#   member    = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
# }
