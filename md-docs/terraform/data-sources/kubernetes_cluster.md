[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Managed Services for Kubernetes > Data Sources > kubernetes_cluster

# yandex_kubernetes_cluster (DataSource)

Get information about a Yandex Cloud Managed Kubernetes Cluster. For more information, see [the official documentation](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

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
- `cluster_ipv4_range` (*Read-Only*) (String). CIDR block. IP range for allocating pod addresses. It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets.
- `cluster_ipv6_range` (*Read-Only*) (String). Identical to `cluster_ipv4_range` but for IPv6 protocol.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (*Read-Only*) (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `health` (*Read-Only*) (String). Health of the Kubernetes cluster.
- `id` (String). 
- `kms_provider` (*Read-Only*) (List Of Object). Cluster KMS provider parameters.
  - `key_id` . 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `log_group_id` (*Read-Only*) (String). Log group where cluster stores cluster system logs, like audit, events, or control plane logs.
- `master` (*Read-Only*) (List Of Object). Kubernetes master configuration options.
  - `cluster_ca_certificate` . 
  - `etcd_cluster_size` . 
  - `external_v4_address` . 
  - `external_v4_endpoint` . 
  - `external_v6_address` . 
  - `external_v6_endpoint` . 
  - `internal_v4_address` . 
  - `internal_v4_endpoint` . 
  - `maintenance_policy` . 
    - `auto_upgrade` . 
    - `maintenance_window` . 
      - `day` . 
      - `duration` . 
      - `start_time` . 
  - `master_location` . 
    - `subnet_id` . 
    - `zone` . 
  - `master_logging` . 
    - `audit_enabled` . 
    - `cluster_autoscaler_enabled` . 
    - `enabled` . 
    - `events_enabled` . 
    - `folder_id` . 
    - `kube_apiserver_enabled` . 
    - `log_group_id` . 
  - `public_ip` . 
  - `regional` . 
    - `region` . 
  - `scale_policy` . 
    - `auto_scale` . 
      - `min_resource_preset_id` . 
  - `security_group_ids` . 
  - `version` . 
  - `version_info` . 
    - `current_version` . 
    - `new_revision_available` . 
    - `new_revision_summary` . 
    - `version_deprecated` . 
  - `zonal` . 
    - `zone` . 
- `name` (String). The resource name.
- `network_id` (*Read-Only*) (String). The ID of the cluster network.
- `network_implementation` (*Read-Only*) (List Of Object). Network Implementation options.
  - `cilium` . 
    - `routing_mode` . 
- `network_policy_provider` (*Read-Only*) (String). Network policy provider for the cluster. Possible values: `CALICO`.
- `node_ipv4_cidr_mask_size` (*Read-Only*) (Number). Size of the masks that are assigned to each node in the cluster. Effectively limits maximum number of pods for each node.
- `node_service_account_id` (*Read-Only*) (String). Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics.
- `release_channel` (*Read-Only*) (String). Cluster release channel.
- `service_account_id` (*Read-Only*) (String). Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. Selected service account should have `edit` role on the folder where the Kubernetes cluster will be located and on the folder where selected network resides.
- `service_ipv4_range` (*Read-Only*) (String). CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from. It should not overlap with any subnet in the network the Kubernetes cluster located in.
- `service_ipv6_range` (*Read-Only*) (String). Identical to service_ipv4_range but for IPv6 protocol.
- `status` (*Read-Only*) (String). Status of the Kubernetes cluster.
- `workload_identity_federation` (*Read-Only*) (List Of Object). Workload Identity Federation configuration.
  - `enabled` . 
  - `issuer` . 
  - `jwks_uri` .