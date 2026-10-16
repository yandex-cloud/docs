```yaml
name: <trail_name>
folder_id: <folder_ID>
destination:
  object_storage:
    bucket_id: <bucket_name>
    object_prefix: <prefix_for_objects>
service_account_id: <service_account_ID>
filtering_policy:
  management_events_filter:
    resource_scopes:
      - id: <cloud_or_folder_organization_ID>
        type: <type>
  data_events_filters:
    - service: <service_name>
      resource_scopes:
        - id: <cloud_or_folder_organization_ID>
          type: <type>
      included_events:
        event_types:
          - <full_event_name>
```
