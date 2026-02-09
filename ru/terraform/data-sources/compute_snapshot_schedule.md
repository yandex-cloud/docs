---
subcategory: Compute Cloud
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/compute_snapshot_schedule.md
---

# yandex_compute_snapshot_schedule (DataSource)

Get information about a Yandex Compute snapshot schedule. For more information, see [the official documentation](https://yandex.cloud/docs/compute/concepts/snapshot-schedule).

{% note warning %}

One of `snapshot_schedule_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing Compute Snapshot Schedule
//
data "yandex_compute_snapshot_schedule" "my_snapshot_schedule" {
  snapshot_schedule_id = "some_snapshot_schedule_id"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `disk_ids` (Set Of String). IDs of the disk for snapshot schedule.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `retention_period` (String). Time duration applied to snapshots created by this snapshot schedule. This is a signed sequence of decimal numbers, each with optional fraction and a unit suffix. Valid time units are `ns`, `us` (or `µs`), `ms`, `s`, `m`, `h`. Examples: `300ms`, `1.5h` or `2h45m`.
- `snapshot_count` (Number). Maximum number of snapshots for every disk of the snapshot schedule.
- `snapshot_schedule_id` (String). The ID of a specific snapshot schedule.
- `status` (*Read-Only*) (String). The status of the snapshot schedule.
- `schedule_policy` [Block]. Schedule policy of the snapshot schedule.
  - `expression` (String). Cron expression to schedule snapshots (in cron format `" * ****"`).
  - `start_at` (String). Time to start the snapshot schedule (in format RFC3339 `2006-01-02T15:04:05Z07:00`). If empty current time will be used. Unlike an `expression` that specifies regularity rules, the `start_at` parameter determines from what point these rules will be applied.
- `snapshot_spec` [Block]. Additional attributes for snapshots created by this snapshot schedule.
  - `description` (String). Description to assign to snapshots created by this snapshot schedule.
  - `labels` (Map Of String). A set of key/value label pairs to assign to snapshots created by this snapshot schedule.


