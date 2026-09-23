[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Audit Trails > Data Sources > audit_trails_trail

# yandex_audit_trails_trail (DataSource)

Get information about a trail. For information about the trail concept, see [official documentation](../../audit-trails/concepts/trail.md).

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

- `data_stream_destination` (*Read-Only*) (List Of Object). Structure describing destination data stream of the trail. Mutually exclusive with `logging_destination` and `storage_destination`.
  - `codec` . 
  - `database_id` . 
  - `stream_name` . 
- `description` (*Read-Only*) (String). The resource description.
- `filter` (*Read-Only*) (Set Of Object). Structure is deprecated. Use `filtering_policy` instead.
  - `event_filters` . 
    - `categories` . 
      - `plane` . 
      - `type` . 
    - `path_filter` . 
      - `any_filter` . 
        - `resource_id` . 
        - `resource_type` . 
      - `some_filter` . 
        - `any_filters` . 
          - `resource_id` . 
          - `resource_type` . 
        - `resource_id` . 
        - `resource_type` . 
    - `service` . 
  - `path_filter` . 
    - `any_filter` . 
      - `resource_id` . 
      - `resource_type` . 
    - `some_filter` . 
      - `any_filters` . 
        - `resource_id` . 
        - `resource_type` . 
      - `resource_id` . 
      - `resource_type` . 
- `filtering_policy` (*Read-Only*) (List Of Object). Structure describing event filtering process for the trail. Mutually exclusive with `filter`. At least one of the `management_events_filter` or `data_events_filter` fields will be filled.
  - `data_events_filter` . 
    - `dns_filter` . 
      - `include_nonrecursive_queries` . 
    - `exclude_rule` . 
      - `condition` . 
        - `field` . 
        - `operator` . 
        - `values` . 
    - `excluded_events` . 
    - `include_rule` . 
      - `condition` . 
        - `field` . 
        - `operator` . 
        - `values` . 
    - `included_events` . 
    - `resource_scope` . 
      - `resource_id` . 
      - `resource_type` . 
    - `service` . 
  - `management_events_filter` . 
    - `exclude_rule` . 
      - `condition` . 
        - `field` . 
        - `operator` . 
        - `values` . 
    - `include_rule` . 
      - `condition` . 
        - `field` . 
        - `operator` . 
        - `values` . 
    - `resource_scope` . 
      - `resource_id` . 
      - `resource_type` . 
- `folder_id` (*Read-Only*) (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `logging_destination` (*Read-Only*) (List Of Object). Structure describing destination log group of the trail. Mutually exclusive with `storage_destination` and `data_stream_destination`.
  - `log_group_id` . 
- `name` (*Read-Only*) (String). The resource name.
- `service_account_id` (*Read-Only*) (String). [Service account](../../iam/concepts/users/service-accounts.md) which linked to the resource.
- `status` (*Read-Only*) (String). Status of this trail.
- `storage_destination` (*Read-Only*) (List Of Object). Structure describing destination bucket of the trail. Mutually exclusive with `logging_destination` and `data_stream_destination`.
  - `bucket_name` . 
  - `object_prefix` . 
- `trail_id` (**Required**)(String). Trail ID.