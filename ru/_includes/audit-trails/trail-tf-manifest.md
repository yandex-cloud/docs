```hcl
resource "yandex_audit_trails_trail" "basic_trail" {
  name        = "<имя_трейла>"
  folder_id   = "<идентификатор_каталога>"
  description = "<описание_трейла>"
  labels = {
    key = "value"
  }
  service_account_id = "<идентификатор_сервисного_аккаунта>"

  storage_destination {
    bucket_name   = "<имя_бакета>"
    object_prefix = "<префикс>"
  }

  filtering_policy {
    management_events_filter {
      resource_scope {
        resource_id   = "<идентификатор_организации_облака_или_каталога>"
        resource_type = "<тип>"
      }
    }

    data_events_filter {
      service         = "<имя_сервиса>"
      included_events = ["<полное_имя_события>"]

      resource_scope {
        resource_id   = "<идентификатор_организации_облака_или_каталога>"
        resource_type = "<тип>"
      }
    }
  }
}
```
