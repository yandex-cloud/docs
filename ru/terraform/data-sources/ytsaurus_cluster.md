---
subcategory: Ytsaurus
---

# yandex_ytsaurus_cluster (DataSource)



## Example usage

```terraform
//
// Get information about existing YTsaurus cluster.
//
data "yandex_ytsaurus_cluster" "my_cluster" {
  cluster_id = "some_cluster_id"
}
```

## Arguments & Attributes Reference

- `cidr_blocks_whitelist` [Block]. CIDRs whitelist.
  - `v4_cidr_blocks` (*Read-Only*) (List Of String). IPv4 CIDR blocks.
- `cluster_id` (String). ID of the cluster to return.
- `created_at` (*Read-Only*) (String). Time when the cluster was created.
- `created_by` (*Read-Only*) (String). User who created the cluster.
- `description` (*Read-Only*) (String). Description of the cluster.
- `endpoints` [Block]. Endpoints of the cluster.
  - `external_http_proxy_balancer` (*Read-Only*) (String). package: yandex.cloud.ytsaurus.v1
filename: yandex/cloud/ytsaurus/v1/cluster.proto

  - `internal_http_proxy_alias` (*Read-Only*) (String). package: yandex.cloud.ytsaurus.v1
filename: yandex/cloud/ytsaurus/v1/cluster.proto

  - `internal_rpc_proxy_alias` (*Read-Only*) (String). package: yandex.cloud.ytsaurus.v1
filename: yandex/cloud/ytsaurus/v1/cluster.proto

  - `ui` (*Read-Only*) (String). package: yandex.cloud.ytsaurus.v1
filename: yandex/cloud/ytsaurus/v1/cluster.proto

- `folder_id` (String). ID of the folder that the cluster belongs to.
- `health` (*Read-Only*) (String). Health of the cluster.
- `id` (String). ID of the cluster to return.
- `labels` (*Read-Only*) (Map Of String). Cluster labels as `key:value` pairs.
- `maintenance_window` [Block]. Maintenance window of the cluster.
  - `anytime` [Block]. Maintenance can be scheduled anytime.
  - `weekly_maintenance_window` [Block]. Maintenance is allowed only within the specified weekly window.
    - `day` (*Read-Only*) (String). Day of the week when maintenance can occur.
    - `hour` (*Read-Only*) (Number). Hour of the day in UTC when the maintenance window starts.
- `name` (*Read-Only*) (String). Name of the cluster.
 The name is unique within the folder.
- `security_group_ids` (*Read-Only*) (List Of String). Network interfaces security groups.
- `spec` [Block]. Cluster specification.
  - `client_logging` [Block]. Client Cloud logging configuration.
    - `audit_logs_enabled` (*Read-Only*) (Bool). Enable audit logs.
    - `folder_id` (String). ID of cloud logging folder. Used default loging group.
    - `log_group_id` (*Read-Only*) (String). ID of cloud logging group.
    - `service_account_id` (String). ID of Service account used for write logs.
  - `compute` [Block]. Cluster exec nodes configuration.
    - `disks` [Block]. Configuration of exec node strorage.
      - `location_quotas_gb` (*Read-Only*) (List Of Number). Quotas for each location. Must be the same length as locations or empty. Zero value will disable quota for location.
      - `locations` (*Read-Only*) (List Of String). Locations on a disk.
      - `size_gb` (*Read-Only*) (Number). Size of a single disk in GB.
      - `type` (*Read-Only*) (String). Type of a disk.
    - `name` (*Read-Only*) (String). Name for exec pool.
    - `preset` (*Read-Only*) (String). VM configuration preset name.
    - `scale_policy` [Block]. Exec nodes scaling policy.
      - `auto` [Block]. Scale policy that can adjust number of running exec nodes within specified range based on some criteria.
        - `initial_size` (*Read-Only*) (Number). package: yandex.cloud.ytsaurus.v1
