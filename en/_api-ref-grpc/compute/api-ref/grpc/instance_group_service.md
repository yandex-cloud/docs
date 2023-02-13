---
editable: false
---

# Compute Cloud API, gRPC: InstanceGroupService

A set of methods for managing InstanceGroup resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified InstanceGroup resource. |
| [List](#List) | Retrieves the list of InstanceGroup resources in the specified folder. |
| [Create](#Create) | Creates an instance group in the specified folder. |
| [CreateFromYaml](#CreateFromYaml) | Creates an instance group in the specified folder from a YAML file. |
| [Update](#Update) | Updates the specified instance group. |
| [UpdateFromYaml](#UpdateFromYaml) | Updates the specified instance group from a YAML file. |
| [Stop](#Stop) | Stops the specified instance group. |
| [Start](#Start) | Starts the specified instance group. |
| [Delete](#Delete) | Deletes the specified instance group. |
| [ListInstances](#ListInstances) | Lists instances for the specified instance group. |
| [DeleteInstances](#DeleteInstances) | Delete instances from the instance group. |
| [StopInstances](#StopInstances) | Stop instances from the instance group. |
| [ListOperations](#ListOperations) | Lists operations for the specified instance group. |
| [ListLogRecords](#ListLogRecords) | Lists logs for the specified instance group. |
| [ListAccessBindings](#ListAccessBindings) | Lists existing access bindings for the specified instance group. |
| [SetAccessBindings](#SetAccessBindings) | Sets access bindings for the specified instance group. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings for the specified instance group. |
| [ResumeProcesses](#ResumeProcesses) | Resumes all processes regarding management of the specified instance group, i.e. |
| [PauseProcesses](#PauseProcesses) | Pauses all processes regarding management of the specified instance group, i.e. |

## Calls InstanceGroupService {#calls}

## Get {#Get}

Returns the specified InstanceGroup resource. <br>To get the list of available InstanceGroup resources, make a [List](#List) request.

**rpc Get ([GetInstanceGroupRequest](#GetInstanceGroupRequest)) returns ([InstanceGroup](#InstanceGroup))**

### GetInstanceGroupRequest {#GetInstanceGroupRequest}

Field | Description
--- | ---
instance_group_id | **string**<br>Required. ID of the InstanceGroup resource to return. To get the instance group ID, use a [InstanceGroupService.List](#List) request. The maximum string length in characters is 50.
view | enum **InstanceGroupView**<br>Defines which information about the Instance template should be returned in the server response. <ul><li>`BASIC`: Doesn't include the metadata of the instance template in the server response.</li><li>`FULL`: Returns the metadata of the instance template in the server response.</li></ul>


### InstanceGroup {#InstanceGroup}

Field | Description
--- | ---
id | **string**<br>ID of the instance group. 
folder_id | **string**<br>ID of the folder that the instance group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the instance group. The name is unique within the folder. 
description | **string**<br>Description of the instance group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
instance_template | **[InstanceTemplate](#InstanceTemplate)**<br>Instance template for creating the instance group. For more information, see [Instance Templates](/docs/compute/concepts/instance-groups/instance-template). 
scale_policy | **[ScalePolicy](#ScalePolicy)**<br>[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. 
deploy_policy | **[DeployPolicy](#DeployPolicy)**<br>Deployment policy of the instance group. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy)**<br>Allocation policy of the instance group by zones and regions. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState)**<br>Status of the Network Load Balancer target group attributed to the instance group. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState)**<br>States of instances for this instance group. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec)**<br>Settings for balancing load between instances via [Network Load Balancer](/docs/network-load-balancer/concepts) (OSI model layer 3). 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec)**<br>Health checking specification. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. 
status | enum **Status**<br>Status of the instance group. <ul><li>`STARTING`: Instance group is being started and will become active soon.</li><li>`ACTIVE`: Instance group is active. In this state the group manages its instances and monitors their health, creating, deleting, stopping, updating and starting instances as needed. <br>To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/api-ref/grpc/instance_group_service#Stop). To pause the processes in the instance group, i.e. scaling, checking instances' health, auto-healing and updating them, without stopping the instances, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.PauseProcesses](/docs/compute/api-ref/grpc/instance_group_service#PauseProcesses).</li><li>`STOPPING`: Instance group is being stopped. Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.</li><li>`STOPPED`: Instance group is stopped. In this state the group cannot be updated and does not react to any changes made to its instances. To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/api-ref/grpc/instance_group_service#Start).</li><li>`DELETING`: Instance group is being deleted.</li><li>`PAUSED`: Instance group is paused. In this state all the processes regarding the group management, i.e. scaling, checking instances' health, auto-healing and updating them, are paused. The instances that were running prior to pausing the group, however, may still be running. <br>To resume the processes in the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.ResumeProcesses](/docs/compute/api-ref/grpc/instance_group_service#ResumeProcesses). The group status will change to `ACTIVE`.</li></ul>
variables[] | **[Variable](#Variable)**<br> 
deletion_protection | **bool**<br>Flag prohibiting deletion of the instance group. <br>Allowed values:</br>- `false`: The instance group can be deleted.</br>- `true`: The instance group cannot be deleted. <br>The default is `false`. 
application_load_balancer_spec | **[ApplicationLoadBalancerSpec](#ApplicationLoadBalancerSpec)**<br>Settings for balancing load between instances via [Application Load Balancer](/docs/application-load-balancer/concepts) (OSI model layer 7). 
application_load_balancer_state | **[ApplicationLoadBalancerState](#ApplicationLoadBalancerState)**<br>Status of the Application Load Balancer target group attributed to the instance group. <br>Returned if there is a working load balancer that the target group is connected to. 


### InstanceTemplate {#InstanceTemplate}

Field | Description
--- | ---
description | **string**<br>Description of the instance template. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
platform_id | **string**<br>Required. ID of the hardware platform configuration for the instance. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see [Platforms](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec)**<br>Required. Computing resources of the instance such as the amount of memory and number of cores. 
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>Metadata values may contain one of the supported placeholders: {instance_group.id} {instance.short_id} {instance.index} {instance.index_in_zone} {instance.zone_id} InstanceGroup and Instance labels may be copied to metadata following way: {instance_group.labels.some_label_key} {instance.labels.another_label_key} These placeholders will be substituted for each created instance anywhere in the value text. In the rare case the value requires to contain this placeholder explicitly, it must be escaped with double brackets, in example {instance.index}. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). No more than 128 per resource. The maximum string length in characters for each value is 262144. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec)**<br>Required. Boot disk specification that will be attached to the instance. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec)**<br>Array of secondary disks that will be attached to the instance. The maximum number of elements is 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec)**<br>Array of network interfaces that will be attached to the instance. The number of elemets must be exactly 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy)**<br>Scheduling policy for the instance. 
service_account_id | **string**<br>Service account ID for the instance. 
network_settings | **[NetworkSettings](#NetworkSettings)**<br>Network settings for the instance. 
name | **string**<br>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
hostname | **string**<br>Host name for the instance. This field is used to generate the `yandex.cloud.compute.v1.Instance.fqdn` value. The host name must be unique within the network and region. If not specified, the host name will be equal to `yandex.cloud.compute.v1.Instance.id` of the instance and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`. <br>In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, `name` value will be used It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
placement_policy | **[PlacementPolicy](#PlacementPolicy)**<br>Placement Group 
filesystem_specs[] | **[AttachedFilesystemSpec](#AttachedFilesystemSpec)**<br>Array of filesystems to attach to the instance. <br>The filesystems must reside in the same availability zone as the instance. <br>To use the instance with an attached filesystem, the latter must be mounted. For details, see [documentation](/docs/compute/operations/filesystem/attach-to-vm). 


### ResourcesSpec {#ResourcesSpec}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. The maximum value is 824633720832.
cores | **int64**<br>The number of cores available to the instance. Value must be equal to 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64,68,72,76,80.
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. Value must be equal to 0,5,20,50,100.
gpus | **int64**<br>The number of GPUs available to the instance. Value must be equal to 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec}

Field | Description
--- | ---
mode | enum **Mode**<br>Required. Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li></ul>
device_name | **string**<br>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec)**<br>Required. oneof disk_spec or disk_id Disk specification that is attached to the instance. For more information, see [Disks](/docs/compute/concepts/disk). 
disk_id | **string**<br>Set to use an existing disk. To set use variables. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### DiskSpec {#DiskSpec}

Field | Description
--- | ---
description | **string**<br>Description of the disk. The maximum string length in characters is 256.
type_id | **string**<br>Required. ID of the disk type. 
size | **int64**<br>Size of the disk, specified in bytes. Acceptable values are 4194304 to 28587302322176, inclusive.
source_oneof | **oneof:** `image_id` or `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>ID of the image that will be used for disk creation. The maximum string length in characters is 50.
&nbsp;&nbsp;snapshot_id | **string**<br>ID of the snapshot that will be used for disk creation. The maximum string length in characters is 50.
preserve_after_instance_delete | **bool**<br>When set to true, disk will not be deleted even after managed instance is deleted. It will be a user's responsibility to delete such disks. 


### NetworkInterfaceSpec {#NetworkInterfaceSpec}

Field | Description
--- | ---
network_id | **string**<br>ID of the network. 
subnet_ids[] | **string**<br>IDs of the subnets. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>IDs of security groups. 


### PrimaryAddressSpec {#PrimaryAddressSpec}

Field | Description
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec)**<br>An external IP address configuration. If not specified, then this managed instance will have no external internet access. 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec)**<br>Internal DNS configuration 
address | **string**<br>Optional. Manual set static internal IP. To set use variables. 


### OneToOneNatSpec {#OneToOneNatSpec}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>IP version for the public IP address. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li></ul>
address | **string**<br>Manual set static public IP. To set use variables. (optional) 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec)**<br>External DNS configuration 


### DnsRecordSpec {#DnsRecordSpec}

Field | Description
--- | ---
fqdn | **string**<br>Required. FQDN (required) 
dns_zone_id | **string**<br>DNS zone id (optional, if not set, private zone used) 
ttl | **int64**<br>DNS record ttl, values in 0-86400 (optional) Acceptable values are 0 to 86400, inclusive.
ptr | **bool**<br>When set to true, also create PTR DNS record (optional) 


### SchedulingPolicy {#SchedulingPolicy}

Field | Description
--- | ---
preemptible | **bool**<br>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings}

Field | Description
--- | ---
type | enum **Type**<br>Type of instance network. 


### PlacementPolicy {#PlacementPolicy}

Field | Description
--- | ---
placement_group_id | **string**<br>Identifier of placement group 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action 
values[] | **string**<br>Affinity value or host ID or host group ID 


### AttachedFilesystemSpec {#AttachedFilesystemSpec}

Field | Description
--- | ---
mode | enum **Mode**<br>Mode of access to the filesystem that should be attached. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access. Default value.</li></ul>
device_name | **string**<br>Name of the device representing the filesystem on the instance. <br>The name should be used for referencing the filesystem from within the instance when it's being mounted, resized etc. <br>If not specified, a random value will be generated. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
filesystem_id | **string**<br>ID of the filesystem that should be attached. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### ScalePolicy {#ScalePolicy}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale` or `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale)**<br>[Manual scaling policy](/docs/compute/concepts/instance-groups/scale#fixed-policy) of the instance group. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale)**<br>[Automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 
test_auto_scale | **[AutoScale](#AutoScale)**<br>Test spec for [automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 


### AutoScale {#AutoScale}

Field | Description
--- | ---
min_zone_size | **int64**<br>Lower limit for instance count in each zone. Acceptable values are 0 to 100, inclusive.
max_size | **int64**<br>Upper limit for total instance count (across all zones). 0 means maximum limit = 100. Acceptable values are 0 to 100, inclusive.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time in seconds allotted for averaging metrics. 1 minute by default. Acceptable values are 1m to 10m, inclusive.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected. The maximum value is 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should. Acceptable values are 1m to 30m, inclusive.
initial_size | **int64**<br>Target group size. The minimum value is 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule)**<br>Defines an autoscaling rule based on the average CPU utilization of the instance group. <br>If more than one rule is specified, e.g. CPU utilization and one or more Monitoring metrics (`custom_rules`), the size of the instance group will be equal to the maximum of sizes calculated according to each metric. 
custom_rules[] | **[CustomRule](#CustomRule)**<br>Defines an autoscaling rule based on a [custom metric](/docs/monitoring/operations/metric/add) from Monitoring. <br>If more than one rule is specified, e.g. CPU utilization (`cpu_utilization_rule`) and one or more Monitoring metrics, the size of the instance group will be equal to the maximum of sizes calculated according to each metric. The maximum number of elements is 3.
auto_scale_type | enum **AutoScaleType**<br>Autoscaling type. <ul><li>`ZONAL`: Scale each zone independently. This is the default.</li><li>`REGIONAL`: Scale group as a whole.</li></ul>


### CpuUtilizationRule {#CpuUtilizationRule}

Field | Description
--- | ---
utilization_target | **double**<br>Target CPU utilization level. Instance Groups maintains this level for each availability zone. Acceptable values are 10 to 100, inclusive.


### CustomRule {#CustomRule}

Field | Description
--- | ---
rule_type | enum **RuleType**<br>Required. Custom metric rule type. This field affects which label from the custom metric should be used: `zone_id` or `instance_id`. <ul><li>`UTILIZATION`: This type means that the metric applies to one instance. First, Instance Groups calculates the average metric value for each instance, then averages the values for instances in one availability zone or in whole group depends on autoscaling type. This type of metric must have the `instance_id` label.</li><li>`WORKLOAD`: This type means that the metric applies to instances in one availability zone or to whole group depends on autoscaling type. This type of metric must have the `zone_id` label if ZONAL autoscaling type is chosen.</li></ul>
metric_type | enum **MetricType**<br>Required. Type of custom metric. This field affects how Instance Groups calculates the average metric value. <ul><li>`GAUGE`: This type is used for metrics that show the metric value at a certain point in time, such as requests per second to the server on an instance. <br>Instance Groups calculates the average metric value for the period specified in the [AutoScale.measurement_duration](#AutoScale) field.</li><li>`COUNTER`: This type is used for metrics that monotonically increase over time, such as the total number of requests to the server on an instance. <br>Instance Groups calculates the average value increase for the period specified in the [AutoScale.measurement_duration](#AutoScale) field.</li></ul>
metric_name | **string**<br>Required. Name of custom metric in Monitoring that should be used for scaling. Value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
labels | **map<string,string>**<br>Labels of custom metric in Monitoring that should be used for scaling. Each value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `. Each key must match the regular expression ` ^[a-zA-Z][0-9a-zA-Z_]{0,31}$ `.
target | **double**<br>Target value for the custom metric. Instance Groups maintains this level for each availability zone. Value must be greater than 0.
folder_id | **string**<br>Folder id of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 50.
service | **string**<br>Service of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 200.


### FixedScale {#FixedScale}

Field | Description
--- | ---
size | **int64**<br>Number of instances in the instance group. Acceptable values are 1 to 100, inclusive.


### DeployPolicy {#DeployPolicy}

Field | Description
--- | ---
max_unavailable | **int64**<br>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If `max_expansion` is not specified or set to zero, `max_unavailable` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
max_deleting | **int64**<br>The maximum number of instances that can be deleted at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_creating | **int64**<br>The maximum number of instances that can be created at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_expansion | **int64**<br>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If `max_unavailable` is not specified or set to zero, `max_expansion` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Instance startup duration. Instance will be considered up and running (and start receiving traffic) only after startup_duration has elapsed and all health checks are passed. See `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status` for more information. Acceptable values are 0m to 1h, inclusive.
strategy | enum **Strategy**<br>Affects the lifecycle of the instance during deployment. <ul><li>`PROACTIVE`: Instance Groups can forcefully stop a running instance. This is the default.</li><li>`OPPORTUNISTIC`: Instance Groups does not stop a running instance. Instead, it will wait until the instance stops itself or becomes unhealthy.</li></ul>


### AllocationPolicy {#AllocationPolicy}

Field | Description
--- | ---
zones[] | **[Zone](#Zone)**<br>List of availability zones. The minimum number of elements is 1.


### Zone {#Zone}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the instance resides. 


### LoadBalancerState {#LoadBalancerState}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Network Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


### ManagedInstancesState {#ManagedInstancesState}

Field | Description
--- | ---
target_size | **int64**<br>Target number of instances for this instance group. 
running_actual_count | **int64**<br>The number of running instances that match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_ACTUAL](#ManagedInstance). 
running_outdated_count | **int64**<br>The number of running instances that does not match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_OUTDATED](#ManagedInstance). 
processing_count | **int64**<br>The number of instances in flight (for example, updating, starting, deleting). For more information, see [ManagedInstance.Status](#ManagedInstance). 


### Statuses {#Statuses}

Field | Description
--- | ---
creating | **int64**<br>Instance is being created. 
starting | **int64**<br>Instance is being started. 
opening | **int64**<br>Instance is being opened to receive traffic. 
warming | **int64**<br>Instance is being warmed. 
running | **int64**<br>Instance is running normally. 
closing | **int64**<br>Instance is being closed to traffic. 
stopping | **int64**<br>Instance is being stopped. 
updating | **int64**<br>Instance is being updated. 
deleting | **int64**<br>Instance is being deleted. 
failed | **int64**<br>Instance failed and needs to be recreated. 


### LoadBalancerSpec {#LoadBalancerSpec}

Field | Description
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec)**<br>Specification of the target group that the instance group will be added to. For more information, see [Target groups and resources](/docs/load-balancer/concepts/target-resources). 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### TargetGroupSpec {#TargetGroupSpec}

Field | Description
--- | ---
name | **string**<br>Name of the target group. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the target group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec}

Field | Description
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). The minimum number of elements is 1.
max_checking_health_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to become healthy. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### HealthCheckSpec {#HealthCheckSpec}

Field | Description
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. Acceptable values are 1s to 300s, inclusive.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the managed instance to return a response for the health check. The default is 1 second. Acceptable values are 1s to 60s, inclusive.
unhealthy_threshold | **int64**<br>The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` or `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions)**<br>Configuration options for a TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions)**<br>Configuration options for an HTTP health check. 


### TcpOptions {#TcpOptions}

Field | Description
--- | ---
port | **int64**<br>Port to use for TCP health checks. Acceptable values are 1 to 65535, inclusive.


### HttpOptions {#HttpOptions}

Field | Description
--- | ---
port | **int64**<br>Port to use for HTTP health checks. Acceptable values are 1 to 65535, inclusive.
path | **string**<br>URL path to set for health checking requests. 


### Variable {#Variable}

Field | Description
--- | ---
key | **string**<br> The string length in characters must be 1-128. Value must match the regular expression ` [a-zA-Z0-9._-]* `.
value | **string**<br> The maximum string length in characters is 128.


### ApplicationLoadBalancerSpec {#ApplicationLoadBalancerSpec}

Field | Description
--- | ---
target_group_spec | **[ApplicationTargetGroupSpec](#ApplicationTargetGroupSpec)**<br>Required. Basic properties of the Application Load Balancer target group attributed to the instance group. 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### ApplicationTargetGroupSpec {#ApplicationTargetGroupSpec}

Field | Description
--- | ---
name | **string**<br>Name of the target group. 
description | **string**<br>Description of the target group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 


### ApplicationLoadBalancerState {#ApplicationLoadBalancerState}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Application Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


## List {#List}

Retrieves the list of InstanceGroup resources in the specified folder.

**rpc List ([ListInstanceGroupsRequest](#ListInstanceGroupsRequest)) returns ([ListInstanceGroupsResponse](#ListInstanceGroupsResponse))**

### ListInstanceGroupsRequest {#ListInstanceGroupsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list instance groups in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListInstanceGroupsResponse.next_page_token](#ListInstanceGroupsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListInstanceGroupsResponse.next_page_token](#ListInstanceGroupsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. Currently you can use filtering only on the [InstanceGroup.name](#InstanceGroup1) field. The maximum string length in characters is 1000.
view | enum **InstanceGroupView**<br>Defines which information about the Instance template should be returned in the server response. <ul><li>`BASIC`: Doesn't include the metadata of the instance template in the server response.</li><li>`FULL`: Returns the metadata of the instance template in the server response.</li></ul>


### ListInstanceGroupsResponse {#ListInstanceGroupsResponse}

Field | Description
--- | ---
instance_groups[] | **[InstanceGroup](#InstanceGroup1)**<br>Lists instance groups for the specified folder. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListInstanceGroupsRequest.page_size](#ListInstanceGroupsRequest), use `next_page_token` as the value for the [ListInstanceGroupsRequest.page_token](#ListInstanceGroupsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### InstanceGroup {#InstanceGroup1}

Field | Description
--- | ---
id | **string**<br>ID of the instance group. 
folder_id | **string**<br>ID of the folder that the instance group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the instance group. The name is unique within the folder. 
description | **string**<br>Description of the instance group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
instance_template | **[InstanceTemplate](#InstanceTemplate1)**<br>Instance template for creating the instance group. For more information, see [Instance Templates](/docs/compute/concepts/instance-groups/instance-template). 
scale_policy | **[ScalePolicy](#ScalePolicy1)**<br>[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. 
deploy_policy | **[DeployPolicy](#DeployPolicy1)**<br>Deployment policy of the instance group. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy1)**<br>Allocation policy of the instance group by zones and regions. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState1)**<br>Status of the Network Load Balancer target group attributed to the instance group. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState1)**<br>States of instances for this instance group. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec1)**<br>Settings for balancing load between instances via [Network Load Balancer](/docs/network-load-balancer/concepts) (OSI model layer 3). 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec1)**<br>Health checking specification. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. 
status | enum **Status**<br>Status of the instance group. <ul><li>`STARTING`: Instance group is being started and will become active soon.</li><li>`ACTIVE`: Instance group is active. In this state the group manages its instances and monitors their health, creating, deleting, stopping, updating and starting instances as needed. <br>To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/api-ref/grpc/instance_group_service#Stop). To pause the processes in the instance group, i.e. scaling, checking instances' health, auto-healing and updating them, without stopping the instances, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.PauseProcesses](/docs/compute/api-ref/grpc/instance_group_service#PauseProcesses).</li><li>`STOPPING`: Instance group is being stopped. Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.</li><li>`STOPPED`: Instance group is stopped. In this state the group cannot be updated and does not react to any changes made to its instances. To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/api-ref/grpc/instance_group_service#Start).</li><li>`DELETING`: Instance group is being deleted.</li><li>`PAUSED`: Instance group is paused. In this state all the processes regarding the group management, i.e. scaling, checking instances' health, auto-healing and updating them, are paused. The instances that were running prior to pausing the group, however, may still be running. <br>To resume the processes in the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.ResumeProcesses](/docs/compute/api-ref/grpc/instance_group_service#ResumeProcesses). The group status will change to `ACTIVE`.</li></ul>
variables[] | **[Variable](#Variable1)**<br> 
deletion_protection | **bool**<br>Flag prohibiting deletion of the instance group. <br>Allowed values:</br>- `false`: The instance group can be deleted.</br>- `true`: The instance group cannot be deleted. <br>The default is `false`. 
application_load_balancer_spec | **[ApplicationLoadBalancerSpec](#ApplicationLoadBalancerSpec1)**<br>Settings for balancing load between instances via [Application Load Balancer](/docs/application-load-balancer/concepts) (OSI model layer 7). 
application_load_balancer_state | **[ApplicationLoadBalancerState](#ApplicationLoadBalancerState1)**<br>Status of the Application Load Balancer target group attributed to the instance group. <br>Returned if there is a working load balancer that the target group is connected to. 


### InstanceTemplate {#InstanceTemplate1}

Field | Description
--- | ---
description | **string**<br>Description of the instance template. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
platform_id | **string**<br>Required. ID of the hardware platform configuration for the instance. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see [Platforms](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec1)**<br>Required. Computing resources of the instance such as the amount of memory and number of cores. 
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>Metadata values may contain one of the supported placeholders: {instance_group.id} {instance.short_id} {instance.index} {instance.index_in_zone} {instance.zone_id} InstanceGroup and Instance labels may be copied to metadata following way: {instance_group.labels.some_label_key} {instance.labels.another_label_key} These placeholders will be substituted for each created instance anywhere in the value text. In the rare case the value requires to contain this placeholder explicitly, it must be escaped with double brackets, in example {instance.index}. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). No more than 128 per resource. The maximum string length in characters for each value is 262144. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec1)**<br>Required. Boot disk specification that will be attached to the instance. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec1)**<br>Array of secondary disks that will be attached to the instance. The maximum number of elements is 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec1)**<br>Array of network interfaces that will be attached to the instance. The number of elemets must be exactly 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy1)**<br>Scheduling policy for the instance. 
service_account_id | **string**<br>Service account ID for the instance. 
network_settings | **[NetworkSettings](#NetworkSettings1)**<br>Network settings for the instance. 
name | **string**<br>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
hostname | **string**<br>Host name for the instance. This field is used to generate the `yandex.cloud.compute.v1.Instance.fqdn` value. The host name must be unique within the network and region. If not specified, the host name will be equal to `yandex.cloud.compute.v1.Instance.id` of the instance and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`. <br>In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, `name` value will be used It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
placement_policy | **[PlacementPolicy](#PlacementPolicy1)**<br>Placement Group 
filesystem_specs[] | **[AttachedFilesystemSpec](#AttachedFilesystemSpec1)**<br>Array of filesystems to attach to the instance. <br>The filesystems must reside in the same availability zone as the instance. <br>To use the instance with an attached filesystem, the latter must be mounted. For details, see [documentation](/docs/compute/operations/filesystem/attach-to-vm). 


### ResourcesSpec {#ResourcesSpec1}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. The maximum value is 824633720832.
cores | **int64**<br>The number of cores available to the instance. Value must be equal to 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64,68,72,76,80.
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. Value must be equal to 0,5,20,50,100.
gpus | **int64**<br>The number of GPUs available to the instance. Value must be equal to 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec1}

Field | Description
--- | ---
mode | enum **Mode**<br>Required. Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li></ul>
device_name | **string**<br>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec1)**<br>Required. oneof disk_spec or disk_id Disk specification that is attached to the instance. For more information, see [Disks](/docs/compute/concepts/disk). 
disk_id | **string**<br>Set to use an existing disk. To set use variables. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### DiskSpec {#DiskSpec1}

Field | Description
--- | ---
description | **string**<br>Description of the disk. The maximum string length in characters is 256.
type_id | **string**<br>Required. ID of the disk type. 
size | **int64**<br>Size of the disk, specified in bytes. Acceptable values are 4194304 to 28587302322176, inclusive.
source_oneof | **oneof:** `image_id` or `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>ID of the image that will be used for disk creation. The maximum string length in characters is 50.
&nbsp;&nbsp;snapshot_id | **string**<br>ID of the snapshot that will be used for disk creation. The maximum string length in characters is 50.
preserve_after_instance_delete | **bool**<br>When set to true, disk will not be deleted even after managed instance is deleted. It will be a user's responsibility to delete such disks. 


### NetworkInterfaceSpec {#NetworkInterfaceSpec1}

Field | Description
--- | ---
network_id | **string**<br>ID of the network. 
subnet_ids[] | **string**<br>IDs of the subnets. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec1)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec1)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>IDs of security groups. 


### PrimaryAddressSpec {#PrimaryAddressSpec1}

Field | Description
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec1)**<br>An external IP address configuration. If not specified, then this managed instance will have no external internet access. 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec1)**<br>Internal DNS configuration 
address | **string**<br>Optional. Manual set static internal IP. To set use variables. 


### OneToOneNatSpec {#OneToOneNatSpec1}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>IP version for the public IP address. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li></ul>
address | **string**<br>Manual set static public IP. To set use variables. (optional) 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec1)**<br>External DNS configuration 


### DnsRecordSpec {#DnsRecordSpec1}

Field | Description
--- | ---
fqdn | **string**<br>Required. FQDN (required) 
dns_zone_id | **string**<br>DNS zone id (optional, if not set, private zone used) 
ttl | **int64**<br>DNS record ttl, values in 0-86400 (optional) Acceptable values are 0 to 86400, inclusive.
ptr | **bool**<br>When set to true, also create PTR DNS record (optional) 


### SchedulingPolicy {#SchedulingPolicy1}

Field | Description
--- | ---
preemptible | **bool**<br>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings1}

Field | Description
--- | ---
type | enum **Type**<br>Type of instance network. 


### PlacementPolicy {#PlacementPolicy1}

Field | Description
--- | ---
placement_group_id | **string**<br>Identifier of placement group 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule1)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule1}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action 
values[] | **string**<br>Affinity value or host ID or host group ID 


### AttachedFilesystemSpec {#AttachedFilesystemSpec1}

Field | Description
--- | ---
mode | enum **Mode**<br>Mode of access to the filesystem that should be attached. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access. Default value.</li></ul>
device_name | **string**<br>Name of the device representing the filesystem on the instance. <br>The name should be used for referencing the filesystem from within the instance when it's being mounted, resized etc. <br>If not specified, a random value will be generated. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
filesystem_id | **string**<br>ID of the filesystem that should be attached. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### ScalePolicy {#ScalePolicy1}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale` or `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale1)**<br>[Manual scaling policy](/docs/compute/concepts/instance-groups/scale#fixed-policy) of the instance group. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale1)**<br>[Automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 
test_auto_scale | **[AutoScale](#AutoScale1)**<br>Test spec for [automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 


### AutoScale {#AutoScale1}

Field | Description
--- | ---
min_zone_size | **int64**<br>Lower limit for instance count in each zone. Acceptable values are 0 to 100, inclusive.
max_size | **int64**<br>Upper limit for total instance count (across all zones). 0 means maximum limit = 100. Acceptable values are 0 to 100, inclusive.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time in seconds allotted for averaging metrics. 1 minute by default. Acceptable values are 1m to 10m, inclusive.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected. The maximum value is 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should. Acceptable values are 1m to 30m, inclusive.
initial_size | **int64**<br>Target group size. The minimum value is 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule1)**<br>Defines an autoscaling rule based on the average CPU utilization of the instance group. <br>If more than one rule is specified, e.g. CPU utilization and one or more Monitoring metrics (`custom_rules`), the size of the instance group will be equal to the maximum of sizes calculated according to each metric. 
custom_rules[] | **[CustomRule](#CustomRule1)**<br>Defines an autoscaling rule based on a [custom metric](/docs/monitoring/operations/metric/add) from Monitoring. <br>If more than one rule is specified, e.g. CPU utilization (`cpu_utilization_rule`) and one or more Monitoring metrics, the size of the instance group will be equal to the maximum of sizes calculated according to each metric. The maximum number of elements is 3.
auto_scale_type | enum **AutoScaleType**<br>Autoscaling type. <ul><li>`ZONAL`: Scale each zone independently. This is the default.</li><li>`REGIONAL`: Scale group as a whole.</li></ul>


### CpuUtilizationRule {#CpuUtilizationRule1}

Field | Description
--- | ---
utilization_target | **double**<br>Target CPU utilization level. Instance Groups maintains this level for each availability zone. Acceptable values are 10 to 100, inclusive.


### CustomRule {#CustomRule1}

Field | Description
--- | ---
rule_type | enum **RuleType**<br>Required. Custom metric rule type. This field affects which label from the custom metric should be used: `zone_id` or `instance_id`. <ul><li>`UTILIZATION`: This type means that the metric applies to one instance. First, Instance Groups calculates the average metric value for each instance, then averages the values for instances in one availability zone or in whole group depends on autoscaling type. This type of metric must have the `instance_id` label.</li><li>`WORKLOAD`: This type means that the metric applies to instances in one availability zone or to whole group depends on autoscaling type. This type of metric must have the `zone_id` label if ZONAL autoscaling type is chosen.</li></ul>
metric_type | enum **MetricType**<br>Required. Type of custom metric. This field affects how Instance Groups calculates the average metric value. <ul><li>`GAUGE`: This type is used for metrics that show the metric value at a certain point in time, such as requests per second to the server on an instance. <br>Instance Groups calculates the average metric value for the period specified in the [AutoScale.measurement_duration](#AutoScale1) field.</li><li>`COUNTER`: This type is used for metrics that monotonically increase over time, such as the total number of requests to the server on an instance. <br>Instance Groups calculates the average value increase for the period specified in the [AutoScale.measurement_duration](#AutoScale1) field.</li></ul>
metric_name | **string**<br>Required. Name of custom metric in Monitoring that should be used for scaling. Value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
labels | **map<string,string>**<br>Labels of custom metric in Monitoring that should be used for scaling. Each value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `. Each key must match the regular expression ` ^[a-zA-Z][0-9a-zA-Z_]{0,31}$ `.
target | **double**<br>Target value for the custom metric. Instance Groups maintains this level for each availability zone. Value must be greater than 0.
folder_id | **string**<br>Folder id of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 50.
service | **string**<br>Service of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 200.


### FixedScale {#FixedScale1}

Field | Description
--- | ---
size | **int64**<br>Number of instances in the instance group. Acceptable values are 1 to 100, inclusive.


### DeployPolicy {#DeployPolicy1}

Field | Description
--- | ---
max_unavailable | **int64**<br>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If `max_expansion` is not specified or set to zero, `max_unavailable` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
max_deleting | **int64**<br>The maximum number of instances that can be deleted at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_creating | **int64**<br>The maximum number of instances that can be created at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_expansion | **int64**<br>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If `max_unavailable` is not specified or set to zero, `max_expansion` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Instance startup duration. Instance will be considered up and running (and start receiving traffic) only after startup_duration has elapsed and all health checks are passed. See `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status` for more information. Acceptable values are 0m to 1h, inclusive.
strategy | enum **Strategy**<br>Affects the lifecycle of the instance during deployment. <ul><li>`PROACTIVE`: Instance Groups can forcefully stop a running instance. This is the default.</li><li>`OPPORTUNISTIC`: Instance Groups does not stop a running instance. Instead, it will wait until the instance stops itself or becomes unhealthy.</li></ul>


### AllocationPolicy {#AllocationPolicy1}

Field | Description
--- | ---
zones[] | **[Zone](#Zone1)**<br>List of availability zones. The minimum number of elements is 1.


### Zone {#Zone1}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the instance resides. 


### LoadBalancerState {#LoadBalancerState1}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Network Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


### ManagedInstancesState {#ManagedInstancesState1}

Field | Description
--- | ---
target_size | **int64**<br>Target number of instances for this instance group. 
running_actual_count | **int64**<br>The number of running instances that match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_ACTUAL](#ManagedInstance). 
running_outdated_count | **int64**<br>The number of running instances that does not match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_OUTDATED](#ManagedInstance). 
processing_count | **int64**<br>The number of instances in flight (for example, updating, starting, deleting). For more information, see [ManagedInstance.Status](#ManagedInstance). 


### Statuses {#Statuses1}

Field | Description
--- | ---
creating | **int64**<br>Instance is being created. 
starting | **int64**<br>Instance is being started. 
opening | **int64**<br>Instance is being opened to receive traffic. 
warming | **int64**<br>Instance is being warmed. 
running | **int64**<br>Instance is running normally. 
closing | **int64**<br>Instance is being closed to traffic. 
stopping | **int64**<br>Instance is being stopped. 
updating | **int64**<br>Instance is being updated. 
deleting | **int64**<br>Instance is being deleted. 
failed | **int64**<br>Instance failed and needs to be recreated. 


### LoadBalancerSpec {#LoadBalancerSpec1}

Field | Description
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec1)**<br>Specification of the target group that the instance group will be added to. For more information, see [Target groups and resources](/docs/load-balancer/concepts/target-resources). 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### TargetGroupSpec {#TargetGroupSpec1}

Field | Description
--- | ---
name | **string**<br>Name of the target group. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the target group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec1}

Field | Description
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec1)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). The minimum number of elements is 1.
max_checking_health_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to become healthy. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### HealthCheckSpec {#HealthCheckSpec1}

Field | Description
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. Acceptable values are 1s to 300s, inclusive.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the managed instance to return a response for the health check. The default is 1 second. Acceptable values are 1s to 60s, inclusive.
unhealthy_threshold | **int64**<br>The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` or `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions1)**<br>Configuration options for a TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions1)**<br>Configuration options for an HTTP health check. 


### TcpOptions {#TcpOptions1}

Field | Description
--- | ---
port | **int64**<br>Port to use for TCP health checks. Acceptable values are 1 to 65535, inclusive.


### HttpOptions {#HttpOptions1}

Field | Description
--- | ---
port | **int64**<br>Port to use for HTTP health checks. Acceptable values are 1 to 65535, inclusive.
path | **string**<br>URL path to set for health checking requests. 


### Variable {#Variable1}

Field | Description
--- | ---
key | **string**<br> The string length in characters must be 1-128. Value must match the regular expression ` [a-zA-Z0-9._-]* `.
value | **string**<br> The maximum string length in characters is 128.


### ApplicationLoadBalancerSpec {#ApplicationLoadBalancerSpec1}

Field | Description
--- | ---
target_group_spec | **[ApplicationTargetGroupSpec](#ApplicationTargetGroupSpec1)**<br>Required. Basic properties of the Application Load Balancer target group attributed to the instance group. 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### ApplicationTargetGroupSpec {#ApplicationTargetGroupSpec1}

Field | Description
--- | ---
name | **string**<br>Name of the target group. 
description | **string**<br>Description of the target group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 


### ApplicationLoadBalancerState {#ApplicationLoadBalancerState1}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Application Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


## Create {#Create}

Creates an instance group in the specified folder. This method starts an operation that can be cancelled by another operation.

**rpc Create ([CreateInstanceGroupRequest](#CreateInstanceGroupRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateInstanceGroupMetadata](#CreateInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](#InstanceGroup2)<br>

### CreateInstanceGroupRequest {#CreateInstanceGroupRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create an instance group in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
name | **string**<br>Name of the instance group. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the instance group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
instance_template | **[InstanceTemplate](#InstanceTemplate2)**<br>Required. Instance template that the instance group belongs to. 
scale_policy | **[ScalePolicy](#ScalePolicy2)**<br>Required. [Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. 
deploy_policy | **[DeployPolicy](#DeployPolicy2)**<br>Required. Deployment policy of the instance group. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy2)**<br>Required. Allocation policy of the instance group by zones and regions. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec2)**<br>Settings for balancing load between instances via [Network Load Balancer](/docs/network-load-balancer/concepts) (OSI model layer 3). <br>If specified, a Network Load Balancer target group containing all instances from the instance group will be created and attributed to the instance group. 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec2)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. 
variables[] | **[Variable](#Variable2)**<br> 
deletion_protection | **bool**<br>Flag prohibiting deletion of the instance group. <br>Allowed values:</br>- `false`: The instance group can be deleted.</br>- `true`: The instance group cannot be deleted. <br>The default is `false`. 
application_load_balancer_spec | **[ApplicationLoadBalancerSpec](#ApplicationLoadBalancerSpec2)**<br>Settings for balancing load between instances via [Application Load Balancer](/docs/application-load-balancer/concepts) (OSI model layer 7). <br>If specified, an Application Load Balancer target group containing all instances from the instance group will be created and attributed to the instance group. 


### InstanceTemplate {#InstanceTemplate2}

Field | Description
--- | ---
description | **string**<br>Description of the instance template. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
platform_id | **string**<br>Required. ID of the hardware platform configuration for the instance. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see [Platforms](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec2)**<br>Required. Computing resources of the instance such as the amount of memory and number of cores. 
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>Metadata values may contain one of the supported placeholders: {instance_group.id} {instance.short_id} {instance.index} {instance.index_in_zone} {instance.zone_id} InstanceGroup and Instance labels may be copied to metadata following way: {instance_group.labels.some_label_key} {instance.labels.another_label_key} These placeholders will be substituted for each created instance anywhere in the value text. In the rare case the value requires to contain this placeholder explicitly, it must be escaped with double brackets, in example {instance.index}. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). No more than 128 per resource. The maximum string length in characters for each value is 262144. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec2)**<br>Required. Boot disk specification that will be attached to the instance. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec2)**<br>Array of secondary disks that will be attached to the instance. The maximum number of elements is 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec2)**<br>Array of network interfaces that will be attached to the instance. The number of elemets must be exactly 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy2)**<br>Scheduling policy for the instance. 
service_account_id | **string**<br>Service account ID for the instance. 
network_settings | **[NetworkSettings](#NetworkSettings2)**<br>Network settings for the instance. 
name | **string**<br>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
hostname | **string**<br>Host name for the instance. This field is used to generate the `yandex.cloud.compute.v1.Instance.fqdn` value. The host name must be unique within the network and region. If not specified, the host name will be equal to `yandex.cloud.compute.v1.Instance.id` of the instance and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`. <br>In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, `name` value will be used It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
placement_policy | **[PlacementPolicy](#PlacementPolicy2)**<br>Placement Group 
filesystem_specs[] | **[AttachedFilesystemSpec](#AttachedFilesystemSpec2)**<br>Array of filesystems to attach to the instance. <br>The filesystems must reside in the same availability zone as the instance. <br>To use the instance with an attached filesystem, the latter must be mounted. For details, see [documentation](/docs/compute/operations/filesystem/attach-to-vm). 


### ResourcesSpec {#ResourcesSpec2}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. The maximum value is 824633720832.
cores | **int64**<br>The number of cores available to the instance. Value must be equal to 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64,68,72,76,80.
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. Value must be equal to 0,5,20,50,100.
gpus | **int64**<br>The number of GPUs available to the instance. Value must be equal to 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec2}

Field | Description
--- | ---
mode | enum **Mode**<br>Required. Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li></ul>
device_name | **string**<br>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec2)**<br>Required. oneof disk_spec or disk_id Disk specification that is attached to the instance. For more information, see [Disks](/docs/compute/concepts/disk). 
disk_id | **string**<br>Set to use an existing disk. To set use variables. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### DiskSpec {#DiskSpec2}

Field | Description
--- | ---
description | **string**<br>Description of the disk. The maximum string length in characters is 256.
type_id | **string**<br>Required. ID of the disk type. 
size | **int64**<br>Size of the disk, specified in bytes. Acceptable values are 4194304 to 28587302322176, inclusive.
source_oneof | **oneof:** `image_id` or `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>ID of the image that will be used for disk creation. The maximum string length in characters is 50.
&nbsp;&nbsp;snapshot_id | **string**<br>ID of the snapshot that will be used for disk creation. The maximum string length in characters is 50.
preserve_after_instance_delete | **bool**<br>When set to true, disk will not be deleted even after managed instance is deleted. It will be a user's responsibility to delete such disks. 


### NetworkInterfaceSpec {#NetworkInterfaceSpec2}

Field | Description
--- | ---
network_id | **string**<br>ID of the network. 
subnet_ids[] | **string**<br>IDs of the subnets. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec2)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec2)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>IDs of security groups. 


### PrimaryAddressSpec {#PrimaryAddressSpec2}

Field | Description
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec2)**<br>An external IP address configuration. If not specified, then this managed instance will have no external internet access. 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec2)**<br>Internal DNS configuration 
address | **string**<br>Optional. Manual set static internal IP. To set use variables. 


### OneToOneNatSpec {#OneToOneNatSpec2}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>IP version for the public IP address. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li></ul>
address | **string**<br>Manual set static public IP. To set use variables. (optional) 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec2)**<br>External DNS configuration 


### DnsRecordSpec {#DnsRecordSpec2}

Field | Description
--- | ---
fqdn | **string**<br>Required. FQDN (required) 
dns_zone_id | **string**<br>DNS zone id (optional, if not set, private zone used) 
ttl | **int64**<br>DNS record ttl, values in 0-86400 (optional) Acceptable values are 0 to 86400, inclusive.
ptr | **bool**<br>When set to true, also create PTR DNS record (optional) 


### SchedulingPolicy {#SchedulingPolicy2}

Field | Description
--- | ---
preemptible | **bool**<br>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings2}

Field | Description
--- | ---
type | enum **Type**<br>Type of instance network. 


### PlacementPolicy {#PlacementPolicy2}

Field | Description
--- | ---
placement_group_id | **string**<br>Identifier of placement group 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule2)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule2}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action 
values[] | **string**<br>Affinity value or host ID or host group ID 


### AttachedFilesystemSpec {#AttachedFilesystemSpec2}

Field | Description
--- | ---
mode | enum **Mode**<br>Mode of access to the filesystem that should be attached. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access. Default value.</li></ul>
device_name | **string**<br>Name of the device representing the filesystem on the instance. <br>The name should be used for referencing the filesystem from within the instance when it's being mounted, resized etc. <br>If not specified, a random value will be generated. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
filesystem_id | **string**<br>ID of the filesystem that should be attached. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### ScalePolicy {#ScalePolicy2}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale` or `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale2)**<br>[Manual scaling policy](/docs/compute/concepts/instance-groups/scale#fixed-policy) of the instance group. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale2)**<br>[Automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 
test_auto_scale | **[AutoScale](#AutoScale2)**<br>Test spec for [automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 


### AutoScale {#AutoScale2}

Field | Description
--- | ---
min_zone_size | **int64**<br>Lower limit for instance count in each zone. Acceptable values are 0 to 100, inclusive.
max_size | **int64**<br>Upper limit for total instance count (across all zones). 0 means maximum limit = 100. Acceptable values are 0 to 100, inclusive.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time in seconds allotted for averaging metrics. 1 minute by default. Acceptable values are 1m to 10m, inclusive.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected. The maximum value is 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should. Acceptable values are 1m to 30m, inclusive.
initial_size | **int64**<br>Target group size. The minimum value is 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule2)**<br>Defines an autoscaling rule based on the average CPU utilization of the instance group. <br>If more than one rule is specified, e.g. CPU utilization and one or more Monitoring metrics (`custom_rules`), the size of the instance group will be equal to the maximum of sizes calculated according to each metric. 
custom_rules[] | **[CustomRule](#CustomRule2)**<br>Defines an autoscaling rule based on a [custom metric](/docs/monitoring/operations/metric/add) from Monitoring. <br>If more than one rule is specified, e.g. CPU utilization (`cpu_utilization_rule`) and one or more Monitoring metrics, the size of the instance group will be equal to the maximum of sizes calculated according to each metric. The maximum number of elements is 3.
auto_scale_type | enum **AutoScaleType**<br>Autoscaling type. <ul><li>`ZONAL`: Scale each zone independently. This is the default.</li><li>`REGIONAL`: Scale group as a whole.</li></ul>


### CpuUtilizationRule {#CpuUtilizationRule2}

Field | Description
--- | ---
utilization_target | **double**<br>Target CPU utilization level. Instance Groups maintains this level for each availability zone. Acceptable values are 10 to 100, inclusive.


### CustomRule {#CustomRule2}

Field | Description
--- | ---
rule_type | enum **RuleType**<br>Required. Custom metric rule type. This field affects which label from the custom metric should be used: `zone_id` or `instance_id`. <ul><li>`UTILIZATION`: This type means that the metric applies to one instance. First, Instance Groups calculates the average metric value for each instance, then averages the values for instances in one availability zone or in whole group depends on autoscaling type. This type of metric must have the `instance_id` label.</li><li>`WORKLOAD`: This type means that the metric applies to instances in one availability zone or to whole group depends on autoscaling type. This type of metric must have the `zone_id` label if ZONAL autoscaling type is chosen.</li></ul>
metric_type | enum **MetricType**<br>Required. Type of custom metric. This field affects how Instance Groups calculates the average metric value. <ul><li>`GAUGE`: This type is used for metrics that show the metric value at a certain point in time, such as requests per second to the server on an instance. <br>Instance Groups calculates the average metric value for the period specified in the [AutoScale.measurement_duration](#AutoScale2) field.</li><li>`COUNTER`: This type is used for metrics that monotonically increase over time, such as the total number of requests to the server on an instance. <br>Instance Groups calculates the average value increase for the period specified in the [AutoScale.measurement_duration](#AutoScale2) field.</li></ul>
metric_name | **string**<br>Required. Name of custom metric in Monitoring that should be used for scaling. Value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
labels | **map<string,string>**<br>Labels of custom metric in Monitoring that should be used for scaling. Each value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `. Each key must match the regular expression ` ^[a-zA-Z][0-9a-zA-Z_]{0,31}$ `.
target | **double**<br>Target value for the custom metric. Instance Groups maintains this level for each availability zone. Value must be greater than 0.
folder_id | **string**<br>Folder id of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 50.
service | **string**<br>Service of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 200.


### FixedScale {#FixedScale2}

Field | Description
--- | ---
size | **int64**<br>Number of instances in the instance group. Acceptable values are 1 to 100, inclusive.


### DeployPolicy {#DeployPolicy2}

Field | Description
--- | ---
max_unavailable | **int64**<br>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If `max_expansion` is not specified or set to zero, `max_unavailable` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
max_deleting | **int64**<br>The maximum number of instances that can be deleted at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_creating | **int64**<br>The maximum number of instances that can be created at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_expansion | **int64**<br>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If `max_unavailable` is not specified or set to zero, `max_expansion` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Instance startup duration. Instance will be considered up and running (and start receiving traffic) only after startup_duration has elapsed and all health checks are passed. See `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status` for more information. Acceptable values are 0m to 1h, inclusive.
strategy | enum **Strategy**<br>Affects the lifecycle of the instance during deployment. <ul><li>`PROACTIVE`: Instance Groups can forcefully stop a running instance. This is the default.</li><li>`OPPORTUNISTIC`: Instance Groups does not stop a running instance. Instead, it will wait until the instance stops itself or becomes unhealthy.</li></ul>


### AllocationPolicy {#AllocationPolicy2}

Field | Description
--- | ---
zones[] | **[Zone](#Zone2)**<br>List of availability zones. The minimum number of elements is 1.


### Zone {#Zone2}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the instance resides. 


### LoadBalancerSpec {#LoadBalancerSpec2}

Field | Description
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec2)**<br>Specification of the target group that the instance group will be added to. For more information, see [Target groups and resources](/docs/load-balancer/concepts/target-resources). 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### TargetGroupSpec {#TargetGroupSpec2}

Field | Description
--- | ---
name | **string**<br>Name of the target group. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the target group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec2}

Field | Description
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec2)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). The minimum number of elements is 1.
max_checking_health_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to become healthy. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### HealthCheckSpec {#HealthCheckSpec2}

Field | Description
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. Acceptable values are 1s to 300s, inclusive.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the managed instance to return a response for the health check. The default is 1 second. Acceptable values are 1s to 60s, inclusive.
unhealthy_threshold | **int64**<br>The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` or `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions2)**<br>Configuration options for a TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions2)**<br>Configuration options for an HTTP health check. 


### TcpOptions {#TcpOptions2}

Field | Description
--- | ---
port | **int64**<br>Port to use for TCP health checks. Acceptable values are 1 to 65535, inclusive.


### HttpOptions {#HttpOptions2}

Field | Description
--- | ---
port | **int64**<br>Port to use for HTTP health checks. Acceptable values are 1 to 65535, inclusive.
path | **string**<br>URL path to set for health checking requests. 


### Variable {#Variable2}

Field | Description
--- | ---
key | **string**<br> The string length in characters must be 1-128. Value must match the regular expression ` [a-zA-Z0-9._-]* `.
value | **string**<br> The maximum string length in characters is 128.


### ApplicationLoadBalancerSpec {#ApplicationLoadBalancerSpec2}

Field | Description
--- | ---
target_group_spec | **[ApplicationTargetGroupSpec](#ApplicationTargetGroupSpec2)**<br>Required. Basic properties of the Application Load Balancer target group attributed to the instance group. 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### ApplicationTargetGroupSpec {#ApplicationTargetGroupSpec2}

Field | Description
--- | ---
name | **string**<br>Name of the target group. 
description | **string**<br>Description of the target group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateInstanceGroupMetadata](#CreateInstanceGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](#InstanceGroup2)>**<br>if operation finished successfully. 


### CreateInstanceGroupMetadata {#CreateInstanceGroupMetadata}

Field | Description
--- | ---
instance_group_id | **string**<br>ID of the instance group that is being created. The maximum string length in characters is 50.


### InstanceGroup {#InstanceGroup2}

Field | Description
--- | ---
id | **string**<br>ID of the instance group. 
folder_id | **string**<br>ID of the folder that the instance group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the instance group. The name is unique within the folder. 
description | **string**<br>Description of the instance group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
instance_template | **[InstanceTemplate](#InstanceTemplate3)**<br>Instance template for creating the instance group. For more information, see [Instance Templates](/docs/compute/concepts/instance-groups/instance-template). 
scale_policy | **[ScalePolicy](#ScalePolicy3)**<br>[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. 
deploy_policy | **[DeployPolicy](#DeployPolicy3)**<br>Deployment policy of the instance group. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy3)**<br>Allocation policy of the instance group by zones and regions. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState2)**<br>Status of the Network Load Balancer target group attributed to the instance group. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState2)**<br>States of instances for this instance group. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec3)**<br>Settings for balancing load between instances via [Network Load Balancer](/docs/network-load-balancer/concepts) (OSI model layer 3). 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec3)**<br>Health checking specification. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. 
status | enum **Status**<br>Status of the instance group. <ul><li>`STARTING`: Instance group is being started and will become active soon.</li><li>`ACTIVE`: Instance group is active. In this state the group manages its instances and monitors their health, creating, deleting, stopping, updating and starting instances as needed. <br>To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/api-ref/grpc/instance_group_service#Stop). To pause the processes in the instance group, i.e. scaling, checking instances' health, auto-healing and updating them, without stopping the instances, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.PauseProcesses](/docs/compute/api-ref/grpc/instance_group_service#PauseProcesses).</li><li>`STOPPING`: Instance group is being stopped. Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.</li><li>`STOPPED`: Instance group is stopped. In this state the group cannot be updated and does not react to any changes made to its instances. To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/api-ref/grpc/instance_group_service#Start).</li><li>`DELETING`: Instance group is being deleted.</li><li>`PAUSED`: Instance group is paused. In this state all the processes regarding the group management, i.e. scaling, checking instances' health, auto-healing and updating them, are paused. The instances that were running prior to pausing the group, however, may still be running. <br>To resume the processes in the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.ResumeProcesses](/docs/compute/api-ref/grpc/instance_group_service#ResumeProcesses). The group status will change to `ACTIVE`.</li></ul>
variables[] | **[Variable](#Variable3)**<br> 
deletion_protection | **bool**<br>Flag prohibiting deletion of the instance group. <br>Allowed values:</br>- `false`: The instance group can be deleted.</br>- `true`: The instance group cannot be deleted. <br>The default is `false`. 
application_load_balancer_spec | **[ApplicationLoadBalancerSpec](#ApplicationLoadBalancerSpec3)**<br>Settings for balancing load between instances via [Application Load Balancer](/docs/application-load-balancer/concepts) (OSI model layer 7). 
application_load_balancer_state | **[ApplicationLoadBalancerState](#ApplicationLoadBalancerState2)**<br>Status of the Application Load Balancer target group attributed to the instance group. <br>Returned if there is a working load balancer that the target group is connected to. 


### LoadBalancerState {#LoadBalancerState2}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Network Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


### ManagedInstancesState {#ManagedInstancesState2}

Field | Description
--- | ---
target_size | **int64**<br>Target number of instances for this instance group. 
running_actual_count | **int64**<br>The number of running instances that match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_ACTUAL](#ManagedInstance). 
running_outdated_count | **int64**<br>The number of running instances that does not match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_OUTDATED](#ManagedInstance). 
processing_count | **int64**<br>The number of instances in flight (for example, updating, starting, deleting). For more information, see [ManagedInstance.Status](#ManagedInstance). 


### Statuses {#Statuses2}

Field | Description
--- | ---
creating | **int64**<br>Instance is being created. 
starting | **int64**<br>Instance is being started. 
opening | **int64**<br>Instance is being opened to receive traffic. 
warming | **int64**<br>Instance is being warmed. 
running | **int64**<br>Instance is running normally. 
closing | **int64**<br>Instance is being closed to traffic. 
stopping | **int64**<br>Instance is being stopped. 
updating | **int64**<br>Instance is being updated. 
deleting | **int64**<br>Instance is being deleted. 
failed | **int64**<br>Instance failed and needs to be recreated. 


### ApplicationLoadBalancerState {#ApplicationLoadBalancerState2}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Application Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


## CreateFromYaml {#CreateFromYaml}

Creates an instance group in the specified folder from a YAML file. This method starts an operation that can be cancelled by another operation.

**rpc CreateFromYaml ([CreateInstanceGroupFromYamlRequest](#CreateInstanceGroupFromYamlRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateInstanceGroupMetadata](#CreateInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](#InstanceGroup3)<br>

### CreateInstanceGroupFromYamlRequest {#CreateInstanceGroupFromYamlRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create an instance group in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
instance_group_yaml | **string**<br>Required. [InstanceGroupService.Create](#Create) request in YAML format. The maximum string length in characters is 1048576.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateInstanceGroupMetadata](#CreateInstanceGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](#InstanceGroup3)>**<br>if operation finished successfully. 


### CreateInstanceGroupMetadata {#CreateInstanceGroupMetadata1}

Field | Description
--- | ---
instance_group_id | **string**<br>ID of the instance group that is being created. The maximum string length in characters is 50.


### InstanceGroup {#InstanceGroup3}

Field | Description
--- | ---
id | **string**<br>ID of the instance group. 
folder_id | **string**<br>ID of the folder that the instance group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the instance group. The name is unique within the folder. 
description | **string**<br>Description of the instance group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
instance_template | **[InstanceTemplate](#InstanceTemplate3)**<br>Instance template for creating the instance group. For more information, see [Instance Templates](/docs/compute/concepts/instance-groups/instance-template). 
scale_policy | **[ScalePolicy](#ScalePolicy3)**<br>[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. 
deploy_policy | **[DeployPolicy](#DeployPolicy3)**<br>Deployment policy of the instance group. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy3)**<br>Allocation policy of the instance group by zones and regions. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState3)**<br>Status of the Network Load Balancer target group attributed to the instance group. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState3)**<br>States of instances for this instance group. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec3)**<br>Settings for balancing load between instances via [Network Load Balancer](/docs/network-load-balancer/concepts) (OSI model layer 3). 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec3)**<br>Health checking specification. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. 
status | enum **Status**<br>Status of the instance group. <ul><li>`STARTING`: Instance group is being started and will become active soon.</li><li>`ACTIVE`: Instance group is active. In this state the group manages its instances and monitors their health, creating, deleting, stopping, updating and starting instances as needed. <br>To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/api-ref/grpc/instance_group_service#Stop). To pause the processes in the instance group, i.e. scaling, checking instances' health, auto-healing and updating them, without stopping the instances, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.PauseProcesses](/docs/compute/api-ref/grpc/instance_group_service#PauseProcesses).</li><li>`STOPPING`: Instance group is being stopped. Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.</li><li>`STOPPED`: Instance group is stopped. In this state the group cannot be updated and does not react to any changes made to its instances. To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/api-ref/grpc/instance_group_service#Start).</li><li>`DELETING`: Instance group is being deleted.</li><li>`PAUSED`: Instance group is paused. In this state all the processes regarding the group management, i.e. scaling, checking instances' health, auto-healing and updating them, are paused. The instances that were running prior to pausing the group, however, may still be running. <br>To resume the processes in the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.ResumeProcesses](/docs/compute/api-ref/grpc/instance_group_service#ResumeProcesses). The group status will change to `ACTIVE`.</li></ul>
variables[] | **[Variable](#Variable3)**<br> 
deletion_protection | **bool**<br>Flag prohibiting deletion of the instance group. <br>Allowed values:</br>- `false`: The instance group can be deleted.</br>- `true`: The instance group cannot be deleted. <br>The default is `false`. 
application_load_balancer_spec | **[ApplicationLoadBalancerSpec](#ApplicationLoadBalancerSpec3)**<br>Settings for balancing load between instances via [Application Load Balancer](/docs/application-load-balancer/concepts) (OSI model layer 7). 
application_load_balancer_state | **[ApplicationLoadBalancerState](#ApplicationLoadBalancerState3)**<br>Status of the Application Load Balancer target group attributed to the instance group. <br>Returned if there is a working load balancer that the target group is connected to. 


### InstanceTemplate {#InstanceTemplate3}

Field | Description
--- | ---
description | **string**<br>Description of the instance template. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
platform_id | **string**<br>Required. ID of the hardware platform configuration for the instance. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see [Platforms](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec3)**<br>Required. Computing resources of the instance such as the amount of memory and number of cores. 
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>Metadata values may contain one of the supported placeholders: {instance_group.id} {instance.short_id} {instance.index} {instance.index_in_zone} {instance.zone_id} InstanceGroup and Instance labels may be copied to metadata following way: {instance_group.labels.some_label_key} {instance.labels.another_label_key} These placeholders will be substituted for each created instance anywhere in the value text. In the rare case the value requires to contain this placeholder explicitly, it must be escaped with double brackets, in example {instance.index}. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). No more than 128 per resource. The maximum string length in characters for each value is 262144. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec3)**<br>Required. Boot disk specification that will be attached to the instance. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec3)**<br>Array of secondary disks that will be attached to the instance. The maximum number of elements is 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec3)**<br>Array of network interfaces that will be attached to the instance. The number of elemets must be exactly 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy3)**<br>Scheduling policy for the instance. 
service_account_id | **string**<br>Service account ID for the instance. 
network_settings | **[NetworkSettings](#NetworkSettings3)**<br>Network settings for the instance. 
name | **string**<br>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
hostname | **string**<br>Host name for the instance. This field is used to generate the `yandex.cloud.compute.v1.Instance.fqdn` value. The host name must be unique within the network and region. If not specified, the host name will be equal to `yandex.cloud.compute.v1.Instance.id` of the instance and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`. <br>In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, `name` value will be used It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
placement_policy | **[PlacementPolicy](#PlacementPolicy3)**<br>Placement Group 
filesystem_specs[] | **[AttachedFilesystemSpec](#AttachedFilesystemSpec3)**<br>Array of filesystems to attach to the instance. <br>The filesystems must reside in the same availability zone as the instance. <br>To use the instance with an attached filesystem, the latter must be mounted. For details, see [documentation](/docs/compute/operations/filesystem/attach-to-vm). 


### ResourcesSpec {#ResourcesSpec3}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. The maximum value is 824633720832.
cores | **int64**<br>The number of cores available to the instance. Value must be equal to 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64,68,72,76,80.
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. Value must be equal to 0,5,20,50,100.
gpus | **int64**<br>The number of GPUs available to the instance. Value must be equal to 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec3}

Field | Description
--- | ---
mode | enum **Mode**<br>Required. Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li></ul>
device_name | **string**<br>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec3)**<br>Required. oneof disk_spec or disk_id Disk specification that is attached to the instance. For more information, see [Disks](/docs/compute/concepts/disk). 
disk_id | **string**<br>Set to use an existing disk. To set use variables. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### DiskSpec {#DiskSpec3}

Field | Description
--- | ---
description | **string**<br>Description of the disk. The maximum string length in characters is 256.
type_id | **string**<br>Required. ID of the disk type. 
size | **int64**<br>Size of the disk, specified in bytes. Acceptable values are 4194304 to 28587302322176, inclusive.
source_oneof | **oneof:** `image_id` or `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>ID of the image that will be used for disk creation. The maximum string length in characters is 50.
&nbsp;&nbsp;snapshot_id | **string**<br>ID of the snapshot that will be used for disk creation. The maximum string length in characters is 50.
preserve_after_instance_delete | **bool**<br>When set to true, disk will not be deleted even after managed instance is deleted. It will be a user's responsibility to delete such disks. 


### NetworkInterfaceSpec {#NetworkInterfaceSpec3}

Field | Description
--- | ---
network_id | **string**<br>ID of the network. 
subnet_ids[] | **string**<br>IDs of the subnets. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec3)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec3)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>IDs of security groups. 


### PrimaryAddressSpec {#PrimaryAddressSpec3}

Field | Description
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec3)**<br>An external IP address configuration. If not specified, then this managed instance will have no external internet access. 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec3)**<br>Internal DNS configuration 
address | **string**<br>Optional. Manual set static internal IP. To set use variables. 


### OneToOneNatSpec {#OneToOneNatSpec3}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>IP version for the public IP address. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li></ul>
address | **string**<br>Manual set static public IP. To set use variables. (optional) 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec3)**<br>External DNS configuration 


### DnsRecordSpec {#DnsRecordSpec3}

Field | Description
--- | ---
fqdn | **string**<br>Required. FQDN (required) 
dns_zone_id | **string**<br>DNS zone id (optional, if not set, private zone used) 
ttl | **int64**<br>DNS record ttl, values in 0-86400 (optional) Acceptable values are 0 to 86400, inclusive.
ptr | **bool**<br>When set to true, also create PTR DNS record (optional) 


### SchedulingPolicy {#SchedulingPolicy3}

Field | Description
--- | ---
preemptible | **bool**<br>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings3}

Field | Description
--- | ---
type | enum **Type**<br>Type of instance network. 


### PlacementPolicy {#PlacementPolicy3}

Field | Description
--- | ---
placement_group_id | **string**<br>Identifier of placement group 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule3)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule3}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action 
values[] | **string**<br>Affinity value or host ID or host group ID 


### AttachedFilesystemSpec {#AttachedFilesystemSpec3}

Field | Description
--- | ---
mode | enum **Mode**<br>Mode of access to the filesystem that should be attached. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access. Default value.</li></ul>
device_name | **string**<br>Name of the device representing the filesystem on the instance. <br>The name should be used for referencing the filesystem from within the instance when it's being mounted, resized etc. <br>If not specified, a random value will be generated. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
filesystem_id | **string**<br>ID of the filesystem that should be attached. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### ScalePolicy {#ScalePolicy3}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale` or `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale3)**<br>[Manual scaling policy](/docs/compute/concepts/instance-groups/scale#fixed-policy) of the instance group. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale3)**<br>[Automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 
test_auto_scale | **[AutoScale](#AutoScale3)**<br>Test spec for [automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 


### AutoScale {#AutoScale3}

Field | Description
--- | ---
min_zone_size | **int64**<br>Lower limit for instance count in each zone. Acceptable values are 0 to 100, inclusive.
max_size | **int64**<br>Upper limit for total instance count (across all zones). 0 means maximum limit = 100. Acceptable values are 0 to 100, inclusive.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time in seconds allotted for averaging metrics. 1 minute by default. Acceptable values are 1m to 10m, inclusive.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected. The maximum value is 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should. Acceptable values are 1m to 30m, inclusive.
initial_size | **int64**<br>Target group size. The minimum value is 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule3)**<br>Defines an autoscaling rule based on the average CPU utilization of the instance group. <br>If more than one rule is specified, e.g. CPU utilization and one or more Monitoring metrics (`custom_rules`), the size of the instance group will be equal to the maximum of sizes calculated according to each metric. 
custom_rules[] | **[CustomRule](#CustomRule3)**<br>Defines an autoscaling rule based on a [custom metric](/docs/monitoring/operations/metric/add) from Monitoring. <br>If more than one rule is specified, e.g. CPU utilization (`cpu_utilization_rule`) and one or more Monitoring metrics, the size of the instance group will be equal to the maximum of sizes calculated according to each metric. The maximum number of elements is 3.
auto_scale_type | enum **AutoScaleType**<br>Autoscaling type. <ul><li>`ZONAL`: Scale each zone independently. This is the default.</li><li>`REGIONAL`: Scale group as a whole.</li></ul>


### CpuUtilizationRule {#CpuUtilizationRule3}

Field | Description
--- | ---
utilization_target | **double**<br>Target CPU utilization level. Instance Groups maintains this level for each availability zone. Acceptable values are 10 to 100, inclusive.


### CustomRule {#CustomRule3}

Field | Description
--- | ---
rule_type | enum **RuleType**<br>Required. Custom metric rule type. This field affects which label from the custom metric should be used: `zone_id` or `instance_id`. <ul><li>`UTILIZATION`: This type means that the metric applies to one instance. First, Instance Groups calculates the average metric value for each instance, then averages the values for instances in one availability zone or in whole group depends on autoscaling type. This type of metric must have the `instance_id` label.</li><li>`WORKLOAD`: This type means that the metric applies to instances in one availability zone or to whole group depends on autoscaling type. This type of metric must have the `zone_id` label if ZONAL autoscaling type is chosen.</li></ul>
metric_type | enum **MetricType**<br>Required. Type of custom metric. This field affects how Instance Groups calculates the average metric value. <ul><li>`GAUGE`: This type is used for metrics that show the metric value at a certain point in time, such as requests per second to the server on an instance. <br>Instance Groups calculates the average metric value for the period specified in the [AutoScale.measurement_duration](#AutoScale3) field.</li><li>`COUNTER`: This type is used for metrics that monotonically increase over time, such as the total number of requests to the server on an instance. <br>Instance Groups calculates the average value increase for the period specified in the [AutoScale.measurement_duration](#AutoScale3) field.</li></ul>
metric_name | **string**<br>Required. Name of custom metric in Monitoring that should be used for scaling. Value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
labels | **map<string,string>**<br>Labels of custom metric in Monitoring that should be used for scaling. Each value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `. Each key must match the regular expression ` ^[a-zA-Z][0-9a-zA-Z_]{0,31}$ `.
target | **double**<br>Target value for the custom metric. Instance Groups maintains this level for each availability zone. Value must be greater than 0.
folder_id | **string**<br>Folder id of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 50.
service | **string**<br>Service of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 200.


### FixedScale {#FixedScale3}

Field | Description
--- | ---
size | **int64**<br>Number of instances in the instance group. Acceptable values are 1 to 100, inclusive.


### DeployPolicy {#DeployPolicy3}

Field | Description
--- | ---
max_unavailable | **int64**<br>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If `max_expansion` is not specified or set to zero, `max_unavailable` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
max_deleting | **int64**<br>The maximum number of instances that can be deleted at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_creating | **int64**<br>The maximum number of instances that can be created at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_expansion | **int64**<br>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If `max_unavailable` is not specified or set to zero, `max_expansion` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Instance startup duration. Instance will be considered up and running (and start receiving traffic) only after startup_duration has elapsed and all health checks are passed. See `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status` for more information. Acceptable values are 0m to 1h, inclusive.
strategy | enum **Strategy**<br>Affects the lifecycle of the instance during deployment. <ul><li>`PROACTIVE`: Instance Groups can forcefully stop a running instance. This is the default.</li><li>`OPPORTUNISTIC`: Instance Groups does not stop a running instance. Instead, it will wait until the instance stops itself or becomes unhealthy.</li></ul>


### AllocationPolicy {#AllocationPolicy3}

Field | Description
--- | ---
zones[] | **[Zone](#Zone3)**<br>List of availability zones. The minimum number of elements is 1.


### Zone {#Zone3}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the instance resides. 


### LoadBalancerState {#LoadBalancerState3}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Network Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


### ManagedInstancesState {#ManagedInstancesState3}

Field | Description
--- | ---
target_size | **int64**<br>Target number of instances for this instance group. 
running_actual_count | **int64**<br>The number of running instances that match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_ACTUAL](#ManagedInstance). 
running_outdated_count | **int64**<br>The number of running instances that does not match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_OUTDATED](#ManagedInstance). 
processing_count | **int64**<br>The number of instances in flight (for example, updating, starting, deleting). For more information, see [ManagedInstance.Status](#ManagedInstance). 


### Statuses {#Statuses3}

Field | Description
--- | ---
creating | **int64**<br>Instance is being created. 
starting | **int64**<br>Instance is being started. 
opening | **int64**<br>Instance is being opened to receive traffic. 
warming | **int64**<br>Instance is being warmed. 
running | **int64**<br>Instance is running normally. 
closing | **int64**<br>Instance is being closed to traffic. 
stopping | **int64**<br>Instance is being stopped. 
updating | **int64**<br>Instance is being updated. 
deleting | **int64**<br>Instance is being deleted. 
failed | **int64**<br>Instance failed and needs to be recreated. 


### LoadBalancerSpec {#LoadBalancerSpec3}

Field | Description
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec3)**<br>Specification of the target group that the instance group will be added to. For more information, see [Target groups and resources](/docs/load-balancer/concepts/target-resources). 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### TargetGroupSpec {#TargetGroupSpec3}

Field | Description
--- | ---
name | **string**<br>Name of the target group. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the target group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec3}

Field | Description
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec3)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). The minimum number of elements is 1.
max_checking_health_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to become healthy. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### HealthCheckSpec {#HealthCheckSpec3}

Field | Description
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. Acceptable values are 1s to 300s, inclusive.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the managed instance to return a response for the health check. The default is 1 second. Acceptable values are 1s to 60s, inclusive.
unhealthy_threshold | **int64**<br>The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` or `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions3)**<br>Configuration options for a TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions3)**<br>Configuration options for an HTTP health check. 


### TcpOptions {#TcpOptions3}

Field | Description
--- | ---
port | **int64**<br>Port to use for TCP health checks. Acceptable values are 1 to 65535, inclusive.


### HttpOptions {#HttpOptions3}

Field | Description
--- | ---
port | **int64**<br>Port to use for HTTP health checks. Acceptable values are 1 to 65535, inclusive.
path | **string**<br>URL path to set for health checking requests. 


### Variable {#Variable3}

Field | Description
--- | ---
key | **string**<br> The string length in characters must be 1-128. Value must match the regular expression ` [a-zA-Z0-9._-]* `.
value | **string**<br> The maximum string length in characters is 128.


### ApplicationLoadBalancerSpec {#ApplicationLoadBalancerSpec3}

Field | Description
--- | ---
target_group_spec | **[ApplicationTargetGroupSpec](#ApplicationTargetGroupSpec3)**<br>Required. Basic properties of the Application Load Balancer target group attributed to the instance group. 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### ApplicationTargetGroupSpec {#ApplicationTargetGroupSpec3}

Field | Description
--- | ---
name | **string**<br>Name of the target group. 
description | **string**<br>Description of the target group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 


### ApplicationLoadBalancerState {#ApplicationLoadBalancerState3}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Application Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


## Update {#Update}

Updates the specified instance group. This method starts an operation that can be cancelled by another operation.

**rpc Update ([UpdateInstanceGroupRequest](#UpdateInstanceGroupRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateInstanceGroupMetadata](#UpdateInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](#InstanceGroup4)<br>

### UpdateInstanceGroupRequest {#UpdateInstanceGroupRequest}

Field | Description
--- | ---
instance_group_id | **string**<br>Required. ID of the instance group to update. To get the instance group ID, use a [InstanceGroupService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the InstanceGroup resource are going to be updated. 
name | **string**<br>Name of the instance group. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the instance group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. <br>The existing set of `labels` is completely replaced by the provided set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
instance_template | **[InstanceTemplate](#InstanceTemplate4)**<br>Required. Instance template that the instance group belongs to. 
scale_policy | **[ScalePolicy](#ScalePolicy4)**<br>Required. [Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. 
deploy_policy | **[DeployPolicy](#DeployPolicy4)**<br>Required. Deployment policy of the instance group. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy4)**<br>Required. Allocation policy of the instance group by zones and regions. 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec4)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec4)**<br>Settings for balancing load between instances via [Network Load Balancer](/docs/network-load-balancer/concepts) (OSI model layer 3). 
variables[] | **[Variable](#Variable4)**<br> 
deletion_protection | **bool**<br>Flag that inhibits deletion of the instance group 
application_load_balancer_spec | **[ApplicationLoadBalancerSpec](#ApplicationLoadBalancerSpec4)**<br>Settings for balancing load between instances via [Application Load Balancer](/docs/application-load-balancer/concepts) (OSI model layer 7). 


### InstanceTemplate {#InstanceTemplate4}

Field | Description
--- | ---
description | **string**<br>Description of the instance template. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
platform_id | **string**<br>Required. ID of the hardware platform configuration for the instance. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see [Platforms](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec4)**<br>Required. Computing resources of the instance such as the amount of memory and number of cores. 
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>Metadata values may contain one of the supported placeholders: {instance_group.id} {instance.short_id} {instance.index} {instance.index_in_zone} {instance.zone_id} InstanceGroup and Instance labels may be copied to metadata following way: {instance_group.labels.some_label_key} {instance.labels.another_label_key} These placeholders will be substituted for each created instance anywhere in the value text. In the rare case the value requires to contain this placeholder explicitly, it must be escaped with double brackets, in example {instance.index}. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). No more than 128 per resource. The maximum string length in characters for each value is 262144. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec4)**<br>Required. Boot disk specification that will be attached to the instance. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec4)**<br>Array of secondary disks that will be attached to the instance. The maximum number of elements is 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec4)**<br>Array of network interfaces that will be attached to the instance. The number of elemets must be exactly 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy4)**<br>Scheduling policy for the instance. 
service_account_id | **string**<br>Service account ID for the instance. 
network_settings | **[NetworkSettings](#NetworkSettings4)**<br>Network settings for the instance. 
name | **string**<br>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
hostname | **string**<br>Host name for the instance. This field is used to generate the `yandex.cloud.compute.v1.Instance.fqdn` value. The host name must be unique within the network and region. If not specified, the host name will be equal to `yandex.cloud.compute.v1.Instance.id` of the instance and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`. <br>In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, `name` value will be used It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
placement_policy | **[PlacementPolicy](#PlacementPolicy4)**<br>Placement Group 
filesystem_specs[] | **[AttachedFilesystemSpec](#AttachedFilesystemSpec4)**<br>Array of filesystems to attach to the instance. <br>The filesystems must reside in the same availability zone as the instance. <br>To use the instance with an attached filesystem, the latter must be mounted. For details, see [documentation](/docs/compute/operations/filesystem/attach-to-vm). 


### ResourcesSpec {#ResourcesSpec4}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. The maximum value is 824633720832.
cores | **int64**<br>The number of cores available to the instance. Value must be equal to 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64,68,72,76,80.
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. Value must be equal to 0,5,20,50,100.
gpus | **int64**<br>The number of GPUs available to the instance. Value must be equal to 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec4}

Field | Description
--- | ---
mode | enum **Mode**<br>Required. Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li></ul>
device_name | **string**<br>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec4)**<br>Required. oneof disk_spec or disk_id Disk specification that is attached to the instance. For more information, see [Disks](/docs/compute/concepts/disk). 
disk_id | **string**<br>Set to use an existing disk. To set use variables. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### DiskSpec {#DiskSpec4}

Field | Description
--- | ---
description | **string**<br>Description of the disk. The maximum string length in characters is 256.
type_id | **string**<br>Required. ID of the disk type. 
size | **int64**<br>Size of the disk, specified in bytes. Acceptable values are 4194304 to 28587302322176, inclusive.
source_oneof | **oneof:** `image_id` or `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>ID of the image that will be used for disk creation. The maximum string length in characters is 50.
&nbsp;&nbsp;snapshot_id | **string**<br>ID of the snapshot that will be used for disk creation. The maximum string length in characters is 50.
preserve_after_instance_delete | **bool**<br>When set to true, disk will not be deleted even after managed instance is deleted. It will be a user's responsibility to delete such disks. 


### NetworkInterfaceSpec {#NetworkInterfaceSpec4}

Field | Description
--- | ---
network_id | **string**<br>ID of the network. 
subnet_ids[] | **string**<br>IDs of the subnets. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec4)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec4)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>IDs of security groups. 


### PrimaryAddressSpec {#PrimaryAddressSpec4}

Field | Description
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec4)**<br>An external IP address configuration. If not specified, then this managed instance will have no external internet access. 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec4)**<br>Internal DNS configuration 
address | **string**<br>Optional. Manual set static internal IP. To set use variables. 


### OneToOneNatSpec {#OneToOneNatSpec4}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>IP version for the public IP address. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li></ul>
address | **string**<br>Manual set static public IP. To set use variables. (optional) 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec4)**<br>External DNS configuration 


### DnsRecordSpec {#DnsRecordSpec4}

Field | Description
--- | ---
fqdn | **string**<br>Required. FQDN (required) 
dns_zone_id | **string**<br>DNS zone id (optional, if not set, private zone used) 
ttl | **int64**<br>DNS record ttl, values in 0-86400 (optional) Acceptable values are 0 to 86400, inclusive.
ptr | **bool**<br>When set to true, also create PTR DNS record (optional) 


### SchedulingPolicy {#SchedulingPolicy4}

Field | Description
--- | ---
preemptible | **bool**<br>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings4}

Field | Description
--- | ---
type | enum **Type**<br>Type of instance network. 


### PlacementPolicy {#PlacementPolicy4}

Field | Description
--- | ---
placement_group_id | **string**<br>Identifier of placement group 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule4)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule4}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action 
values[] | **string**<br>Affinity value or host ID or host group ID 


### AttachedFilesystemSpec {#AttachedFilesystemSpec4}

Field | Description
--- | ---
mode | enum **Mode**<br>Mode of access to the filesystem that should be attached. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access. Default value.</li></ul>
device_name | **string**<br>Name of the device representing the filesystem on the instance. <br>The name should be used for referencing the filesystem from within the instance when it's being mounted, resized etc. <br>If not specified, a random value will be generated. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
filesystem_id | **string**<br>ID of the filesystem that should be attached. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### ScalePolicy {#ScalePolicy4}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale` or `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale4)**<br>[Manual scaling policy](/docs/compute/concepts/instance-groups/scale#fixed-policy) of the instance group. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale4)**<br>[Automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 
test_auto_scale | **[AutoScale](#AutoScale4)**<br>Test spec for [automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 


### AutoScale {#AutoScale4}

Field | Description
--- | ---
min_zone_size | **int64**<br>Lower limit for instance count in each zone. Acceptable values are 0 to 100, inclusive.
max_size | **int64**<br>Upper limit for total instance count (across all zones). 0 means maximum limit = 100. Acceptable values are 0 to 100, inclusive.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time in seconds allotted for averaging metrics. 1 minute by default. Acceptable values are 1m to 10m, inclusive.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected. The maximum value is 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should. Acceptable values are 1m to 30m, inclusive.
initial_size | **int64**<br>Target group size. The minimum value is 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule4)**<br>Defines an autoscaling rule based on the average CPU utilization of the instance group. <br>If more than one rule is specified, e.g. CPU utilization and one or more Monitoring metrics (`custom_rules`), the size of the instance group will be equal to the maximum of sizes calculated according to each metric. 
custom_rules[] | **[CustomRule](#CustomRule4)**<br>Defines an autoscaling rule based on a [custom metric](/docs/monitoring/operations/metric/add) from Monitoring. <br>If more than one rule is specified, e.g. CPU utilization (`cpu_utilization_rule`) and one or more Monitoring metrics, the size of the instance group will be equal to the maximum of sizes calculated according to each metric. The maximum number of elements is 3.
auto_scale_type | enum **AutoScaleType**<br>Autoscaling type. <ul><li>`ZONAL`: Scale each zone independently. This is the default.</li><li>`REGIONAL`: Scale group as a whole.</li></ul>


### CpuUtilizationRule {#CpuUtilizationRule4}

Field | Description
--- | ---
utilization_target | **double**<br>Target CPU utilization level. Instance Groups maintains this level for each availability zone. Acceptable values are 10 to 100, inclusive.


### CustomRule {#CustomRule4}

Field | Description
--- | ---
rule_type | enum **RuleType**<br>Required. Custom metric rule type. This field affects which label from the custom metric should be used: `zone_id` or `instance_id`. <ul><li>`UTILIZATION`: This type means that the metric applies to one instance. First, Instance Groups calculates the average metric value for each instance, then averages the values for instances in one availability zone or in whole group depends on autoscaling type. This type of metric must have the `instance_id` label.</li><li>`WORKLOAD`: This type means that the metric applies to instances in one availability zone or to whole group depends on autoscaling type. This type of metric must have the `zone_id` label if ZONAL autoscaling type is chosen.</li></ul>
metric_type | enum **MetricType**<br>Required. Type of custom metric. This field affects how Instance Groups calculates the average metric value. <ul><li>`GAUGE`: This type is used for metrics that show the metric value at a certain point in time, such as requests per second to the server on an instance. <br>Instance Groups calculates the average metric value for the period specified in the [AutoScale.measurement_duration](#AutoScale4) field.</li><li>`COUNTER`: This type is used for metrics that monotonically increase over time, such as the total number of requests to the server on an instance. <br>Instance Groups calculates the average value increase for the period specified in the [AutoScale.measurement_duration](#AutoScale4) field.</li></ul>
metric_name | **string**<br>Required. Name of custom metric in Monitoring that should be used for scaling. Value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
labels | **map<string,string>**<br>Labels of custom metric in Monitoring that should be used for scaling. Each value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `. Each key must match the regular expression ` ^[a-zA-Z][0-9a-zA-Z_]{0,31}$ `.
target | **double**<br>Target value for the custom metric. Instance Groups maintains this level for each availability zone. Value must be greater than 0.
folder_id | **string**<br>Folder id of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 50.
service | **string**<br>Service of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 200.


### FixedScale {#FixedScale4}

Field | Description
--- | ---
size | **int64**<br>Number of instances in the instance group. Acceptable values are 1 to 100, inclusive.


### DeployPolicy {#DeployPolicy4}

Field | Description
--- | ---
max_unavailable | **int64**<br>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If `max_expansion` is not specified or set to zero, `max_unavailable` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
max_deleting | **int64**<br>The maximum number of instances that can be deleted at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_creating | **int64**<br>The maximum number of instances that can be created at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_expansion | **int64**<br>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If `max_unavailable` is not specified or set to zero, `max_expansion` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Instance startup duration. Instance will be considered up and running (and start receiving traffic) only after startup_duration has elapsed and all health checks are passed. See `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status` for more information. Acceptable values are 0m to 1h, inclusive.
strategy | enum **Strategy**<br>Affects the lifecycle of the instance during deployment. <ul><li>`PROACTIVE`: Instance Groups can forcefully stop a running instance. This is the default.</li><li>`OPPORTUNISTIC`: Instance Groups does not stop a running instance. Instead, it will wait until the instance stops itself or becomes unhealthy.</li></ul>


### AllocationPolicy {#AllocationPolicy4}

Field | Description
--- | ---
zones[] | **[Zone](#Zone4)**<br>List of availability zones. The minimum number of elements is 1.


### Zone {#Zone4}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the instance resides. 


### HealthChecksSpec {#HealthChecksSpec4}

Field | Description
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec4)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). The minimum number of elements is 1.
max_checking_health_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to become healthy. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### HealthCheckSpec {#HealthCheckSpec4}

Field | Description
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. Acceptable values are 1s to 300s, inclusive.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the managed instance to return a response for the health check. The default is 1 second. Acceptable values are 1s to 60s, inclusive.
unhealthy_threshold | **int64**<br>The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` or `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions4)**<br>Configuration options for a TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions4)**<br>Configuration options for an HTTP health check. 


### TcpOptions {#TcpOptions4}

Field | Description
--- | ---
port | **int64**<br>Port to use for TCP health checks. Acceptable values are 1 to 65535, inclusive.


### HttpOptions {#HttpOptions4}

Field | Description
--- | ---
port | **int64**<br>Port to use for HTTP health checks. Acceptable values are 1 to 65535, inclusive.
path | **string**<br>URL path to set for health checking requests. 


### LoadBalancerSpec {#LoadBalancerSpec4}

Field | Description
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec4)**<br>Specification of the target group that the instance group will be added to. For more information, see [Target groups and resources](/docs/load-balancer/concepts/target-resources). 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### TargetGroupSpec {#TargetGroupSpec4}

Field | Description
--- | ---
name | **string**<br>Name of the target group. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the target group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.


### Variable {#Variable4}

Field | Description
--- | ---
key | **string**<br> The string length in characters must be 1-128. Value must match the regular expression ` [a-zA-Z0-9._-]* `.
value | **string**<br> The maximum string length in characters is 128.


### ApplicationLoadBalancerSpec {#ApplicationLoadBalancerSpec4}

Field | Description
--- | ---
target_group_spec | **[ApplicationTargetGroupSpec](#ApplicationTargetGroupSpec4)**<br>Required. Basic properties of the Application Load Balancer target group attributed to the instance group. 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### ApplicationTargetGroupSpec {#ApplicationTargetGroupSpec4}

Field | Description
--- | ---
name | **string**<br>Name of the target group. 
description | **string**<br>Description of the target group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateInstanceGroupMetadata](#UpdateInstanceGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](#InstanceGroup4)>**<br>if operation finished successfully. 


### UpdateInstanceGroupMetadata {#UpdateInstanceGroupMetadata}

Field | Description
--- | ---
instance_group_id | **string**<br>ID of the InstanceGroup resource that is being updated. To get the instance group ID, use a [InstanceGroupService.List](#List) request. 


### InstanceGroup {#InstanceGroup4}

Field | Description
--- | ---
id | **string**<br>ID of the instance group. 
folder_id | **string**<br>ID of the folder that the instance group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the instance group. The name is unique within the folder. 
description | **string**<br>Description of the instance group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
instance_template | **[InstanceTemplate](#InstanceTemplate5)**<br>Instance template for creating the instance group. For more information, see [Instance Templates](/docs/compute/concepts/instance-groups/instance-template). 
scale_policy | **[ScalePolicy](#ScalePolicy5)**<br>[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. 
deploy_policy | **[DeployPolicy](#DeployPolicy5)**<br>Deployment policy of the instance group. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy5)**<br>Allocation policy of the instance group by zones and regions. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState4)**<br>Status of the Network Load Balancer target group attributed to the instance group. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState4)**<br>States of instances for this instance group. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec5)**<br>Settings for balancing load between instances via [Network Load Balancer](/docs/network-load-balancer/concepts) (OSI model layer 3). 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec5)**<br>Health checking specification. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. 
status | enum **Status**<br>Status of the instance group. <ul><li>`STARTING`: Instance group is being started and will become active soon.</li><li>`ACTIVE`: Instance group is active. In this state the group manages its instances and monitors their health, creating, deleting, stopping, updating and starting instances as needed. <br>To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/api-ref/grpc/instance_group_service#Stop). To pause the processes in the instance group, i.e. scaling, checking instances' health, auto-healing and updating them, without stopping the instances, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.PauseProcesses](/docs/compute/api-ref/grpc/instance_group_service#PauseProcesses).</li><li>`STOPPING`: Instance group is being stopped. Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.</li><li>`STOPPED`: Instance group is stopped. In this state the group cannot be updated and does not react to any changes made to its instances. To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/api-ref/grpc/instance_group_service#Start).</li><li>`DELETING`: Instance group is being deleted.</li><li>`PAUSED`: Instance group is paused. In this state all the processes regarding the group management, i.e. scaling, checking instances' health, auto-healing and updating them, are paused. The instances that were running prior to pausing the group, however, may still be running. <br>To resume the processes in the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.ResumeProcesses](/docs/compute/api-ref/grpc/instance_group_service#ResumeProcesses). The group status will change to `ACTIVE`.</li></ul>
variables[] | **[Variable](#Variable5)**<br> 
deletion_protection | **bool**<br>Flag prohibiting deletion of the instance group. <br>Allowed values:</br>- `false`: The instance group can be deleted.</br>- `true`: The instance group cannot be deleted. <br>The default is `false`. 
application_load_balancer_spec | **[ApplicationLoadBalancerSpec](#ApplicationLoadBalancerSpec5)**<br>Settings for balancing load between instances via [Application Load Balancer](/docs/application-load-balancer/concepts) (OSI model layer 7). 
application_load_balancer_state | **[ApplicationLoadBalancerState](#ApplicationLoadBalancerState4)**<br>Status of the Application Load Balancer target group attributed to the instance group. <br>Returned if there is a working load balancer that the target group is connected to. 


### LoadBalancerState {#LoadBalancerState4}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Network Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


### ManagedInstancesState {#ManagedInstancesState4}

Field | Description
--- | ---
target_size | **int64**<br>Target number of instances for this instance group. 
running_actual_count | **int64**<br>The number of running instances that match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_ACTUAL](#ManagedInstance). 
running_outdated_count | **int64**<br>The number of running instances that does not match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_OUTDATED](#ManagedInstance). 
processing_count | **int64**<br>The number of instances in flight (for example, updating, starting, deleting). For more information, see [ManagedInstance.Status](#ManagedInstance). 


### Statuses {#Statuses4}

Field | Description
--- | ---
creating | **int64**<br>Instance is being created. 
starting | **int64**<br>Instance is being started. 
opening | **int64**<br>Instance is being opened to receive traffic. 
warming | **int64**<br>Instance is being warmed. 
running | **int64**<br>Instance is running normally. 
closing | **int64**<br>Instance is being closed to traffic. 
stopping | **int64**<br>Instance is being stopped. 
updating | **int64**<br>Instance is being updated. 
deleting | **int64**<br>Instance is being deleted. 
failed | **int64**<br>Instance failed and needs to be recreated. 


### ApplicationLoadBalancerState {#ApplicationLoadBalancerState4}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Application Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


## UpdateFromYaml {#UpdateFromYaml}

Updates the specified instance group from a YAML file. This method starts an operation that can be cancelled by another operation.

**rpc UpdateFromYaml ([UpdateInstanceGroupFromYamlRequest](#UpdateInstanceGroupFromYamlRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateInstanceGroupMetadata](#UpdateInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](#InstanceGroup5)<br>

### UpdateInstanceGroupFromYamlRequest {#UpdateInstanceGroupFromYamlRequest}

Field | Description
--- | ---
instance_group_id | **string**<br>Required. ID of the instance group to update. To get the instance group ID, use a [InstanceGroupService.List](#List) request. The maximum string length in characters is 50.
instance_group_yaml | **string**<br>Required. [InstanceGroupService.Update](#Update) request in YAML format. The maximum string length in characters is 1048576.


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateInstanceGroupMetadata](#UpdateInstanceGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](#InstanceGroup5)>**<br>if operation finished successfully. 


### UpdateInstanceGroupMetadata {#UpdateInstanceGroupMetadata1}

Field | Description
--- | ---
instance_group_id | **string**<br>ID of the InstanceGroup resource that is being updated. To get the instance group ID, use a [InstanceGroupService.List](#List) request. 


### InstanceGroup {#InstanceGroup5}

Field | Description
--- | ---
id | **string**<br>ID of the instance group. 
folder_id | **string**<br>ID of the folder that the instance group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the instance group. The name is unique within the folder. 
description | **string**<br>Description of the instance group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
instance_template | **[InstanceTemplate](#InstanceTemplate5)**<br>Instance template for creating the instance group. For more information, see [Instance Templates](/docs/compute/concepts/instance-groups/instance-template). 
scale_policy | **[ScalePolicy](#ScalePolicy5)**<br>[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. 
deploy_policy | **[DeployPolicy](#DeployPolicy5)**<br>Deployment policy of the instance group. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy5)**<br>Allocation policy of the instance group by zones and regions. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState5)**<br>Status of the Network Load Balancer target group attributed to the instance group. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState5)**<br>States of instances for this instance group. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec5)**<br>Settings for balancing load between instances via [Network Load Balancer](/docs/network-load-balancer/concepts) (OSI model layer 3). 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec5)**<br>Health checking specification. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. 
status | enum **Status**<br>Status of the instance group. <ul><li>`STARTING`: Instance group is being started and will become active soon.</li><li>`ACTIVE`: Instance group is active. In this state the group manages its instances and monitors their health, creating, deleting, stopping, updating and starting instances as needed. <br>To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/api-ref/grpc/instance_group_service#Stop). To pause the processes in the instance group, i.e. scaling, checking instances' health, auto-healing and updating them, without stopping the instances, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.PauseProcesses](/docs/compute/api-ref/grpc/instance_group_service#PauseProcesses).</li><li>`STOPPING`: Instance group is being stopped. Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.</li><li>`STOPPED`: Instance group is stopped. In this state the group cannot be updated and does not react to any changes made to its instances. To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/api-ref/grpc/instance_group_service#Start).</li><li>`DELETING`: Instance group is being deleted.</li><li>`PAUSED`: Instance group is paused. In this state all the processes regarding the group management, i.e. scaling, checking instances' health, auto-healing and updating them, are paused. The instances that were running prior to pausing the group, however, may still be running. <br>To resume the processes in the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.ResumeProcesses](/docs/compute/api-ref/grpc/instance_group_service#ResumeProcesses). The group status will change to `ACTIVE`.</li></ul>
variables[] | **[Variable](#Variable5)**<br> 
deletion_protection | **bool**<br>Flag prohibiting deletion of the instance group. <br>Allowed values:</br>- `false`: The instance group can be deleted.</br>- `true`: The instance group cannot be deleted. <br>The default is `false`. 
application_load_balancer_spec | **[ApplicationLoadBalancerSpec](#ApplicationLoadBalancerSpec5)**<br>Settings for balancing load between instances via [Application Load Balancer](/docs/application-load-balancer/concepts) (OSI model layer 7). 
application_load_balancer_state | **[ApplicationLoadBalancerState](#ApplicationLoadBalancerState5)**<br>Status of the Application Load Balancer target group attributed to the instance group. <br>Returned if there is a working load balancer that the target group is connected to. 


### InstanceTemplate {#InstanceTemplate5}

Field | Description
--- | ---
description | **string**<br>Description of the instance template. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
platform_id | **string**<br>Required. ID of the hardware platform configuration for the instance. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see [Platforms](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec5)**<br>Required. Computing resources of the instance such as the amount of memory and number of cores. 
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>Metadata values may contain one of the supported placeholders: {instance_group.id} {instance.short_id} {instance.index} {instance.index_in_zone} {instance.zone_id} InstanceGroup and Instance labels may be copied to metadata following way: {instance_group.labels.some_label_key} {instance.labels.another_label_key} These placeholders will be substituted for each created instance anywhere in the value text. In the rare case the value requires to contain this placeholder explicitly, it must be escaped with double brackets, in example {instance.index}. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). No more than 128 per resource. The maximum string length in characters for each value is 262144. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec5)**<br>Required. Boot disk specification that will be attached to the instance. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec5)**<br>Array of secondary disks that will be attached to the instance. The maximum number of elements is 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec5)**<br>Array of network interfaces that will be attached to the instance. The number of elemets must be exactly 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy5)**<br>Scheduling policy for the instance. 
service_account_id | **string**<br>Service account ID for the instance. 
network_settings | **[NetworkSettings](#NetworkSettings5)**<br>Network settings for the instance. 
name | **string**<br>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
hostname | **string**<br>Host name for the instance. This field is used to generate the `yandex.cloud.compute.v1.Instance.fqdn` value. The host name must be unique within the network and region. If not specified, the host name will be equal to `yandex.cloud.compute.v1.Instance.id` of the instance and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`. <br>In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, `name` value will be used It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
placement_policy | **[PlacementPolicy](#PlacementPolicy5)**<br>Placement Group 
filesystem_specs[] | **[AttachedFilesystemSpec](#AttachedFilesystemSpec5)**<br>Array of filesystems to attach to the instance. <br>The filesystems must reside in the same availability zone as the instance. <br>To use the instance with an attached filesystem, the latter must be mounted. For details, see [documentation](/docs/compute/operations/filesystem/attach-to-vm). 


### ResourcesSpec {#ResourcesSpec5}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. The maximum value is 824633720832.
cores | **int64**<br>The number of cores available to the instance. Value must be equal to 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64,68,72,76,80.
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. Value must be equal to 0,5,20,50,100.
gpus | **int64**<br>The number of GPUs available to the instance. Value must be equal to 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec5}

Field | Description
--- | ---
mode | enum **Mode**<br>Required. Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li></ul>
device_name | **string**<br>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec5)**<br>Required. oneof disk_spec or disk_id Disk specification that is attached to the instance. For more information, see [Disks](/docs/compute/concepts/disk). 
disk_id | **string**<br>Set to use an existing disk. To set use variables. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### DiskSpec {#DiskSpec5}

Field | Description
--- | ---
description | **string**<br>Description of the disk. The maximum string length in characters is 256.
type_id | **string**<br>Required. ID of the disk type. 
size | **int64**<br>Size of the disk, specified in bytes. Acceptable values are 4194304 to 28587302322176, inclusive.
source_oneof | **oneof:** `image_id` or `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>ID of the image that will be used for disk creation. The maximum string length in characters is 50.
&nbsp;&nbsp;snapshot_id | **string**<br>ID of the snapshot that will be used for disk creation. The maximum string length in characters is 50.
preserve_after_instance_delete | **bool**<br>When set to true, disk will not be deleted even after managed instance is deleted. It will be a user's responsibility to delete such disks. 


### NetworkInterfaceSpec {#NetworkInterfaceSpec5}

Field | Description
--- | ---
network_id | **string**<br>ID of the network. 
subnet_ids[] | **string**<br>IDs of the subnets. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec5)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec5)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>IDs of security groups. 


### PrimaryAddressSpec {#PrimaryAddressSpec5}

Field | Description
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec5)**<br>An external IP address configuration. If not specified, then this managed instance will have no external internet access. 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec5)**<br>Internal DNS configuration 
address | **string**<br>Optional. Manual set static internal IP. To set use variables. 


### OneToOneNatSpec {#OneToOneNatSpec5}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>IP version for the public IP address. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li></ul>
address | **string**<br>Manual set static public IP. To set use variables. (optional) 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec5)**<br>External DNS configuration 


### DnsRecordSpec {#DnsRecordSpec5}

Field | Description
--- | ---
fqdn | **string**<br>Required. FQDN (required) 
dns_zone_id | **string**<br>DNS zone id (optional, if not set, private zone used) 
ttl | **int64**<br>DNS record ttl, values in 0-86400 (optional) Acceptable values are 0 to 86400, inclusive.
ptr | **bool**<br>When set to true, also create PTR DNS record (optional) 


### SchedulingPolicy {#SchedulingPolicy5}

Field | Description
--- | ---
preemptible | **bool**<br>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings5}

Field | Description
--- | ---
type | enum **Type**<br>Type of instance network. 


### PlacementPolicy {#PlacementPolicy5}

Field | Description
--- | ---
placement_group_id | **string**<br>Identifier of placement group 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule5)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule5}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action 
values[] | **string**<br>Affinity value or host ID or host group ID 


### AttachedFilesystemSpec {#AttachedFilesystemSpec5}

Field | Description
--- | ---
mode | enum **Mode**<br>Mode of access to the filesystem that should be attached. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access. Default value.</li></ul>
device_name | **string**<br>Name of the device representing the filesystem on the instance. <br>The name should be used for referencing the filesystem from within the instance when it's being mounted, resized etc. <br>If not specified, a random value will be generated. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
filesystem_id | **string**<br>ID of the filesystem that should be attached. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### ScalePolicy {#ScalePolicy5}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale` or `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale5)**<br>[Manual scaling policy](/docs/compute/concepts/instance-groups/scale#fixed-policy) of the instance group. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale5)**<br>[Automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 
test_auto_scale | **[AutoScale](#AutoScale5)**<br>Test spec for [automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 


### AutoScale {#AutoScale5}

Field | Description
--- | ---
min_zone_size | **int64**<br>Lower limit for instance count in each zone. Acceptable values are 0 to 100, inclusive.
max_size | **int64**<br>Upper limit for total instance count (across all zones). 0 means maximum limit = 100. Acceptable values are 0 to 100, inclusive.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time in seconds allotted for averaging metrics. 1 minute by default. Acceptable values are 1m to 10m, inclusive.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected. The maximum value is 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should. Acceptable values are 1m to 30m, inclusive.
initial_size | **int64**<br>Target group size. The minimum value is 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule5)**<br>Defines an autoscaling rule based on the average CPU utilization of the instance group. <br>If more than one rule is specified, e.g. CPU utilization and one or more Monitoring metrics (`custom_rules`), the size of the instance group will be equal to the maximum of sizes calculated according to each metric. 
custom_rules[] | **[CustomRule](#CustomRule5)**<br>Defines an autoscaling rule based on a [custom metric](/docs/monitoring/operations/metric/add) from Monitoring. <br>If more than one rule is specified, e.g. CPU utilization (`cpu_utilization_rule`) and one or more Monitoring metrics, the size of the instance group will be equal to the maximum of sizes calculated according to each metric. The maximum number of elements is 3.
auto_scale_type | enum **AutoScaleType**<br>Autoscaling type. <ul><li>`ZONAL`: Scale each zone independently. This is the default.</li><li>`REGIONAL`: Scale group as a whole.</li></ul>


### CpuUtilizationRule {#CpuUtilizationRule5}

Field | Description
--- | ---
utilization_target | **double**<br>Target CPU utilization level. Instance Groups maintains this level for each availability zone. Acceptable values are 10 to 100, inclusive.


### CustomRule {#CustomRule5}

Field | Description
--- | ---
rule_type | enum **RuleType**<br>Required. Custom metric rule type. This field affects which label from the custom metric should be used: `zone_id` or `instance_id`. <ul><li>`UTILIZATION`: This type means that the metric applies to one instance. First, Instance Groups calculates the average metric value for each instance, then averages the values for instances in one availability zone or in whole group depends on autoscaling type. This type of metric must have the `instance_id` label.</li><li>`WORKLOAD`: This type means that the metric applies to instances in one availability zone or to whole group depends on autoscaling type. This type of metric must have the `zone_id` label if ZONAL autoscaling type is chosen.</li></ul>
metric_type | enum **MetricType**<br>Required. Type of custom metric. This field affects how Instance Groups calculates the average metric value. <ul><li>`GAUGE`: This type is used for metrics that show the metric value at a certain point in time, such as requests per second to the server on an instance. <br>Instance Groups calculates the average metric value for the period specified in the [AutoScale.measurement_duration](#AutoScale5) field.</li><li>`COUNTER`: This type is used for metrics that monotonically increase over time, such as the total number of requests to the server on an instance. <br>Instance Groups calculates the average value increase for the period specified in the [AutoScale.measurement_duration](#AutoScale5) field.</li></ul>
metric_name | **string**<br>Required. Name of custom metric in Monitoring that should be used for scaling. Value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
labels | **map<string,string>**<br>Labels of custom metric in Monitoring that should be used for scaling. Each value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `. Each key must match the regular expression ` ^[a-zA-Z][0-9a-zA-Z_]{0,31}$ `.
target | **double**<br>Target value for the custom metric. Instance Groups maintains this level for each availability zone. Value must be greater than 0.
folder_id | **string**<br>Folder id of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 50.
service | **string**<br>Service of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 200.


### FixedScale {#FixedScale5}

Field | Description
--- | ---
size | **int64**<br>Number of instances in the instance group. Acceptable values are 1 to 100, inclusive.


### DeployPolicy {#DeployPolicy5}

Field | Description
--- | ---
max_unavailable | **int64**<br>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If `max_expansion` is not specified or set to zero, `max_unavailable` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
max_deleting | **int64**<br>The maximum number of instances that can be deleted at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_creating | **int64**<br>The maximum number of instances that can be created at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_expansion | **int64**<br>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If `max_unavailable` is not specified or set to zero, `max_expansion` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Instance startup duration. Instance will be considered up and running (and start receiving traffic) only after startup_duration has elapsed and all health checks are passed. See `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status` for more information. Acceptable values are 0m to 1h, inclusive.
strategy | enum **Strategy**<br>Affects the lifecycle of the instance during deployment. <ul><li>`PROACTIVE`: Instance Groups can forcefully stop a running instance. This is the default.</li><li>`OPPORTUNISTIC`: Instance Groups does not stop a running instance. Instead, it will wait until the instance stops itself or becomes unhealthy.</li></ul>


### AllocationPolicy {#AllocationPolicy5}

Field | Description
--- | ---
zones[] | **[Zone](#Zone5)**<br>List of availability zones. The minimum number of elements is 1.


### Zone {#Zone5}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the instance resides. 


### LoadBalancerState {#LoadBalancerState5}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Network Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


### ManagedInstancesState {#ManagedInstancesState5}

Field | Description
--- | ---
target_size | **int64**<br>Target number of instances for this instance group. 
running_actual_count | **int64**<br>The number of running instances that match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_ACTUAL](#ManagedInstance). 
running_outdated_count | **int64**<br>The number of running instances that does not match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_OUTDATED](#ManagedInstance). 
processing_count | **int64**<br>The number of instances in flight (for example, updating, starting, deleting). For more information, see [ManagedInstance.Status](#ManagedInstance). 


### Statuses {#Statuses5}

Field | Description
--- | ---
creating | **int64**<br>Instance is being created. 
starting | **int64**<br>Instance is being started. 
opening | **int64**<br>Instance is being opened to receive traffic. 
warming | **int64**<br>Instance is being warmed. 
running | **int64**<br>Instance is running normally. 
closing | **int64**<br>Instance is being closed to traffic. 
stopping | **int64**<br>Instance is being stopped. 
updating | **int64**<br>Instance is being updated. 
deleting | **int64**<br>Instance is being deleted. 
failed | **int64**<br>Instance failed and needs to be recreated. 


### LoadBalancerSpec {#LoadBalancerSpec5}

Field | Description
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec5)**<br>Specification of the target group that the instance group will be added to. For more information, see [Target groups and resources](/docs/load-balancer/concepts/target-resources). 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### TargetGroupSpec {#TargetGroupSpec5}

Field | Description
--- | ---
name | **string**<br>Name of the target group. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the target group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec5}

Field | Description
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec5)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). The minimum number of elements is 1.
max_checking_health_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to become healthy. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### HealthCheckSpec {#HealthCheckSpec5}

Field | Description
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. Acceptable values are 1s to 300s, inclusive.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the managed instance to return a response for the health check. The default is 1 second. Acceptable values are 1s to 60s, inclusive.
unhealthy_threshold | **int64**<br>The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` or `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions5)**<br>Configuration options for a TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions5)**<br>Configuration options for an HTTP health check. 


### TcpOptions {#TcpOptions5}

Field | Description
--- | ---
port | **int64**<br>Port to use for TCP health checks. Acceptable values are 1 to 65535, inclusive.


### HttpOptions {#HttpOptions5}

Field | Description
--- | ---
port | **int64**<br>Port to use for HTTP health checks. Acceptable values are 1 to 65535, inclusive.
path | **string**<br>URL path to set for health checking requests. 


### Variable {#Variable5}

Field | Description
--- | ---
key | **string**<br> The string length in characters must be 1-128. Value must match the regular expression ` [a-zA-Z0-9._-]* `.
value | **string**<br> The maximum string length in characters is 128.


### ApplicationLoadBalancerSpec {#ApplicationLoadBalancerSpec5}

Field | Description
--- | ---
target_group_spec | **[ApplicationTargetGroupSpec](#ApplicationTargetGroupSpec5)**<br>Required. Basic properties of the Application Load Balancer target group attributed to the instance group. 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### ApplicationTargetGroupSpec {#ApplicationTargetGroupSpec5}

Field | Description
--- | ---
name | **string**<br>Name of the target group. 
description | **string**<br>Description of the target group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 


### ApplicationLoadBalancerState {#ApplicationLoadBalancerState5}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Application Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


## Stop {#Stop}

Stops the specified instance group.

**rpc Stop ([StopInstanceGroupRequest](#StopInstanceGroupRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopInstanceGroupMetadata](#StopInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](#InstanceGroup6)<br>

### StopInstanceGroupRequest {#StopInstanceGroupRequest}

Field | Description
--- | ---
instance_group_id | **string**<br>Required. ID of the instance group to stop. To get the instance group ID, use a [InstanceGroupService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StopInstanceGroupMetadata](#StopInstanceGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](#InstanceGroup6)>**<br>if operation finished successfully. 


### StopInstanceGroupMetadata {#StopInstanceGroupMetadata}

Field | Description
--- | ---
instance_group_id | **string**<br>ID of the InstanceGroup resource that is being stopped. 


### InstanceGroup {#InstanceGroup6}

Field | Description
--- | ---
id | **string**<br>ID of the instance group. 
folder_id | **string**<br>ID of the folder that the instance group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the instance group. The name is unique within the folder. 
description | **string**<br>Description of the instance group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
instance_template | **[InstanceTemplate](#InstanceTemplate6)**<br>Instance template for creating the instance group. For more information, see [Instance Templates](/docs/compute/concepts/instance-groups/instance-template). 
scale_policy | **[ScalePolicy](#ScalePolicy6)**<br>[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. 
deploy_policy | **[DeployPolicy](#DeployPolicy6)**<br>Deployment policy of the instance group. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy6)**<br>Allocation policy of the instance group by zones and regions. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState6)**<br>Status of the Network Load Balancer target group attributed to the instance group. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState6)**<br>States of instances for this instance group. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec6)**<br>Settings for balancing load between instances via [Network Load Balancer](/docs/network-load-balancer/concepts) (OSI model layer 3). 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec6)**<br>Health checking specification. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. 
status | enum **Status**<br>Status of the instance group. <ul><li>`STARTING`: Instance group is being started and will become active soon.</li><li>`ACTIVE`: Instance group is active. In this state the group manages its instances and monitors their health, creating, deleting, stopping, updating and starting instances as needed. <br>To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/api-ref/grpc/instance_group_service#Stop). To pause the processes in the instance group, i.e. scaling, checking instances' health, auto-healing and updating them, without stopping the instances, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.PauseProcesses](/docs/compute/api-ref/grpc/instance_group_service#PauseProcesses).</li><li>`STOPPING`: Instance group is being stopped. Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.</li><li>`STOPPED`: Instance group is stopped. In this state the group cannot be updated and does not react to any changes made to its instances. To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/api-ref/grpc/instance_group_service#Start).</li><li>`DELETING`: Instance group is being deleted.</li><li>`PAUSED`: Instance group is paused. In this state all the processes regarding the group management, i.e. scaling, checking instances' health, auto-healing and updating them, are paused. The instances that were running prior to pausing the group, however, may still be running. <br>To resume the processes in the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.ResumeProcesses](/docs/compute/api-ref/grpc/instance_group_service#ResumeProcesses). The group status will change to `ACTIVE`.</li></ul>
variables[] | **[Variable](#Variable6)**<br> 
deletion_protection | **bool**<br>Flag prohibiting deletion of the instance group. <br>Allowed values:</br>- `false`: The instance group can be deleted.</br>- `true`: The instance group cannot be deleted. <br>The default is `false`. 
application_load_balancer_spec | **[ApplicationLoadBalancerSpec](#ApplicationLoadBalancerSpec6)**<br>Settings for balancing load between instances via [Application Load Balancer](/docs/application-load-balancer/concepts) (OSI model layer 7). 
application_load_balancer_state | **[ApplicationLoadBalancerState](#ApplicationLoadBalancerState6)**<br>Status of the Application Load Balancer target group attributed to the instance group. <br>Returned if there is a working load balancer that the target group is connected to. 


### InstanceTemplate {#InstanceTemplate6}

Field | Description
--- | ---
description | **string**<br>Description of the instance template. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
platform_id | **string**<br>Required. ID of the hardware platform configuration for the instance. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see [Platforms](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec6)**<br>Required. Computing resources of the instance such as the amount of memory and number of cores. 
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>Metadata values may contain one of the supported placeholders: {instance_group.id} {instance.short_id} {instance.index} {instance.index_in_zone} {instance.zone_id} InstanceGroup and Instance labels may be copied to metadata following way: {instance_group.labels.some_label_key} {instance.labels.another_label_key} These placeholders will be substituted for each created instance anywhere in the value text. In the rare case the value requires to contain this placeholder explicitly, it must be escaped with double brackets, in example {instance.index}. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). No more than 128 per resource. The maximum string length in characters for each value is 262144. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec6)**<br>Required. Boot disk specification that will be attached to the instance. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec6)**<br>Array of secondary disks that will be attached to the instance. The maximum number of elements is 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec6)**<br>Array of network interfaces that will be attached to the instance. The number of elemets must be exactly 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy6)**<br>Scheduling policy for the instance. 
service_account_id | **string**<br>Service account ID for the instance. 
network_settings | **[NetworkSettings](#NetworkSettings6)**<br>Network settings for the instance. 
name | **string**<br>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
hostname | **string**<br>Host name for the instance. This field is used to generate the `yandex.cloud.compute.v1.Instance.fqdn` value. The host name must be unique within the network and region. If not specified, the host name will be equal to `yandex.cloud.compute.v1.Instance.id` of the instance and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`. <br>In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, `name` value will be used It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
placement_policy | **[PlacementPolicy](#PlacementPolicy6)**<br>Placement Group 
filesystem_specs[] | **[AttachedFilesystemSpec](#AttachedFilesystemSpec6)**<br>Array of filesystems to attach to the instance. <br>The filesystems must reside in the same availability zone as the instance. <br>To use the instance with an attached filesystem, the latter must be mounted. For details, see [documentation](/docs/compute/operations/filesystem/attach-to-vm). 


### ResourcesSpec {#ResourcesSpec6}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. The maximum value is 824633720832.
cores | **int64**<br>The number of cores available to the instance. Value must be equal to 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64,68,72,76,80.
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. Value must be equal to 0,5,20,50,100.
gpus | **int64**<br>The number of GPUs available to the instance. Value must be equal to 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec6}

Field | Description
--- | ---
mode | enum **Mode**<br>Required. Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li></ul>
device_name | **string**<br>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec6)**<br>Required. oneof disk_spec or disk_id Disk specification that is attached to the instance. For more information, see [Disks](/docs/compute/concepts/disk). 
disk_id | **string**<br>Set to use an existing disk. To set use variables. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### DiskSpec {#DiskSpec6}

Field | Description
--- | ---
description | **string**<br>Description of the disk. The maximum string length in characters is 256.
type_id | **string**<br>Required. ID of the disk type. 
size | **int64**<br>Size of the disk, specified in bytes. Acceptable values are 4194304 to 28587302322176, inclusive.
source_oneof | **oneof:** `image_id` or `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>ID of the image that will be used for disk creation. The maximum string length in characters is 50.
&nbsp;&nbsp;snapshot_id | **string**<br>ID of the snapshot that will be used for disk creation. The maximum string length in characters is 50.
preserve_after_instance_delete | **bool**<br>When set to true, disk will not be deleted even after managed instance is deleted. It will be a user's responsibility to delete such disks. 


### NetworkInterfaceSpec {#NetworkInterfaceSpec6}

Field | Description
--- | ---
network_id | **string**<br>ID of the network. 
subnet_ids[] | **string**<br>IDs of the subnets. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec6)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec6)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>IDs of security groups. 


### PrimaryAddressSpec {#PrimaryAddressSpec6}

Field | Description
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec6)**<br>An external IP address configuration. If not specified, then this managed instance will have no external internet access. 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec6)**<br>Internal DNS configuration 
address | **string**<br>Optional. Manual set static internal IP. To set use variables. 


### OneToOneNatSpec {#OneToOneNatSpec6}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>IP version for the public IP address. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li></ul>
address | **string**<br>Manual set static public IP. To set use variables. (optional) 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec6)**<br>External DNS configuration 


### DnsRecordSpec {#DnsRecordSpec6}

Field | Description
--- | ---
fqdn | **string**<br>Required. FQDN (required) 
dns_zone_id | **string**<br>DNS zone id (optional, if not set, private zone used) 
ttl | **int64**<br>DNS record ttl, values in 0-86400 (optional) Acceptable values are 0 to 86400, inclusive.
ptr | **bool**<br>When set to true, also create PTR DNS record (optional) 


### SchedulingPolicy {#SchedulingPolicy6}

Field | Description
--- | ---
preemptible | **bool**<br>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings6}

Field | Description
--- | ---
type | enum **Type**<br>Type of instance network. 


### PlacementPolicy {#PlacementPolicy6}

Field | Description
--- | ---
placement_group_id | **string**<br>Identifier of placement group 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule6)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule6}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action 
values[] | **string**<br>Affinity value or host ID or host group ID 


### AttachedFilesystemSpec {#AttachedFilesystemSpec6}

Field | Description
--- | ---
mode | enum **Mode**<br>Mode of access to the filesystem that should be attached. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access. Default value.</li></ul>
device_name | **string**<br>Name of the device representing the filesystem on the instance. <br>The name should be used for referencing the filesystem from within the instance when it's being mounted, resized etc. <br>If not specified, a random value will be generated. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
filesystem_id | **string**<br>ID of the filesystem that should be attached. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### ScalePolicy {#ScalePolicy6}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale` or `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale6)**<br>[Manual scaling policy](/docs/compute/concepts/instance-groups/scale#fixed-policy) of the instance group. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale6)**<br>[Automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 
test_auto_scale | **[AutoScale](#AutoScale6)**<br>Test spec for [automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 


### AutoScale {#AutoScale6}

Field | Description
--- | ---
min_zone_size | **int64**<br>Lower limit for instance count in each zone. Acceptable values are 0 to 100, inclusive.
max_size | **int64**<br>Upper limit for total instance count (across all zones). 0 means maximum limit = 100. Acceptable values are 0 to 100, inclusive.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time in seconds allotted for averaging metrics. 1 minute by default. Acceptable values are 1m to 10m, inclusive.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected. The maximum value is 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should. Acceptable values are 1m to 30m, inclusive.
initial_size | **int64**<br>Target group size. The minimum value is 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule6)**<br>Defines an autoscaling rule based on the average CPU utilization of the instance group. <br>If more than one rule is specified, e.g. CPU utilization and one or more Monitoring metrics (`custom_rules`), the size of the instance group will be equal to the maximum of sizes calculated according to each metric. 
custom_rules[] | **[CustomRule](#CustomRule6)**<br>Defines an autoscaling rule based on a [custom metric](/docs/monitoring/operations/metric/add) from Monitoring. <br>If more than one rule is specified, e.g. CPU utilization (`cpu_utilization_rule`) and one or more Monitoring metrics, the size of the instance group will be equal to the maximum of sizes calculated according to each metric. The maximum number of elements is 3.
auto_scale_type | enum **AutoScaleType**<br>Autoscaling type. <ul><li>`ZONAL`: Scale each zone independently. This is the default.</li><li>`REGIONAL`: Scale group as a whole.</li></ul>


### CpuUtilizationRule {#CpuUtilizationRule6}

Field | Description
--- | ---
utilization_target | **double**<br>Target CPU utilization level. Instance Groups maintains this level for each availability zone. Acceptable values are 10 to 100, inclusive.


### CustomRule {#CustomRule6}

Field | Description
--- | ---
rule_type | enum **RuleType**<br>Required. Custom metric rule type. This field affects which label from the custom metric should be used: `zone_id` or `instance_id`. <ul><li>`UTILIZATION`: This type means that the metric applies to one instance. First, Instance Groups calculates the average metric value for each instance, then averages the values for instances in one availability zone or in whole group depends on autoscaling type. This type of metric must have the `instance_id` label.</li><li>`WORKLOAD`: This type means that the metric applies to instances in one availability zone or to whole group depends on autoscaling type. This type of metric must have the `zone_id` label if ZONAL autoscaling type is chosen.</li></ul>
metric_type | enum **MetricType**<br>Required. Type of custom metric. This field affects how Instance Groups calculates the average metric value. <ul><li>`GAUGE`: This type is used for metrics that show the metric value at a certain point in time, such as requests per second to the server on an instance. <br>Instance Groups calculates the average metric value for the period specified in the [AutoScale.measurement_duration](#AutoScale6) field.</li><li>`COUNTER`: This type is used for metrics that monotonically increase over time, such as the total number of requests to the server on an instance. <br>Instance Groups calculates the average value increase for the period specified in the [AutoScale.measurement_duration](#AutoScale6) field.</li></ul>
metric_name | **string**<br>Required. Name of custom metric in Monitoring that should be used for scaling. Value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
labels | **map<string,string>**<br>Labels of custom metric in Monitoring that should be used for scaling. Each value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `. Each key must match the regular expression ` ^[a-zA-Z][0-9a-zA-Z_]{0,31}$ `.
target | **double**<br>Target value for the custom metric. Instance Groups maintains this level for each availability zone. Value must be greater than 0.
folder_id | **string**<br>Folder id of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 50.
service | **string**<br>Service of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 200.


### FixedScale {#FixedScale6}

Field | Description
--- | ---
size | **int64**<br>Number of instances in the instance group. Acceptable values are 1 to 100, inclusive.


### DeployPolicy {#DeployPolicy6}

Field | Description
--- | ---
max_unavailable | **int64**<br>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If `max_expansion` is not specified or set to zero, `max_unavailable` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
max_deleting | **int64**<br>The maximum number of instances that can be deleted at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_creating | **int64**<br>The maximum number of instances that can be created at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_expansion | **int64**<br>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If `max_unavailable` is not specified or set to zero, `max_expansion` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Instance startup duration. Instance will be considered up and running (and start receiving traffic) only after startup_duration has elapsed and all health checks are passed. See `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status` for more information. Acceptable values are 0m to 1h, inclusive.
strategy | enum **Strategy**<br>Affects the lifecycle of the instance during deployment. <ul><li>`PROACTIVE`: Instance Groups can forcefully stop a running instance. This is the default.</li><li>`OPPORTUNISTIC`: Instance Groups does not stop a running instance. Instead, it will wait until the instance stops itself or becomes unhealthy.</li></ul>


### AllocationPolicy {#AllocationPolicy6}

Field | Description
--- | ---
zones[] | **[Zone](#Zone6)**<br>List of availability zones. The minimum number of elements is 1.


### Zone {#Zone6}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the instance resides. 


### LoadBalancerState {#LoadBalancerState6}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Network Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


### ManagedInstancesState {#ManagedInstancesState6}

Field | Description
--- | ---
target_size | **int64**<br>Target number of instances for this instance group. 
running_actual_count | **int64**<br>The number of running instances that match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_ACTUAL](#ManagedInstance). 
running_outdated_count | **int64**<br>The number of running instances that does not match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_OUTDATED](#ManagedInstance). 
processing_count | **int64**<br>The number of instances in flight (for example, updating, starting, deleting). For more information, see [ManagedInstance.Status](#ManagedInstance). 


### Statuses {#Statuses6}

Field | Description
--- | ---
creating | **int64**<br>Instance is being created. 
starting | **int64**<br>Instance is being started. 
opening | **int64**<br>Instance is being opened to receive traffic. 
warming | **int64**<br>Instance is being warmed. 
running | **int64**<br>Instance is running normally. 
closing | **int64**<br>Instance is being closed to traffic. 
stopping | **int64**<br>Instance is being stopped. 
updating | **int64**<br>Instance is being updated. 
deleting | **int64**<br>Instance is being deleted. 
failed | **int64**<br>Instance failed and needs to be recreated. 


### LoadBalancerSpec {#LoadBalancerSpec6}

Field | Description
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec6)**<br>Specification of the target group that the instance group will be added to. For more information, see [Target groups and resources](/docs/load-balancer/concepts/target-resources). 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### TargetGroupSpec {#TargetGroupSpec6}

Field | Description
--- | ---
name | **string**<br>Name of the target group. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the target group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec6}

Field | Description
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec6)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). The minimum number of elements is 1.
max_checking_health_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to become healthy. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### HealthCheckSpec {#HealthCheckSpec6}

Field | Description
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. Acceptable values are 1s to 300s, inclusive.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the managed instance to return a response for the health check. The default is 1 second. Acceptable values are 1s to 60s, inclusive.
unhealthy_threshold | **int64**<br>The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` or `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions6)**<br>Configuration options for a TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions6)**<br>Configuration options for an HTTP health check. 


### TcpOptions {#TcpOptions6}

Field | Description
--- | ---
port | **int64**<br>Port to use for TCP health checks. Acceptable values are 1 to 65535, inclusive.


### HttpOptions {#HttpOptions6}

Field | Description
--- | ---
port | **int64**<br>Port to use for HTTP health checks. Acceptable values are 1 to 65535, inclusive.
path | **string**<br>URL path to set for health checking requests. 


### Variable {#Variable6}

Field | Description
--- | ---
key | **string**<br> The string length in characters must be 1-128. Value must match the regular expression ` [a-zA-Z0-9._-]* `.
value | **string**<br> The maximum string length in characters is 128.


### ApplicationLoadBalancerSpec {#ApplicationLoadBalancerSpec6}

Field | Description
--- | ---
target_group_spec | **[ApplicationTargetGroupSpec](#ApplicationTargetGroupSpec6)**<br>Required. Basic properties of the Application Load Balancer target group attributed to the instance group. 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### ApplicationTargetGroupSpec {#ApplicationTargetGroupSpec6}

Field | Description
--- | ---
name | **string**<br>Name of the target group. 
description | **string**<br>Description of the target group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 


### ApplicationLoadBalancerState {#ApplicationLoadBalancerState6}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Application Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


## Start {#Start}

Starts the specified instance group.

**rpc Start ([StartInstanceGroupRequest](#StartInstanceGroupRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartInstanceGroupMetadata](#StartInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](#InstanceGroup7)<br>

### StartInstanceGroupRequest {#StartInstanceGroupRequest}

Field | Description
--- | ---
instance_group_id | **string**<br>Required. ID of the instance group to start. To get the instance group ID, use a [InstanceGroupService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation5}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StartInstanceGroupMetadata](#StartInstanceGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](#InstanceGroup7)>**<br>if operation finished successfully. 


### StartInstanceGroupMetadata {#StartInstanceGroupMetadata}

Field | Description
--- | ---
instance_group_id | **string**<br>ID of the InstanceGroup resource that is being started. 


### InstanceGroup {#InstanceGroup7}

Field | Description
--- | ---
id | **string**<br>ID of the instance group. 
folder_id | **string**<br>ID of the folder that the instance group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the instance group. The name is unique within the folder. 
description | **string**<br>Description of the instance group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
instance_template | **[InstanceTemplate](#InstanceTemplate7)**<br>Instance template for creating the instance group. For more information, see [Instance Templates](/docs/compute/concepts/instance-groups/instance-template). 
scale_policy | **[ScalePolicy](#ScalePolicy7)**<br>[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. 
deploy_policy | **[DeployPolicy](#DeployPolicy7)**<br>Deployment policy of the instance group. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy7)**<br>Allocation policy of the instance group by zones and regions. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState7)**<br>Status of the Network Load Balancer target group attributed to the instance group. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState7)**<br>States of instances for this instance group. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec7)**<br>Settings for balancing load between instances via [Network Load Balancer](/docs/network-load-balancer/concepts) (OSI model layer 3). 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec7)**<br>Health checking specification. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. 
status | enum **Status**<br>Status of the instance group. <ul><li>`STARTING`: Instance group is being started and will become active soon.</li><li>`ACTIVE`: Instance group is active. In this state the group manages its instances and monitors their health, creating, deleting, stopping, updating and starting instances as needed. <br>To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/api-ref/grpc/instance_group_service#Stop). To pause the processes in the instance group, i.e. scaling, checking instances' health, auto-healing and updating them, without stopping the instances, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.PauseProcesses](/docs/compute/api-ref/grpc/instance_group_service#PauseProcesses).</li><li>`STOPPING`: Instance group is being stopped. Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.</li><li>`STOPPED`: Instance group is stopped. In this state the group cannot be updated and does not react to any changes made to its instances. To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/api-ref/grpc/instance_group_service#Start).</li><li>`DELETING`: Instance group is being deleted.</li><li>`PAUSED`: Instance group is paused. In this state all the processes regarding the group management, i.e. scaling, checking instances' health, auto-healing and updating them, are paused. The instances that were running prior to pausing the group, however, may still be running. <br>To resume the processes in the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.ResumeProcesses](/docs/compute/api-ref/grpc/instance_group_service#ResumeProcesses). The group status will change to `ACTIVE`.</li></ul>
variables[] | **[Variable](#Variable7)**<br> 
deletion_protection | **bool**<br>Flag prohibiting deletion of the instance group. <br>Allowed values:</br>- `false`: The instance group can be deleted.</br>- `true`: The instance group cannot be deleted. <br>The default is `false`. 
application_load_balancer_spec | **[ApplicationLoadBalancerSpec](#ApplicationLoadBalancerSpec7)**<br>Settings for balancing load between instances via [Application Load Balancer](/docs/application-load-balancer/concepts) (OSI model layer 7). 
application_load_balancer_state | **[ApplicationLoadBalancerState](#ApplicationLoadBalancerState7)**<br>Status of the Application Load Balancer target group attributed to the instance group. <br>Returned if there is a working load balancer that the target group is connected to. 


### InstanceTemplate {#InstanceTemplate7}

Field | Description
--- | ---
description | **string**<br>Description of the instance template. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
platform_id | **string**<br>Required. ID of the hardware platform configuration for the instance. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see [Platforms](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec7)**<br>Required. Computing resources of the instance such as the amount of memory and number of cores. 
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>Metadata values may contain one of the supported placeholders: {instance_group.id} {instance.short_id} {instance.index} {instance.index_in_zone} {instance.zone_id} InstanceGroup and Instance labels may be copied to metadata following way: {instance_group.labels.some_label_key} {instance.labels.another_label_key} These placeholders will be substituted for each created instance anywhere in the value text. In the rare case the value requires to contain this placeholder explicitly, it must be escaped with double brackets, in example {instance.index}. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). No more than 128 per resource. The maximum string length in characters for each value is 262144. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec7)**<br>Required. Boot disk specification that will be attached to the instance. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec7)**<br>Array of secondary disks that will be attached to the instance. The maximum number of elements is 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec7)**<br>Array of network interfaces that will be attached to the instance. The number of elemets must be exactly 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy7)**<br>Scheduling policy for the instance. 
service_account_id | **string**<br>Service account ID for the instance. 
network_settings | **[NetworkSettings](#NetworkSettings7)**<br>Network settings for the instance. 
name | **string**<br>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
hostname | **string**<br>Host name for the instance. This field is used to generate the `yandex.cloud.compute.v1.Instance.fqdn` value. The host name must be unique within the network and region. If not specified, the host name will be equal to `yandex.cloud.compute.v1.Instance.id` of the instance and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`. <br>In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, `name` value will be used It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
placement_policy | **[PlacementPolicy](#PlacementPolicy7)**<br>Placement Group 
filesystem_specs[] | **[AttachedFilesystemSpec](#AttachedFilesystemSpec7)**<br>Array of filesystems to attach to the instance. <br>The filesystems must reside in the same availability zone as the instance. <br>To use the instance with an attached filesystem, the latter must be mounted. For details, see [documentation](/docs/compute/operations/filesystem/attach-to-vm). 


### ResourcesSpec {#ResourcesSpec7}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. The maximum value is 824633720832.
cores | **int64**<br>The number of cores available to the instance. Value must be equal to 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64,68,72,76,80.
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. Value must be equal to 0,5,20,50,100.
gpus | **int64**<br>The number of GPUs available to the instance. Value must be equal to 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec7}

Field | Description
--- | ---
mode | enum **Mode**<br>Required. Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li></ul>
device_name | **string**<br>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec7)**<br>Required. oneof disk_spec or disk_id Disk specification that is attached to the instance. For more information, see [Disks](/docs/compute/concepts/disk). 
disk_id | **string**<br>Set to use an existing disk. To set use variables. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### DiskSpec {#DiskSpec7}

Field | Description
--- | ---
description | **string**<br>Description of the disk. The maximum string length in characters is 256.
type_id | **string**<br>Required. ID of the disk type. 
size | **int64**<br>Size of the disk, specified in bytes. Acceptable values are 4194304 to 28587302322176, inclusive.
source_oneof | **oneof:** `image_id` or `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>ID of the image that will be used for disk creation. The maximum string length in characters is 50.
&nbsp;&nbsp;snapshot_id | **string**<br>ID of the snapshot that will be used for disk creation. The maximum string length in characters is 50.
preserve_after_instance_delete | **bool**<br>When set to true, disk will not be deleted even after managed instance is deleted. It will be a user's responsibility to delete such disks. 


### NetworkInterfaceSpec {#NetworkInterfaceSpec7}

Field | Description
--- | ---
network_id | **string**<br>ID of the network. 
subnet_ids[] | **string**<br>IDs of the subnets. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec7)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec7)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>IDs of security groups. 


### PrimaryAddressSpec {#PrimaryAddressSpec7}

Field | Description
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec7)**<br>An external IP address configuration. If not specified, then this managed instance will have no external internet access. 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec7)**<br>Internal DNS configuration 
address | **string**<br>Optional. Manual set static internal IP. To set use variables. 


### OneToOneNatSpec {#OneToOneNatSpec7}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>IP version for the public IP address. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li></ul>
address | **string**<br>Manual set static public IP. To set use variables. (optional) 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec7)**<br>External DNS configuration 


### DnsRecordSpec {#DnsRecordSpec7}

Field | Description
--- | ---
fqdn | **string**<br>Required. FQDN (required) 
dns_zone_id | **string**<br>DNS zone id (optional, if not set, private zone used) 
ttl | **int64**<br>DNS record ttl, values in 0-86400 (optional) Acceptable values are 0 to 86400, inclusive.
ptr | **bool**<br>When set to true, also create PTR DNS record (optional) 


### SchedulingPolicy {#SchedulingPolicy7}

Field | Description
--- | ---
preemptible | **bool**<br>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings7}

Field | Description
--- | ---
type | enum **Type**<br>Type of instance network. 


### PlacementPolicy {#PlacementPolicy7}

Field | Description
--- | ---
placement_group_id | **string**<br>Identifier of placement group 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule7)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule7}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action 
values[] | **string**<br>Affinity value or host ID or host group ID 


### AttachedFilesystemSpec {#AttachedFilesystemSpec7}

Field | Description
--- | ---
mode | enum **Mode**<br>Mode of access to the filesystem that should be attached. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access. Default value.</li></ul>
device_name | **string**<br>Name of the device representing the filesystem on the instance. <br>The name should be used for referencing the filesystem from within the instance when it's being mounted, resized etc. <br>If not specified, a random value will be generated. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
filesystem_id | **string**<br>ID of the filesystem that should be attached. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### ScalePolicy {#ScalePolicy7}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale` or `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale7)**<br>[Manual scaling policy](/docs/compute/concepts/instance-groups/scale#fixed-policy) of the instance group. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale7)**<br>[Automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 
test_auto_scale | **[AutoScale](#AutoScale7)**<br>Test spec for [automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 


### AutoScale {#AutoScale7}

Field | Description
--- | ---
min_zone_size | **int64**<br>Lower limit for instance count in each zone. Acceptable values are 0 to 100, inclusive.
max_size | **int64**<br>Upper limit for total instance count (across all zones). 0 means maximum limit = 100. Acceptable values are 0 to 100, inclusive.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time in seconds allotted for averaging metrics. 1 minute by default. Acceptable values are 1m to 10m, inclusive.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected. The maximum value is 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should. Acceptable values are 1m to 30m, inclusive.
initial_size | **int64**<br>Target group size. The minimum value is 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule7)**<br>Defines an autoscaling rule based on the average CPU utilization of the instance group. <br>If more than one rule is specified, e.g. CPU utilization and one or more Monitoring metrics (`custom_rules`), the size of the instance group will be equal to the maximum of sizes calculated according to each metric. 
custom_rules[] | **[CustomRule](#CustomRule7)**<br>Defines an autoscaling rule based on a [custom metric](/docs/monitoring/operations/metric/add) from Monitoring. <br>If more than one rule is specified, e.g. CPU utilization (`cpu_utilization_rule`) and one or more Monitoring metrics, the size of the instance group will be equal to the maximum of sizes calculated according to each metric. The maximum number of elements is 3.
auto_scale_type | enum **AutoScaleType**<br>Autoscaling type. <ul><li>`ZONAL`: Scale each zone independently. This is the default.</li><li>`REGIONAL`: Scale group as a whole.</li></ul>


### CpuUtilizationRule {#CpuUtilizationRule7}

Field | Description
--- | ---
utilization_target | **double**<br>Target CPU utilization level. Instance Groups maintains this level for each availability zone. Acceptable values are 10 to 100, inclusive.


### CustomRule {#CustomRule7}

Field | Description
--- | ---
rule_type | enum **RuleType**<br>Required. Custom metric rule type. This field affects which label from the custom metric should be used: `zone_id` or `instance_id`. <ul><li>`UTILIZATION`: This type means that the metric applies to one instance. First, Instance Groups calculates the average metric value for each instance, then averages the values for instances in one availability zone or in whole group depends on autoscaling type. This type of metric must have the `instance_id` label.</li><li>`WORKLOAD`: This type means that the metric applies to instances in one availability zone or to whole group depends on autoscaling type. This type of metric must have the `zone_id` label if ZONAL autoscaling type is chosen.</li></ul>
metric_type | enum **MetricType**<br>Required. Type of custom metric. This field affects how Instance Groups calculates the average metric value. <ul><li>`GAUGE`: This type is used for metrics that show the metric value at a certain point in time, such as requests per second to the server on an instance. <br>Instance Groups calculates the average metric value for the period specified in the [AutoScale.measurement_duration](#AutoScale7) field.</li><li>`COUNTER`: This type is used for metrics that monotonically increase over time, such as the total number of requests to the server on an instance. <br>Instance Groups calculates the average value increase for the period specified in the [AutoScale.measurement_duration](#AutoScale7) field.</li></ul>
metric_name | **string**<br>Required. Name of custom metric in Monitoring that should be used for scaling. Value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
labels | **map<string,string>**<br>Labels of custom metric in Monitoring that should be used for scaling. Each value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `. Each key must match the regular expression ` ^[a-zA-Z][0-9a-zA-Z_]{0,31}$ `.
target | **double**<br>Target value for the custom metric. Instance Groups maintains this level for each availability zone. Value must be greater than 0.
folder_id | **string**<br>Folder id of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 50.
service | **string**<br>Service of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 200.


### FixedScale {#FixedScale7}

Field | Description
--- | ---
size | **int64**<br>Number of instances in the instance group. Acceptable values are 1 to 100, inclusive.


### DeployPolicy {#DeployPolicy7}

Field | Description
--- | ---
max_unavailable | **int64**<br>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If `max_expansion` is not specified or set to zero, `max_unavailable` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
max_deleting | **int64**<br>The maximum number of instances that can be deleted at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_creating | **int64**<br>The maximum number of instances that can be created at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_expansion | **int64**<br>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If `max_unavailable` is not specified or set to zero, `max_expansion` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Instance startup duration. Instance will be considered up and running (and start receiving traffic) only after startup_duration has elapsed and all health checks are passed. See `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status` for more information. Acceptable values are 0m to 1h, inclusive.
strategy | enum **Strategy**<br>Affects the lifecycle of the instance during deployment. <ul><li>`PROACTIVE`: Instance Groups can forcefully stop a running instance. This is the default.</li><li>`OPPORTUNISTIC`: Instance Groups does not stop a running instance. Instead, it will wait until the instance stops itself or becomes unhealthy.</li></ul>


### AllocationPolicy {#AllocationPolicy7}

Field | Description
--- | ---
zones[] | **[Zone](#Zone7)**<br>List of availability zones. The minimum number of elements is 1.


### Zone {#Zone7}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the instance resides. 


### LoadBalancerState {#LoadBalancerState7}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Network Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


### ManagedInstancesState {#ManagedInstancesState7}

Field | Description
--- | ---
target_size | **int64**<br>Target number of instances for this instance group. 
running_actual_count | **int64**<br>The number of running instances that match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_ACTUAL](#ManagedInstance). 
running_outdated_count | **int64**<br>The number of running instances that does not match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_OUTDATED](#ManagedInstance). 
processing_count | **int64**<br>The number of instances in flight (for example, updating, starting, deleting). For more information, see [ManagedInstance.Status](#ManagedInstance). 


### Statuses {#Statuses7}

Field | Description
--- | ---
creating | **int64**<br>Instance is being created. 
starting | **int64**<br>Instance is being started. 
opening | **int64**<br>Instance is being opened to receive traffic. 
warming | **int64**<br>Instance is being warmed. 
running | **int64**<br>Instance is running normally. 
closing | **int64**<br>Instance is being closed to traffic. 
stopping | **int64**<br>Instance is being stopped. 
updating | **int64**<br>Instance is being updated. 
deleting | **int64**<br>Instance is being deleted. 
failed | **int64**<br>Instance failed and needs to be recreated. 


### LoadBalancerSpec {#LoadBalancerSpec7}

Field | Description
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec7)**<br>Specification of the target group that the instance group will be added to. For more information, see [Target groups and resources](/docs/load-balancer/concepts/target-resources). 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### TargetGroupSpec {#TargetGroupSpec7}

Field | Description
--- | ---
name | **string**<br>Name of the target group. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the target group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec7}

Field | Description
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec7)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). The minimum number of elements is 1.
max_checking_health_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to become healthy. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### HealthCheckSpec {#HealthCheckSpec7}

Field | Description
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. Acceptable values are 1s to 300s, inclusive.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the managed instance to return a response for the health check. The default is 1 second. Acceptable values are 1s to 60s, inclusive.
unhealthy_threshold | **int64**<br>The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` or `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions7)**<br>Configuration options for a TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions7)**<br>Configuration options for an HTTP health check. 


### TcpOptions {#TcpOptions7}

Field | Description
--- | ---
port | **int64**<br>Port to use for TCP health checks. Acceptable values are 1 to 65535, inclusive.


### HttpOptions {#HttpOptions7}

Field | Description
--- | ---
port | **int64**<br>Port to use for HTTP health checks. Acceptable values are 1 to 65535, inclusive.
path | **string**<br>URL path to set for health checking requests. 


### Variable {#Variable7}

Field | Description
--- | ---
key | **string**<br> The string length in characters must be 1-128. Value must match the regular expression ` [a-zA-Z0-9._-]* `.
value | **string**<br> The maximum string length in characters is 128.


### ApplicationLoadBalancerSpec {#ApplicationLoadBalancerSpec7}

Field | Description
--- | ---
target_group_spec | **[ApplicationTargetGroupSpec](#ApplicationTargetGroupSpec7)**<br>Required. Basic properties of the Application Load Balancer target group attributed to the instance group. 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### ApplicationTargetGroupSpec {#ApplicationTargetGroupSpec7}

Field | Description
--- | ---
name | **string**<br>Name of the target group. 
description | **string**<br>Description of the target group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 


### ApplicationLoadBalancerState {#ApplicationLoadBalancerState7}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Application Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


## Delete {#Delete}

Deletes the specified instance group.

**rpc Delete ([DeleteInstanceGroupRequest](#DeleteInstanceGroupRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteInstanceGroupMetadata](#DeleteInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteInstanceGroupRequest {#DeleteInstanceGroupRequest}

Field | Description
--- | ---
instance_group_id | **string**<br>Required. ID of the instance group to delete. To get the instance group ID, use a [InstanceGroupService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation6}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteInstanceGroupMetadata](#DeleteInstanceGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteInstanceGroupMetadata {#DeleteInstanceGroupMetadata}

Field | Description
--- | ---
instance_group_id | **string**<br>ID of the instance group that is being deleted. To get the instance group ID, use a [InstanceGroupService.List](#List) request. 


## ListInstances {#ListInstances}

Lists instances for the specified instance group.

**rpc ListInstances ([ListInstanceGroupInstancesRequest](#ListInstanceGroupInstancesRequest)) returns ([ListInstanceGroupInstancesResponse](#ListInstanceGroupInstancesResponse))**

### ListInstanceGroupInstancesRequest {#ListInstanceGroupInstancesRequest}

Field | Description
--- | ---
instance_group_id | **string**<br>Required. ID of the InstanceGroup resource to list instances for. To get the instance group ID, use a [InstanceGroupService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListInstanceGroupInstancesResponse.next_page_token](#ListInstanceGroupInstancesResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListInstanceGroupInstancesResponse.next_page_token](#ListInstanceGroupInstancesResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. Currently you can use filtering only on the [ManagedInstance.name](#ManagedInstance) field. The maximum string length in characters is 1000.


### ListInstanceGroupInstancesResponse {#ListInstanceGroupInstancesResponse}

Field | Description
--- | ---
instances[] | **[ManagedInstance](#ManagedInstance)**<br>Lists instances for the specified instance group. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is more than [ListInstanceGroupInstancesRequest.page_size](#ListInstanceGroupInstancesRequest), use `next_page_token` as the value for the [ListInstanceGroupInstancesRequest.page_token](#ListInstanceGroupInstancesRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### ManagedInstance {#ManagedInstance}

Field | Description
--- | ---
id | **string**<br>ID of the managed instance. 
status | enum **Status**<br>Status of the managed instance. <ul><li>`CREATING_INSTANCE`: Instance is being created.</li><li>`UPDATING_INSTANCE`: Instance is being updated.</li><li>`DELETING_INSTANCE`: Instance is being deleted.</li><li>`STARTING_INSTANCE`: Instance is being started.</li><li>`STOPPING_INSTANCE`: Instance is being stopped.</li><li>`AWAITING_STARTUP_DURATION`: Instance has been created successfully, but startup duration has not elapsed yet.</li><li>`CHECKING_HEALTH`: Instance has been created successfully and startup duration has elapsed, but health checks have not passed yet and the managed instance is not ready to receive traffic.</li><li>`OPENING_TRAFFIC`: Instance Groups is initiating health checks and routing traffic to the instances.</li><li>`AWAITING_WARMUP_DURATION`: Instance is now receiving traffic, but warmup duration has not elapsed yet.</li><li>`CLOSING_TRAFFIC`: Instance Groups has initiated the process of stopping routing traffic to the instances.</li><li>`RUNNING_ACTUAL`: Instance is running normally and its attributes match the current InstanceTemplate.</li><li>`RUNNING_OUTDATED`: Instance is running normally, but its attributes do not match the current InstanceTemplate. It will be updated, recreated or deleted shortly.</li><li>`STOPPED`: Instance was stopped.</li><li>`DELETED`: Instance was deleted.</li><li>`PREPARING_RESOURCES`: Instance Groups is preparing dependent resources.</li></ul>
instance_id | **string**<br>ID of the instance. 
fqdn | **string**<br>Fully Qualified Domain Name. 
name | **string**<br>The name of the managed instance. 
status_message | **string**<br>Status message for the managed instance. 
zone_id | **string**<br>ID of the availability zone where the instance resides. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface)**<br>Array of network interfaces that are attached to the managed instance. 
status_changed_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format when the status of the managed instance was last changed. 


### NetworkInterface {#NetworkInterface}

Field | Description
--- | ---
index | **string**<br>The index of the network interface, generated by the server, 0,1,2... etc. Currently only one network interface is supported per instance. 
mac_address | **string**<br>MAC address that is assigned to the network interface. 
subnet_id | **string**<br>ID of the subnet. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 is not available yet. 


### PrimaryAddress {#PrimaryAddress}

Field | Description
--- | ---
address | **string**<br>An IPv4 internal network address that is assigned to the managed instance for this network interface. If not specified by the user, an unused internal IP is assigned by the system. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat)**<br>One-to-one NAT configuration. If missing, NAT has not been set up. 
dns_records[] | **[DnsRecord](#DnsRecord)**<br>Internal DNS configuration. 


### OneToOneNat {#OneToOneNat}

Field | Description
--- | ---
address | **string**<br>An IPv4 external network address that is assigned to the managed instance for this network interface. 
ip_version | enum **IpVersion**<br>External IP address version. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li></ul>
dns_records[] | **[DnsRecord](#DnsRecord)**<br>External DNS configuration. 


### DnsRecord {#DnsRecord}

Field | Description
--- | ---
fqdn | **string**<br>Required. Name of the A/AAAA record as specified when creating the instance. Note that if `fqdn' has no trailing '.', it is specified relative to the zone (@see dns_zone_id). 
dns_zone_id | **string**<br>DNS zone id (optional, if not set, some private zone is used). 
ttl | **int64**<br>DNS record ttl (optional, if 0, a reasonable default is used). Acceptable values are 0 to 86400, inclusive.
ptr | **bool**<br>When true, indicates there is a corresponding auto-created PTR DNS record. 


## DeleteInstances {#DeleteInstances}

Delete instances from the instance group.

**rpc DeleteInstances ([DeleteInstancesRequest](#DeleteInstancesRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteInstancesMetadata](#DeleteInstancesMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](#InstanceGroup8)<br>

### DeleteInstancesRequest {#DeleteInstancesRequest}

Field | Description
--- | ---
instance_group_id | **string**<br>Required. ID of the instance group that the instances are being deleted from. To get the ID of the instance group, use the [InstanceGroupService.List](#List) request. The maximum string length in characters is 50.
managed_instance_ids[] | **string**<br>IDs of the instances to delete. Instances will be deleted along with all dependent resources. Only IDs from the ManagedInstance.id field are allowed, not ManagedInstance.instance_id. The minimum number of elements is 1. The maximum string length in characters for each value is 50.
create_another | **bool**<br>If set to true, the target size of instance group will not be reduced and a new instance will be created instead of the deleted one. By default, the target size of instance group will be reduced by the specified number of instance IDs. 


### Operation {#Operation7}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteInstancesMetadata](#DeleteInstancesMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](#InstanceGroup8)>**<br>if operation finished successfully. 


### DeleteInstancesMetadata {#DeleteInstancesMetadata}

Field | Description
--- | ---
instance_group_id | **string**<br>ID of the instance group that the instances are being deleted from. 


### InstanceGroup {#InstanceGroup8}

Field | Description
--- | ---
id | **string**<br>ID of the instance group. 
folder_id | **string**<br>ID of the folder that the instance group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the instance group. The name is unique within the folder. 
description | **string**<br>Description of the instance group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
instance_template | **[InstanceTemplate](#InstanceTemplate8)**<br>Instance template for creating the instance group. For more information, see [Instance Templates](/docs/compute/concepts/instance-groups/instance-template). 
scale_policy | **[ScalePolicy](#ScalePolicy8)**<br>[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. 
deploy_policy | **[DeployPolicy](#DeployPolicy8)**<br>Deployment policy of the instance group. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy8)**<br>Allocation policy of the instance group by zones and regions. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState8)**<br>Status of the Network Load Balancer target group attributed to the instance group. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState8)**<br>States of instances for this instance group. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec8)**<br>Settings for balancing load between instances via [Network Load Balancer](/docs/network-load-balancer/concepts) (OSI model layer 3). 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec8)**<br>Health checking specification. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. 
status | enum **Status**<br>Status of the instance group. <ul><li>`STARTING`: Instance group is being started and will become active soon.</li><li>`ACTIVE`: Instance group is active. In this state the group manages its instances and monitors their health, creating, deleting, stopping, updating and starting instances as needed. <br>To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/api-ref/grpc/instance_group_service#Stop). To pause the processes in the instance group, i.e. scaling, checking instances' health, auto-healing and updating them, without stopping the instances, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.PauseProcesses](/docs/compute/api-ref/grpc/instance_group_service#PauseProcesses).</li><li>`STOPPING`: Instance group is being stopped. Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.</li><li>`STOPPED`: Instance group is stopped. In this state the group cannot be updated and does not react to any changes made to its instances. To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/api-ref/grpc/instance_group_service#Start).</li><li>`DELETING`: Instance group is being deleted.</li><li>`PAUSED`: Instance group is paused. In this state all the processes regarding the group management, i.e. scaling, checking instances' health, auto-healing and updating them, are paused. The instances that were running prior to pausing the group, however, may still be running. <br>To resume the processes in the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.ResumeProcesses](/docs/compute/api-ref/grpc/instance_group_service#ResumeProcesses). The group status will change to `ACTIVE`.</li></ul>
variables[] | **[Variable](#Variable8)**<br> 
deletion_protection | **bool**<br>Flag prohibiting deletion of the instance group. <br>Allowed values:</br>- `false`: The instance group can be deleted.</br>- `true`: The instance group cannot be deleted. <br>The default is `false`. 
application_load_balancer_spec | **[ApplicationLoadBalancerSpec](#ApplicationLoadBalancerSpec8)**<br>Settings for balancing load between instances via [Application Load Balancer](/docs/application-load-balancer/concepts) (OSI model layer 7). 
application_load_balancer_state | **[ApplicationLoadBalancerState](#ApplicationLoadBalancerState8)**<br>Status of the Application Load Balancer target group attributed to the instance group. <br>Returned if there is a working load balancer that the target group is connected to. 


### InstanceTemplate {#InstanceTemplate8}

Field | Description
--- | ---
description | **string**<br>Description of the instance template. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
platform_id | **string**<br>Required. ID of the hardware platform configuration for the instance. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see [Platforms](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec8)**<br>Required. Computing resources of the instance such as the amount of memory and number of cores. 
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>Metadata values may contain one of the supported placeholders: {instance_group.id} {instance.short_id} {instance.index} {instance.index_in_zone} {instance.zone_id} InstanceGroup and Instance labels may be copied to metadata following way: {instance_group.labels.some_label_key} {instance.labels.another_label_key} These placeholders will be substituted for each created instance anywhere in the value text. In the rare case the value requires to contain this placeholder explicitly, it must be escaped with double brackets, in example {instance.index}. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). No more than 128 per resource. The maximum string length in characters for each value is 262144. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec8)**<br>Required. Boot disk specification that will be attached to the instance. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec8)**<br>Array of secondary disks that will be attached to the instance. The maximum number of elements is 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec8)**<br>Array of network interfaces that will be attached to the instance. The number of elemets must be exactly 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy8)**<br>Scheduling policy for the instance. 
service_account_id | **string**<br>Service account ID for the instance. 
network_settings | **[NetworkSettings](#NetworkSettings8)**<br>Network settings for the instance. 
name | **string**<br>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
hostname | **string**<br>Host name for the instance. This field is used to generate the `yandex.cloud.compute.v1.Instance.fqdn` value. The host name must be unique within the network and region. If not specified, the host name will be equal to `yandex.cloud.compute.v1.Instance.id` of the instance and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`. <br>In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, `name` value will be used It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
placement_policy | **[PlacementPolicy](#PlacementPolicy8)**<br>Placement Group 
filesystem_specs[] | **[AttachedFilesystemSpec](#AttachedFilesystemSpec8)**<br>Array of filesystems to attach to the instance. <br>The filesystems must reside in the same availability zone as the instance. <br>To use the instance with an attached filesystem, the latter must be mounted. For details, see [documentation](/docs/compute/operations/filesystem/attach-to-vm). 


### ResourcesSpec {#ResourcesSpec8}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. The maximum value is 824633720832.
cores | **int64**<br>The number of cores available to the instance. Value must be equal to 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64,68,72,76,80.
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. Value must be equal to 0,5,20,50,100.
gpus | **int64**<br>The number of GPUs available to the instance. Value must be equal to 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec8}

Field | Description
--- | ---
mode | enum **Mode**<br>Required. Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li></ul>
device_name | **string**<br>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec8)**<br>Required. oneof disk_spec or disk_id Disk specification that is attached to the instance. For more information, see [Disks](/docs/compute/concepts/disk). 
disk_id | **string**<br>Set to use an existing disk. To set use variables. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### DiskSpec {#DiskSpec8}

Field | Description
--- | ---
description | **string**<br>Description of the disk. The maximum string length in characters is 256.
type_id | **string**<br>Required. ID of the disk type. 
size | **int64**<br>Size of the disk, specified in bytes. Acceptable values are 4194304 to 28587302322176, inclusive.
source_oneof | **oneof:** `image_id` or `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>ID of the image that will be used for disk creation. The maximum string length in characters is 50.
&nbsp;&nbsp;snapshot_id | **string**<br>ID of the snapshot that will be used for disk creation. The maximum string length in characters is 50.
preserve_after_instance_delete | **bool**<br>When set to true, disk will not be deleted even after managed instance is deleted. It will be a user's responsibility to delete such disks. 


### NetworkInterfaceSpec {#NetworkInterfaceSpec8}

Field | Description
--- | ---
network_id | **string**<br>ID of the network. 
subnet_ids[] | **string**<br>IDs of the subnets. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec8)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec8)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>IDs of security groups. 


### PrimaryAddressSpec {#PrimaryAddressSpec8}

Field | Description
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec8)**<br>An external IP address configuration. If not specified, then this managed instance will have no external internet access. 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec8)**<br>Internal DNS configuration 
address | **string**<br>Optional. Manual set static internal IP. To set use variables. 


### OneToOneNatSpec {#OneToOneNatSpec8}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>IP version for the public IP address. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li></ul>
address | **string**<br>Manual set static public IP. To set use variables. (optional) 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec8)**<br>External DNS configuration 


### DnsRecordSpec {#DnsRecordSpec8}

Field | Description
--- | ---
fqdn | **string**<br>Required. FQDN (required) 
dns_zone_id | **string**<br>DNS zone id (optional, if not set, private zone used) 
ttl | **int64**<br>DNS record ttl, values in 0-86400 (optional) Acceptable values are 0 to 86400, inclusive.
ptr | **bool**<br>When set to true, also create PTR DNS record (optional) 


### SchedulingPolicy {#SchedulingPolicy8}

Field | Description
--- | ---
preemptible | **bool**<br>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings8}

Field | Description
--- | ---
type | enum **Type**<br>Type of instance network. 


### PlacementPolicy {#PlacementPolicy8}

Field | Description
--- | ---
placement_group_id | **string**<br>Identifier of placement group 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule8)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule8}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action 
values[] | **string**<br>Affinity value or host ID or host group ID 


### AttachedFilesystemSpec {#AttachedFilesystemSpec8}

Field | Description
--- | ---
mode | enum **Mode**<br>Mode of access to the filesystem that should be attached. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access. Default value.</li></ul>
device_name | **string**<br>Name of the device representing the filesystem on the instance. <br>The name should be used for referencing the filesystem from within the instance when it's being mounted, resized etc. <br>If not specified, a random value will be generated. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
filesystem_id | **string**<br>ID of the filesystem that should be attached. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### ScalePolicy {#ScalePolicy8}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale` or `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale8)**<br>[Manual scaling policy](/docs/compute/concepts/instance-groups/scale#fixed-policy) of the instance group. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale8)**<br>[Automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 
test_auto_scale | **[AutoScale](#AutoScale8)**<br>Test spec for [automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 


### AutoScale {#AutoScale8}

Field | Description
--- | ---
min_zone_size | **int64**<br>Lower limit for instance count in each zone. Acceptable values are 0 to 100, inclusive.
max_size | **int64**<br>Upper limit for total instance count (across all zones). 0 means maximum limit = 100. Acceptable values are 0 to 100, inclusive.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time in seconds allotted for averaging metrics. 1 minute by default. Acceptable values are 1m to 10m, inclusive.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected. The maximum value is 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should. Acceptable values are 1m to 30m, inclusive.
initial_size | **int64**<br>Target group size. The minimum value is 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule8)**<br>Defines an autoscaling rule based on the average CPU utilization of the instance group. <br>If more than one rule is specified, e.g. CPU utilization and one or more Monitoring metrics (`custom_rules`), the size of the instance group will be equal to the maximum of sizes calculated according to each metric. 
custom_rules[] | **[CustomRule](#CustomRule8)**<br>Defines an autoscaling rule based on a [custom metric](/docs/monitoring/operations/metric/add) from Monitoring. <br>If more than one rule is specified, e.g. CPU utilization (`cpu_utilization_rule`) and one or more Monitoring metrics, the size of the instance group will be equal to the maximum of sizes calculated according to each metric. The maximum number of elements is 3.
auto_scale_type | enum **AutoScaleType**<br>Autoscaling type. <ul><li>`ZONAL`: Scale each zone independently. This is the default.</li><li>`REGIONAL`: Scale group as a whole.</li></ul>


### CpuUtilizationRule {#CpuUtilizationRule8}

Field | Description
--- | ---
utilization_target | **double**<br>Target CPU utilization level. Instance Groups maintains this level for each availability zone. Acceptable values are 10 to 100, inclusive.


### CustomRule {#CustomRule8}

Field | Description
--- | ---
rule_type | enum **RuleType**<br>Required. Custom metric rule type. This field affects which label from the custom metric should be used: `zone_id` or `instance_id`. <ul><li>`UTILIZATION`: This type means that the metric applies to one instance. First, Instance Groups calculates the average metric value for each instance, then averages the values for instances in one availability zone or in whole group depends on autoscaling type. This type of metric must have the `instance_id` label.</li><li>`WORKLOAD`: This type means that the metric applies to instances in one availability zone or to whole group depends on autoscaling type. This type of metric must have the `zone_id` label if ZONAL autoscaling type is chosen.</li></ul>
metric_type | enum **MetricType**<br>Required. Type of custom metric. This field affects how Instance Groups calculates the average metric value. <ul><li>`GAUGE`: This type is used for metrics that show the metric value at a certain point in time, such as requests per second to the server on an instance. <br>Instance Groups calculates the average metric value for the period specified in the [AutoScale.measurement_duration](#AutoScale8) field.</li><li>`COUNTER`: This type is used for metrics that monotonically increase over time, such as the total number of requests to the server on an instance. <br>Instance Groups calculates the average value increase for the period specified in the [AutoScale.measurement_duration](#AutoScale8) field.</li></ul>
metric_name | **string**<br>Required. Name of custom metric in Monitoring that should be used for scaling. Value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
labels | **map<string,string>**<br>Labels of custom metric in Monitoring that should be used for scaling. Each value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `. Each key must match the regular expression ` ^[a-zA-Z][0-9a-zA-Z_]{0,31}$ `.
target | **double**<br>Target value for the custom metric. Instance Groups maintains this level for each availability zone. Value must be greater than 0.
folder_id | **string**<br>Folder id of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 50.
service | **string**<br>Service of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 200.


### FixedScale {#FixedScale8}

Field | Description
--- | ---
size | **int64**<br>Number of instances in the instance group. Acceptable values are 1 to 100, inclusive.


### DeployPolicy {#DeployPolicy8}

Field | Description
--- | ---
max_unavailable | **int64**<br>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If `max_expansion` is not specified or set to zero, `max_unavailable` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
max_deleting | **int64**<br>The maximum number of instances that can be deleted at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_creating | **int64**<br>The maximum number of instances that can be created at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_expansion | **int64**<br>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If `max_unavailable` is not specified or set to zero, `max_expansion` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Instance startup duration. Instance will be considered up and running (and start receiving traffic) only after startup_duration has elapsed and all health checks are passed. See `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status` for more information. Acceptable values are 0m to 1h, inclusive.
strategy | enum **Strategy**<br>Affects the lifecycle of the instance during deployment. <ul><li>`PROACTIVE`: Instance Groups can forcefully stop a running instance. This is the default.</li><li>`OPPORTUNISTIC`: Instance Groups does not stop a running instance. Instead, it will wait until the instance stops itself or becomes unhealthy.</li></ul>


### AllocationPolicy {#AllocationPolicy8}

Field | Description
--- | ---
zones[] | **[Zone](#Zone8)**<br>List of availability zones. The minimum number of elements is 1.


### Zone {#Zone8}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the instance resides. 


### LoadBalancerState {#LoadBalancerState8}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Network Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


### ManagedInstancesState {#ManagedInstancesState8}

Field | Description
--- | ---
target_size | **int64**<br>Target number of instances for this instance group. 
running_actual_count | **int64**<br>The number of running instances that match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_ACTUAL](#ManagedInstance1). 
running_outdated_count | **int64**<br>The number of running instances that does not match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_OUTDATED](#ManagedInstance1). 
processing_count | **int64**<br>The number of instances in flight (for example, updating, starting, deleting). For more information, see [ManagedInstance.Status](#ManagedInstance1). 


### Statuses {#Statuses8}

Field | Description
--- | ---
creating | **int64**<br>Instance is being created. 
starting | **int64**<br>Instance is being started. 
opening | **int64**<br>Instance is being opened to receive traffic. 
warming | **int64**<br>Instance is being warmed. 
running | **int64**<br>Instance is running normally. 
closing | **int64**<br>Instance is being closed to traffic. 
stopping | **int64**<br>Instance is being stopped. 
updating | **int64**<br>Instance is being updated. 
deleting | **int64**<br>Instance is being deleted. 
failed | **int64**<br>Instance failed and needs to be recreated. 


### LoadBalancerSpec {#LoadBalancerSpec8}

Field | Description
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec8)**<br>Specification of the target group that the instance group will be added to. For more information, see [Target groups and resources](/docs/load-balancer/concepts/target-resources). 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### TargetGroupSpec {#TargetGroupSpec8}

Field | Description
--- | ---
name | **string**<br>Name of the target group. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the target group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec8}

Field | Description
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec8)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). The minimum number of elements is 1.
max_checking_health_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to become healthy. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### HealthCheckSpec {#HealthCheckSpec8}

Field | Description
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. Acceptable values are 1s to 300s, inclusive.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the managed instance to return a response for the health check. The default is 1 second. Acceptable values are 1s to 60s, inclusive.
unhealthy_threshold | **int64**<br>The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` or `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions8)**<br>Configuration options for a TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions8)**<br>Configuration options for an HTTP health check. 


### TcpOptions {#TcpOptions8}

Field | Description
--- | ---
port | **int64**<br>Port to use for TCP health checks. Acceptable values are 1 to 65535, inclusive.


### HttpOptions {#HttpOptions8}

Field | Description
--- | ---
port | **int64**<br>Port to use for HTTP health checks. Acceptable values are 1 to 65535, inclusive.
path | **string**<br>URL path to set for health checking requests. 


### Variable {#Variable8}

Field | Description
--- | ---
key | **string**<br> The string length in characters must be 1-128. Value must match the regular expression ` [a-zA-Z0-9._-]* `.
value | **string**<br> The maximum string length in characters is 128.


### ApplicationLoadBalancerSpec {#ApplicationLoadBalancerSpec8}

Field | Description
--- | ---
target_group_spec | **[ApplicationTargetGroupSpec](#ApplicationTargetGroupSpec8)**<br>Required. Basic properties of the Application Load Balancer target group attributed to the instance group. 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### ApplicationTargetGroupSpec {#ApplicationTargetGroupSpec8}

Field | Description
--- | ---
name | **string**<br>Name of the target group. 
description | **string**<br>Description of the target group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 


### ApplicationLoadBalancerState {#ApplicationLoadBalancerState8}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Application Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


## StopInstances {#StopInstances}

Stop instances from the instance group.

**rpc StopInstances ([StopInstancesRequest](#StopInstancesRequest)) returns ([operation.Operation](#Operation8))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopInstancesMetadata](#StopInstancesMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](#InstanceGroup9)<br>

### StopInstancesRequest {#StopInstancesRequest}

Field | Description
--- | ---
instance_group_id | **string**<br>Required. ID of the instance group that the instances are being stopped from. To get the ID of the instance group, use the [InstanceGroupService.List](#List) request. The maximum string length in characters is 50.
managed_instance_ids[] | **string**<br>IDs of the instances to stop. After stopping, the instance can be updated, started, or deleted according to scale and deploy policies. Only IDs from the ManagedInstance.id field are allowed, not ManagedInstance.instance_id. The minimum number of elements is 1. The maximum string length in characters for each value is 50.


### Operation {#Operation8}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StopInstancesMetadata](#StopInstancesMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](#InstanceGroup9)>**<br>if operation finished successfully. 


### StopInstancesMetadata {#StopInstancesMetadata}

Field | Description
--- | ---
instance_group_id | **string**<br>ID of the instance group that the instances are being stopped from. 


### InstanceGroup {#InstanceGroup9}

Field | Description
--- | ---
id | **string**<br>ID of the instance group. 
folder_id | **string**<br>ID of the folder that the instance group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the instance group. The name is unique within the folder. 
description | **string**<br>Description of the instance group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
instance_template | **[InstanceTemplate](#InstanceTemplate9)**<br>Instance template for creating the instance group. For more information, see [Instance Templates](/docs/compute/concepts/instance-groups/instance-template). 
scale_policy | **[ScalePolicy](#ScalePolicy9)**<br>[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. 
deploy_policy | **[DeployPolicy](#DeployPolicy9)**<br>Deployment policy of the instance group. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy9)**<br>Allocation policy of the instance group by zones and regions. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState9)**<br>Status of the Network Load Balancer target group attributed to the instance group. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState9)**<br>States of instances for this instance group. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec9)**<br>Settings for balancing load between instances via [Network Load Balancer](/docs/network-load-balancer/concepts) (OSI model layer 3). 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec9)**<br>Health checking specification. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. 
status | enum **Status**<br>Status of the instance group. <ul><li>`STARTING`: Instance group is being started and will become active soon.</li><li>`ACTIVE`: Instance group is active. In this state the group manages its instances and monitors their health, creating, deleting, stopping, updating and starting instances as needed. <br>To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/api-ref/grpc/instance_group_service#Stop). To pause the processes in the instance group, i.e. scaling, checking instances' health, auto-healing and updating them, without stopping the instances, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.PauseProcesses](/docs/compute/api-ref/grpc/instance_group_service#PauseProcesses).</li><li>`STOPPING`: Instance group is being stopped. Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.</li><li>`STOPPED`: Instance group is stopped. In this state the group cannot be updated and does not react to any changes made to its instances. To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/api-ref/grpc/instance_group_service#Start).</li><li>`DELETING`: Instance group is being deleted.</li><li>`PAUSED`: Instance group is paused. In this state all the processes regarding the group management, i.e. scaling, checking instances' health, auto-healing and updating them, are paused. The instances that were running prior to pausing the group, however, may still be running. <br>To resume the processes in the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.ResumeProcesses](/docs/compute/api-ref/grpc/instance_group_service#ResumeProcesses). The group status will change to `ACTIVE`.</li></ul>
variables[] | **[Variable](#Variable9)**<br> 
deletion_protection | **bool**<br>Flag prohibiting deletion of the instance group. <br>Allowed values:</br>- `false`: The instance group can be deleted.</br>- `true`: The instance group cannot be deleted. <br>The default is `false`. 
application_load_balancer_spec | **[ApplicationLoadBalancerSpec](#ApplicationLoadBalancerSpec9)**<br>Settings for balancing load between instances via [Application Load Balancer](/docs/application-load-balancer/concepts) (OSI model layer 7). 
application_load_balancer_state | **[ApplicationLoadBalancerState](#ApplicationLoadBalancerState9)**<br>Status of the Application Load Balancer target group attributed to the instance group. <br>Returned if there is a working load balancer that the target group is connected to. 


### InstanceTemplate {#InstanceTemplate9}

Field | Description
--- | ---
description | **string**<br>Description of the instance template. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
platform_id | **string**<br>Required. ID of the hardware platform configuration for the instance. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see [Platforms](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec9)**<br>Required. Computing resources of the instance such as the amount of memory and number of cores. 
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>Metadata values may contain one of the supported placeholders: {instance_group.id} {instance.short_id} {instance.index} {instance.index_in_zone} {instance.zone_id} InstanceGroup and Instance labels may be copied to metadata following way: {instance_group.labels.some_label_key} {instance.labels.another_label_key} These placeholders will be substituted for each created instance anywhere in the value text. In the rare case the value requires to contain this placeholder explicitly, it must be escaped with double brackets, in example {instance.index}. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). No more than 128 per resource. The maximum string length in characters for each value is 262144. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec9)**<br>Required. Boot disk specification that will be attached to the instance. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec9)**<br>Array of secondary disks that will be attached to the instance. The maximum number of elements is 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec9)**<br>Array of network interfaces that will be attached to the instance. The number of elemets must be exactly 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy9)**<br>Scheduling policy for the instance. 
service_account_id | **string**<br>Service account ID for the instance. 
network_settings | **[NetworkSettings](#NetworkSettings9)**<br>Network settings for the instance. 
name | **string**<br>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
hostname | **string**<br>Host name for the instance. This field is used to generate the `yandex.cloud.compute.v1.Instance.fqdn` value. The host name must be unique within the network and region. If not specified, the host name will be equal to `yandex.cloud.compute.v1.Instance.id` of the instance and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`. <br>In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, `name` value will be used It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
placement_policy | **[PlacementPolicy](#PlacementPolicy9)**<br>Placement Group 
filesystem_specs[] | **[AttachedFilesystemSpec](#AttachedFilesystemSpec9)**<br>Array of filesystems to attach to the instance. <br>The filesystems must reside in the same availability zone as the instance. <br>To use the instance with an attached filesystem, the latter must be mounted. For details, see [documentation](/docs/compute/operations/filesystem/attach-to-vm). 


### ResourcesSpec {#ResourcesSpec9}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. The maximum value is 824633720832.
cores | **int64**<br>The number of cores available to the instance. Value must be equal to 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64,68,72,76,80.
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. Value must be equal to 0,5,20,50,100.
gpus | **int64**<br>The number of GPUs available to the instance. Value must be equal to 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec9}

Field | Description
--- | ---
mode | enum **Mode**<br>Required. Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li></ul>
device_name | **string**<br>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec9)**<br>Required. oneof disk_spec or disk_id Disk specification that is attached to the instance. For more information, see [Disks](/docs/compute/concepts/disk). 
disk_id | **string**<br>Set to use an existing disk. To set use variables. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### DiskSpec {#DiskSpec9}

Field | Description
--- | ---
description | **string**<br>Description of the disk. The maximum string length in characters is 256.
type_id | **string**<br>Required. ID of the disk type. 
size | **int64**<br>Size of the disk, specified in bytes. Acceptable values are 4194304 to 28587302322176, inclusive.
source_oneof | **oneof:** `image_id` or `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>ID of the image that will be used for disk creation. The maximum string length in characters is 50.
&nbsp;&nbsp;snapshot_id | **string**<br>ID of the snapshot that will be used for disk creation. The maximum string length in characters is 50.
preserve_after_instance_delete | **bool**<br>When set to true, disk will not be deleted even after managed instance is deleted. It will be a user's responsibility to delete such disks. 


### NetworkInterfaceSpec {#NetworkInterfaceSpec9}

Field | Description
--- | ---
network_id | **string**<br>ID of the network. 
subnet_ids[] | **string**<br>IDs of the subnets. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec9)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec9)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>IDs of security groups. 


### PrimaryAddressSpec {#PrimaryAddressSpec9}

Field | Description
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec9)**<br>An external IP address configuration. If not specified, then this managed instance will have no external internet access. 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec9)**<br>Internal DNS configuration 
address | **string**<br>Optional. Manual set static internal IP. To set use variables. 


### OneToOneNatSpec {#OneToOneNatSpec9}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>IP version for the public IP address. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li></ul>
address | **string**<br>Manual set static public IP. To set use variables. (optional) 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec9)**<br>External DNS configuration 


### DnsRecordSpec {#DnsRecordSpec9}

Field | Description
--- | ---
fqdn | **string**<br>Required. FQDN (required) 
dns_zone_id | **string**<br>DNS zone id (optional, if not set, private zone used) 
ttl | **int64**<br>DNS record ttl, values in 0-86400 (optional) Acceptable values are 0 to 86400, inclusive.
ptr | **bool**<br>When set to true, also create PTR DNS record (optional) 


### SchedulingPolicy {#SchedulingPolicy9}

Field | Description
--- | ---
preemptible | **bool**<br>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings9}

Field | Description
--- | ---
type | enum **Type**<br>Type of instance network. 


### PlacementPolicy {#PlacementPolicy9}

Field | Description
--- | ---
placement_group_id | **string**<br>Identifier of placement group 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule9)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule9}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action 
values[] | **string**<br>Affinity value or host ID or host group ID 


### AttachedFilesystemSpec {#AttachedFilesystemSpec9}

Field | Description
--- | ---
mode | enum **Mode**<br>Mode of access to the filesystem that should be attached. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access. Default value.</li></ul>
device_name | **string**<br>Name of the device representing the filesystem on the instance. <br>The name should be used for referencing the filesystem from within the instance when it's being mounted, resized etc. <br>If not specified, a random value will be generated. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
filesystem_id | **string**<br>ID of the filesystem that should be attached. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### ScalePolicy {#ScalePolicy9}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale` or `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale9)**<br>[Manual scaling policy](/docs/compute/concepts/instance-groups/scale#fixed-policy) of the instance group. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale9)**<br>[Automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 
test_auto_scale | **[AutoScale](#AutoScale9)**<br>Test spec for [automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 


### AutoScale {#AutoScale9}

Field | Description
--- | ---
min_zone_size | **int64**<br>Lower limit for instance count in each zone. Acceptable values are 0 to 100, inclusive.
max_size | **int64**<br>Upper limit for total instance count (across all zones). 0 means maximum limit = 100. Acceptable values are 0 to 100, inclusive.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time in seconds allotted for averaging metrics. 1 minute by default. Acceptable values are 1m to 10m, inclusive.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected. The maximum value is 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should. Acceptable values are 1m to 30m, inclusive.
initial_size | **int64**<br>Target group size. The minimum value is 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule9)**<br>Defines an autoscaling rule based on the average CPU utilization of the instance group. <br>If more than one rule is specified, e.g. CPU utilization and one or more Monitoring metrics (`custom_rules`), the size of the instance group will be equal to the maximum of sizes calculated according to each metric. 
custom_rules[] | **[CustomRule](#CustomRule9)**<br>Defines an autoscaling rule based on a [custom metric](/docs/monitoring/operations/metric/add) from Monitoring. <br>If more than one rule is specified, e.g. CPU utilization (`cpu_utilization_rule`) and one or more Monitoring metrics, the size of the instance group will be equal to the maximum of sizes calculated according to each metric. The maximum number of elements is 3.
auto_scale_type | enum **AutoScaleType**<br>Autoscaling type. <ul><li>`ZONAL`: Scale each zone independently. This is the default.</li><li>`REGIONAL`: Scale group as a whole.</li></ul>


### CpuUtilizationRule {#CpuUtilizationRule9}

Field | Description
--- | ---
utilization_target | **double**<br>Target CPU utilization level. Instance Groups maintains this level for each availability zone. Acceptable values are 10 to 100, inclusive.


### CustomRule {#CustomRule9}

Field | Description
--- | ---
rule_type | enum **RuleType**<br>Required. Custom metric rule type. This field affects which label from the custom metric should be used: `zone_id` or `instance_id`. <ul><li>`UTILIZATION`: This type means that the metric applies to one instance. First, Instance Groups calculates the average metric value for each instance, then averages the values for instances in one availability zone or in whole group depends on autoscaling type. This type of metric must have the `instance_id` label.</li><li>`WORKLOAD`: This type means that the metric applies to instances in one availability zone or to whole group depends on autoscaling type. This type of metric must have the `zone_id` label if ZONAL autoscaling type is chosen.</li></ul>
metric_type | enum **MetricType**<br>Required. Type of custom metric. This field affects how Instance Groups calculates the average metric value. <ul><li>`GAUGE`: This type is used for metrics that show the metric value at a certain point in time, such as requests per second to the server on an instance. <br>Instance Groups calculates the average metric value for the period specified in the [AutoScale.measurement_duration](#AutoScale9) field.</li><li>`COUNTER`: This type is used for metrics that monotonically increase over time, such as the total number of requests to the server on an instance. <br>Instance Groups calculates the average value increase for the period specified in the [AutoScale.measurement_duration](#AutoScale9) field.</li></ul>
metric_name | **string**<br>Required. Name of custom metric in Monitoring that should be used for scaling. Value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
labels | **map<string,string>**<br>Labels of custom metric in Monitoring that should be used for scaling. Each value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `. Each key must match the regular expression ` ^[a-zA-Z][0-9a-zA-Z_]{0,31}$ `.
target | **double**<br>Target value for the custom metric. Instance Groups maintains this level for each availability zone. Value must be greater than 0.
folder_id | **string**<br>Folder id of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 50.
service | **string**<br>Service of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 200.


### FixedScale {#FixedScale9}

Field | Description
--- | ---
size | **int64**<br>Number of instances in the instance group. Acceptable values are 1 to 100, inclusive.


### DeployPolicy {#DeployPolicy9}

Field | Description
--- | ---
max_unavailable | **int64**<br>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If `max_expansion` is not specified or set to zero, `max_unavailable` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
max_deleting | **int64**<br>The maximum number of instances that can be deleted at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_creating | **int64**<br>The maximum number of instances that can be created at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_expansion | **int64**<br>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If `max_unavailable` is not specified or set to zero, `max_expansion` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Instance startup duration. Instance will be considered up and running (and start receiving traffic) only after startup_duration has elapsed and all health checks are passed. See `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status` for more information. Acceptable values are 0m to 1h, inclusive.
strategy | enum **Strategy**<br>Affects the lifecycle of the instance during deployment. <ul><li>`PROACTIVE`: Instance Groups can forcefully stop a running instance. This is the default.</li><li>`OPPORTUNISTIC`: Instance Groups does not stop a running instance. Instead, it will wait until the instance stops itself or becomes unhealthy.</li></ul>


### AllocationPolicy {#AllocationPolicy9}

Field | Description
--- | ---
zones[] | **[Zone](#Zone9)**<br>List of availability zones. The minimum number of elements is 1.


### Zone {#Zone9}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the instance resides. 


### LoadBalancerState {#LoadBalancerState9}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Network Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


### ManagedInstancesState {#ManagedInstancesState9}

Field | Description
--- | ---
target_size | **int64**<br>Target number of instances for this instance group. 
running_actual_count | **int64**<br>The number of running instances that match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_ACTUAL](#ManagedInstance1). 
running_outdated_count | **int64**<br>The number of running instances that does not match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_OUTDATED](#ManagedInstance1). 
processing_count | **int64**<br>The number of instances in flight (for example, updating, starting, deleting). For more information, see [ManagedInstance.Status](#ManagedInstance1). 


### Statuses {#Statuses9}

Field | Description
--- | ---
creating | **int64**<br>Instance is being created. 
starting | **int64**<br>Instance is being started. 
opening | **int64**<br>Instance is being opened to receive traffic. 
warming | **int64**<br>Instance is being warmed. 
running | **int64**<br>Instance is running normally. 
closing | **int64**<br>Instance is being closed to traffic. 
stopping | **int64**<br>Instance is being stopped. 
updating | **int64**<br>Instance is being updated. 
deleting | **int64**<br>Instance is being deleted. 
failed | **int64**<br>Instance failed and needs to be recreated. 


### LoadBalancerSpec {#LoadBalancerSpec9}

Field | Description
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec9)**<br>Specification of the target group that the instance group will be added to. For more information, see [Target groups and resources](/docs/load-balancer/concepts/target-resources). 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### TargetGroupSpec {#TargetGroupSpec9}

Field | Description
--- | ---
name | **string**<br>Name of the target group. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the target group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec9}

Field | Description
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec9)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). The minimum number of elements is 1.
max_checking_health_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to become healthy. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### HealthCheckSpec {#HealthCheckSpec9}

Field | Description
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. Acceptable values are 1s to 300s, inclusive.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the managed instance to return a response for the health check. The default is 1 second. Acceptable values are 1s to 60s, inclusive.
unhealthy_threshold | **int64**<br>The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` or `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions9)**<br>Configuration options for a TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions9)**<br>Configuration options for an HTTP health check. 


### TcpOptions {#TcpOptions9}

Field | Description
--- | ---
port | **int64**<br>Port to use for TCP health checks. Acceptable values are 1 to 65535, inclusive.


### HttpOptions {#HttpOptions9}

Field | Description
--- | ---
port | **int64**<br>Port to use for HTTP health checks. Acceptable values are 1 to 65535, inclusive.
path | **string**<br>URL path to set for health checking requests. 


### Variable {#Variable9}

Field | Description
--- | ---
key | **string**<br> The string length in characters must be 1-128. Value must match the regular expression ` [a-zA-Z0-9._-]* `.
value | **string**<br> The maximum string length in characters is 128.


### ApplicationLoadBalancerSpec {#ApplicationLoadBalancerSpec9}

Field | Description
--- | ---
target_group_spec | **[ApplicationTargetGroupSpec](#ApplicationTargetGroupSpec9)**<br>Required. Basic properties of the Application Load Balancer target group attributed to the instance group. 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### ApplicationTargetGroupSpec {#ApplicationTargetGroupSpec9}

Field | Description
--- | ---
name | **string**<br>Name of the target group. 
description | **string**<br>Description of the target group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 


### ApplicationLoadBalancerState {#ApplicationLoadBalancerState9}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Application Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


## ListOperations {#ListOperations}

Lists operations for the specified instance group.

**rpc ListOperations ([ListInstanceGroupOperationsRequest](#ListInstanceGroupOperationsRequest)) returns ([ListInstanceGroupOperationsResponse](#ListInstanceGroupOperationsResponse))**

### ListInstanceGroupOperationsRequest {#ListInstanceGroupOperationsRequest}

Field | Description
--- | ---
instance_group_id | **string**<br>Required. ID of the InstanceGroup resource to list operations for. To get the instance group ID, use a [InstanceGroupService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is more than `page_size`, the service returns a [ListInstanceGroupOperationsResponse.next_page_token](#ListInstanceGroupOperationsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListInstanceGroupOperationsResponse.next_page_token](#ListInstanceGroupOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. Currently you can use filtering only on the [InstanceGroup.name](#InstanceGroup10) field. The maximum string length in characters is 1000.


### ListInstanceGroupOperationsResponse {#ListInstanceGroupOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation9)**<br>Lists operations for the specified instance group. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is more than [ListInstanceGroupOperationsRequest.page_size](#ListInstanceGroupOperationsRequest), use the `next_page_token` as the value for the [ListInstanceGroupOperationsRequest.page_token](#ListInstanceGroupOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation9}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any. 


## ListLogRecords {#ListLogRecords}

Lists logs for the specified instance group.

**rpc ListLogRecords ([ListInstanceGroupLogRecordsRequest](#ListInstanceGroupLogRecordsRequest)) returns ([ListInstanceGroupLogRecordsResponse](#ListInstanceGroupLogRecordsResponse))**

### ListInstanceGroupLogRecordsRequest {#ListInstanceGroupLogRecordsRequest}

Field | Description
--- | ---
instance_group_id | **string**<br>Required. ID of the InstanceGroup resource to list logs for. To get the instance group ID, use a [InstanceGroupService.List](#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListInstanceGroupLogRecordsResponse.next_page_token](#ListInstanceGroupLogRecordsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListInstanceGroupLogRecordsResponse.next_page_token](#ListInstanceGroupLogRecordsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. Currently you can use filtering only on the [InstanceGroup.name](#InstanceGroup10) field. The maximum string length in characters is 1000.


### ListInstanceGroupLogRecordsResponse {#ListInstanceGroupLogRecordsResponse}

Field | Description
--- | ---
log_records[] | **[LogRecord](#LogRecord)**<br>Lists logs for the specified instance group. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListInstanceGroupLogRecordsRequest.page_size](#ListInstanceGroupLogRecordsRequest), use `next_page_token` as the value for the [ListInstanceGroupLogRecordsRequest.page_token](#ListInstanceGroupLogRecordsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### LogRecord {#LogRecord}

Field | Description
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Log timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
message | **string**<br>The log message. 


## ListAccessBindings {#ListAccessBindings}

Lists existing access bindings for the specified instance group.

**rpc ListAccessBindings ([ListAccessBindingsRequest](#ListAccessBindingsRequest)) returns ([ListAccessBindingsResponse](#ListAccessBindingsResponse))**

### ListAccessBindingsRequest {#ListAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource to list access bindings for. <br>To get the resource ID, use a corresponding List request. For example, use the [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/grpc/cloud_service#List) request to get the Cloud resource ID. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListAccessBindingsResponse.next_page_token](#ListAccessBindingsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. Set `page_token` to the [ListAccessBindingsResponse.next_page_token](#ListAccessBindingsResponse) returned by a previous list request to get the next page of results. The maximum string length in characters is 100.


### ListAccessBindingsResponse {#ListAccessBindingsResponse}

Field | Description
--- | ---
access_bindings[] | **[AccessBinding](#AccessBinding)**<br>List of access bindings for the specified resource. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListAccessBindingsRequest.page_size](#ListAccessBindingsRequest), use the `next_page_token` as the value for the [ListAccessBindingsRequest.page_token](#ListAccessBindingsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### AccessBinding {#AccessBinding}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject}

Field | Description
--- | ---
id | **string**<br>Required. ID of the subject. <br>It can contain one of the following values: <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li></ul>who is authenticated. It can be used only if the `type` is `system`. <ul><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li></ul>For example, you don't need to specify the IAM token in an API query. <ul><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul>It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. The maximum string length in characters is 50.
type | **string**<br>Required. Type of the subject. <br>It can contain one of the following values: <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul><br>For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). The maximum string length in characters is 100.


## SetAccessBindings {#SetAccessBindings}

Sets access bindings for the specified instance group.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation10))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### SetAccessBindingsRequest {#SetAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource for which access bindings are being set. <br>To get the resource ID, use a corresponding List request. The maximum string length in characters is 50.
access_bindings[] | **[AccessBinding](#AccessBinding)**<br>Required. Access bindings to be set. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings). 


### AccessBinding {#AccessBinding1}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject1}

Field | Description
--- | ---
id | **string**<br>Required. ID of the subject. <br>It can contain one of the following values: <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li></ul>who is authenticated. It can be used only if the `type` is `system`. <ul><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li></ul>For example, you don't need to specify the IAM token in an API query. <ul><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul>It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. The maximum string length in characters is 50.
type | **string**<br>Required. Type of the subject. <br>It can contain one of the following values: <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul><br>For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). The maximum string length in characters is 100.


### Operation {#Operation10}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### SetAccessBindingsMetadata {#SetAccessBindingsMetadata}

Field | Description
--- | ---
resource_id | **string**<br>ID of the resource for which access bindings are being set. 


## UpdateAccessBindings {#UpdateAccessBindings}

Updates access bindings for the specified instance group.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation11))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateAccessBindingsRequest {#UpdateAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource for which access bindings are being updated. The maximum string length in characters is 50.
access_binding_deltas[] | **[AccessBindingDelta](#AccessBindingDelta)**<br>Required. Updates to access bindings. The number of elements must be greater than 0.


### AccessBindingDelta {#AccessBindingDelta}

Field | Description
--- | ---
action | enum **AccessBindingAction**<br>Required. The action that is being performed on an access binding. <ul><li>`ADD`: Addition of an access binding.</li><li>`REMOVE`: Removal of an access binding.</li></ul>
access_binding | **[AccessBinding](#AccessBinding)**<br>Required. Access binding. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings). 


### AccessBinding {#AccessBinding2}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject2}

Field | Description
--- | ---
id | **string**<br>Required. ID of the subject. <br>It can contain one of the following values: <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li></ul>who is authenticated. It can be used only if the `type` is `system`. <ul><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li></ul>For example, you don't need to specify the IAM token in an API query. <ul><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul>It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. The maximum string length in characters is 50.
type | **string**<br>Required. Type of the subject. <br>It can contain one of the following values: <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul><br>For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). The maximum string length in characters is 100.


### Operation {#Operation11}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### UpdateAccessBindingsMetadata {#UpdateAccessBindingsMetadata}

Field | Description
--- | ---
resource_id | **string**<br>ID of the resource for which access bindings are being updated. 


## ResumeProcesses {#ResumeProcesses}

Resumes all processes regarding management of the specified instance group, i.e. scaling, checking instances' health, auto-healing and updating them.

**rpc ResumeProcesses ([ResumeInstanceGroupProcessesRequest](#ResumeInstanceGroupProcessesRequest)) returns ([operation.Operation](#Operation12))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ResumeInstanceGroupProcessMetadata](#ResumeInstanceGroupProcessMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](#InstanceGroup10)<br>

### ResumeInstanceGroupProcessesRequest {#ResumeInstanceGroupProcessesRequest}

Field | Description
--- | ---
instance_group_id | **string**<br>ID of the instance group to resume processes in. <br>The instance group must have a `PAUSED` status ([InstanceGroup.status](#InstanceGroup10)). <br>To get the instance group ID, make a [InstanceGroupService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation12}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ResumeInstanceGroupProcessMetadata](#ResumeInstanceGroupProcessMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](#InstanceGroup10)>**<br>if operation finished successfully. 


### ResumeInstanceGroupProcessMetadata {#ResumeInstanceGroupProcessMetadata}

Field | Description
--- | ---
instance_group_id | **string**<br>ID of the instance group that processes are being resumed in. 


### InstanceGroup {#InstanceGroup10}

Field | Description
--- | ---
id | **string**<br>ID of the instance group. 
folder_id | **string**<br>ID of the folder that the instance group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the instance group. The name is unique within the folder. 
description | **string**<br>Description of the instance group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
instance_template | **[InstanceTemplate](#InstanceTemplate10)**<br>Instance template for creating the instance group. For more information, see [Instance Templates](/docs/compute/concepts/instance-groups/instance-template). 
scale_policy | **[ScalePolicy](#ScalePolicy10)**<br>[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. 
deploy_policy | **[DeployPolicy](#DeployPolicy10)**<br>Deployment policy of the instance group. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy10)**<br>Allocation policy of the instance group by zones and regions. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState10)**<br>Status of the Network Load Balancer target group attributed to the instance group. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState10)**<br>States of instances for this instance group. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec10)**<br>Settings for balancing load between instances via [Network Load Balancer](/docs/network-load-balancer/concepts) (OSI model layer 3). 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec10)**<br>Health checking specification. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. 
status | enum **Status**<br>Status of the instance group. <ul><li>`STARTING`: Instance group is being started and will become active soon.</li><li>`ACTIVE`: Instance group is active. In this state the group manages its instances and monitors their health, creating, deleting, stopping, updating and starting instances as needed. <br>To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/api-ref/grpc/instance_group_service#Stop). To pause the processes in the instance group, i.e. scaling, checking instances' health, auto-healing and updating them, without stopping the instances, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.PauseProcesses](/docs/compute/api-ref/grpc/instance_group_service#PauseProcesses).</li><li>`STOPPING`: Instance group is being stopped. Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.</li><li>`STOPPED`: Instance group is stopped. In this state the group cannot be updated and does not react to any changes made to its instances. To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/api-ref/grpc/instance_group_service#Start).</li><li>`DELETING`: Instance group is being deleted.</li><li>`PAUSED`: Instance group is paused. In this state all the processes regarding the group management, i.e. scaling, checking instances' health, auto-healing and updating them, are paused. The instances that were running prior to pausing the group, however, may still be running. <br>To resume the processes in the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.ResumeProcesses](/docs/compute/api-ref/grpc/instance_group_service#ResumeProcesses). The group status will change to `ACTIVE`.</li></ul>
variables[] | **[Variable](#Variable10)**<br> 
deletion_protection | **bool**<br>Flag prohibiting deletion of the instance group. <br>Allowed values:</br>- `false`: The instance group can be deleted.</br>- `true`: The instance group cannot be deleted. <br>The default is `false`. 
application_load_balancer_spec | **[ApplicationLoadBalancerSpec](#ApplicationLoadBalancerSpec10)**<br>Settings for balancing load between instances via [Application Load Balancer](/docs/application-load-balancer/concepts) (OSI model layer 7). 
application_load_balancer_state | **[ApplicationLoadBalancerState](#ApplicationLoadBalancerState10)**<br>Status of the Application Load Balancer target group attributed to the instance group. <br>Returned if there is a working load balancer that the target group is connected to. 


### InstanceTemplate {#InstanceTemplate10}

Field | Description
--- | ---
description | **string**<br>Description of the instance template. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
platform_id | **string**<br>Required. ID of the hardware platform configuration for the instance. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see [Platforms](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec10)**<br>Required. Computing resources of the instance such as the amount of memory and number of cores. 
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>Metadata values may contain one of the supported placeholders: {instance_group.id} {instance.short_id} {instance.index} {instance.index_in_zone} {instance.zone_id} InstanceGroup and Instance labels may be copied to metadata following way: {instance_group.labels.some_label_key} {instance.labels.another_label_key} These placeholders will be substituted for each created instance anywhere in the value text. In the rare case the value requires to contain this placeholder explicitly, it must be escaped with double brackets, in example {instance.index}. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). No more than 128 per resource. The maximum string length in characters for each value is 262144. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec10)**<br>Required. Boot disk specification that will be attached to the instance. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec10)**<br>Array of secondary disks that will be attached to the instance. The maximum number of elements is 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec10)**<br>Array of network interfaces that will be attached to the instance. The number of elemets must be exactly 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy10)**<br>Scheduling policy for the instance. 
service_account_id | **string**<br>Service account ID for the instance. 
network_settings | **[NetworkSettings](#NetworkSettings10)**<br>Network settings for the instance. 
name | **string**<br>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
hostname | **string**<br>Host name for the instance. This field is used to generate the `yandex.cloud.compute.v1.Instance.fqdn` value. The host name must be unique within the network and region. If not specified, the host name will be equal to `yandex.cloud.compute.v1.Instance.id` of the instance and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`. <br>In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, `name` value will be used It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
placement_policy | **[PlacementPolicy](#PlacementPolicy10)**<br>Placement Group 
filesystem_specs[] | **[AttachedFilesystemSpec](#AttachedFilesystemSpec10)**<br>Array of filesystems to attach to the instance. <br>The filesystems must reside in the same availability zone as the instance. <br>To use the instance with an attached filesystem, the latter must be mounted. For details, see [documentation](/docs/compute/operations/filesystem/attach-to-vm). 


### ResourcesSpec {#ResourcesSpec10}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. The maximum value is 824633720832.
cores | **int64**<br>The number of cores available to the instance. Value must be equal to 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64,68,72,76,80.
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. Value must be equal to 0,5,20,50,100.
gpus | **int64**<br>The number of GPUs available to the instance. Value must be equal to 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec10}

Field | Description
--- | ---
mode | enum **Mode**<br>Required. Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li></ul>
device_name | **string**<br>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec10)**<br>Required. oneof disk_spec or disk_id Disk specification that is attached to the instance. For more information, see [Disks](/docs/compute/concepts/disk). 
disk_id | **string**<br>Set to use an existing disk. To set use variables. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### DiskSpec {#DiskSpec10}

Field | Description
--- | ---
description | **string**<br>Description of the disk. The maximum string length in characters is 256.
type_id | **string**<br>Required. ID of the disk type. 
size | **int64**<br>Size of the disk, specified in bytes. Acceptable values are 4194304 to 28587302322176, inclusive.
source_oneof | **oneof:** `image_id` or `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>ID of the image that will be used for disk creation. The maximum string length in characters is 50.
&nbsp;&nbsp;snapshot_id | **string**<br>ID of the snapshot that will be used for disk creation. The maximum string length in characters is 50.
preserve_after_instance_delete | **bool**<br>When set to true, disk will not be deleted even after managed instance is deleted. It will be a user's responsibility to delete such disks. 


### NetworkInterfaceSpec {#NetworkInterfaceSpec10}

Field | Description
--- | ---
network_id | **string**<br>ID of the network. 
subnet_ids[] | **string**<br>IDs of the subnets. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec10)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec10)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>IDs of security groups. 


### PrimaryAddressSpec {#PrimaryAddressSpec10}

Field | Description
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec10)**<br>An external IP address configuration. If not specified, then this managed instance will have no external internet access. 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec10)**<br>Internal DNS configuration 
address | **string**<br>Optional. Manual set static internal IP. To set use variables. 


### OneToOneNatSpec {#OneToOneNatSpec10}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>IP version for the public IP address. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li></ul>
address | **string**<br>Manual set static public IP. To set use variables. (optional) 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec10)**<br>External DNS configuration 


### DnsRecordSpec {#DnsRecordSpec10}

Field | Description
--- | ---
fqdn | **string**<br>Required. FQDN (required) 
dns_zone_id | **string**<br>DNS zone id (optional, if not set, private zone used) 
ttl | **int64**<br>DNS record ttl, values in 0-86400 (optional) Acceptable values are 0 to 86400, inclusive.
ptr | **bool**<br>When set to true, also create PTR DNS record (optional) 


### SchedulingPolicy {#SchedulingPolicy10}

Field | Description
--- | ---
preemptible | **bool**<br>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings10}

Field | Description
--- | ---
type | enum **Type**<br>Type of instance network. 


### PlacementPolicy {#PlacementPolicy10}

Field | Description
--- | ---
placement_group_id | **string**<br>Identifier of placement group 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule10)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule10}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action 
values[] | **string**<br>Affinity value or host ID or host group ID 


### AttachedFilesystemSpec {#AttachedFilesystemSpec10}

Field | Description
--- | ---
mode | enum **Mode**<br>Mode of access to the filesystem that should be attached. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access. Default value.</li></ul>
device_name | **string**<br>Name of the device representing the filesystem on the instance. <br>The name should be used for referencing the filesystem from within the instance when it's being mounted, resized etc. <br>If not specified, a random value will be generated. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
filesystem_id | **string**<br>ID of the filesystem that should be attached. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### ScalePolicy {#ScalePolicy10}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale` or `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale10)**<br>[Manual scaling policy](/docs/compute/concepts/instance-groups/scale#fixed-policy) of the instance group. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale10)**<br>[Automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 
test_auto_scale | **[AutoScale](#AutoScale10)**<br>Test spec for [automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 


### AutoScale {#AutoScale10}

Field | Description
--- | ---
min_zone_size | **int64**<br>Lower limit for instance count in each zone. Acceptable values are 0 to 100, inclusive.
max_size | **int64**<br>Upper limit for total instance count (across all zones). 0 means maximum limit = 100. Acceptable values are 0 to 100, inclusive.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time in seconds allotted for averaging metrics. 1 minute by default. Acceptable values are 1m to 10m, inclusive.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected. The maximum value is 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should. Acceptable values are 1m to 30m, inclusive.
initial_size | **int64**<br>Target group size. The minimum value is 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule10)**<br>Defines an autoscaling rule based on the average CPU utilization of the instance group. <br>If more than one rule is specified, e.g. CPU utilization and one or more Monitoring metrics (`custom_rules`), the size of the instance group will be equal to the maximum of sizes calculated according to each metric. 
custom_rules[] | **[CustomRule](#CustomRule10)**<br>Defines an autoscaling rule based on a [custom metric](/docs/monitoring/operations/metric/add) from Monitoring. <br>If more than one rule is specified, e.g. CPU utilization (`cpu_utilization_rule`) and one or more Monitoring metrics, the size of the instance group will be equal to the maximum of sizes calculated according to each metric. The maximum number of elements is 3.
auto_scale_type | enum **AutoScaleType**<br>Autoscaling type. <ul><li>`ZONAL`: Scale each zone independently. This is the default.</li><li>`REGIONAL`: Scale group as a whole.</li></ul>


### CpuUtilizationRule {#CpuUtilizationRule10}

Field | Description
--- | ---
utilization_target | **double**<br>Target CPU utilization level. Instance Groups maintains this level for each availability zone. Acceptable values are 10 to 100, inclusive.


### CustomRule {#CustomRule10}

Field | Description
--- | ---
rule_type | enum **RuleType**<br>Required. Custom metric rule type. This field affects which label from the custom metric should be used: `zone_id` or `instance_id`. <ul><li>`UTILIZATION`: This type means that the metric applies to one instance. First, Instance Groups calculates the average metric value for each instance, then averages the values for instances in one availability zone or in whole group depends on autoscaling type. This type of metric must have the `instance_id` label.</li><li>`WORKLOAD`: This type means that the metric applies to instances in one availability zone or to whole group depends on autoscaling type. This type of metric must have the `zone_id` label if ZONAL autoscaling type is chosen.</li></ul>
metric_type | enum **MetricType**<br>Required. Type of custom metric. This field affects how Instance Groups calculates the average metric value. <ul><li>`GAUGE`: This type is used for metrics that show the metric value at a certain point in time, such as requests per second to the server on an instance. <br>Instance Groups calculates the average metric value for the period specified in the [AutoScale.measurement_duration](#AutoScale10) field.</li><li>`COUNTER`: This type is used for metrics that monotonically increase over time, such as the total number of requests to the server on an instance. <br>Instance Groups calculates the average value increase for the period specified in the [AutoScale.measurement_duration](#AutoScale10) field.</li></ul>
metric_name | **string**<br>Required. Name of custom metric in Monitoring that should be used for scaling. Value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
labels | **map<string,string>**<br>Labels of custom metric in Monitoring that should be used for scaling. Each value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `. Each key must match the regular expression ` ^[a-zA-Z][0-9a-zA-Z_]{0,31}$ `.
target | **double**<br>Target value for the custom metric. Instance Groups maintains this level for each availability zone. Value must be greater than 0.
folder_id | **string**<br>Folder id of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 50.
service | **string**<br>Service of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 200.


### FixedScale {#FixedScale10}

Field | Description
--- | ---
size | **int64**<br>Number of instances in the instance group. Acceptable values are 1 to 100, inclusive.


### DeployPolicy {#DeployPolicy10}

Field | Description
--- | ---
max_unavailable | **int64**<br>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If `max_expansion` is not specified or set to zero, `max_unavailable` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
max_deleting | **int64**<br>The maximum number of instances that can be deleted at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_creating | **int64**<br>The maximum number of instances that can be created at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_expansion | **int64**<br>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If `max_unavailable` is not specified or set to zero, `max_expansion` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Instance startup duration. Instance will be considered up and running (and start receiving traffic) only after startup_duration has elapsed and all health checks are passed. See `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status` for more information. Acceptable values are 0m to 1h, inclusive.
strategy | enum **Strategy**<br>Affects the lifecycle of the instance during deployment. <ul><li>`PROACTIVE`: Instance Groups can forcefully stop a running instance. This is the default.</li><li>`OPPORTUNISTIC`: Instance Groups does not stop a running instance. Instead, it will wait until the instance stops itself or becomes unhealthy.</li></ul>


### AllocationPolicy {#AllocationPolicy10}

Field | Description
--- | ---
zones[] | **[Zone](#Zone10)**<br>List of availability zones. The minimum number of elements is 1.


### Zone {#Zone10}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the instance resides. 


### LoadBalancerState {#LoadBalancerState10}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Network Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


### ManagedInstancesState {#ManagedInstancesState10}

Field | Description
--- | ---
target_size | **int64**<br>Target number of instances for this instance group. 
running_actual_count | **int64**<br>The number of running instances that match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_ACTUAL](#ManagedInstance1). 
running_outdated_count | **int64**<br>The number of running instances that does not match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_OUTDATED](#ManagedInstance1). 
processing_count | **int64**<br>The number of instances in flight (for example, updating, starting, deleting). For more information, see [ManagedInstance.Status](#ManagedInstance1). 


### Statuses {#Statuses10}

Field | Description
--- | ---
creating | **int64**<br>Instance is being created. 
starting | **int64**<br>Instance is being started. 
opening | **int64**<br>Instance is being opened to receive traffic. 
warming | **int64**<br>Instance is being warmed. 
running | **int64**<br>Instance is running normally. 
closing | **int64**<br>Instance is being closed to traffic. 
stopping | **int64**<br>Instance is being stopped. 
updating | **int64**<br>Instance is being updated. 
deleting | **int64**<br>Instance is being deleted. 
failed | **int64**<br>Instance failed and needs to be recreated. 


### LoadBalancerSpec {#LoadBalancerSpec10}

Field | Description
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec10)**<br>Specification of the target group that the instance group will be added to. For more information, see [Target groups and resources](/docs/load-balancer/concepts/target-resources). 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### TargetGroupSpec {#TargetGroupSpec10}

Field | Description
--- | ---
name | **string**<br>Name of the target group. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the target group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec10}

Field | Description
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec10)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). The minimum number of elements is 1.
max_checking_health_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to become healthy. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### HealthCheckSpec {#HealthCheckSpec10}

Field | Description
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. Acceptable values are 1s to 300s, inclusive.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the managed instance to return a response for the health check. The default is 1 second. Acceptable values are 1s to 60s, inclusive.
unhealthy_threshold | **int64**<br>The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` or `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions10)**<br>Configuration options for a TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions10)**<br>Configuration options for an HTTP health check. 


### TcpOptions {#TcpOptions10}

Field | Description
--- | ---
port | **int64**<br>Port to use for TCP health checks. Acceptable values are 1 to 65535, inclusive.


### HttpOptions {#HttpOptions10}

Field | Description
--- | ---
port | **int64**<br>Port to use for HTTP health checks. Acceptable values are 1 to 65535, inclusive.
path | **string**<br>URL path to set for health checking requests. 


### Variable {#Variable10}

Field | Description
--- | ---
key | **string**<br> The string length in characters must be 1-128. Value must match the regular expression ` [a-zA-Z0-9._-]* `.
value | **string**<br> The maximum string length in characters is 128.


### ApplicationLoadBalancerSpec {#ApplicationLoadBalancerSpec10}

Field | Description
--- | ---
target_group_spec | **[ApplicationTargetGroupSpec](#ApplicationTargetGroupSpec10)**<br>Required. Basic properties of the Application Load Balancer target group attributed to the instance group. 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### ApplicationTargetGroupSpec {#ApplicationTargetGroupSpec10}

Field | Description
--- | ---
name | **string**<br>Name of the target group. 
description | **string**<br>Description of the target group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 


### ApplicationLoadBalancerState {#ApplicationLoadBalancerState10}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Application Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


## PauseProcesses {#PauseProcesses}

Pauses all processes regarding management of the specified instance group, i.e. scaling, checking instances' health, auto-healing and updating them. Running instances are not stopped.

**rpc PauseProcesses ([PauseInstanceGroupProcessesRequest](#PauseInstanceGroupProcessesRequest)) returns ([operation.Operation](#Operation13))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[PauseInstanceGroupProcessMetadata](#PauseInstanceGroupProcessMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](#InstanceGroup11)<br>

### PauseInstanceGroupProcessesRequest {#PauseInstanceGroupProcessesRequest}

Field | Description
--- | ---
instance_group_id | **string**<br>ID of the instance group to pause processes in. <br>The instance group must have an `ACTIVE` status ([InstanceGroup.status](#InstanceGroup11)). <br>To get the instance group ID, make a [InstanceGroupService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation13}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[PauseInstanceGroupProcessMetadata](#PauseInstanceGroupProcessMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](#InstanceGroup11)>**<br>if operation finished successfully. 


### PauseInstanceGroupProcessMetadata {#PauseInstanceGroupProcessMetadata}

Field | Description
--- | ---
instance_group_id | **string**<br>ID of the instance group that processes are being paused in. 


### InstanceGroup {#InstanceGroup11}

Field | Description
--- | ---
id | **string**<br>ID of the instance group. 
folder_id | **string**<br>ID of the folder that the instance group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the instance group. The name is unique within the folder. 
description | **string**<br>Description of the instance group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
instance_template | **[InstanceTemplate](#InstanceTemplate11)**<br>Instance template for creating the instance group. For more information, see [Instance Templates](/docs/compute/concepts/instance-groups/instance-template). 
scale_policy | **[ScalePolicy](#ScalePolicy11)**<br>[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. 
deploy_policy | **[DeployPolicy](#DeployPolicy11)**<br>Deployment policy of the instance group. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy11)**<br>Allocation policy of the instance group by zones and regions. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState11)**<br>Status of the Network Load Balancer target group attributed to the instance group. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState11)**<br>States of instances for this instance group. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec11)**<br>Settings for balancing load between instances via [Network Load Balancer](/docs/network-load-balancer/concepts) (OSI model layer 3). 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec11)**<br>Health checking specification. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. 
status | enum **Status**<br>Status of the instance group. <ul><li>`STARTING`: Instance group is being started and will become active soon.</li><li>`ACTIVE`: Instance group is active. In this state the group manages its instances and monitors their health, creating, deleting, stopping, updating and starting instances as needed. <br>To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/api-ref/grpc/instance_group_service#Stop). To pause the processes in the instance group, i.e. scaling, checking instances' health, auto-healing and updating them, without stopping the instances, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.PauseProcesses](/docs/compute/api-ref/grpc/instance_group_service#PauseProcesses).</li><li>`STOPPING`: Instance group is being stopped. Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.</li><li>`STOPPED`: Instance group is stopped. In this state the group cannot be updated and does not react to any changes made to its instances. To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/api-ref/grpc/instance_group_service#Start).</li><li>`DELETING`: Instance group is being deleted.</li><li>`PAUSED`: Instance group is paused. In this state all the processes regarding the group management, i.e. scaling, checking instances' health, auto-healing and updating them, are paused. The instances that were running prior to pausing the group, however, may still be running. <br>To resume the processes in the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.ResumeProcesses](/docs/compute/api-ref/grpc/instance_group_service#ResumeProcesses). The group status will change to `ACTIVE`.</li></ul>
variables[] | **[Variable](#Variable11)**<br> 
deletion_protection | **bool**<br>Flag prohibiting deletion of the instance group. <br>Allowed values:</br>- `false`: The instance group can be deleted.</br>- `true`: The instance group cannot be deleted. <br>The default is `false`. 
application_load_balancer_spec | **[ApplicationLoadBalancerSpec](#ApplicationLoadBalancerSpec11)**<br>Settings for balancing load between instances via [Application Load Balancer](/docs/application-load-balancer/concepts) (OSI model layer 7). 
application_load_balancer_state | **[ApplicationLoadBalancerState](#ApplicationLoadBalancerState11)**<br>Status of the Application Load Balancer target group attributed to the instance group. <br>Returned if there is a working load balancer that the target group is connected to. 


### InstanceTemplate {#InstanceTemplate11}

Field | Description
--- | ---
description | **string**<br>Description of the instance template. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
platform_id | **string**<br>Required. ID of the hardware platform configuration for the instance. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see [Platforms](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec11)**<br>Required. Computing resources of the instance such as the amount of memory and number of cores. 
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>Metadata values may contain one of the supported placeholders: {instance_group.id} {instance.short_id} {instance.index} {instance.index_in_zone} {instance.zone_id} InstanceGroup and Instance labels may be copied to metadata following way: {instance_group.labels.some_label_key} {instance.labels.another_label_key} These placeholders will be substituted for each created instance anywhere in the value text. In the rare case the value requires to contain this placeholder explicitly, it must be escaped with double brackets, in example {instance.index}. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). No more than 128 per resource. The maximum string length in characters for each value is 262144. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec11)**<br>Required. Boot disk specification that will be attached to the instance. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec11)**<br>Array of secondary disks that will be attached to the instance. The maximum number of elements is 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec11)**<br>Array of network interfaces that will be attached to the instance. The number of elemets must be exactly 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy11)**<br>Scheduling policy for the instance. 
service_account_id | **string**<br>Service account ID for the instance. 
network_settings | **[NetworkSettings](#NetworkSettings11)**<br>Network settings for the instance. 
name | **string**<br>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
hostname | **string**<br>Host name for the instance. This field is used to generate the `yandex.cloud.compute.v1.Instance.fqdn` value. The host name must be unique within the network and region. If not specified, the host name will be equal to `yandex.cloud.compute.v1.Instance.id` of the instance and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`. <br>In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, `name` value will be used It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
placement_policy | **[PlacementPolicy](#PlacementPolicy11)**<br>Placement Group 
filesystem_specs[] | **[AttachedFilesystemSpec](#AttachedFilesystemSpec11)**<br>Array of filesystems to attach to the instance. <br>The filesystems must reside in the same availability zone as the instance. <br>To use the instance with an attached filesystem, the latter must be mounted. For details, see [documentation](/docs/compute/operations/filesystem/attach-to-vm). 


### ResourcesSpec {#ResourcesSpec11}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. The maximum value is 824633720832.
cores | **int64**<br>The number of cores available to the instance. Value must be equal to 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64,68,72,76,80.
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. Value must be equal to 0,5,20,50,100.
gpus | **int64**<br>The number of GPUs available to the instance. Value must be equal to 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec11}

Field | Description
--- | ---
mode | enum **Mode**<br>Required. Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li></ul>
device_name | **string**<br>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec11)**<br>Required. oneof disk_spec or disk_id Disk specification that is attached to the instance. For more information, see [Disks](/docs/compute/concepts/disk). 
disk_id | **string**<br>Set to use an existing disk. To set use variables. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### DiskSpec {#DiskSpec11}

Field | Description
--- | ---
description | **string**<br>Description of the disk. The maximum string length in characters is 256.
type_id | **string**<br>Required. ID of the disk type. 
size | **int64**<br>Size of the disk, specified in bytes. Acceptable values are 4194304 to 28587302322176, inclusive.
source_oneof | **oneof:** `image_id` or `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>ID of the image that will be used for disk creation. The maximum string length in characters is 50.
&nbsp;&nbsp;snapshot_id | **string**<br>ID of the snapshot that will be used for disk creation. The maximum string length in characters is 50.
preserve_after_instance_delete | **bool**<br>When set to true, disk will not be deleted even after managed instance is deleted. It will be a user's responsibility to delete such disks. 


### NetworkInterfaceSpec {#NetworkInterfaceSpec11}

Field | Description
--- | ---
network_id | **string**<br>ID of the network. 
subnet_ids[] | **string**<br>IDs of the subnets. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec11)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec11)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>IDs of security groups. 


### PrimaryAddressSpec {#PrimaryAddressSpec11}

Field | Description
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec11)**<br>An external IP address configuration. If not specified, then this managed instance will have no external internet access. 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec11)**<br>Internal DNS configuration 
address | **string**<br>Optional. Manual set static internal IP. To set use variables. 


### OneToOneNatSpec {#OneToOneNatSpec11}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>IP version for the public IP address. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li></ul>
address | **string**<br>Manual set static public IP. To set use variables. (optional) 
dns_record_specs[] | **[DnsRecordSpec](#DnsRecordSpec11)**<br>External DNS configuration 


### DnsRecordSpec {#DnsRecordSpec11}

Field | Description
--- | ---
fqdn | **string**<br>Required. FQDN (required) 
dns_zone_id | **string**<br>DNS zone id (optional, if not set, private zone used) 
ttl | **int64**<br>DNS record ttl, values in 0-86400 (optional) Acceptable values are 0 to 86400, inclusive.
ptr | **bool**<br>When set to true, also create PTR DNS record (optional) 


### SchedulingPolicy {#SchedulingPolicy11}

Field | Description
--- | ---
preemptible | **bool**<br>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings11}

Field | Description
--- | ---
type | enum **Type**<br>Type of instance network. 


### PlacementPolicy {#PlacementPolicy11}

Field | Description
--- | ---
placement_group_id | **string**<br>Identifier of placement group 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule11)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule11}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action 
values[] | **string**<br>Affinity value or host ID or host group ID 


### AttachedFilesystemSpec {#AttachedFilesystemSpec11}

Field | Description
--- | ---
mode | enum **Mode**<br>Mode of access to the filesystem that should be attached. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access. Default value.</li></ul>
device_name | **string**<br>Name of the device representing the filesystem on the instance. <br>The name should be used for referencing the filesystem from within the instance when it's being mounted, resized etc. <br>If not specified, a random value will be generated. Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `.
filesystem_id | **string**<br>ID of the filesystem that should be attached. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### ScalePolicy {#ScalePolicy11}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale` or `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale11)**<br>[Manual scaling policy](/docs/compute/concepts/instance-groups/scale#fixed-policy) of the instance group. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale11)**<br>[Automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 
test_auto_scale | **[AutoScale](#AutoScale11)**<br>Test spec for [automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 


### AutoScale {#AutoScale11}

Field | Description
--- | ---
min_zone_size | **int64**<br>Lower limit for instance count in each zone. Acceptable values are 0 to 100, inclusive.
max_size | **int64**<br>Upper limit for total instance count (across all zones). 0 means maximum limit = 100. Acceptable values are 0 to 100, inclusive.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time in seconds allotted for averaging metrics. 1 minute by default. Acceptable values are 1m to 10m, inclusive.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected. The maximum value is 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should. Acceptable values are 1m to 30m, inclusive.
initial_size | **int64**<br>Target group size. The minimum value is 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule11)**<br>Defines an autoscaling rule based on the average CPU utilization of the instance group. <br>If more than one rule is specified, e.g. CPU utilization and one or more Monitoring metrics (`custom_rules`), the size of the instance group will be equal to the maximum of sizes calculated according to each metric. 
custom_rules[] | **[CustomRule](#CustomRule11)**<br>Defines an autoscaling rule based on a [custom metric](/docs/monitoring/operations/metric/add) from Monitoring. <br>If more than one rule is specified, e.g. CPU utilization (`cpu_utilization_rule`) and one or more Monitoring metrics, the size of the instance group will be equal to the maximum of sizes calculated according to each metric. The maximum number of elements is 3.
auto_scale_type | enum **AutoScaleType**<br>Autoscaling type. <ul><li>`ZONAL`: Scale each zone independently. This is the default.</li><li>`REGIONAL`: Scale group as a whole.</li></ul>


### CpuUtilizationRule {#CpuUtilizationRule11}

Field | Description
--- | ---
utilization_target | **double**<br>Target CPU utilization level. Instance Groups maintains this level for each availability zone. Acceptable values are 10 to 100, inclusive.


### CustomRule {#CustomRule11}

Field | Description
--- | ---
rule_type | enum **RuleType**<br>Required. Custom metric rule type. This field affects which label from the custom metric should be used: `zone_id` or `instance_id`. <ul><li>`UTILIZATION`: This type means that the metric applies to one instance. First, Instance Groups calculates the average metric value for each instance, then averages the values for instances in one availability zone or in whole group depends on autoscaling type. This type of metric must have the `instance_id` label.</li><li>`WORKLOAD`: This type means that the metric applies to instances in one availability zone or to whole group depends on autoscaling type. This type of metric must have the `zone_id` label if ZONAL autoscaling type is chosen.</li></ul>
metric_type | enum **MetricType**<br>Required. Type of custom metric. This field affects how Instance Groups calculates the average metric value. <ul><li>`GAUGE`: This type is used for metrics that show the metric value at a certain point in time, such as requests per second to the server on an instance. <br>Instance Groups calculates the average metric value for the period specified in the [AutoScale.measurement_duration](#AutoScale11) field.</li><li>`COUNTER`: This type is used for metrics that monotonically increase over time, such as the total number of requests to the server on an instance. <br>Instance Groups calculates the average value increase for the period specified in the [AutoScale.measurement_duration](#AutoScale11) field.</li></ul>
metric_name | **string**<br>Required. Name of custom metric in Monitoring that should be used for scaling. Value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
labels | **map<string,string>**<br>Labels of custom metric in Monitoring that should be used for scaling. Each value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `. Each key must match the regular expression ` ^[a-zA-Z][0-9a-zA-Z_]{0,31}$ `.
target | **double**<br>Target value for the custom metric. Instance Groups maintains this level for each availability zone. Value must be greater than 0.
folder_id | **string**<br>Folder id of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 50.
service | **string**<br>Service of custom metric in Monitoring that should be used for scaling. The maximum string length in characters is 200.


### FixedScale {#FixedScale11}

Field | Description
--- | ---
size | **int64**<br>Number of instances in the instance group. Acceptable values are 1 to 100, inclusive.


### DeployPolicy {#DeployPolicy11}

Field | Description
--- | ---
max_unavailable | **int64**<br>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If `max_expansion` is not specified or set to zero, `max_unavailable` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
max_deleting | **int64**<br>The maximum number of instances that can be deleted at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_creating | **int64**<br>The maximum number of instances that can be created at the same time. <br>The value 0 is any number of virtual machines within the allowed values. Acceptable values are 0 to 100, inclusive.
max_expansion | **int64**<br>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If `max_unavailable` is not specified or set to zero, `max_expansion` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Instance startup duration. Instance will be considered up and running (and start receiving traffic) only after startup_duration has elapsed and all health checks are passed. See `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status` for more information. Acceptable values are 0m to 1h, inclusive.
strategy | enum **Strategy**<br>Affects the lifecycle of the instance during deployment. <ul><li>`PROACTIVE`: Instance Groups can forcefully stop a running instance. This is the default.</li><li>`OPPORTUNISTIC`: Instance Groups does not stop a running instance. Instead, it will wait until the instance stops itself or becomes unhealthy.</li></ul>


### AllocationPolicy {#AllocationPolicy11}

Field | Description
--- | ---
zones[] | **[Zone](#Zone11)**<br>List of availability zones. The minimum number of elements is 1.


### Zone {#Zone11}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the instance resides. 


### LoadBalancerState {#LoadBalancerState11}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Network Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


### ManagedInstancesState {#ManagedInstancesState11}

Field | Description
--- | ---
target_size | **int64**<br>Target number of instances for this instance group. 
running_actual_count | **int64**<br>The number of running instances that match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_ACTUAL](#ManagedInstance1). 
running_outdated_count | **int64**<br>The number of running instances that does not match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_OUTDATED](#ManagedInstance1). 
processing_count | **int64**<br>The number of instances in flight (for example, updating, starting, deleting). For more information, see [ManagedInstance.Status](#ManagedInstance1). 


### Statuses {#Statuses11}

Field | Description
--- | ---
creating | **int64**<br>Instance is being created. 
starting | **int64**<br>Instance is being started. 
opening | **int64**<br>Instance is being opened to receive traffic. 
warming | **int64**<br>Instance is being warmed. 
running | **int64**<br>Instance is running normally. 
closing | **int64**<br>Instance is being closed to traffic. 
stopping | **int64**<br>Instance is being stopped. 
updating | **int64**<br>Instance is being updated. 
deleting | **int64**<br>Instance is being deleted. 
failed | **int64**<br>Instance failed and needs to be recreated. 


### LoadBalancerSpec {#LoadBalancerSpec11}

Field | Description
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec11)**<br>Specification of the target group that the instance group will be added to. For more information, see [Target groups and resources](/docs/load-balancer/concepts/target-resources). 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### TargetGroupSpec {#TargetGroupSpec11}

Field | Description
--- | ---
name | **string**<br>Name of the target group. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the target group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec11}

Field | Description
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec11)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). The minimum number of elements is 1.
max_checking_health_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to become healthy. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### HealthCheckSpec {#HealthCheckSpec11}

Field | Description
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. Acceptable values are 1s to 300s, inclusive.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the managed instance to return a response for the health check. The default is 1 second. Acceptable values are 1s to 60s, inclusive.
unhealthy_threshold | **int64**<br>The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` or `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions11)**<br>Configuration options for a TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions11)**<br>Configuration options for an HTTP health check. 


### TcpOptions {#TcpOptions11}

Field | Description
--- | ---
port | **int64**<br>Port to use for TCP health checks. Acceptable values are 1 to 65535, inclusive.


### HttpOptions {#HttpOptions11}

Field | Description
--- | ---
port | **int64**<br>Port to use for HTTP health checks. Acceptable values are 1 to 65535, inclusive.
path | **string**<br>URL path to set for health checking requests. 


### Variable {#Variable11}

Field | Description
--- | ---
key | **string**<br> The string length in characters must be 1-128. Value must match the regular expression ` [a-zA-Z0-9._-]* `.
value | **string**<br> The maximum string length in characters is 128.


### ApplicationLoadBalancerSpec {#ApplicationLoadBalancerSpec11}

Field | Description
--- | ---
target_group_spec | **[ApplicationTargetGroupSpec](#ApplicationTargetGroupSpec11)**<br>Required. Basic properties of the Application Load Balancer target group attributed to the instance group. 
max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds. The minimum value is 1s.


### ApplicationTargetGroupSpec {#ApplicationTargetGroupSpec11}

Field | Description
--- | ---
name | **string**<br>Name of the target group. 
description | **string**<br>Description of the target group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 


### ApplicationLoadBalancerState {#ApplicationLoadBalancerState11}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the Application Load Balancer target group attributed to the instance group. 
status_message | **string**<br>Status message of the target group. 


