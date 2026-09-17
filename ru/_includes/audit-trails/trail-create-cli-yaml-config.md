```yaml
name: <имя_трейла>
folder_id: <идентификатор_каталога>
destination:
  object_storage:
    bucket_id: <имя_бакета>
    object_prefix: <префикс_для_объектов>
service_account_id: <идентификатор_сервисного_аккаунта>
filtering_policy:
  management_events_filter:
    resource_scopes:
      - id: <идентификатор_организации_облака_или_каталога>
        type: <тип>
  data_events_filters:
    - service: <имя_сервиса>
      resource_scopes:
        - id: <идентификатор_организации_облака_или_каталога>
          type: <тип>
      included_events:
        event_types:
          - <полное_имя_события>
```
