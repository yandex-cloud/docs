---
subcategory: Managed Services for Kubernetes
---

# yandex_kubernetes_node_group (DataSource)

Get information about a Yandex Kubernetes Node Group. For more information, see [the official documentation](https://yandex.cloud/docs/managed-kubernetes/concepts/#node-group).

{% note warning %}

One of `node_group_id` or `name` should be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing Managed Kubernetes Node Group.
//
data "yandex_kubernetes_node_group" "my_node_group" {
  node_group_id = "some_k8s_node_group_id"
}

output "my_node_group.status" {
  value = data.yandex_kubernetes_node_group.my_node_group.status
}
```

## Arguments & Attributes Reference

- `allocation_policy` (*Read-Only*) (List Of Object). This argument specify subnets (zones), that will be used by node group compute instances.
  - `location` . 
    - `subnet_id` . 
    - `zone` . 
- `allowed_unsafe_sysctls` (*Read-Only*) (List Of String). A list of allowed unsafe `sysctl` parameters for this node group. For more details see [documentation](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster).
- `cluster_id` (*Read-Only*) (String). The ID of the Kubernetes cluster that this node group belongs to.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deploy_policy` (*Read-Only*) (List Of Object). Deploy policy of the node group.
  - `max_expansion` . 
  - `max_unavailable` . 
- `description` (*Read-Only*) (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `instance_group_id` (*Read-Only*) (String). ID of instance group that is used to manage this Kubernetes node group.
- `instance_template` (*Read-Only*) (List Of Object). Template used to create compute instances in this Kubernetes node group.
  - `boot_disk` . 
    - `size` . 
    - `type` . 
  - `container_network` . 
    - `pod_mtu` . 
  - `container_runtime` . 
    - `type` . 
  - `gpu_settings` . 
    - `gpu_cluster_id` . 
    - `gpu_environment` . 
  - `labels` . 
  - `metadata` . 
  - `name` . 
  - `nat` . 
  - `network_acceleration_type` . 
  - `network_interface` . 
    - `ipv4` . 
    - `ipv4_dns_records` . 
      - `dns_zone_id` . 
      - `fqdn` . 
      - `ptr` . 
      - `ttl` . 
    - `ipv6` . 
    - `ipv6_dns_records` . 
      - `dns_zone_id` . 
      - `fqdn` . 
      - `ptr` . 
      - `ttl` . 
    - `nat` . 
    - `security_group_ids` . 
    - `subnet_ids` . 
  - `placement_policy` . 
    - `placement_group_id` . 
  - `platform_id` . 
  - `reserved_instance_pool_id` . 
  - `resources` . 
    - `core_fraction` . 
    - `cores` . 
    - `gpus` . 
    - `memory` . 
  - `scheduling_policy` . 
    - `preemptible` . 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `maintenance_policy` (*Read-Only*) (List Of Object). Maintenance policy for this Kubernetes node group. If policy is omitted, automatic revision upgrades are enabled and could happen at any time. Revision upgrades are performed only within the same minor version, e.g. `1.29`. Minor version upgrades (e.g. `1.29`->`1.30`) should be performed manually.
  - `auto_repair` . 
  - `auto_upgrade` . 
  - `maintenance_window` . 
    - `day` . 
    - `duration` . 
    - `start_time` . 
- `name` (String). The resource name.
- `node_group_id` (String). ID of a specific Kubernetes node group.
- `node_labels` (*Read-Only*) (Map Of String). A set of key/value label pairs, that are assigned to all the nodes of this Kubernetes node group.
- `node_taints` (*Read-Only*) (List Of String). A list of Kubernetes taints, that are applied to all the nodes of this Kubernetes node group.
- `scale_policy` (*Read-Only*) (List Of Object). Scale policy of the node group.
  - `auto_scale` . 
    - `initial` . 
    - `max` . 
    - `min` . 
  - `fixed_scale` . 
    - `size` . 
- `status` (*Read-Only*) (String). Status of the Kubernetes node group.
- `variables` (*Read-Only*) (Map Of String). Variables for templating as key/value pairs.
- `version_info` (*Read-Only*) (List Of Object). Information about Kubernetes node group version.
  - `current_version` . 
  - `new_revision_available` . 
  - `new_revision_summary` . 
  - `version_deprecated` . 
- `workload_identity_federation` (*Read-Only*) (List Of Object). Workload Identity Federation configuration.
  - `enabled` .


