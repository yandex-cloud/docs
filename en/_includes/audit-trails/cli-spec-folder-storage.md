```yml
folder_id: b1g9d2k0itu4********
name: sample-trail
description: My very first trail
labels:
  key: value
destination:
  object_storage:
    bucket_id: at-destination-bucket
    object_prefix: sample-trail-audit-logs
service_account_id: ajeee339l4m5********
filter:
  path_filter:
    root:
      any_filter:
        resource:
          id: b1g9d2k0itu4********
          type: resource-manager.folder
  event_filter:
    filters:
      - service: mdb.postgresql
        categories:
          - plane: DATA_PLANE
            type: WRITE
        path_filter:
          root:
            any_filter:
              resource:
                id: b1g9d2k0itu4********
                type: resource-manager.folder
      - service: dns
        categories:
          - plane: DATA_PLANE
            type: READ
        path_filter:
          root:
            any_filter:
              resource:
                id: b1g9d2k0itu4********
                type: resource-manager.folder
```