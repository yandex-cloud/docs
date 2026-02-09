---
subcategory: Managed Services for Kubernetes
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/kubernetes_cluster.md
---

# yandex_kubernetes_cluster (DataSource)

Get information about a Yandex Cloud Managed Kubernetes Cluster. For more information, see [the official documentation](https://yandex.cloud/docs/managed-kubernetes/concepts/#kubernetes-cluster).

{% note warning %}

One of `cluster_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing Managed Kubernetes Cluster (MK8S).
//
data "yandex_kubernetes_cluster" "my_cluster" {
  cluster_id = "some_k8s_cluster_id"
}

output "cluster_external_v4_endpoint" {
  value = data.yandex_kubernetes_cluster.my_cluster.master.0.external_v4_endpoint
}
```

## Arguments & Attributes Reference

- `cluster_id` (String). ID of a specific Kubernetes cluster.
- `cluster_ipv4_range` (String). CIDR block. IP range for allocating pod addresses. It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets.
- `cluster_ipv6_range` (String). Identical to `cluster_ipv4_range` but for IPv6 protocol.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `health` (*Read-Only*) (String). Health of the Kubernetes cluster.
- `id` (String). 
- `kms_provider` [Block]. Cluster KMS provider parameters.
  - `key_id` (String). KMS key ID.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `log_group_id` (*Read-Only*) (String). Log group where cluster stores cluster system logs, like audit, events, or control plane logs.
- `master` [Block]. Kubernetes master configuration options.
  - `cluster_ca_certificate` (*Read-Only*) (String). PEM-encoded public certificate that is the root of trust for the Kubernetes cluster.
  - `etcd_cluster_size` (Number). Number of etcd clusters that will be used for the Kubernetes master.
  - `external_v4_address` (*Read-Only*) (String). An IPv4 external network address that is assigned to the master.
  - `external_v4_endpoint` (*Read-Only*) (String). External endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud).
  - `external_v6_address` (String). An IPv6 external network address that is assigned to the master.
  - `external_v6_endpoint` (*Read-Only*) (String). External IPv6 endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud).
  - `internal_v4_address` (*Read-Only*) (String). An IPv4 internal network address that is assigned to the master.
  - `internal_v4_endpoint` (*Read-Only*) (String). Internal endpoint that can be used to connect to the master from cloud networks.
  - `maintenance_policy` [Block]. Maintenance policy for Kubernetes master. If policy is omitted, automatic revision upgrades of the kubernetes master are enabled and could happen at any time. Revision upgrades are performed only within the same minor version, e.g. 1.29. Minor version upgrades (e.g. 1.29->1.30) should be performed manually.
    - `auto_upgrade` (**Required**)(Bool). Boolean flag that specifies if master can be upgraded automatically. When omitted, default value is TRUE.
    - `maintenance_window` [Block]. This structure specifies maintenance window, when update for master is allowed. When omitted, it defaults to any time. To specify time of day interval, for all days, one element should be provided, with two fields set, `start_time` and `duration`. Please see `zonal_cluster_resource_name` config example.To allow maintenance only on specific days of week, please provide list of elements, with all fields set. Only one time interval (`duration`) is allowed for each day of week. Please see `regional_cluster_resource_name` config example
      - `day` (String). The day of the week which you want to update.
      - `duration` (**Required**)(String). The duration of the day of week you want to update.
      - `start_time` (**Required**)(String). The start time of the day of week you want to update.
  - `master_location` [Block]. Cluster master's instances locations array (zone and subnet). Cannot be used together with `zonal` or `regional`. Currently, supports either one, for zonal master, or three instances of `master_location`. Can be updated in place. When creating regional cluster (three master instances), its `region` will be evaluated automatically by backend.
    - `subnet_id` (String). ID of the subnet.
    - `zone` (String). ID of the availability zone.
  - `master_logging` [Block]. Master Logging options.
    - `audit_enabled` (Bool). Boolean flag that specifies if kube-apiserver audit logs should be sent to Yandex Cloud Logging.
    - `cluster_autoscaler_enabled` (Bool). Boolean flag that specifies if cluster-autoscaler logs should be sent to Yandex Cloud Logging.
    - `enabled` (Bool). Boolean flag that specifies if master components logs should be sent to [Yandex Cloud Logging](https://yandex.cloud/docs/logging/). The exact components that will send their logs must be configured via the options described below.

        {% note warning %}

        Only one of `log_group_id` or `folder_id` (or none) may be specified. If `log_group_id` is specified, logs will be sent to this specific Log group. If `folder_id` is specified, logs will be sent to **default** Log group of this folder. If none of two is specified, logs will be sent to **default** Log group of the **same** folder as Kubernetes cluster.

        {% endnote %}
    - `events_enabled` (Bool). Boolean flag that specifies if kubernetes cluster events should be sent to Yandex Cloud Logging.
    - `folder_id` (String). ID of the folder default Log group of which should be used to collect logs.
    - `kube_apiserver_enabled` (Bool). Boolean flag that specifies if kube-apiserver logs should be sent to Yandex Cloud Logging.
    - `log_group_id` (String). ID of the Yandex Cloud Logging [Log group](https://yandex.cloud/docs/logging/concepts/log-group).
  - `public_ip` (Bool). When `true`, Kubernetes master will have visible ipv4 address.
  - `regional` [Block]. Initialize parameters for Regional Master (highly available master).
    - `region` (**Required**)(String). Name of availability region (e.g. `ru-central1`), where master instances will be allocated.
  - `scale_policy` [Block]. Scale policy of the master.
    - `auto_scale` [Block]. Autoscaled master instance resources.
      - `min_resource_preset_id` (**Required**)(String). Minimal resource preset ID.
  - `security_group_ids` (Set Of String). The list of security groups applied to resource or their components.
  - `version` (String). Version of Kubernetes that will be used for master.
  - `version_info` (*Read-Only*) (List Of Object). Information about cluster version.
    - `current_version` . 
    - `new_revision_available` . 
    - `new_revision_summary` . 
    - `version_deprecated` . 
  - `zonal` [Block]. Initialize parameters for Zonal Master (single node master).
    - `zone` (String). ID of the availability zone.
- `name` (String). The resource name.
- `network_id` (**Required**)(String). The ID of the cluster network.
- `network_implementation` [Block]. Network Implementation options.
  - `cilium` [Block]. Cilium network implementation configuration. No options exist.
    - `routing_mode` . 
- `network_policy_provider` (String). Network policy provider for the cluster. Possible values: `CALICO`.
- `node_ipv4_cidr_mask_size` (Number). Size of the masks that are assigned to each node in the cluster. Effectively limits maximum number of pods for each node.
- `node_service_account_id` (**Required**)(String). Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics.
- `release_channel` (String). Cluster release channel.
- `service_account_id` (**Required**)(String). Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. Selected service account should have `edit` role on the folder where the Kubernetes cluster will be located and on the folder where selected network resides.
- `service_ipv4_range` (String). CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from. It should not overlap with any subnet in the network the Kubernetes cluster located in.
- `service_ipv6_range` (String). Identical to service_ipv4_range but for IPv6 protocol.
- `status` (*Read-Only*) (String). Status of the Kubernetes cluster.
- `workload_identity_federation` [Block]. Workload Identity Federation configuration.
  - `enabled` (**Required**)(Bool). Identifies whether Workload Identity Federation is enabled.
  - `issuer` (*Read-Only*) (String). Issuer URI for Kubernetes service account tokens.
  - `jwks_uri` (*Read-Only*) (String). JSON Web Key Set URI used to verify token signatures.


