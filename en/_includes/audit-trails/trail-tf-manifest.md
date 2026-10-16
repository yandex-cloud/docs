```hcl
resource "yandex_audit_trails_trail" "basic_trail" {
  name        = "<trail_name>"
  folder_id   = "<folder_ID>"
  description = "<trail_description>"
  labels = {
    key = "value"
  }
  service_account_id = "<service_account_ID>"

  storage_destination {
    bucket_name   = "<bucket_name>"
    object_prefix = "<prefix>"
  }

  filtering_policy {
    management_events_filter {
      resource_scope {
        resource_id   = "<cloud_or_folder_organization_ID>"
        resource_type = "<type>"
      }
    }

    data_events_filter {
      service         = "<service_name>"
      included_events = ["<full_event_name>"]

      resource_scope {
        resource_id   = "<cloud_or_folder_organization_ID>"
        resource_type = "<type>"
      }
    }
  }
}
```
