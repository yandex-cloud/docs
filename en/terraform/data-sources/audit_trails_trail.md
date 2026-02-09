---
subcategory: Audit Trails
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/audit_trails_trail.md
---

# yandex_audit_trails_trail (DataSource)

Get information about a trail. For information about the trail concept, see [official documentation](https://yandex.cloud/docs/audit-trails/concepts/trail).

## Example usage

```terraform
//
// Get information about existing Audit Trails Trail
//
data "yandex_audit_trails_trail" "basic-trail" {
  trail_id = "cnpqe**********sh835"
}
```

## Arguments & Attributes Reference

- `data_stream_destination` [Block]. Structure describing destination data stream of the trail. Mutually exclusive with `logging_destination` and `storage_destination`.
  - `codec` (String). Codec for compressing events. Allowed values: RAW, GZIP, ZSTD. Default: RAW
  - `database_id` (**Required**)(String). ID of the [YDB](https://yandex.cloud/docs/ydb/concepts/resources) hosting the destination data stream.
  - `stream_name` (**Required**)(String). Name of the [YDS stream](https://yandex.cloud/docs/data-streams/concepts/glossary#stream-concepts) belonging to the specified YDB.
- `description` (String). The resource description.
- `filter` [Block]. Structure is deprecated. Use `filtering_policy` instead.
  - `event_filters` [Block]. Deprecated.
    - `categories` [Block]. Deprecated.
      - `plane` (**Required**)(String). Deprecated.
      - `type` (**Required**)(String). Deprecated.
    - `path_filter` [Block]. Deprecated.
      - `any_filter` [Block]. Deprecated.
        - `resource_id` (**Required**)(String). Resource ID.
        - `resource_type` (**Required**)(String). Resource type.
      - `some_filter` [Block]. Deprecated.
        - `any_filters` [Block]. Deprecated.
          - `resource_id` (**Required**)(String). Resource ID.
          - `resource_type` (**Required**)(String). Resource type.
        - `resource_id` (**Required**)(String). Deprecated.
        - `resource_type` (**Required**)(String). Deprecated.
    - `service` (**Required**)(String). Deprecated.
  - `path_filter` [Block]. Deprecated.
    - `any_filter` [Block]. Deprecated.
      - `resource_id` (**Required**)(String). Resource ID.
      - `resource_type` (**Required**)(String). Resource type.
    - `some_filter` [Block]. Deprecated.
      - `any_filters` [Block]. Deprecated.
        - `resource_id` (**Required**)(String). Resource ID.
        - `resource_type` (**Required**)(String). Resource type.
      - `resource_id` (**Required**)(String). Deprecated.
      - `resource_type` (**Required**)(String). Deprecated.
- `filtering_policy` [Block]. Structure describing event filtering process for the trail. Mutually exclusive with `filter`. At least one of the `management_events_filter` or `data_events_filter` fields will be filled.
  - `data_events_filter` [Block]. Structure describing filtering process for the service-specific data events.
    - `dns_filter` [Block]. Specific filter for DNS service.
      - `include_nonrecursive_queries` (**Required**)(Bool). All types of queries will be delivered.
    - `excluded_events` (List Of String). A list of events that won't be gathered by the trail from this service. New events will be automatically gathered when this option is specified. Mutually exclusive with `included_events`.
    - `included_events` (List Of String). A list of events that will be gathered by the trail from this service. New events won't be gathered by default when this option is specified. Mutually exclusive with `excluded_events`.
    - `resource_scope` [Block]. Structure describing that events will be gathered from the specified resource.
      - `resource_id` (**Required**)(String). Resource ID.
      - `resource_type` (**Required**)(String). Resource type.
    - `service` (**Required**)(String). ID of the service which events will be gathered.
  - `management_events_filter` [Block]. Structure describing filtering process for management events.
    - `resource_scope` [Block]. Structure describing that events will be gathered from the specified resource.
      - `resource_id` (**Required**)(String). Resource ID.
      - `resource_type` (**Required**)(String). Resource type.
- `folder_id` (**Required**)(String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `logging_destination` [Block]. Structure describing destination log group of the trail. Mutually exclusive with `storage_destination` and `data_stream_destination`.
  - `log_group_id` (**Required**)(String). ID of the destination [Cloud Logging Group](https://yandex.cloud/docs/logging/concepts/log-group).
- `name` (**Required**)(String). The resource name.
- `service_account_id` (**Required**)(String). [Service account](https://yandex.cloud/docs/iam/concepts/users/service-accounts) which linked to the resource.
- `status` (*Read-Only*) (String). Status of this trail.
- `storage_destination` [Block]. Structure describing destination bucket of the trail. Mutually exclusive with `logging_destination` and `data_stream_destination`.
  - `bucket_name` (**Required**)(String). Name of the [destination bucket](https://yandex.cloud/docs/storage/concepts/bucket).
  - `object_prefix` (String). Additional prefix of the uploaded objects. If not specified, objects will be uploaded with prefix equal to `trail_id`.
- `trail_id` (*Read-Only*) (String). ID of the trail resource.


