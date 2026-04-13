```hcl
# Declaring variables

variable "folder_id" {
  type = string
}

variable "organization_id" {
  type = string
}

locals {
  sa_name        = "maxpatrol-sa"
  sa_reader_name = "maxpatrol-reader-sa"
  db_name        = "maxpatrol-db"
  yds_name       = "maxpatrol-stream"
  trail_name     = "maxpatrol-trail"
}

# Configuring the provider

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  folder_id = var.folder_id
}

# Creating service accounts

resource "yandex_iam_service_account" "maxpatrol-sa" {
  name = local.sa_name
}

resource "yandex_iam_service_account" "maxpatrol-reader-sa" {
  name = local.sa_reader_name
}

# Assigning roles to service accounts

resource "yandex_resourcemanager_folder_iam_member" "yds-writer" {
  folder_id = var.folder_id
  role      = "yds.writer"
  member    = "serviceAccount:${yandex_iam_service_account.maxpatrol-sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "yds-viewer" {
  folder_id = var.folder_id
  role      = "yds.viewer"
  member    = "serviceAccount:${yandex_iam_service_account.maxpatrol-reader-sa.id}"
}

resource "yandex_organizationmanager_organization_iam_binding" "audit-trails-viewer" {
  organization_id   = var.organization_id
  role              = "audit-trails.viewer"
  members = [
    "serviceAccount:${yandex_iam_service_account.maxpatrol-sa.id}",
  ]
}

# Creating a static access key for the service account

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.maxpatrol-reader-sa.id
}

# Creating a serverless YDB

resource "yandex_ydb_database_serverless" "maxpatrol-db" {
  name        = local.db_name
  folder_id   = var.folder_id
  sleep_after = 90
}

# Creating a YDB topic: Data Streams

resource "yandex_ydb_topic" "data-streams" {
  database_endpoint = yandex_ydb_database_serverless.maxpatrol-db.ydb_full_endpoint
  name              = local.yds_name
}

# Wait until the topic is created before creating the trail.

resource "time_sleep" "wait-for-topic" {
  depends_on      = [yandex_ydb_topic.data-streams]
  create_duration = "20s"
}

# Creating a trail

resource "yandex_audit_trails_trail" "maxpatrol-trail" {
  depends_on = [time_sleep.wait-for-topic]
  name                = local.trail_name
  folder_id           = var.folder_id
  service_account_id  = yandex_iam_service_account.maxpatrol-sa.id

  data_stream_destination {
    database_id = yandex_ydb_database_serverless.maxpatrol-db.id
    stream_name = local.yds_name
  }

  filtering_policy {
    management_events_filter {
      resource_scope {
        resource_id   = var.organization_id
        resource_type = "organization-manager.organization"
      }
    }
  }
}

output "static-access-key" {
  sensitive = true
  value = yandex_iam_service_account_static_access_key.sa-static-key.access_key
}

output "static-secret-key" {
  sensitive = true
  value = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
}

output "database-id" {
  sensitive = true
  value = yandex_ydb_database_serverless.maxpatrol-db.id
}
```