---
subcategory: Ytsaurus
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/ytsaurus_cluster.md
---

# yandex_ytsaurus_cluster (Resource)



## Example usage

```terraform
//
// Create a new YTsaurus cluster
//
resource "yandex_ytsaurus_cluster" "my_cluster" {
  name = "my-cluster"
  description = "my_cluster description"

  zone_id			 = "ru-central1-a"
  subnet_id			 = "my_subnet_id"
  security_group_ids = ["my_security_group_id"]

  spec = {
	storage = {
	  hdd = {
	  	size_gb = 100
		count 	= 3
	  }

	  ssd = {
	  	size_gb = 100
		type 	= "network-ssd"
		count 	= 3
	  }
	}

	compute = [{
	  preset = "c8-m32"
	  disks = [{
	  	type 	= "network-ssd"
		size_gb = 50
	  }]
	  scale_policy = {
	  	fixed = {
		  size = 3
		}
	  }
	}]

	tablet = {
      preset = "c8-m16"
	  count = 3
	}

	proxy = {
	  http = {
	  	count = 1
	  }
      
	  rpc = {
	  	count = 1
	  }
	}
  }
}
```

## Arguments & Attributes Reference

- `cidr_blocks_whitelist` [Block]. CIDRs whitelist.
  - `v4_cidr_blocks` (List Of String). IPv4 CIDR blocks.
- `cluster_id` (String). ID of the cluster to return.
- `created_at` (*Read-Only*) (String). Time when the cluster was created.
- `created_by` (*Read-Only*) (String). User who created the cluster.
- `description` (String). Description of the cluster.
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
- `labels` (Map Of String). Cluster labels as `key:value` pairs.
- `name` (String). Name of the cluster.
 The name is unique within the folder.
- `security_group_ids` (List Of String). Network interfaces security groups.
- `spec` [Block]. Cluster specification.
  - `client_logging` [Block]. Client Cloud logging configuration.
    - `audit_logs_enabled` (Bool). Enable audit logs.
    - `folder_id` (String). ID of cloud logging folder. Used default loging group.
    - `log_group_id` (String). ID of cloud logging group.
    - `service_account_id` (String). ID of Service account used for write logs.
  - `compute` [Block]. Cluster exec nodes configuration.
    - `disks` [Block]. Configuration of exec node strorage.
      - `locations` (List Of String). Locations on a disk.
      - `size_gb` (Number). Size of a single disk in GB.
      - `type` (String). Type of a disk.
    - `name` (String). Name for exec pool.
    - `preset` (String). VM configuration preset name.
    - `scale_policy` [Block]. Exec nodes scaling policy.
      - `auto` [Block]. Scale policy that can adjust number of running exec nodes within specified range based on some criteria.
        - `max_size` (Number). package: yandex.cloud.ytsaurus.v1
filename: yandex/cloud/ytsaurus/v1/cluster.proto

        - `min_size` (Number). package: yandex.cloud.ytsaurus.v1
filename: yandex/cloud/ytsaurus/v1/cluster.proto

      - `fixed` [Block]. Scale policy that doesn't change number of running exec nodes over time.
        - `size` (Number). package: yandex.cloud.ytsaurus.v1
filename: yandex/cloud/ytsaurus/v1/cluster.proto

  - `cron` [Block]. Cluster regular processing settings.
    - `clear_tmp` [Block]. Cluster regular tmp-account cleaning settings.
      - `account_usage_ratio_save_per_owner` (Number). Per account max space usage ratio.
      - `account_usage_ratio_save_total` (Number). Total max space usage ratio.
      - `interval` (String). Script starting interval.
      - `max_dir_node_count` (Number). Max nodes in every directory.
  - `flavor` (String). Cluster flavor (type).
  - `odin` [Block]. Odin configuration.
    - `checks_ttl` (String). TTL of Odin check samples.
  - `proxy` [Block]. Cluster proxies configuration.
    - `http` [Block]. Configuration of HTTP proxies.
      - `count` (Number). Total amount of HTTP proxies.
    - `rpc` [Block]. Configuration of rpc proxies.
      - `count` (Number). Total amount of RPC proxies.
  - `storage` [Block]. Cluster storage configuration.
    - `hdd` [Block]. Configuration of cluster HDD strorage.
      - `count` (Number). Total amount of HDD disks.
      - `size_gb` (Number). Size of a single HDD disk in GB.
    - `ssd` [Block]. Configuration of cluster SSD strorage
      - `changelogs` [Block]. Configuration of dynamic table changelogs.
        - `size_gb` (Number). package: yandex.cloud.ytsaurus.v1
filename: yandex/cloud/ytsaurus/v1/cluster.proto

      - `count` (Number). Total amount of SSD disks.
      - `size_gb` (Number). Size of a single SSD disk in GB.
      - `type` (String). Type of a SSD disk.
  - `tablet` [Block]. Cluster tablet nodes configuration.
    - `count` (Number). Total amount of tablet nodes.
    - `preset` (String). VM configuration preset name.
- `status` (*Read-Only*) (String). Status of the cluster.
- `subnet_id` (**Required**)(String). ID of the subnet where the cluster resides.
- `updated_at` (*Read-Only*) (String). Time when the cluster was last updated.
- `updated_by` (*Read-Only*) (String). User who last updated the cluster.
- `zone_id` (**Required**)(String). ID of the availability zone where the cluster resides.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
terraform import yandex_ytsaurus_cluster.my_cluster some_cluster_id
```
