[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Managed Service for MongoDB > Data Sources > mdb_mongodb_backup_retention_policy

# yandex_mdb_mongodb_backup_retention_policy (DataSource)

Message to describe a retention policy for cluster backups.

## Example usage

```terraform
//
// Get information about existing MDB MongoDB Backup Retention Policy.
//
data "yandex_mdb_mongodb_backup_retention_policy" "my_policy" {
  cluster_id = "some_cluster_id"
  policy_id  = "some_policy_id"
}

output "policy_name" {
  value = data.yandex_mdb_mongodb_backup_retention_policy.my_policy.policy_name
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