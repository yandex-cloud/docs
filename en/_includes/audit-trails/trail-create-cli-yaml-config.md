
```yaml
name: <trail_name>
folder_id: <folder_ID>
destination:
  # Only one destination must be specified:
  # object_storage, cloud_logging, data_stream
  # Settings for all destinations are provided for illustration purposes.
  object_storage:
    bucket_id: <bucket_name>
    object_prefix: <prefix_for_objects>
  cloud_logging:
    log_group_id: <log_group_ID>
  data_stream:
    stream_name: <YDS_name>
    database_id: <YDS_database_ID>
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
      # You can specify either `included_events` or `excluded_events`, or skip both parameters to collect all service events.
      # 
      # Both parameters are provided for illustration purposes.
      included_events:
        event_types:
          - <these_events_will_be_collected>
      excluded_events:
        event_types:
          - <these_events_will_not_be_collected>
```