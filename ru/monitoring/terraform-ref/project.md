# ycp_monitoring_project (Resource)

Monitoring project, can be created only in some monitoring installations

## Schema

### Required

- `abc_service` (String) Project ABC service
- `name` (String) Project name
- `project_id` (String) Project identifier, will be copied to ID

### Optional

- `description` (String) Project description
- `id` (String) The ID of this resource.
- `labels` (Map of String) Project labels
- `settings` (Block List) Additional settings (see [below for nested schema](#nestedblock--settings))
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))

### Nested Schema for `settings` {#nestedblock--settings}

Optional:

- `metric_name_label` (String) Default metric name label
- `only_auth_push` (Boolean) Supports only authenticated push
- `only_auth_read` (Boolean) Supports only authenticated read
- `only_new_format_reads` (Boolean)
- `only_new_format_writes` (Boolean)
- `only_sensor_name_shards` (Boolean) Supports only metric name shards


### Nested Schema for `timeouts` {#nestedblock--timeouts}

Optional:

- `create` (String)
- `delete` (String)
- `read` (String)
- `update` (String)


## Example
```
resource "ycp_monitoring_project" "this" {
  project_id  = "aletrushkin_test"
  name        = "TF test"
  abc_service = "solomon_tests"
  labels      = {
    tf = "true"
  }
}
```
