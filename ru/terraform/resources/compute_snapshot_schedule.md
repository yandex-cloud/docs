---
subcategory: Compute Cloud
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/compute_snapshot_schedule.md
---

# yandex_compute_snapshot_schedule (Resource)

Creates a new snapshot schedule. For more information, see [the official documentation](https://yandex.cloud/docs/compute/concepts/snapshot-schedule).

## Example usage

```terraform
//
// Create a new Compute Snapshot Schedule.
//
resource "yandex_compute_snapshot_schedule" "vm_snap_sch1" {
  name = "my-name"

  schedule_policy {
    expression = "0 0 * * *"
  }

  snapshot_count = 1

  snapshot_spec {
    description = "snapshot-description"
    labels = {
      snapshot-label = "my-snapshot-label-value"
    }
  }

  labels = {
    my-label = "my-label-value"
  }

  disk_ids = ["test_disk_id", "another_test_disk_id"]
}
```
```terraform
//
// Create a new Compute Snapshot Schedule with retention period.
//
resource "yandex_compute_snapshot_schedule" "vm_snap_sch2" {
  schedule_policy {
    expression = "0 0 * * *"
  }

  retention_period = "12h"

  snapshot_spec {
    description = "retention-snapshot"
  }

  disk_ids = ["test_disk_id", "another_test_disk_id"]
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
- `status` (*Read-Only*) (String). The status of the snapshot schedule.
- `schedule_policy` [Block]. Schedule policy of the snapshot schedule.
  - `expression` (String). Cron expression to schedule snapshots (in cron format `" * ****"`).
  - `start_at` (String). Time to start the snapshot schedule (in format RFC3339 `2006-01-02T15:04:05Z07:00`). If empty current time will be used. Unlike an `expression` that specifies regularity rules, the `start_at` parameter determines from what point these rules will be applied.
- `snapshot_spec` [Block]. Additional attributes for snapshots created by this snapshot schedule.
  - `description` (String). Description to assign to snapshots created by this snapshot schedule.
  - `labels` (Map Of String). A set of key/value label pairs to assign to snapshots created by this snapshot schedule.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_compute_snapshot_schedule.<resource Name> <resource Id>
terraform import yandex_compute_snapshot_schedule.my_snapshot_schedule fd8hc**********o4qe2
```
