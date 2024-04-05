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
            any_filter:
              resource:
                id: bpfaidqca8vd********
                type: organization-manager.organization
      - service: kms
        categories:
          - plane: DATA_PLANE
            type: READ
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
```