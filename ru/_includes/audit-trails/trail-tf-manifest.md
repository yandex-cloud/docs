```hcl
resource "yandex_audit_trails_trail" "basic_trail" {
  name        = "<имя_трейла>"
  folder_id   = "<идентификатор_каталога>"
  description = "<описание_трейла>"
  labels = {
    key = "value"
  }
  service_account_id = "<идентификатор_сервисного_аккаунта>"


  # Должно быть указано только одно место назначения:
  # storage_destination , logging_destination, data_stream_destination
  # Настройки для всех мест назначения приведены для иллюстрации

  logging_destination {
    log_group_id = "<идентификатор_лог-группы>"
  }
  storage_destination {
    bucket_name   = "<идентификатор_бакета>"
    object_prefix = "<префикс>"
  }
  data_stream_destination {
    database_id = "<идентификатор_базы_данных_YDS>"
    stream_name = "<имя_потока_данных_YDS>"
  }

  # Настройки политики фильтрации

  filtering_policy {
    management_events_filter {
      resource_scope {
        resource_id   = "<идентификатор_организации>"
        resource_type = "resource-manager.organization"
      }
    }  
    data_events_filter {
      service = "<сервис>"
      included_events = ["<тип_событий_сервиса>","<тип_событий_сервиса_2>"]
      resource_scope {
        resource_id   = "<идентификатор_облака>"
        resource_type = "resource-manager.cloud"
      }
      resource_scope {
        resource_id   = "<идентификатор_каталога>"
        resource_type = "resource-manager.folder"
      }
    }
    data_events_filter {
      service = "<сервис_2>"
      resource_scope {
        resource_id   = "<идентификатор_облака_2>"
        resource_type = "resource-manager.cloud"
      }
      resource_scope {
        resource_id   = "<идентификатор_облака_3>"
        resource_type = "resource-manager.cloud"
      }
    }
    data_events_filter {
      service = "<сервис_3>"
      resource_scope {
        resource_id   = "<идентификатор_каталога_2>"
        resource_type = "resource-manager.folder"
      }
      resource_scope {
        resource_id   = "<идентификатор_каталога_3>"
        resource_type = "resource-manager.folder"
      }
    }
  }
}
```