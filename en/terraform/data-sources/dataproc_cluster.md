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

- `autoscaling_service_account_id` (*Read-Only*) (String). Service account to be used for managing hosts in an autoscaled subcluster.
- `bucket` (*Read-Only*) (String). Name of the Object Storage bucket to use for Yandex Data Processing jobs. Yandex Data Processing Agent saves output of job driver's process to specified bucket. In order for this to work service account (specified by the `service_account_id` argument) should be given permission to create objects within this bucket.
- `cluster_config` (*Read-Only*) (List Of Object). Configuration and resources for hosts that should be created with the cluster.
  - `hadoop` . 
    - `initialization_action` . 
      - `args` . 
      - `timeout` . 
      - `uri` . 
    - `oslogin` . 
    - `properties` . 
    - `services` . 
    - `ssh_public_keys` . 
  - `subcluster_spec` . 
    - `assign_public_ip` . 
    - `autoscaling_config` . 
      - `cpu_utilization_target` . 
      - `decommission_timeout` . 
      - `max_hosts_count` . 
      - `measurement_duration` . 
      - `preemptible` . 
      - `stabilization_duration` . 
      - `warmup_duration` . 
    - `hosts_count` . 
    - `id` . 
    - `name` . 
    - `resources` . 
      - `disk_size` . 
      - `disk_type_id` . 
      - `resource_preset_id` . 
    - `role` . 
    - `subnet_id` . 
  - `version_id` . 
- `cluster_id` (String). The ID of the Yandex Data Processing cluster.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `deletion_protection` (*Read-Only*) (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (*Read-Only*) (String). The resource description.
- `environment` (*Read-Only*) (String). Deployment environment of the cluster. Can be either `PRESTABLE` or `PRODUCTION`. The default is `PRESTABLE`.
- `folder_id` (*Read-Only*) (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `host_group_ids` (*Read-Only*) (Set Of String). A list of host group IDs to place VMs of the cluster on.
- `id` (String). 
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `log_group_id` (*Read-Only*) (String). ID of the cloud logging group for cluster logs.
- `name` (String). The resource name.
- `security_group_ids` (*Read-Only*) (Set Of String). The list of security groups applied to resource or their components.
- `service_account_id` (*Read-Only*) (String). Service account to be used by the Yandex Data Processing agent to access resources of Yandex Cloud. Selected service account should have `mdb.dataproc.agent` role on the folder where the Yandex Data Processing cluster will be located.
- `ui_proxy` (*Read-Only*) (Bool). Whether to enable UI Proxy feature.
- `zone_id` (*Read-Only*) (String). The [availability zone](https://yandex.cloud/docs/overview/concepts/geo-scope) where resource is located. If it is not provided, the default provider zone will be used.