filename: yandex/cloud/ytsaurus/v1/cluster.proto

        - `linear` [Block]. package: yandex.cloud.ytsaurus.v1
filename: yandex/cloud/ytsaurus/v1/cluster.proto

          - `cooldown_interval` (*Read-Only*) (String). Cooldown interval.
          - `overload_coefficient` (*Read-Only*) (Number). Overload coefficient.
          - `statistics_interval` (*Read-Only*) (String). Statistics interval.
          - `underload_coefficient` (*Read-Only*) (Number). Underload coefficient.
        - `max_size` (*Read-Only*) (Number). package: yandex.cloud.ytsaurus.v1
filename: yandex/cloud/ytsaurus/v1/cluster.proto

        - `min_size` (*Read-Only*) (Number). package: yandex.cloud.ytsaurus.v1
filename: yandex/cloud/ytsaurus/v1/cluster.proto

      - `fixed` [Block]. Scale policy that doesn't change number of running exec nodes over time.
        - `size` (*Read-Only*) (Number). package: yandex.cloud.ytsaurus.v1
filename: yandex/cloud/ytsaurus/v1/cluster.proto

  - `cron` [Block]. Cluster regular processing settings.
    - `clear_tmp` [Block]. Cluster regular tmp-account cleaning settings.
      - `account_usage_ratio_save_per_owner` (*Read-Only*) (Number). Per account max space usage ratio.
      - `account_usage_ratio_save_total` (*Read-Only*) (Number). Total max space usage ratio.
      - `interval` (*Read-Only*) (String). Script starting interval.
      - `max_dir_node_count` (*Read-Only*) (Number). Max nodes in every directory.
  - `excel` [Block]. Cluster Excel configuration.
    - `enabled` (*Read-Only*) (Bool). Enable Excel.
  - `flavor` (*Read-Only*) (String). Cluster flavor (type).
  - `odin` [Block]. Odin configuration.
    - `checks_ttl` (*Read-Only*) (String). TTL of Odin check samples.
  - `proxy` [Block]. Cluster proxies configuration.
    - `http` [Block]. Configuration of HTTP proxies.
      - `count` (*Read-Only*) (Number). Total amount of HTTP proxies.
    - `rpc` [Block]. Configuration of rpc proxies.
      - `count` (*Read-Only*) (Number). Total amount of RPC proxies.
    - `task` [Block]. Configuration of task proxies.
      - `count` (*Read-Only*) (Number). Total amount of task proxies.
  - `storage` [Block]. Cluster storage configuration.
    - `hdd` [Block]. Configuration of cluster HDD strorage.
      - `count` (*Read-Only*) (Number). Total amount of HDD disks.
      - `size_gb` (*Read-Only*) (Number). Size of a single HDD disk in GB.
    - `ssd` [Block]. Configuration of cluster SSD strorage
      - `changelogs` [Block]. Configuration of dynamic table changelogs.
        - `size_gb` (*Read-Only*) (Number). package: yandex.cloud.ytsaurus.v1
filename: yandex/cloud/ytsaurus/v1/cluster.proto

      - `count` (*Read-Only*) (Number). Total amount of SSD disks.
      - `size_gb` (*Read-Only*) (Number). Size of a single SSD disk in GB.
      - `type` (*Read-Only*) (String). Type of a SSD disk.
  - `tablet` [Block]. Cluster tablet nodes configuration.
    - `count` (*Read-Only*) (Number). Total amount of tablet nodes.
    - `preset` (*Read-Only*) (String). VM configuration preset name.
- `status` (*Read-Only*) (String). Status of the cluster.
- `subnet_id` (*Read-Only*) (String). ID of the subnet where the cluster resides.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `updated_at` (*Read-Only*) (String). Time when the cluster was last updated.
- `updated_by` (*Read-Only*) (String). User who last updated the cluster.
- `zone_id` (*Read-Only*) (String). ID of the availability zone where the cluster resides.


