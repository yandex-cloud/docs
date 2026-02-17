---
subcategory: Yandex Data Processing
---

# yandex_dataproc_cluster (DataSource)



## Example usage

```terraform
//
// Get information about existing Data Processing Cluster.
//
data "yandex_dataproc_cluster" "foo" {
  name = "test"
}

output "service_account_id" {
  value = data.yandex_dataproc_cluster.foo.service_account_id
}
```

## Arguments & Attributes Reference

- `autoscaling_service_account_id` (String). Service account to be used for managing hosts in an autoscaled subcluster.
- `bucket` (String). Name of the Object Storage bucket to use for Yandex Data Processing jobs. Yandex Data Processing Agent saves output of job driver's process to specified bucket. In order for this to work service account (specified by the `service_account_id` argument) should be given permission to create objects within this bucket.
- `cluster_config` [Block]. Configuration and resources for hosts that should be created with the cluster.
  - `hadoop` [Block]. Yandex Data Processing specific options.
    - `initialization_action` [Block]. List of initialization scripts.
      - `args` (List Of String). List of arguments of the initialization script.
      - `timeout` (String). Script execution timeout, in seconds.
      - `uri` (**Required**)(String). Script URI.
    - `oslogin` (Bool). Whether to enable authorization via OS Login.
    - `properties` (Map Of String). A set of key/value pairs that are used to configure cluster services.
    - `services` (Set Of String). List of services to run on Yandex Data Processing cluster.
    - `ssh_public_keys` (Set Of String). List of SSH public keys to put to the hosts of the cluster. For information on how to connect to the cluster, see [the official documentation](https://yandex.cloud/docs/data-proc/operations/connect).
  - `subcluster_spec` [Block]. Configuration of the Yandex Data Processing subcluster.
    - `assign_public_ip` (Bool). If `true` then assign public IP addresses to the hosts of the subclusters.
    - `autoscaling_config` [Block]. Autoscaling configuration for compute subclusters.
      - `cpu_utilization_target` (String). Defines an autoscaling rule based on the average CPU utilization of the instance group. If not set default autoscaling metric will be used.
      - `decommission_timeout` (String). Timeout to gracefully decommission nodes during downscaling. In seconds.
      - `max_hosts_count` (**Required**)(Number). Maximum number of nodes in autoscaling subclusters.
      - `measurement_duration` (String). Time in seconds allotted for averaging metrics.
      - `preemptible` (Bool). Use preemptible compute instances. Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see [Preemptible Virtual Machines](https://yandex.cloud/docs/compute/concepts/preemptible-vm).
      - `stabilization_duration` (String). Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should.
      - `warmup_duration` (String). The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected.
    - `hosts_count` (**Required**)(Number). Number of hosts within Yandex Data Processing subcluster.
    - `id` (*Read-Only*) (String). ID of the subcluster.
    - `name` (**Required**)(String). Name of the Yandex Data Processing subcluster.
    - `resources` [Block]. Resources allocated to each host of the Yandex Data Processing subcluster.
      - `disk_size` (**Required**)(Number). Volume of the storage available to a host, in gigabytes.
      - `disk_type_id` (String). Type of the storage of a host. One of `network-hdd` (default) or `network-ssd`.
      - `resource_preset_id` (**Required**)(String). The ID of the preset for computational resources available to a host. All available presets are listed in the [documentation](https://yandex.cloud/docs/data-proc/concepts/instance-types).
    - `role` (**Required**)(String). Role of the subcluster in the Yandex Data Processing cluster.
    - `subnet_id` (**Required**)(String). The ID of the subnet, to which hosts of the subcluster belong. Subnets of all the subclusters must belong to the same VPC network.
  - `version_id` (String). Version of Yandex Data Processing image.
- `cluster_id` (String). The ID of the Yandex Data Processing cluster.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `environment` (String). Deployment environment of the cluster. Can be either `PRESTABLE` or `PRODUCTION`. The default is `PRESTABLE`.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `host_group_ids` (Set Of String). A list of host group IDs to place VMs of the cluster on.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `log_group_id` (String). ID of the cloud logging group for cluster logs.
- `name` (**Required**)(String). The resource name.
- `security_group_ids` (Set Of String). The list of security groups applied to resource or their components.
- `service_account_id` (**Required**)(String). Service account to be used by the Yandex Data Processing agent to access resources of Yandex Cloud. Selected service account should have `mdb.dataproc.agent` role on the folder where the Yandex Data Processing cluster will be located.
- `ui_proxy` (Bool). Whether to enable UI Proxy feature.
- `zone_id` (String). The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.


