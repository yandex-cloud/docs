---
subcategory: Managed Services for Kubernetes
---

# yandex_kubernetes_node_group (Resource)

Creates a Yandex Managed Kubernetes Cluster Node Group. For more information, see [the official documentation](https://yandex.cloud/docs/managed-kubernetes/concepts/#node-group).

## Example usage

```terraform
//
// Create a new Managed Kubernetes Node Group.
//
resource "yandex_kubernetes_node_group" "my_node_group" {
  cluster_id  = yandex_kubernetes_cluster.my_cluster.id
  name        = "name"
  description = "description"
  version     = "1.30"

  labels = {
    "key" = "value"
  }

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat        = true
      subnet_ids = ["${yandex_vpc_subnet.my_subnet.id}"]
    }

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = "containerd"
    }
  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-a"
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

    maintenance_window {
      day        = "monday"
      start_time = "15:00"
      duration   = "3h"
    }

    maintenance_window {
      day        = "friday"
      start_time = "10:00"
      duration   = "4h30m"
    }
  }

  workload_identity_federation {
    enabled = true
  }
}
```

## Arguments & Attributes Reference

- `allowed_unsafe_sysctls` (List Of String). A list of allowed unsafe `sysctl` parameters for this node group. For more details see [documentation](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster).
- `cluster_id` (**Required**)(String). The ID of the Kubernetes cluster that this node group belongs to.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (String). The resource description.
- `id` (String). 
- `instance_group_id` (*Read-Only*) (String). ID of instance group that is used to manage this Kubernetes node group.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The resource name.
- `node_labels` (Map Of String). A set of key/value label pairs, that are assigned to all the nodes of this Kubernetes node group.
- `node_taints` (List Of String). A list of Kubernetes taints, that are applied to all the nodes of this Kubernetes node group.
- `status` (*Read-Only*) (String). Status of the Kubernetes node group.
- `version` (String). Version of Kubernetes that will be used for Kubernetes node group.
- `version_info` (*Read-Only*) (List Of Object). Information about Kubernetes node group version.
  - `current_version` . 
  - `new_revision_available` . 
  - `new_revision_summary` . 
  - `version_deprecated` . 
- `allocation_policy` [Block]. This argument specify subnets (zones), that will be used by node group compute instances.
  - `location` [Block]. Repeated field, that specify subnets (zones), that will be used by node group compute instances. Subnet specified by `subnet_id` should be allocated in zone specified by 'zone' argument.
    - `subnet_id` (String). ID of the subnet, that will be used by one compute instance in node group.
    - `zone` (String). ID of the availability zone where for one compute instance in node group.
- `deploy_policy` [Block]. Deploy policy of the node group.
  - `max_expansion` (**Required**)(Number). The maximum number of instances that can be temporarily allocated above the group's target size during the update.
  - `max_unavailable` (**Required**)(Number). The maximum number of running instances that can be taken offline during update.
- `instance_template` [Block]. Template used to create compute instances in this Kubernetes node group.
  - `labels` (Map Of String). Labels that will be assigned to compute nodes (instances), created by the Node Group.
  - `metadata` (Map Of String). The set of metadata `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. **Note**: key `user-data` won't be provided into instances. It reserved for internal activity in `kubernetes_node_group` resource.
  - `name` (String). Name template of the instance. In order to be unique it must contain at least one of instance unique placeholders:
    * `{instance.short_id}`
    * `{instance.index}`
    * combination of `{instance.zone_id}` and `{instance.index_in_zone}`

    Example: `my-instance-{instance.index}`.

    If not set, default is used: `{instance_group.id}-{instance.short_id}`. It may also contain another placeholders, see [Compute Instance group metadata doc](https://yandex.cloud/docs/compute/instancegroup/api-ref/grpc/InstanceGroup) for full list.
  - `nat` (Bool). Enables NAT for node group compute instances.
  - `network_acceleration_type` (String). Type of network acceleration. Values: `standard`, `software_accelerated`.
  - `platform_id` (String). The ID of the hardware platform configuration for the node group compute instances.
  - `boot_disk` [Block]. The specifications for boot disks that will be attached to the instance.
    - `size` (Number). The size of the disk in GB. Allowed minimal size: 64 GB.
    - `type` (String). The disk type.
  - `container_network` [Block]. Container network configuration.
    - `pod_mtu` (Number). MTU for pods.
  - `container_runtime` [Block]. Container runtime configuration.
    - `type` (**Required**)(String). Type of container runtime. Values: `docker`, `containerd`.
  - `gpu_settings` [Block]. GPU settings.
    - `gpu_cluster_id` (String). GPU cluster id.
    - `gpu_environment` (String). GPU environment. Values: `runc`, `runc_drivers_cuda`.
  - `network_interface` [Block]. An array with the network interfaces that will be attached to the instance.
    - `ipv4` (Bool). Allocate an IPv4 address for the interface. The default value is `true`.
    - `ipv6` (Bool). If true, allocate an IPv6 address for the interface. The address will be automatically assigned from the specified subnet.
    - `nat` (Bool). A public address that can be used to access the internet over NAT.
    - `security_group_ids` (Set Of String). Security group IDs for network interface.
    - `subnet_ids` (**Required**)(Set Of String). The IDs of the subnets.
    - `ipv4_dns_records` [Block]. List of configurations for creating ipv4 DNS records.
      - `dns_zone_id` (String). DNS zone ID (if not set, private zone is used).
      - `fqdn` (**Required**)(String). DNS record FQDN.
      - `ptr` (Bool). When set to `true`, also create a PTR DNS record.
      - `ttl` (Number). DNS record TTL (in seconds).
    - `ipv6_dns_records` [Block]. List of configurations for creating ipv6 DNS records.
      - `dns_zone_id` (String). DNS zone ID (if not set, private zone is used).
      - `fqdn` (**Required**)(String). DNS record FQDN.
      - `ptr` (Bool). When set to `true`, also create a PTR DNS record.
      - `ttl` (Number). DNS record TTL (in seconds).
  - `placement_policy` [Block]. The placement policy configuration.
    - `placement_group_id` (**Required**)(String). Specifies the id of the Placement Group to assign to the instances.
  - `resources` [Block]. Instance resource configuration.
    - `core_fraction` (Number). Baseline core performance as a percent.
    - `cores` (Number). Number of CPU cores allocated to the instance.
    - `gpus` (Number). Number of GPU cores allocated to the instance.
    - `memory` (Number). The memory size allocated to the instance.
  - `scheduling_policy` [Block]. The scheduling policy for the instances in node group.
    - `preemptible` (Bool). Specifies if the instance is preemptible. Defaults to `false`.
- `maintenance_policy` [Block]. Maintenance policy for this Kubernetes node group. If policy is omitted, automatic revision upgrades are enabled and could happen at any time. Revision upgrades are performed only within the same minor version, e.g. `1.29`. Minor version upgrades (e.g. `1.29`->`1.30`) should be performed manually.
  - `auto_repair` (**Required**)(Bool). Flag that specifies if node group can be repaired automatically. When omitted, default value is `true`.
  - `auto_upgrade` (**Required**)(Bool). Flag specifies if node group can be upgraded automatically. When omitted, default value is `true`.
  - `maintenance_window` [Block]. Set of day intervals, when maintenance is allowed for this node group. When omitted, it defaults to any time.

    To specify time of day interval, for all days, one element should be provided, with two fields set, `start_time` and `duration`.

    To allow maintenance only on specific days of week, please provide list of elements, with all fields set. Only one time interval is allowed for each day of week. Please see `my_node_group` config example.

    - `day` (String). Day of week, on which maintenance is allowed.
    - `duration` (**Required**)(String). Duration of maintenance from start_time.
    - `start_time` (**Required**)(String). Start time of maintenance in day.
- `scale_policy` [Block]. Scale policy of the node group.
  - `auto_scale` [Block]. Scale policy for an autoscaled node group.
    - `initial` (**Required**)(Number). Initial number of instances in the node group.
    - `max` (**Required**)(Number). Maximum number of instances in the node group.
    - `min` (**Required**)(Number). Minimum number of instances in the node group.
  - `fixed_scale` [Block]. Scale policy for a fixed scale node group.
    - `size` (Number). The number of instances in the node group.
- `workload_identity_federation` [Block]. Workload Identity Federation configuration.
  - `enabled` (**Required**)(Bool). Identifies whether Workload Identity Federation is enabled.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_kubernetes_node_group.<resource Name> <resource Id>
terraform import yandex_kubernetes_node_group.my_node_group ...
```
