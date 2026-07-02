[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Managed Service for OpenSearch > Resources > mdb_opensearch_cluster

# yandex_mdb_opensearch_cluster (Resource)

Manages a OpenSearch cluster within the Yandex Cloud. For more information, see [the official documentation](../../managed-opensearch/concepts/index.md).

## Example usage

```terraform
//
// Create a new MDB OpenSearch Cluster.
//
resource "yandex_mdb_opensearch_cluster" "my_cluster" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.foo.id

  config {

    admin_password = "super-password"

    opensearch {
      node_groups {
        name             = "group0"
        assign_public_ip = true
        hosts_count      = 1
        subnet_ids       = ["${yandex_vpc_subnet.foo.id}"]
        zone_ids         = ["ru-central1-d"]
        roles            = ["data", "manager"]
        resources {
          resource_preset_id = "s2.micro"
          disk_size          = 10737418240
          disk_type_id       = "network-ssd"
        }
      }
    }
  }

  maintenance_window {
    type = "ANYTIME"
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
```terraform
//
// Create a new MDB OpenSearch Cluster.
//
locals {
  zones = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
}

resource "yandex_mdb_opensearch_cluster" "my_cluster" {
  name        = "my-cluster"
  environment = "PRODUCTION"
  network_id  = yandex_vpc_network.es-net.id

  config {

    admin_password = "super-password"

    opensearch {
      node_groups {
        name             = "hot_group0"
        assign_public_ip = true
        hosts_count      = 2
        zone_ids         = local.zones
        roles            = ["data"]
        resources {
          resource_preset_id = "s2.small"
          disk_size          = 10737418240
          disk_type_id       = "network-ssd"
        }
      }

      node_groups {
        name             = "cold_group0"
        assign_public_ip = true
        hosts_count      = 2
        zone_ids         = local.zones
        roles            = ["data"]
        resources {
          resource_preset_id = "s2.micro"
          disk_size          = 10737418240
          disk_type_id       = "network-hdd"
        }
      }

      node_groups {
        name             = "managers_group"
        assign_public_ip = true
        hosts_count      = 3
        zone_ids         = local.zones
        roles            = ["manager"]
        resources {
          resource_preset_id = "s2.micro"
          disk_size          = 10737418240
          disk_type_id       = "network-ssd"
        }
      }

      plugins = ["analysis-icu"]
    }

    dashboards {
      node_groups {
        name             = "dashboards"
        assign_public_ip = true
        hosts_count      = 1
        zone_ids         = local.zones
        resources {
          resource_preset_id = "s2.micro"
          disk_size          = 10737418240
          disk_type_id       = "network-ssd"
        }
      }
    }
  }

  auth_settings = {
    saml = {
      idp_entity_id             = "urn:dev.auth0.example.com"
      idp_metadata_file_content = "<EntityDescriptor entityID=\"https://test_identity_provider.example.com\"></EntityDescriptor>"
      sp_entity_id              = "https://test.example.com",
      dashboards_url            = "https://dashboards.example.com"
    }
  }

  depends_on = [
    yandex_vpc_subnet.es-subnet-a,
    yandex_vpc_subnet.es-subnet-b,
    yandex_vpc_subnet.es-subnet-d,
  ]

}

// Auxiliary resources
resource "yandex_vpc_network" "es-net" {}

resource "yandex_vpc_subnet" "es-subnet-a" {
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.es-net.id
  v4_cidr_blocks = ["10.1.0.0/24"]
}

resource "yandex_vpc_subnet" "es-subnet-b" {
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.es-net.id
  v4_cidr_blocks = ["10.2.0.0/24"]
}

resource "yandex_vpc_subnet" "es-subnet-d" {
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.es-net.id
  v4_cidr_blocks = ["10.3.0.0/24"]
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
- `health` (*Read-Only*) (String). Aggregated health of the cluster. Can be either `ALIVE`, `DEGRADED`, `DEAD` or `HEALTH_UNKNOWN`. For more information see `health` field of JSON representation in [the official documentation](../../managed-opensearch/api-ref/Cluster/index.md).
- `hosts` [Block]. A hosts of the OpenSearch cluster.
  - `assign_public_ip` (Bool). Sets whether the host should get a public IP address. Can be either `true` or `false`.
  - `fqdn` (*Read-Only*) (String). The fully qualified domain name of the host.
  - `node_group` (*Read-Only*) (String). Name of the node group.
  - `roles` (*Read-Only*) (Set Of String). The roles of the deployed host. Can contain any combination of `DATA`, `MANAGER`, `WARM` and `INGEST` roles. Will be empty for `DASHBOARDS` type.
  - `subnet_id` (String). The ID of the subnet, to which the host belongs. The subnet must be a part of the network to which the cluster belongs.
  - `type` (*Read-Only*) (String). The type of the deployed host. Can be either `OPENSEARCH` or `DASHBOARDS`.
  - `zone` (*Read-Only*) (String). The availability zone where the OpenSearch host will be created. For more information see [the official documentation](../../overview/concepts/geo-scope.md).
- `id` (*Read-Only*) (String). The resource identifier.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (**Required**)(String). Name of the OpenSearch cluster. The name must be unique within the folder.
- `network_id` (**Required**)(String). The `VPC Network ID` of subnets which resource attached to.
- `security_group_ids` (Set Of String). The list of security groups applied to resource or their components.
- `service_account_id` (String). ID of the service account authorized for this cluster.
- `status` (*Read-Only*) (String).  Status of the cluster. Can be either `CREATING`, `STARTING`, `RUNNING`, `UPDATING`, `STOPPING`, `STOPPED`, `ERROR` or `STATUS_UNKNOWN`. For more information see `status` field of JSON representation in [the official documentation](../../managed-opensearch/api-ref/Cluster/index.md).
- `config` [Block]. Configuration of the OpenSearch cluster.
  - `admin_password` (**Required**)(String). Password for admin user of OpenSearch.
  - `audit_log` [Block]. OpenSearch audit logs settings.
    - `compliance_enabled` (Bool). Enables audit logging on changes to a security index, such as changes to roles mappings and role creation or deletion.
For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/security/audit-logs/index/#audit-user-account-manipulation).
    - `log_backup_operations` (Bool). Enables snapshots and repositories requests logging.
For details, see None.
    - `log_data_modifications` (Bool). Enables indices data write request logging.
For details, see None.
    - `log_index_maintenance` (Bool). Enables indices maintenance requests logging, such as indices refreshes, flushes and merges.
For details, see None.
    - `log_index_metadata_access` (Bool). Enables indices metadata requests logging.
For details, see None.
    - `log_monitoring_checks` (Bool). Enables monitoring data requests logging.
For details, see None.
    - `log_request_body` (Bool). Includes the body of the request (if available) for both REST and the transport layer.
For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/security/audit-logs/index/#disable-request-body-logging).
    - `log_search_queries` (Bool). Enables indices data read requests logging.
For details, see None.
  - `version` (String). Version of OpenSearch.
  - `access` [Block]. Enable access to the Yandex Cloud services.
    - `data_transfer` (Bool). Enable access to the [Data Transfer](../../data-transfer/index.md) service.
    - `serverless` (Bool). Enable access to the [Cloud Functions](../../functions/index.md) service.
  - `dashboards` [Block]. Configuration for Dashboards node groups.
    - `node_groups` [Block]. 
      - `assign_public_ip` (Bool). Sets whether the hosts should get a public IP address.
      - `hosts_count` (**Required**)(Number). Number of hosts in this node group.
      - `name` (**Required**)(String). Name of OpenSearch node group.
      - `subnet_ids` (List Of String). A set of the subnets, to which the hosts belongs. The subnets must be a part of the network to which the cluster belongs.
      - `zone_ids` (**Required**)(Set Of String). A set of availability zones where hosts of node group may be allocated.
      - `resources` [Block]. Resources allocated to hosts of this OpenSearch node group.
        - `disk_size` (Number). Volume of the storage available to a host, in bytes. Exactly one of `disk_size` or `disk_size_gb` must be set in configuration.
        - `disk_size_gb` (Number). Same disk volume in gibibytes (GiB); converted to bytes for the API. Exactly one of `disk_size` or `disk_size_gb` must be set in configuration.
        - `disk_type_id` (**Required**)(String). Type of the storage of OpenSearch hosts.
        - `resource_preset_id` (**Required**)(String). The ID of the preset for computational resources available to a host (CPU, memory etc.). For more information, see [the official documentation](../../managed-opensearch/concepts/index.md).
  - `opensearch` [Block]. Configuration for OpenSearch node groups.
    - `config` [Block]. OpenSearch server configuration settings.
      - `fielddata_cache_size` (String). The maximum size of the field data cache.
May be specified as an absolute value (for example, 8GB) or a percentage of the node heap (for example, 50%).
This setting is dynamic. If you don't specify this setting, the maximum size is 35%.
This value should be smaller than the **indices.breaker.fielddata.limit**
For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/install-and-configure/configuring-opensearch/index-settings/#dynamic-cluster-level-index-settings).
      - `http_max_initial_line_length` (String). Sets the maximum length allowed for HTTP URLs in the initial request line. URLs exceeding this limit will be rejected. Default is **4kb**.
For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/install-and-configure/configuring-opensearch/network-settings/#advanced-http-settings).
      - `max_clause_count` (Number). Defines the maximum product of fields and terms that are queryable simultaneously.
For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/install-and-configure/configuring-opensearch/index-settings/#dynamic-cluster-level-index-settings).
      - `reindex_remote_whitelist` (String). Allowed remote hosts
For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/api-reference/document-apis/reindex/#remote-cluster-allow-list).
      - `search_max_buckets` (Number). The maximum number of aggregation buckets allowed in a single response. Default is 65535
For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/install-and-configure/configuring-opensearch/search-settings).
    - `plugins` (Set Of String). A set of requested OpenSearch plugins.
    - `node_groups` [Block]. A set of named OpenSearch node group configurations.
      - `assign_public_ip` (Bool). Sets whether the hosts should get a public IP address.
      - `disk_size_autoscaling` [Block]. Node group disk size autoscaling settings.
        - `disk_size_gb_limit` (Number). The overall maximum for disk size in gibibytes (GiB) that limit all autoscaling iterations. Exactly one of `disk_size_limit` or `disk_size_gb_limit` must be set in configuration.
        - `disk_size_limit` (Number). The overall maximum for disk size that limit all autoscaling iterations. See the [documentation](../../managed-opensearch/concepts/storage.md#auto-rescale) for details.
        - `emergency_usage_threshold` (Number). Threshold of storage usage (in percent) that triggers immediate automatic scaling of the storage. Zero value means disabled threshold.
        - `planned_usage_threshold` (Number). Threshold of storage usage (in percent) that triggers automatic scaling of the storage during the maintenance window. Zero value means disabled threshold.
      - `hosts_count` (**Required**)(Number). Number of hosts in this node group.
      - `name` (**Required**)(String). Name of OpenSearch node group.
      - `roles` (**Required**)(Set Of String). A set of OpenSearch roles assigned to hosts. Available roles are: `DATA`, `MANAGER`, `WARM` and `INGEST`. Default: [`DATA`, `MANAGER`].
      - `subnet_ids` (List Of String). A set of the subnets, to which the hosts belongs. The subnets must be a part of the network to which the cluster belongs.
      - `zone_ids` (**Required**)(Set Of String). A set of availability zones where hosts of node group may be allocated.
      - `resources` [Block]. Resources allocated to hosts of this OpenSearch node group.
        - `disk_size` (Number). Volume of the storage available to a host, in bytes. Exactly one of `disk_size` or `disk_size_gb` must be set in configuration.
        - `disk_size_gb` (Number). Same disk volume in gibibytes (GiB); converted to bytes for the API. Exactly one of `disk_size` or `disk_size_gb` must be set in configuration.
        - `disk_type_id` (**Required**)(String). Type of the storage of OpenSearch hosts.
        - `resource_preset_id` (**Required**)(String). The ID of the preset for computational resources available to a host (CPU, memory etc.). For more information, see [the official documentation](../../managed-opensearch/concepts/index.md).
- `maintenance_window` [Block]. 
  - `day` (String). 
  - `hour` (Number). 
  - `type` (**Required**)(String). 
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](../../cli/quickstart.md).

```shell
# terraform import yandex_mdb_opensearch_cluster.<resource Name> <resource Id>
terraform import yandex_mdb_opensearch_cluster.my_cluster ...
```