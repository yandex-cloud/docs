# ycp_monitoring_cluster (Resource)

Monitoring cluster

## Schema

### Required

- `cluster_id` (String) Cluster identifier, will be copied to id
- `project_id` (String) Project identifier

### Optional

- `cloud_dns` (Block List) Cluster cloud dns (see [below for nested schema](#nestedblock--cloud_dns))
- `conductor_groups` (Block List) Cluster conductor groups (see [below for nested schema](#nestedblock--conductor_groups))
- `conductor_tags` (Block List) Cluster conductor tags (see [below for nested schema](#nestedblock--conductor_tags))
- `host_urls` (Block List) Cluster host urls (see [below for nested schema](#nestedblock--host_urls))
- `hosts` (Block List) Cluster hosts (see [below for nested schema](#nestedblock--hosts))
- `id` (String) The ID of this resource.
- `instance_groups` (Block List) Cluster instance groups (see [below for nested schema](#nestedblock--instance_groups))
- `label_name` (String) Cluster name
- `labels` (Map of String) Cluster labels
- `metrics_ttl_days` (Number) If this field is filled, Solomon will drop all metrics where last point was metrics TTL days ago
- `nanny_groups` (Block List) Cluster nanny groups (see [below for nested schema](#nestedblock--nanny_groups))
- `networks` (Block List) Cluster networks (see [below for nested schema](#nestedblock--networks))
- `port` (Number) Port which Solomon should use to fetch metrics from your application. Value of this field will override port number defined in service config
- `qloud_groups` (Block List) Cluster qloud groups (see [below for nested schema](#nestedblock--qloud_groups))
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))
- `tvm_destination_id` (String) TVM client id of your application that Solomon will contact to download metrics from
- `use_fqdn` (Boolean) If true Solomon will write FQDN to host label instead of short host
- `walle` (Block List) Cluster walle (see [below for nested schema](#nestedblock--walle))
- `yp_clusters` (Block List) Cluster yp clusters (see [below for nested schema](#nestedblock--yp_clusters))

### Nested Schema for `cloud_dns` {#nestedblock--cloud_dns}

Required:

- `environment` (String) Environment
- `name` (String) Name

Optional:

- `labels` (List of String) One or more optional labels that will be used in aggregation rules for metrics fetched from these hosts. Labels must be written in a 'key=value' format delimited by a space (e.g. 'env=prod dc=man')


### Nested Schema for `conductor_groups` {#nestedblock--conductor_groups}

Required:

- `group` (String) Name of conductor group

Optional:

- `labels` (List of String) One or more optional labels that will be used in aggregation rules for metrics fetched from these hosts. Labels must be written in a 'key=value' format delimited by a space (e.g. 'env=prod dc=man')


### Nested Schema for `conductor_tags` {#nestedblock--conductor_tags}

Required:

- `name` (String) Name of conductor tag

Optional:

- `labels` (List of String) One or more optional labels that will be used in aggregation rules for metrics fetched from these hosts. Labels must be written in a 'key=value' format delimited by a space (e.g. 'env=prod dc=man')


### Nested Schema for `host_urls` {#nestedblock--host_urls}

Required:

- `url` (String) URL of text file with host list

Optional:

- `ignore_ports` (Boolean) If enabled then ports present in downloaded file will be ignored
- `labels` (List of String) One or more optional labels that will be used in aggregation rules for metrics fetched from these hosts. Labels must be written in a 'key=value' format delimited by a space (e.g. 'env=prod dc=man')


### Nested Schema for `hosts` {#nestedblock--hosts}

Required:

- `url_pattern` (String) Don't mind URL in field name, it is actually URL pattern and may contain printf-like pattern (e.g. '%d' or '%03d' that is filled with ranges

Optional:

- `dc` (String) One or data center name
- `labels` (List of String) One or more optional labels that will be used in aggregation rules for metrics fetched from these hosts. Labels must be written in a 'key=value' format delimited by a space (e.g. 'env=prod dc=man')
- `ranges` (String) One or more ranges deilimted by space to fill above pattern (e.g. '0-10 20-40')


### Nested Schema for `instance_groups` {#nestedblock--instance_groups}

Optional:

- `folder_id` (String) Folder ID
- `instance_group_id` (String) Instance group ID
- `labels` (List of String) One or more optional labels that will be used in aggregation rules for metrics fetched from these hosts. Labels must be written in a 'key=value' format delimited by a space (e.g. 'env=prod dc=man')


### Nested Schema for `nanny_groups` {#nestedblock--nanny_groups}

Required:

- `environment` (String) Use Nanny admin installation
- `service` (String) Name of Nanny service as in /v2/services/{service}/current_state/instances/ path

Optional:

- `cfg_group` (List of String) One or more config groups for cfg-api http://api.gencfg.yandex-team.ru/{tag}/groups/{cfgGroup}. Groups must be delimited by space
- `labels` (List of String) One or more optional labels that will be used in aggregation rules for metrics fetched from these hosts. Labels must be written in a 'key=value' format delimited by a space (e.g. 'env=prod dc=man')
- `port_shift` (Number) This value will be added to port before establishing connection with your service
- `use_fetched_port` (Boolean) Use service port as configured in Nanny service


### Nested Schema for `networks` {#nestedblock--networks}

Required:

- `network` (String) Single IP address (v4/v6) or subnetwork expressed in Classless Inter-Domain Routing (CIDR) notation

Optional:

- `labels` (List of String) One or more optional labels that will be used in aggregation rules for metrics fetched from these hosts. Labels must be written in a 'key=value' format delimited by a space (e.g. 'env=prod dc=man')
- `port` (Number) Port which Solomon shoud use to fetch metrics (optional)


### Nested Schema for `qloud_groups` {#nestedblock--qloud_groups}

Optional:

- `application` (String) Qloud application
- `component` (String) Qloud component
- `deployment` (String) Qloud deployment
- `environment` (String) Qloud environment
- `labels` (List of String) One or more optional labels that will be used in aggregation rules for metrics fetched from these hosts. Labels must be written in a 'key=value' format delimited by a space (e.g. 'env=prod dc=man')
- `project` (String) Qloud project


### Nested Schema for `timeouts` {#nestedblock--timeouts}

Optional:

- `create` (String)
- `delete` (String)
- `read` (String)
- `update` (String)


### Nested Schema for `walle` {#nestedblock--walle}

Optional:

- `labels` (List of String) One or more optional labels that will be used in aggregation rules for metrics fetched from these hosts. Labels must be written in a 'key=value' format delimited by a space (e.g. 'env=prod dc=man')
- `projects` (List of String) Space-separated list of wall-e projects
- `tags` (List of String) Space-separated list of wall-e tags


### Nested Schema for `yp_clusters` {#nestedblock--yp_clusters}

Required:

- `cluster` (String) YP cluster

Optional:

- `endpoint_set_id` (String) Endpoint set ID
- `labels` (List of String) One or more optional labels that will be used in aggregation rules for metrics fetched from these hosts. Labels must be written in a 'key=value' format delimited by a space (e.g. 'env=prod dc=man')
- `persistent_labels` (List of String) One or more optional labels that will be used in aggregation rules for metrics fetched from these hosts. Labels must be written in a 'key=value' format delimited by a space (e.g. 'env=prod dc=man')
- `pod_set_id` (String) Pod set ID
- `tvm_label` (String) Obtain a TVM id for the application from the specified YP label
- `yp_label` (String) Discover pods by picking only the ones that have the specified label value set to true (i.e. $YP_LABEL = %true) from any pod set

## Example
```
resource "ycp_monitoring_cluster" "solomon_alerting_prod" {
  project_id = "project_id_here"
  cluster_id = "solomon_alerting_prod"
  label_name = "production"
  conductor_groups {
    group = "solomon_prod_alerting"
  }
}
```
