---
subcategory: Managed Service for OpenSearch
---

# yandex_mdb_opensearch_cluster (DataSource)

Use this data source to get information about a Yandex Managed OpenSearch cluster. For more information, see [the official documentation](https://yandex.cloud/docs/managed-opensearch/concepts).

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

## Arguments & Attributes Reference

- `auth_settings` [Block]. Authentication settings for Dashboards.
  - `saml` [Block]. SAML authentication options.
    - `dashboards_url` (**Required**)(String). Dashboards URL.
    - `enabled` (**Required**)(Bool). Enables SAML authentication.
    - `idp_entity_id` (**Required**)(String). ID of the SAML Identity Provider.
    - `idp_metadata_file_content` (**Required**)(String). Metadata file content of the SAML Identity Provider. You can either put file content manually or use [`file` function](https://developer.hashicorp.com/terraform/language/functions/file)
    - `roles_key` (String). Roles key.
    - `sp_entity_id` (**Required**)(String). Service provider entity ID.
    - `subject_key` (String). Subject key.
- `cluster_id` (String). The ID of the OpenSearch cluster that the resource belongs to.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `disk_encryption_key_id` (String). ID of the KMS key for cluster disk encryption.
- `environment` (String). Deployment environment of the OpenSearch cluster. Can be either `PRESTABLE` or `PRODUCTION`. Default: `PRODUCTION`. **It is not possible to change this value after cluster creation**.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `health` (*Read-Only*) (String). Aggregated health of the cluster. Can be either `ALIVE`, `DEGRADED`, `DEAD` or `HEALTH_UNKNOWN`. For more information see `health` field of JSON representation in [the official documentation](https://yandex.cloud/docs/managed-opensearch/api-ref/Cluster/).
- `hosts` [Block]. A hosts of the OpenSearch cluster.
  - `assign_public_ip` (Bool). Sets whether the host should get a public IP address. Can be either `true` or `false`.
  - `fqdn` (*Read-Only*) (String). The fully qualified domain name of the host.
  - `node_group` (*Read-Only*) (String). Name of the node group.
  - `roles` (*Read-Only*) (Set Of String). The roles of the deployed host. Can contain `DATA` and/or `MANAGER` roles. Will be empty for `DASHBOARDS` type.
  - `subnet_id` (String). The ID of the subnet, to which the host belongs. The subnet must be a part of the network to which the cluster belongs.
  - `type` (*Read-Only*) (String). The type of the deployed host. Can be either `OPENSEARCH` or `DASHBOARDS`.
  - `zone` (*Read-Only*) (String). The availability zone where the OpenSearch host will be created. For more information see [the official documentation](https://yandex.cloud/docs/overview/concepts/geo-scope).
- `id` (*Read-Only*) (String). The resource identifier.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (**Required**)(String). Name of the OpenSearch cluster. The name must be unique within the folder.
- `network_id` (**Required**)(String). The `VPC Network ID` of subnets which resource attached to.
- `security_group_ids` (Set Of String). The list of security groups applied to resource or their components.
- `service_account_id` (String). ID of the service account authorized for this cluster.
- `status` (*Read-Only*) (String).  Status of the cluster. Can be either `CREATING`, `STARTING`, `RUNNING`, `UPDATING`, `STOPPING`, `STOPPED`, `ERROR` or `STATUS_UNKNOWN`. For more information see `status` field of JSON representation in [the official documentation](https://yandex.cloud/docs/managed-opensearch/api-ref/Cluster/).
- `config` [Block]. Configuration of the OpenSearch cluster.
  - `admin_password` (**Required**)(String). Password for admin user of OpenSearch.
  - `version` (String). Version of OpenSearch.
  - `access` [Block]. Enable access to the Yandex Cloud services.
    - `data_transfer` (Bool). Enable access to the [Data Transfer](https://yandex.cloud/docs/data-transfer) service.
    - `serverless` (Bool). Enable access to the [Cloud Functions](https://yandex.cloud/docs/functions) service.
  - `dashboards` [Block]. Configuration for Dashboards node groups.
    - `node_groups` [Block]. 
      - `assign_public_ip` (Bool). Sets whether the hosts should get a public IP address.
      - `hosts_count` (**Required**)(Number). Number of hosts in this node group.
      - `name` (**Required**)(String). Name of OpenSearch node group.
      - `subnet_ids` (List Of String). A set of the subnets, to which the hosts belongs. The subnets must be a part of the network to which the cluster belongs.
      - `zone_ids` (**Required**)(Set Of String). A set of availability zones where hosts of node group may be allocated.
      - `resources` [Block]. Resources allocated to hosts of this OpenSearch node group.
        - `disk_size` (**Required**)(Number). Volume of the storage available to a host, in bytes.
        - `disk_type_id` (**Required**)(String). Type of the storage of OpenSearch hosts.
        - `resource_preset_id` (**Required**)(String). The ID of the preset for computational resources available to a host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-opensearch/concepts).
  - `opensearch` [Block]. Configuration for OpenSearch node groups.
    - `plugins` (Set Of String). A set of requested OpenSearch plugins.
    - `config` [Block]. OpenSearch server configuration settings.
    - `node_groups` [Block]. A set of named OpenSearch node group configurations.
      - `assign_public_ip` (Bool). Sets whether the hosts should get a public IP address.
      - `disk_size_autoscaling` [Block]. Node group disk size autoscaling settings.
        - `disk_size_limit` (**Required**)(Number). The overall maximum for disk size that limit all autoscaling iterations. See the [documentation](https://yandex.cloud/en/docs/managed-opensearch/concepts/storage#auto-rescale) for details.
        - `emergency_usage_threshold` (Number). Threshold of storage usage (in percent) that triggers immediate automatic scaling of the storage. Zero value means disabled threshold.
        - `planned_usage_threshold` (Number). Threshold of storage usage (in percent) that triggers automatic scaling of the storage during the maintenance window. Zero value means disabled threshold.
      - `hosts_count` (**Required**)(Number). Number of hosts in this node group.
      - `name` (**Required**)(String). Name of OpenSearch node group.
      - `roles` (**Required**)(Set Of String). A set of OpenSearch roles assigned to hosts. Available roles are: `DATA`, `MANAGER`. Default: [`DATA`, `MANAGER`].
      - `subnet_ids` (List Of String). A set of the subnets, to which the hosts belongs. The subnets must be a part of the network to which the cluster belongs.
      - `zone_ids` (**Required**)(Set Of String). A set of availability zones where hosts of node group may be allocated.
      - `resources` [Block]. Resources allocated to hosts of this OpenSearch node group.
        - `disk_size` (**Required**)(Number). Volume of the storage available to a host, in bytes.
        - `disk_type_id` (**Required**)(String). Type of the storage of OpenSearch hosts.
        - `resource_preset_id` (**Required**)(String). The ID of the preset for computational resources available to a host (CPU, memory etc.). For more information, see [the official documentation](https://yandex.cloud/docs/managed-opensearch/concepts).
- `maintenance_window` [Block]. 
  - `day` (String). 
  - `hour` (Number). 
  - `type` (**Required**)(String).


