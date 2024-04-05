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
service_account_id: ajeee339l4m58********
filter:
  path_filter:
    root:
      some_filter:
        resource:
          id: bpfaidqca8vd********
          type: organization-manager.organization
        filters:
          - any_filter:
              resource:
                id: b1glti4eser3********
                type: resource-manager.cloud
          - any_filter:
              resource:
                id: b1gssd27h7ra********
                type: resource-manager.cloud
  event_filter:
    filters:
      - service: mdb.postgresql
        categories:
          - plane: DATA_PLANE
            type: WRITE
        path_filter:
          root:
            some_filter:
              resource:
                id: bpfaidqca8vd********
                type: organization-manager.organization
              filters:
                - any_filter:
                    resource:
                      id: b1glti4eser3********
                      type: resource-manager.cloud
                - any_filter:
                    resource:
                      id: b1gssd27h7ra********
                      type: resource-manager.cloud
      - service: dns
        categories:
          - plane: DATA_PLANE
            type: READ
        path_filter:
          root:
            any_filter:
              resource:
                id: bpfaidqca8vd********
                type: organization-manager.organization
```