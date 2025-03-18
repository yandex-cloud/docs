
```yaml
name: <имя_трейла>
folder_id: <идентификатор_каталога>
destination:
  # Должно быть указано только одно место назначения:
  # object_storage, cloud_logging, data_stream
  # Настройки для всех мест назначения приведены для иллюстрации
  object_storage:
    bucket_id: <имя_бакета>
    object_prefix: <префикс_для_объектов>
  cloud_logging:
    log_group_id: <идентификатор_лог_группы>
  data_stream:
    stream_name: <имя_потока_данных_YDS>
    database_id: <идентификатор_базы_данных_YDS>
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
      # Допустимо указать либо included_events, либо excluded_events,
      # либо не указывать оба этих параметра, чтобы собирались все события сервиса
      # Оба параметра приведены для иллюстрации
      included_events:
        event_types:
          - <эти_события_будут_собираться>
      excluded_events:
        event_types:
          - <эти_события_не_будут_собираться>
```