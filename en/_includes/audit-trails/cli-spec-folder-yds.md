```yml
folder_id: b1g9d2k0itu4********
name: sample-trail
description: My very first trail
labels:
  key: value
destination:
  data_stream:
    database_id: etnneuucptkf********
    stream_name: sample-stream
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