---
subcategory: Managed Service for OpenSearch
page_title: 'Yandex: yandex_mdb_opensearch_cluster'
description: Get information about a Yandex Managed OpenSearch cluster.
sourcePath: ru/terraform/tf-ref/yandex-cloud/data-sources/mdb_opensearch_cluster.md
---

# yandex_mdb_opensearch_cluster (Data Source)

Get information about a Yandex Managed OpenSearch cluster. For more information, see [the official documentation](https://yandex.cloud/docs/managed-opensearch/concepts).

## Example usage

```terraform
//
// Get information about existing MDB OpenSearch Cluster.
//
data "yandex_mdb_opensearch_cluster" "foo" {
  name = "test"
}

output "network_id" {
  value = data.yandex_mdb_opensearch_cluster.foo.network_id
}
```

## Argument Reference

The following arguments are supported:

* `cluster_id` - (Optional) The ID of the OpenSearch cluster.

* `name` - (Optional) The name of the OpenSearch cluster.

~> Either `cluster_id` or `name` should be specified.

* `folder_id` - (Optional) The ID of the folder that the resource belongs to. If it is not provided, the default provider folder is used.

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

* `network_id` - ID of the network, to which the OpenSearch cluster belongs.
* `created_at` - Creation timestamp of the key.
* `description` - Description of the OpenSearch cluster.
* `labels` - A set of key/value label pairs to assign to the OpenSearch cluster.
* `environment` - Deployment environment of the OpenSearch cluster.
* `health` - Aggregated health of the cluster.
* `status` - Status of the cluster.
* `config` - Configuration of the OpenSearch cluster. The structure is documented below.
* `hosts` - A hosts of the OpenSearch cluster. The structure is documented below.
* `security_group_ids` - A set of ids of security groups assigned to hosts of the cluster.
* `service_account_id` - ID of the service account authorized for this cluster.
* `auth_settings` - Authorization settings for Dashboards. The structure is documented below.

The `config` block supports:

* `version` - Version of OpenSearch.

* `opensearch` - Configuration for OpenSearch node groups. The structure is documented below.

* `dashboards` - Configuration for Dashboards node groups. The structure is documented below.

The `opensearch` block supports:

* `plugins` - A set of requested OpenSearch plugins.

* `node_groups` - A set of named OpenSearch node group configurations. The structure is documented below.

The OpenSearch `node_groups` block supports:

* `name` - Name of OpenSearch node group.

* `resources` - Resources allocated to hosts of this OpenSearch node group. The structure is documented below.

* `host_count` - Number of hosts in this node group.

* `zones_ids` - A set of availability zones where hosts of node group may be allocated.

* `subnet_ids` - A set of the subnets, to which the hosts belongs. The subnets must be a part of the network to which the cluster belongs.

* `assign_public_ip` - Sets whether the hosts should get a public IP address on creation.

* `roles` - A set of OpenSearch roles assigned to hosts. Available roles are: `DATA`, `MANAGER`.

The Dashboards `node_groups` block supports:

* `name` - Name of OpenSearch node group.

* `resources` - Resources allocated to hosts of this Dashboards node group. The structure is documented below.

* `host_count` - Number of hosts in this node group.

* `zones_ids` - A set of availability zones where hosts of node group may be allocated.

* `subnet_ids` - A set of the subnets, to which the hosts belongs. The subnets must be a part of the network to which the cluster belongs.

* `assign_public_ip` - Sets whether the hosts should get a public IP address on creation.

The `resources` block supports:

* `resources_preset_id` - The ID of the preset for computational resources available to a OpenSearch host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-opensearch/concepts/instance-types).
* `disk_size` - Volume of the storage available to a OpenSearch host, in gigabytes.
* `disk_type_id` - Type of the storage of OpenSearch hosts.

The `hosts` block supports:

* `fqdn` - The fully qualified domain name of the host.

* `zone` - The availability zone where the OpenSearch host was created. For more information see [the official documentation](https://yandex.cloud/docs/overview/concepts/geo-scope).

* `type` - The type of the deployed host. Can be either `OPENSEARCH` or `DASHBOARDS`.

* `roles` - The roles of the deployed host. Can contain `DATA` and/or `MANAGER` roles. Will be empty for `DASHBOARDS` type.

* `subnet_id` - The ID of the subnet, to which the host belongs. The subnet must be a part of the network to which the cluster belongs.

* `assign_public_ip` - Sets whether the host should get a public IP address. Can be either `true` or `false`.

* `node_group` - Name of the node group.

The `maintenance_window` block supports:

* `type` - Type of a maintenance window. Can be either `ANYTIME` or `WEEKLY`. A day and hour need to be specified with the weekly window.
* `hour` - Hour of the day in UTC time zone (1-24) for a maintenance window if the window type is weekly.
* `day` - Day of the week for a maintenance window if the window type is weekly. Possible values: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`.

The `auth_settings` block supports:

* `saml` - (Optional) SAML auth option. The structure is documented below.

The `saml` block supports:

* `enabled` - Enables SAML auth.
* `idp_entity_id` - ID of the SAML Identity Provider.
* `idp_metadata_file_content` - Metadata file content of the SAML Identity Provider.
* `sp_entity_id` - Service provider entity ID.
* `dashboards_url` - Dashboards URL.
* `roles_key` - Roles key.
* `subject_key` - Subject key.
