```hcl
resource "yandex_audit_trails_trail" "basic_trail" {
  name        = "<trail_name>"
  folder_id   = "<folder_ID>"
  description = "<trail_description>"
  labels = {
    key = "value"
  }
  service_account_id = "<service_account_ID>"


  # Only one destination must be specified:
  # storage_destination , logging_destination, data_stream_destination
  # Settings for all destinations are provided for illustration purposes.

  logging_destination {
    log_group_id = "<log_group_ID>"
  }
  storage_destination {
    bucket_name   = "<bucket_ID>"
    object_prefix = "<prefix>"
  }
  data_stream_destination {
    database_id = "<YDS_database_ID>"
    stream_name = "<YDS_name>"
  }

  # Filtering policy settings

  filtering_policy {
    management_events_filter {
      resource_scope {
        resource_id   = "<organization_ID>"
        resource_type = "resource-manager.organization"
      }
    }  
    data_events_filter {
      service = "<service>"
      included_events = ["<service_event_type>","<service_2_event_type>"]
      resource_scope {
        resource_id   = "<cloud_ID>"
        resource_type = "resource-manager.cloud"
      }
      resource_scope {
        resource_id   = "<folder_ID>"
        resource_type = "resource-manager.folder"
      }
    }
    data_events_filter {
      service = "<service_2>"
      resource_scope {
        resource_id   = "<ID_of_cloud_2>"
        resource_type = "resource-manager.cloud"
      }
      resource_scope {
        resource_id   = "<cloud_3_ID>"
        resource_type = "resource-manager.cloud"
      }
    }
    data_events_filter {
      service = "<service_3>"
      resource_scope {
        resource_id   = "<folder_2_ID>"
        resource_type = "resource-manager.folder"
      }
      resource_scope {
        resource_id   = "<folder_3_ID>"
        resource_type = "resource-manager.folder"
      }
    }
  }
}
```