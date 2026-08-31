---
subcategory: Managed Service for MongoDB
---

# yandex_mdb_mongodb_backup_retention_policy (Resource)

Message to describe a retention policy for cluster backups.

## Example usage

```terraform
//
// Create a new MDB MongoDB Backup Retention Policy.
//
// The API does not support updates, so changing any argument
// forces the policy to be replaced (destroyed and recreated).
//
resource "yandex_mdb_mongodb_backup_retention_policy" "my_policy" {
  cluster_id      = yandex_mdb_mongodb_cluster.my_cluster.id
  policy_name     = "keep-weekly-backups"
  description     = "Keep weekly backups for 30 days"
  retain_for_days = 30

  cron = {
    day_of_month = "*"
    day_of_week  = "1"
    month        = "*"
  }
}

resource "yandex_mdb_mongodb_cluster" "my_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id

  cluster_config {
    version = "6.0"
  }

  host {
    zone_id   = "ru-central1-d"
    subnet_id = yandex_vpc_subnet.foo.id
  }
  resources_mongod {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 16
  }
}

// Auxiliary resources
resource "yandex_vpc_network" "foo" {}

resource "yandex_vpc_subnet" "foo" {
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.foo.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}
```

## Arguments & Attributes Reference

- `cluster_id` (**Required**)(String). ID of the MongoDB cluster.
 To get the MongoDB cluster ID use a [ClusterService.List] request.
- `created_at` (*Read-Only*) (String). Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
- `cron` [Block]. CronTab schedule.
  - `day_of_month` (String). Day of month in cron format. Valid values: 1-31, *, ranges (1-15), steps (*/2, 1-15/3), lists (1,15,28).
 Defaults to "*".
  - `day_of_week` (String). Day of week in cron format. Valid values: 0-7 (0 and 7 both mean Sunday), *, ranges (1-5), steps (0-6/2), lists (1,3,5).
 Defaults to "*".
  - `hour` (String). Hour in cron format. Valid values: 0-23, *, ranges (8-18), steps (*/2), lists (0,12).
 Defaults to "". Support depends on the database engine.
  - `minute` (String). Minute in cron format. Valid values: 0-59, *, ranges (0-30), steps (*/5), lists (0,15,30,45).
 Defaults to "". Support depends on the database engine.
  - `month` (String). Month in cron format. Valid values: 1-12, *, ranges (1-6), steps (*/3), lists (1,6,12).
 Defaults to "*".
- `description` (String). Human-readable description.
- `id` (String). Unique identifier for the [BackupRetentionPolicy].
- `policy_id` (String). Unique identifier for the [BackupRetentionPolicy].
- `policy_name` (**Required**)(String). Required. Policy name.
- `retain_for_days` (Number). Retention duration.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_mdb_mongodb_backup_retention_policy.<resource Name> <cluster_id>:<policy_id>
terraform import yandex_mdb_mongodb_backup_retention_policy.my_policy ...:...
```
