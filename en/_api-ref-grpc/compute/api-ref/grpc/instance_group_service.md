---
editable: false
---

# InstanceGroupService

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
| [ListOperations](#ListOperations) | Lists operations for the specified instance group. |
| [ListLogRecords](#ListLogRecords) | Lists logs for the specified instance group. |
| [ListAccessBindings](#ListAccessBindings) | Lists existing access bindings for the specified instance group. |
| [SetAccessBindings](#SetAccessBindings) | Sets access bindings for the specified instance group. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings for the specified instance group. |

## Calls InstanceGroupService {#calls}

## Get {#Get}

Returns the specified InstanceGroup resource. <br>To get the list of available InstanceGroup resources, make a [List](#List) request.

**rpc Get ([GetInstanceGroupRequest](#GetInstanceGroupRequest)) returns ([InstanceGroup](#InstanceGroup))**

### GetInstanceGroupRequest {#GetInstanceGroupRequest}

Field | Description
--- | ---
instance_group_id | **string**<br>Required. ID of the InstanceGroup resource to return. To get the instance group ID, use a [InstanceGroupService.List](#List) request. false The maximum string length in characters is 50.
view | enum **InstanceGroupView**<br>Defines which information about the Instance template should be returned in the server response. <ul><li>`BASIC`: Doesn't include the metadata of the instance template in the server response.</li><li>`FULL`: Returns the metadata of the instance template in the server response.</li><ul/>


### InstanceGroup {#InstanceGroup}

Field | Description
--- | ---
id | **string**<br>ID of the instance group. 
folder_id | **string**<br>ID of the folder that the instance group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the instance group. The name is unique within the folder. 
description | **string**<br>Description of the instance group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
instance_template | **[InstanceTemplate](#InstanceTemplate)**<br>Instance template for creating the instance group. For more information, see [Instance Templates](/docs/compute/concepts/ig-instance-templates). 
scale_policy | **[ScalePolicy](#ScalePolicy)**<br>[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. 
deploy_policy | **[DeployPolicy](#DeployPolicy)**<br>Deployment policy of the instance group. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy)**<br>Allocation policy of the instance group by zones and regions. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState)**<br>Information that indicates which entities can be related to this load balancer. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState)**<br>States of instances for this instance group. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec)**<br>Load balancing specification. 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
status | enum **Status**<br>Status of the instance group. <ul><li>`STARTING`: Instance group is being started and will become active soon.</li><li>`ACTIVE`: Instance group is active. In this state the group manages its instances and monitors their health, creating, deleting, stopping, updating and starting instances as needed. To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Instance group is being stopped. Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.</li><li>`STOPPED`: Instance group is stopped. In this state the group cannot be updated and does not react to any changes made to its instances. To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/grpc/instance_group_service#Start).</li><li>`DELETING`: Instance group is being deleted.</li><ul/>
variables[] | **[Variable](#Variable)**<br> 
deletion_protection | **bool**<br>Flag that inhibits deletion of the instance group 


### InstanceTemplate {#InstanceTemplate}

Field | Description
--- | ---
description | **string**<br>Description of the instance template. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
platform_id | **string**<br>Required. ID of the hardware platform configuration for the instance. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see [Platforms](/docs/compute/concepts/vm-platforms). false
resources_spec | **[ResourcesSpec](#ResourcesSpec)**<br>Required. Computing resources of the instance such as the amount of memory and number of cores. false
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>Metadata values may contain one of the supported placeholders: {instance_group.id} {instance.short_id} {instance.index} {instance.index_in_zone} {instance.zone_id} InstanceGroup and Instance labels may be copied to metadata following way: {instance_group.labels.some_label_key} {instance.labels.another_label_key} These placeholders will be substituted for each created instance anywhere in the value text. In the rare case the value requires to contain this placeholder explicitly, it must be escaped with double brackets, in example {instance.index}. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). No more than 128 per resource. The maximum string length in characters for each value is 262144. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec)**<br>Required. Boot disk specification that will be attached to the instance. false
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec)**<br>Array of secondary disks that will be attached to the instance. The maximum number of elements is 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec)**<br>Array of network interfaces that will be attached to the instance. The number of elemets must be exactly 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy)**<br>Scheduling policy for the instance. 
service_account_id | **string**<br>Service account ID for the instance. 
network_settings | **[NetworkSettings](#NetworkSettings)**<br>Network settings for the instance. 
name | **string**<br>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
hostname | **string**<br>Host name for the instance. This field is used to generate the `yandex.cloud.compute.v1.Instance.fqdn` value. The host name must be unique within the network and region. If not specified, the host name will be equal to `yandex.cloud.compute.v1.Instance.id` of the instance and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`. <br>In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, `name` value will be used It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.


### ResourcesSpec {#ResourcesSpec}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. The maximum value is 824633720832.
cores | **int64**<br>The number of cores available to the instance. Value must be equal to 1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64.
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. Value must be equal to 0,5,20,50,100.
gpus | **int64**<br>The number of GPUs available to the instance. Value must be equal to 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec}

Field | Description
--- | ---
mode | enum **Mode**<br>Required. Access mode to the Disk resource. false<ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li><ul/>
device_name | **string**<br>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. Value must match the regular expression ` |[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec)**<br>Required. oneof disk_spec or disk_id Disk specification that is attached to the instance. For more information, see [Disks](/docs/compute/concepts/disk). false
disk_id | **string**<br>Set to use an existing disk. To set use variables. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### DiskSpec {#DiskSpec}

Field | Description
--- | ---
description | **string**<br>Description of the disk. The maximum string length in characters is 256.
type_id | **string**<br>Required. ID of the disk type. false
size | **int64**<br>Size of the disk, specified in bytes. Acceptable values are 4194304 to 4398046511104, inclusive.
source_oneof | **oneof:** `image_id` or `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>ID of the image that will be used for disk creation. The maximum string length in characters is 50.
&nbsp;&nbsp;snapshot_id | **string**<br>ID of the snapshot that will be used for disk creation. The maximum string length in characters is 50.


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


### OneToOneNatSpec {#OneToOneNatSpec}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>IP version for the public IP address. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy}

Field | Description
--- | ---
preemptible | **bool**<br>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings}

Field | Description
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Type of instance network. <ul><ul/>


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
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time in seconds allotted for averaging metrics. false Acceptable values are 1m to 10m, inclusive.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected. The maximum value is 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should. Acceptable values are 1m to 30m, inclusive.
initial_size | **int64**<br>Target group size. The minimum value is 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule)**<br>Defines an autoscaling rule based on the average CPU utilization of the instance group. 
custom_rules[] | **[CustomRule](#CustomRule)**<br>Defines an autoscaling rule based on a [custom metric](/docs/monitoring/operations/metric/add) from Yandex Monitoring. The maximum number of elements is 1.


### CpuUtilizationRule {#CpuUtilizationRule}

Field | Description
--- | ---
utilization_target | **double**<br>Target CPU utilization level. Instance Groups maintains this level for each availability zone. Acceptable values are 10 to 100, inclusive.


### CustomRule {#CustomRule}

Field | Description
--- | ---
rule_type | enum **RuleType**<br>Required. Custom metric rule type. This field affects which label from the custom metric should be used: `zone_id` or `instance_id`. false<ul><li>`UTILIZATION`: This type means that the metric applies to one instance. First, Instance Groups calculates the average metric value for each instance, then averages the values for instances in one availability zone. This type of metric must have the `instance_id` label.</li><li>`WORKLOAD`: This type means that the metric applies to instances in one availability zone. This type of metric must have the `zone_id` label.</li><ul/>
metric_type | enum **MetricType**<br>Required. Type of custom metric. This field affects how Instance Groups calculates the average metric value. false<ul><li>`GAUGE`: This type is used for metrics that show the metric value at a certain point in time, such as requests per second to the server on an instance. <br>Instance Groups calculates the average metric value for the period specified in the [AutoScale.measurement_duration](#AutoScale) field.</li><li>`COUNTER`: This type is used for metrics that monotonically increase over time, such as the total number of requests to the server on an instance. <br>Instance Groups calculates the average value increase for the period specified in the [AutoScale.measurement_duration](#AutoScale) field.</li><ul/>
metric_name | **string**<br>Required. Name of custom metric in Yandex Monitoring that should be used for scaling. false Value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
labels | **map<string,string>**<br>Labels of custom metric in Yandex Monitoring that should be used for scaling. Each value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `. Each key must match the regular expression ` ^[a-zA-Z][0-9a-zA-Z_]{0,31}$ `.
target | **double**<br>Target value for the custom metric. Instance Groups maintains this level for each availability zone. Value must be greater than 0.


### FixedScale {#FixedScale}

Field | Description
--- | ---
size | **int64**<br>Number of instances in the instance group. Acceptable values are 1 to 100, inclusive.


### DeployPolicy {#DeployPolicy}

Field | Description
--- | ---
max_unavailable | **int64**<br>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If `max_expansion` is not specified or set to zero, `max_unavailable` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
max_deleting | **int64**<br>The maximum number of instances that can be deleted at the same time. Acceptable values are 0 to 100, inclusive.
max_creating | **int64**<br>The maximum number of instances that can be created at the same time. Acceptable values are 0 to 100, inclusive.
max_expansion | **int64**<br>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If `max_unavailable` is not specified or set to zero, `max_expansion` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Instance startup duration. Instance will be considered up and running (and start receiving traffic) only after startup_duration has elapsed and all health checks are passed. See `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status` for more information. Acceptable values are 0m to 1h, inclusive.


### AllocationPolicy {#AllocationPolicy}

Field | Description
--- | ---
zones[] | **[Zone](#Zone)**<br>List of availability zones. The minimum number of elements is 1.


### Zone {#Zone}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the instance resides. false


### LoadBalancerState {#LoadBalancerState}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the target group used for load balancing. 
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
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec)**<br>Specification of the target group that the instance group will be added to. For more information, see [Target groups and resources](/docs/load-balancer/target-resources). 


### TargetGroupSpec {#TargetGroupSpec}

Field | Description
--- | ---
name | **string**<br>Name of the target group. Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the target group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec}

Field | Description
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). The minimum number of elements is 1.


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


## List {#List}

Retrieves the list of InstanceGroup resources in the specified folder.

**rpc List ([ListInstanceGroupsRequest](#ListInstanceGroupsRequest)) returns ([ListInstanceGroupsResponse](#ListInstanceGroupsResponse))**

### ListInstanceGroupsRequest {#ListInstanceGroupsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list instance groups in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. false
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListInstanceGroupsResponse.next_page_token](#ListInstanceGroupsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListInstanceGroupsResponse.next_page_token](#ListInstanceGroupsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. Currently you can use filtering only on the [InstanceGroup.name](#InstanceGroup1) field. The maximum string length in characters is 1000.
view | enum **InstanceGroupView**<br>Defines which information about the Instance template should be returned in the server response. <ul><li>`BASIC`: Doesn't include the metadata of the instance template in the server response.</li><li>`FULL`: Returns the metadata of the instance template in the server response.</li><ul/>


### ListInstanceGroupsResponse {#ListInstanceGroupsResponse}

Field | Description
--- | ---
instance_groups[] | **[InstanceGroup](#InstanceGroup1)**<br>Lists instance groups for the specified folder. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListInstanceGroupsRequest.page_size](#ListInstanceGroupsRequest1), use `next_page_token` as the value for the [ListInstanceGroupsRequest.page_token](#ListInstanceGroupsRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### InstanceGroup {#InstanceGroup}

Field | Description
--- | ---
id | **string**<br>ID of the instance group. 
folder_id | **string**<br>ID of the folder that the instance group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the instance group. The name is unique within the folder. 
description | **string**<br>Description of the instance group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
instance_template | **[InstanceTemplate](#InstanceTemplate1)**<br>Instance template for creating the instance group. For more information, see [Instance Templates](/docs/compute/concepts/ig-instance-templates). 
scale_policy | **[ScalePolicy](#ScalePolicy1)**<br>[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. 
deploy_policy | **[DeployPolicy](#DeployPolicy1)**<br>Deployment policy of the instance group. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy1)**<br>Allocation policy of the instance group by zones and regions. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState1)**<br>Information that indicates which entities can be related to this load balancer. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState1)**<br>States of instances for this instance group. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec1)**<br>Load balancing specification. 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec1)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
status | enum **Status**<br>Status of the instance group. <ul><li>`STARTING`: Instance group is being started and will become active soon.</li><li>`ACTIVE`: Instance group is active. In this state the group manages its instances and monitors their health, creating, deleting, stopping, updating and starting instances as needed. To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Instance group is being stopped. Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.</li><li>`STOPPED`: Instance group is stopped. In this state the group cannot be updated and does not react to any changes made to its instances. To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/grpc/instance_group_service#Start).</li><li>`DELETING`: Instance group is being deleted.</li><ul/>
variables[] | **[Variable](#Variable1)**<br> 
deletion_protection | **bool**<br>Flag that inhibits deletion of the instance group 


### InstanceTemplate {#InstanceTemplate}

Field | Description
--- | ---
description | **string**<br>Description of the instance template. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
platform_id | **string**<br>Required. ID of the hardware platform configuration for the instance. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see [Platforms](/docs/compute/concepts/vm-platforms). false
resources_spec | **[ResourcesSpec](#ResourcesSpec1)**<br>Required. Computing resources of the instance such as the amount of memory and number of cores. false
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>Metadata values may contain one of the supported placeholders: {instance_group.id} {instance.short_id} {instance.index} {instance.index_in_zone} {instance.zone_id} InstanceGroup and Instance labels may be copied to metadata following way: {instance_group.labels.some_label_key} {instance.labels.another_label_key} These placeholders will be substituted for each created instance anywhere in the value text. In the rare case the value requires to contain this placeholder explicitly, it must be escaped with double brackets, in example {instance.index}. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). No more than 128 per resource. The maximum string length in characters for each value is 262144. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec1)**<br>Required. Boot disk specification that will be attached to the instance. false
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec1)**<br>Array of secondary disks that will be attached to the instance. The maximum number of elements is 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec1)**<br>Array of network interfaces that will be attached to the instance. The number of elemets must be exactly 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy1)**<br>Scheduling policy for the instance. 
service_account_id | **string**<br>Service account ID for the instance. 
network_settings | **[NetworkSettings](#NetworkSettings1)**<br>Network settings for the instance. 
name | **string**<br>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
hostname | **string**<br>Host name for the instance. This field is used to generate the `yandex.cloud.compute.v1.Instance.fqdn` value. The host name must be unique within the network and region. If not specified, the host name will be equal to `yandex.cloud.compute.v1.Instance.id` of the instance and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`. <br>In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, `name` value will be used It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.


### ResourcesSpec {#ResourcesSpec}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. The maximum value is 824633720832.
cores | **int64**<br>The number of cores available to the instance. Value must be equal to 1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64.
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. Value must be equal to 0,5,20,50,100.
gpus | **int64**<br>The number of GPUs available to the instance. Value must be equal to 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec}

Field | Description
--- | ---
mode | enum **Mode**<br>Required. Access mode to the Disk resource. false<ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li><ul/>
device_name | **string**<br>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. Value must match the regular expression ` |[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec1)**<br>Required. oneof disk_spec or disk_id Disk specification that is attached to the instance. For more information, see [Disks](/docs/compute/concepts/disk). false
disk_id | **string**<br>Set to use an existing disk. To set use variables. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### DiskSpec {#DiskSpec}

Field | Description
--- | ---
description | **string**<br>Description of the disk. The maximum string length in characters is 256.
type_id | **string**<br>Required. ID of the disk type. false
size | **int64**<br>Size of the disk, specified in bytes. Acceptable values are 4194304 to 4398046511104, inclusive.
source_oneof | **oneof:** `image_id` or `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>ID of the image that will be used for disk creation. The maximum string length in characters is 50.
&nbsp;&nbsp;snapshot_id | **string**<br>ID of the snapshot that will be used for disk creation. The maximum string length in characters is 50.


### NetworkInterfaceSpec {#NetworkInterfaceSpec}

Field | Description
--- | ---
network_id | **string**<br>ID of the network. 
subnet_ids[] | **string**<br>IDs of the subnets. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec1)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec1)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>IDs of security groups. 


### PrimaryAddressSpec {#PrimaryAddressSpec}

Field | Description
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec1)**<br>An external IP address configuration. If not specified, then this managed instance will have no external internet access. 


### OneToOneNatSpec {#OneToOneNatSpec}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>IP version for the public IP address. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy}

Field | Description
--- | ---
preemptible | **bool**<br>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings}

Field | Description
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Type of instance network. <ul><ul/>


### ScalePolicy {#ScalePolicy}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale` or `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale1)**<br>[Manual scaling policy](/docs/compute/concepts/instance-groups/scale#fixed-policy) of the instance group. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale1)**<br>[Automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 
test_auto_scale | **[AutoScale](#AutoScale1)**<br>Test spec for [automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 


### AutoScale {#AutoScale}

Field | Description
--- | ---
min_zone_size | **int64**<br>Lower limit for instance count in each zone. Acceptable values are 0 to 100, inclusive.
max_size | **int64**<br>Upper limit for total instance count (across all zones). 0 means maximum limit = 100. Acceptable values are 0 to 100, inclusive.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time in seconds allotted for averaging metrics. false Acceptable values are 1m to 10m, inclusive.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected. The maximum value is 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should. Acceptable values are 1m to 30m, inclusive.
initial_size | **int64**<br>Target group size. The minimum value is 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule1)**<br>Defines an autoscaling rule based on the average CPU utilization of the instance group. 
custom_rules[] | **[CustomRule](#CustomRule1)**<br>Defines an autoscaling rule based on a [custom metric](/docs/monitoring/operations/metric/add) from Yandex Monitoring. The maximum number of elements is 1.


### CpuUtilizationRule {#CpuUtilizationRule}

Field | Description
--- | ---
utilization_target | **double**<br>Target CPU utilization level. Instance Groups maintains this level for each availability zone. Acceptable values are 10 to 100, inclusive.


### CustomRule {#CustomRule}

Field | Description
--- | ---
rule_type | enum **RuleType**<br>Required. Custom metric rule type. This field affects which label from the custom metric should be used: `zone_id` or `instance_id`. false<ul><li>`UTILIZATION`: This type means that the metric applies to one instance. First, Instance Groups calculates the average metric value for each instance, then averages the values for instances in one availability zone. This type of metric must have the `instance_id` label.</li><li>`WORKLOAD`: This type means that the metric applies to instances in one availability zone. This type of metric must have the `zone_id` label.</li><ul/>
metric_type | enum **MetricType**<br>Required. Type of custom metric. This field affects how Instance Groups calculates the average metric value. false<ul><li>`GAUGE`: This type is used for metrics that show the metric value at a certain point in time, such as requests per second to the server on an instance. <br>Instance Groups calculates the average metric value for the period specified in the [AutoScale.measurement_duration](#AutoScale1) field.</li><li>`COUNTER`: This type is used for metrics that monotonically increase over time, such as the total number of requests to the server on an instance. <br>Instance Groups calculates the average value increase for the period specified in the [AutoScale.measurement_duration](#AutoScale1) field.</li><ul/>
metric_name | **string**<br>Required. Name of custom metric in Yandex Monitoring that should be used for scaling. false Value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
labels | **map<string,string>**<br>Labels of custom metric in Yandex Monitoring that should be used for scaling. Each value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `. Each key must match the regular expression ` ^[a-zA-Z][0-9a-zA-Z_]{0,31}$ `.
target | **double**<br>Target value for the custom metric. Instance Groups maintains this level for each availability zone. Value must be greater than 0.


### FixedScale {#FixedScale}

Field | Description
--- | ---
size | **int64**<br>Number of instances in the instance group. Acceptable values are 1 to 100, inclusive.


### DeployPolicy {#DeployPolicy}

Field | Description
--- | ---
max_unavailable | **int64**<br>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If `max_expansion` is not specified or set to zero, `max_unavailable` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
max_deleting | **int64**<br>The maximum number of instances that can be deleted at the same time. Acceptable values are 0 to 100, inclusive.
max_creating | **int64**<br>The maximum number of instances that can be created at the same time. Acceptable values are 0 to 100, inclusive.
max_expansion | **int64**<br>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If `max_unavailable` is not specified or set to zero, `max_expansion` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Instance startup duration. Instance will be considered up and running (and start receiving traffic) only after startup_duration has elapsed and all health checks are passed. See `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status` for more information. Acceptable values are 0m to 1h, inclusive.


### AllocationPolicy {#AllocationPolicy}

Field | Description
--- | ---
zones[] | **[Zone](#Zone1)**<br>List of availability zones. The minimum number of elements is 1.


### Zone {#Zone}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the instance resides. false


### LoadBalancerState {#LoadBalancerState}

Field | Description
--- | ---
target_group_id | **string**<br>ID of the target group used for load balancing. 
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
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec1)**<br>Specification of the target group that the instance group will be added to. For more information, see [Target groups and resources](/docs/load-balancer/target-resources). 


### TargetGroupSpec {#TargetGroupSpec}

Field | Description
--- | ---
name | **string**<br>Name of the target group. Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the target group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec}

Field | Description
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec1)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). The minimum number of elements is 1.


### HealthCheckSpec {#HealthCheckSpec}

Field | Description
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. Acceptable values are 1s to 300s, inclusive.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the managed instance to return a response for the health check. The default is 1 second. Acceptable values are 1s to 60s, inclusive.
unhealthy_threshold | **int64**<br>The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` or `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions1)**<br>Configuration options for a TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions1)**<br>Configuration options for an HTTP health check. 


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


## Create {#Create}

Creates an instance group in the specified folder. This method starts an operation that can be cancelled by another operation.

**rpc Create ([CreateInstanceGroupRequest](#CreateInstanceGroupRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateInstanceGroupMetadata](#CreateInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](#InstanceGroup2)<br>

### CreateInstanceGroupRequest {#CreateInstanceGroupRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create an instance group in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. false
name | **string**<br>Name of the instance group. Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the instance group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
instance_template | **[InstanceTemplate](#InstanceTemplate2)**<br>Required. Instance template that the instance group belongs to. false
scale_policy | **[ScalePolicy](#ScalePolicy2)**<br>Required. [Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. false
deploy_policy | **[DeployPolicy](#DeployPolicy2)**<br>Required. Deployment policy of the instance group. false
allocation_policy | **[AllocationPolicy](#AllocationPolicy2)**<br>Required. Allocation policy of the instance group by zones and regions. false
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec2)**<br>Load balancing specification. 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec2)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
variables[] | **[Variable](#Variable2)**<br> 
deletion_protection | **bool**<br>Flag that inhibits deletion of the instance group 


### InstanceTemplate {#InstanceTemplate}

Field | Description
--- | ---
description | **string**<br>Description of the instance template. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
platform_id | **string**<br>Required. ID of the hardware platform configuration for the instance. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see [Platforms](/docs/compute/concepts/vm-platforms). false
resources_spec | **[ResourcesSpec](#ResourcesSpec2)**<br>Required. Computing resources of the instance such as the amount of memory and number of cores. false
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>Metadata values may contain one of the supported placeholders: {instance_group.id} {instance.short_id} {instance.index} {instance.index_in_zone} {instance.zone_id} InstanceGroup and Instance labels may be copied to metadata following way: {instance_group.labels.some_label_key} {instance.labels.another_label_key} These placeholders will be substituted for each created instance anywhere in the value text. In the rare case the value requires to contain this placeholder explicitly, it must be escaped with double brackets, in example {instance.index}. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). No more than 128 per resource. The maximum string length in characters for each value is 262144. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec2)**<br>Required. Boot disk specification that will be attached to the instance. false
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec2)**<br>Array of secondary disks that will be attached to the instance. The maximum number of elements is 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec2)**<br>Array of network interfaces that will be attached to the instance. The number of elemets must be exactly 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy2)**<br>Scheduling policy for the instance. 
service_account_id | **string**<br>Service account ID for the instance. 
network_settings | **[NetworkSettings](#NetworkSettings2)**<br>Network settings for the instance. 
name | **string**<br>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
hostname | **string**<br>Host name for the instance. This field is used to generate the `yandex.cloud.compute.v1.Instance.fqdn` value. The host name must be unique within the network and region. If not specified, the host name will be equal to `yandex.cloud.compute.v1.Instance.id` of the instance and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`. <br>In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, `name` value will be used It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.


### ResourcesSpec {#ResourcesSpec}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. The maximum value is 824633720832.
cores | **int64**<br>The number of cores available to the instance. Value must be equal to 1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64.
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. Value must be equal to 0,5,20,50,100.
gpus | **int64**<br>The number of GPUs available to the instance. Value must be equal to 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec}

Field | Description
--- | ---
mode | enum **Mode**<br>Required. Access mode to the Disk resource. false<ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li><ul/>
device_name | **string**<br>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. Value must match the regular expression ` |[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec2)**<br>Required. oneof disk_spec or disk_id Disk specification that is attached to the instance. For more information, see [Disks](/docs/compute/concepts/disk). false
disk_id | **string**<br>Set to use an existing disk. To set use variables. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### DiskSpec {#DiskSpec}

Field | Description
--- | ---
description | **string**<br>Description of the disk. The maximum string length in characters is 256.
type_id | **string**<br>Required. ID of the disk type. false
size | **int64**<br>Size of the disk, specified in bytes. Acceptable values are 4194304 to 4398046511104, inclusive.
source_oneof | **oneof:** `image_id` or `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>ID of the image that will be used for disk creation. The maximum string length in characters is 50.
&nbsp;&nbsp;snapshot_id | **string**<br>ID of the snapshot that will be used for disk creation. The maximum string length in characters is 50.


### NetworkInterfaceSpec {#NetworkInterfaceSpec}

Field | Description
--- | ---
network_id | **string**<br>ID of the network. 
subnet_ids[] | **string**<br>IDs of the subnets. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec2)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec2)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>IDs of security groups. 


### PrimaryAddressSpec {#PrimaryAddressSpec}

Field | Description
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec2)**<br>An external IP address configuration. If not specified, then this managed instance will have no external internet access. 


### OneToOneNatSpec {#OneToOneNatSpec}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>IP version for the public IP address. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy}

Field | Description
--- | ---
preemptible | **bool**<br>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings}

Field | Description
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Type of instance network. <ul><ul/>


### ScalePolicy {#ScalePolicy}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale` or `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale2)**<br>[Manual scaling policy](/docs/compute/concepts/instance-groups/scale#fixed-policy) of the instance group. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale2)**<br>[Automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 
test_auto_scale | **[AutoScale](#AutoScale2)**<br>Test spec for [automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 


### AutoScale {#AutoScale}

Field | Description
--- | ---
min_zone_size | **int64**<br>Lower limit for instance count in each zone. Acceptable values are 0 to 100, inclusive.
max_size | **int64**<br>Upper limit for total instance count (across all zones). 0 means maximum limit = 100. Acceptable values are 0 to 100, inclusive.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time in seconds allotted for averaging metrics. false Acceptable values are 1m to 10m, inclusive.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected. The maximum value is 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should. Acceptable values are 1m to 30m, inclusive.
initial_size | **int64**<br>Target group size. The minimum value is 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule2)**<br>Defines an autoscaling rule based on the average CPU utilization of the instance group. 
custom_rules[] | **[CustomRule](#CustomRule2)**<br>Defines an autoscaling rule based on a [custom metric](/docs/monitoring/operations/metric/add) from Yandex Monitoring. The maximum number of elements is 1.


### CpuUtilizationRule {#CpuUtilizationRule}

Field | Description
--- | ---
utilization_target | **double**<br>Target CPU utilization level. Instance Groups maintains this level for each availability zone. Acceptable values are 10 to 100, inclusive.


### CustomRule {#CustomRule}

Field | Description
--- | ---
rule_type | enum **RuleType**<br>Required. Custom metric rule type. This field affects which label from the custom metric should be used: `zone_id` or `instance_id`. false<ul><li>`UTILIZATION`: This type means that the metric applies to one instance. First, Instance Groups calculates the average metric value for each instance, then averages the values for instances in one availability zone. This type of metric must have the `instance_id` label.</li><li>`WORKLOAD`: This type means that the metric applies to instances in one availability zone. This type of metric must have the `zone_id` label.</li><ul/>
metric_type | enum **MetricType**<br>Required. Type of custom metric. This field affects how Instance Groups calculates the average metric value. false<ul><li>`GAUGE`: This type is used for metrics that show the metric value at a certain point in time, such as requests per second to the server on an instance. <br>Instance Groups calculates the average metric value for the period specified in the [AutoScale.measurement_duration](#AutoScale2) field.</li><li>`COUNTER`: This type is used for metrics that monotonically increase over time, such as the total number of requests to the server on an instance. <br>Instance Groups calculates the average value increase for the period specified in the [AutoScale.measurement_duration](#AutoScale2) field.</li><ul/>
metric_name | **string**<br>Required. Name of custom metric in Yandex Monitoring that should be used for scaling. false Value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
labels | **map<string,string>**<br>Labels of custom metric in Yandex Monitoring that should be used for scaling. Each value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `. Each key must match the regular expression ` ^[a-zA-Z][0-9a-zA-Z_]{0,31}$ `.
target | **double**<br>Target value for the custom metric. Instance Groups maintains this level for each availability zone. Value must be greater than 0.


### FixedScale {#FixedScale}

Field | Description
--- | ---
size | **int64**<br>Number of instances in the instance group. Acceptable values are 1 to 100, inclusive.


### DeployPolicy {#DeployPolicy}

Field | Description
--- | ---
max_unavailable | **int64**<br>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If `max_expansion` is not specified or set to zero, `max_unavailable` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
max_deleting | **int64**<br>The maximum number of instances that can be deleted at the same time. Acceptable values are 0 to 100, inclusive.
max_creating | **int64**<br>The maximum number of instances that can be created at the same time. Acceptable values are 0 to 100, inclusive.
max_expansion | **int64**<br>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If `max_unavailable` is not specified or set to zero, `max_expansion` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Instance startup duration. Instance will be considered up and running (and start receiving traffic) only after startup_duration has elapsed and all health checks are passed. See `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status` for more information. Acceptable values are 0m to 1h, inclusive.


### AllocationPolicy {#AllocationPolicy}

Field | Description
--- | ---
zones[] | **[Zone](#Zone2)**<br>List of availability zones. The minimum number of elements is 1.


### Zone {#Zone}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the instance resides. false


### LoadBalancerSpec {#LoadBalancerSpec}

Field | Description
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec2)**<br>Specification of the target group that the instance group will be added to. For more information, see [Target groups and resources](/docs/load-balancer/target-resources). 


### TargetGroupSpec {#TargetGroupSpec}

Field | Description
--- | ---
name | **string**<br>Name of the target group. Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the target group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.


### HealthChecksSpec {#HealthChecksSpec}

Field | Description
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec2)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). The minimum number of elements is 1.


### HealthCheckSpec {#HealthCheckSpec}

Field | Description
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. Acceptable values are 1s to 300s, inclusive.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the managed instance to return a response for the health check. The default is 1 second. Acceptable values are 1s to 60s, inclusive.
unhealthy_threshold | **int64**<br>The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` or `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions2)**<br>Configuration options for a TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions2)**<br>Configuration options for an HTTP health check. 


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


### InstanceGroup {#InstanceGroup}

Field | Description
--- | ---
id | **string**<br>ID of the instance group. 
folder_id | **string**<br>ID of the folder that the instance group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the instance group. The name is unique within the folder. 
description | **string**<br>Description of the instance group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
instance_template | **[InstanceTemplate](#InstanceTemplate3)**<br>Instance template for creating the instance group. For more information, see [Instance Templates](/docs/compute/concepts/ig-instance-templates). 
scale_policy | **[ScalePolicy](#ScalePolicy3)**<br>[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. 
deploy_policy | **[DeployPolicy](#DeployPolicy3)**<br>Deployment policy of the instance group. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy3)**<br>Allocation policy of the instance group by zones and regions. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState2)**<br>Information that indicates which entities can be related to this load balancer. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState2)**<br>States of instances for this instance group. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec3)**<br>Load balancing specification. 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec3)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
status | enum **Status**<br>Status of the instance group. <ul><li>`STARTING`: Instance group is being started and will become active soon.</li><li>`ACTIVE`: Instance group is active. In this state the group manages its instances and monitors their health, creating, deleting, stopping, updating and starting instances as needed. To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Instance group is being stopped. Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.</li><li>`STOPPED`: Instance group is stopped. In this state the group cannot be updated and does not react to any changes made to its instances. To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/grpc/instance_group_service#Start).</li><li>`DELETING`: Instance group is being deleted.</li><ul/>
variables[] | **[Variable](#Variable3)**<br> 
deletion_protection | **bool**<br>Flag that inhibits deletion of the instance group 


## CreateFromYaml {#CreateFromYaml}

Creates an instance group in the specified folder from a YAML file. This method starts an operation that can be cancelled by another operation.

**rpc CreateFromYaml ([CreateInstanceGroupFromYamlRequest](#CreateInstanceGroupFromYamlRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateInstanceGroupMetadata](#CreateInstanceGroupMetadata1)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](#InstanceGroup3)<br>

### CreateInstanceGroupFromYamlRequest {#CreateInstanceGroupFromYamlRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create an instance group in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. false
instance_group_yaml | **string**<br>Required. [InstanceGroupService.Create](#Create) request in YAML format. false The maximum string length in characters is 1048576.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateInstanceGroupMetadata](#CreateInstanceGroupMetadata1)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](#InstanceGroup3)>**<br>if operation finished successfully. 


### CreateInstanceGroupMetadata {#CreateInstanceGroupMetadata}

Field | Description
--- | ---
instance_group_id | **string**<br>ID of the instance group that is being created. The maximum string length in characters is 50.


### InstanceGroup {#InstanceGroup}

Field | Description
--- | ---
id | **string**<br>ID of the instance group. 
folder_id | **string**<br>ID of the folder that the instance group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the instance group. The name is unique within the folder. 
description | **string**<br>Description of the instance group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
instance_template | **[InstanceTemplate](#InstanceTemplate3)**<br>Instance template for creating the instance group. For more information, see [Instance Templates](/docs/compute/concepts/ig-instance-templates). 
scale_policy | **[ScalePolicy](#ScalePolicy3)**<br>[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. 
deploy_policy | **[DeployPolicy](#DeployPolicy3)**<br>Deployment policy of the instance group. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy3)**<br>Allocation policy of the instance group by zones and regions. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState2)**<br>Information that indicates which entities can be related to this load balancer. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState2)**<br>States of instances for this instance group. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec3)**<br>Load balancing specification. 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec3)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
status | enum **Status**<br>Status of the instance group. <ul><li>`STARTING`: Instance group is being started and will become active soon.</li><li>`ACTIVE`: Instance group is active. In this state the group manages its instances and monitors their health, creating, deleting, stopping, updating and starting instances as needed. To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Instance group is being stopped. Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.</li><li>`STOPPED`: Instance group is stopped. In this state the group cannot be updated and does not react to any changes made to its instances. To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/grpc/instance_group_service#Start).</li><li>`DELETING`: Instance group is being deleted.</li><ul/>
variables[] | **[Variable](#Variable3)**<br> 
deletion_protection | **bool**<br>Flag that inhibits deletion of the instance group 


## Update {#Update}

Updates the specified instance group. This method starts an operation that can be cancelled by another operation.

**rpc Update ([UpdateInstanceGroupRequest](#UpdateInstanceGroupRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateInstanceGroupMetadata](#UpdateInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](#InstanceGroup4)<br>

### UpdateInstanceGroupRequest {#UpdateInstanceGroupRequest}

Field | Description
--- | ---
instance_group_id | **string**<br>Required. ID of the instance group to update. To get the instance group ID, use a [InstanceGroupService.List](#List) request. false The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the InstanceGroup resource are going to be updated. 
name | **string**<br>Name of the instance group. Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the instance group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. <br>The existing set of `labels` is completely replaced by the provided set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
instance_template | **[InstanceTemplate](#InstanceTemplate3)**<br>Required. Instance template that the instance group belongs to. false
scale_policy | **[ScalePolicy](#ScalePolicy3)**<br>Required. [Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. false
deploy_policy | **[DeployPolicy](#DeployPolicy3)**<br>Required. Deployment policy of the instance group. false
allocation_policy | **[AllocationPolicy](#AllocationPolicy3)**<br>Required. Allocation policy of the instance group by zones and regions. false
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec3)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec3)**<br>Load Balancer specification for load balancing support. 
variables[] | **[Variable](#Variable3)**<br> 
deletion_protection | **bool**<br>Flag that inhibits deletion of the instance group 


### InstanceTemplate {#InstanceTemplate}

Field | Description
--- | ---
description | **string**<br>Description of the instance template. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
platform_id | **string**<br>Required. ID of the hardware platform configuration for the instance. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see [Platforms](/docs/compute/concepts/vm-platforms). false
resources_spec | **[ResourcesSpec](#ResourcesSpec3)**<br>Required. Computing resources of the instance such as the amount of memory and number of cores. false
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys. <br>Metadata values may contain one of the supported placeholders: {instance_group.id} {instance.short_id} {instance.index} {instance.index_in_zone} {instance.zone_id} InstanceGroup and Instance labels may be copied to metadata following way: {instance_group.labels.some_label_key} {instance.labels.another_label_key} These placeholders will be substituted for each created instance anywhere in the value text. In the rare case the value requires to contain this placeholder explicitly, it must be escaped with double brackets, in example {instance.index}. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). No more than 128 per resource. The maximum string length in characters for each value is 262144. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec3)**<br>Required. Boot disk specification that will be attached to the instance. false
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec3)**<br>Array of secondary disks that will be attached to the instance. The maximum number of elements is 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec3)**<br>Array of network interfaces that will be attached to the instance. The number of elemets must be exactly 1.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy3)**<br>Scheduling policy for the instance. 
service_account_id | **string**<br>Service account ID for the instance. 
network_settings | **[NetworkSettings](#NetworkSettings3)**<br>Network settings for the instance. 
name | **string**<br>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.
hostname | **string**<br>Host name for the instance. This field is used to generate the `yandex.cloud.compute.v1.Instance.fqdn` value. The host name must be unique within the network and region. If not specified, the host name will be equal to `yandex.cloud.compute.v1.Instance.id` of the instance and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`. <br>In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, `name` value will be used It may also contain another placeholders, see metadata doc for full list. The maximum string length in characters is 128.


### ResourcesSpec {#ResourcesSpec}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. The maximum value is 824633720832.
cores | **int64**<br>The number of cores available to the instance. Value must be equal to 1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64.
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. Value must be equal to 0,5,20,50,100.
gpus | **int64**<br>The number of GPUs available to the instance. Value must be equal to 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec}

Field | Description
--- | ---
mode | enum **Mode**<br>Required. Access mode to the Disk resource. false<ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li><ul/>
device_name | **string**<br>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. Value must match the regular expression ` |[a-z][-_0-9a-z]{0,19} `.
disk_spec | **[DiskSpec](#DiskSpec3)**<br>Required. oneof disk_spec or disk_id Disk specification that is attached to the instance. For more information, see [Disks](/docs/compute/concepts/disk). false
disk_id | **string**<br>Set to use an existing disk. To set use variables. The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `.


### DiskSpec {#DiskSpec}

Field | Description
--- | ---
description | **string**<br>Description of the disk. The maximum string length in characters is 256.
type_id | **string**<br>Required. ID of the disk type. false
size | **int64**<br>Size of the disk, specified in bytes. Acceptable values are 4194304 to 4398046511104, inclusive.
source_oneof | **oneof:** `image_id` or `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>ID of the image that will be used for disk creation. The maximum string length in characters is 50.
&nbsp;&nbsp;snapshot_id | **string**<br>ID of the snapshot that will be used for disk creation. The maximum string length in characters is 50.


### NetworkInterfaceSpec {#NetworkInterfaceSpec}

Field | Description
--- | ---
network_id | **string**<br>ID of the network. 
subnet_ids[] | **string**<br>IDs of the subnets. 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec3)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec3)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>IDs of security groups. 


### PrimaryAddressSpec {#PrimaryAddressSpec}

Field | Description
--- | ---
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec3)**<br>An external IP address configuration. If not specified, then this managed instance will have no external internet access. 


### OneToOneNatSpec {#OneToOneNatSpec}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>IP version for the public IP address. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy}

Field | Description
--- | ---
preemptible | **bool**<br>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings}

Field | Description
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Type of instance network. <ul><ul/>


### ScalePolicy {#ScalePolicy}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale` or `auto_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale3)**<br>[Manual scaling policy](/docs/compute/concepts/instance-groups/scale#fixed-policy) of the instance group. 
&nbsp;&nbsp;auto_scale | **[AutoScale](#AutoScale3)**<br>[Automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 
test_auto_scale | **[AutoScale](#AutoScale3)**<br>Test spec for [automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. 


### AutoScale {#AutoScale}

Field | Description
--- | ---
min_zone_size | **int64**<br>Lower limit for instance count in each zone. Acceptable values are 0 to 100, inclusive.
max_size | **int64**<br>Upper limit for total instance count (across all zones). 0 means maximum limit = 100. Acceptable values are 0 to 100, inclusive.
measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time in seconds allotted for averaging metrics. false Acceptable values are 1m to 10m, inclusive.
warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected. The maximum value is 10m.
stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should. Acceptable values are 1m to 30m, inclusive.
initial_size | **int64**<br>Target group size. The minimum value is 1.
cpu_utilization_rule | **[CpuUtilizationRule](#CpuUtilizationRule3)**<br>Defines an autoscaling rule based on the average CPU utilization of the instance group. 
custom_rules[] | **[CustomRule](#CustomRule3)**<br>Defines an autoscaling rule based on a [custom metric](/docs/monitoring/operations/metric/add) from Yandex Monitoring. The maximum number of elements is 1.


### CpuUtilizationRule {#CpuUtilizationRule}

Field | Description
--- | ---
utilization_target | **double**<br>Target CPU utilization level. Instance Groups maintains this level for each availability zone. Acceptable values are 10 to 100, inclusive.


### CustomRule {#CustomRule}

Field | Description
--- | ---
rule_type | enum **RuleType**<br>Required. Custom metric rule type. This field affects which label from the custom metric should be used: `zone_id` or `instance_id`. false<ul><li>`UTILIZATION`: This type means that the metric applies to one instance. First, Instance Groups calculates the average metric value for each instance, then averages the values for instances in one availability zone. This type of metric must have the `instance_id` label.</li><li>`WORKLOAD`: This type means that the metric applies to instances in one availability zone. This type of metric must have the `zone_id` label.</li><ul/>
metric_type | enum **MetricType**<br>Required. Type of custom metric. This field affects how Instance Groups calculates the average metric value. false<ul><li>`GAUGE`: This type is used for metrics that show the metric value at a certain point in time, such as requests per second to the server on an instance. <br>Instance Groups calculates the average metric value for the period specified in the [AutoScale.measurement_duration](#AutoScale3) field.</li><li>`COUNTER`: This type is used for metrics that monotonically increase over time, such as the total number of requests to the server on an instance. <br>Instance Groups calculates the average value increase for the period specified in the [AutoScale.measurement_duration](#AutoScale3) field.</li><ul/>
metric_name | **string**<br>Required. Name of custom metric in Yandex Monitoring that should be used for scaling. false Value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `.
labels | **map<string,string>**<br>Labels of custom metric in Yandex Monitoring that should be used for scaling. Each value must match the regular expression ` [a-zA-Z0-9./@_][0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198} `. Each key must match the regular expression ` ^[a-zA-Z][0-9a-zA-Z_]{0,31}$ `.
target | **double**<br>Target value for the custom metric. Instance Groups maintains this level for each availability zone. Value must be greater than 0.


### FixedScale {#FixedScale}

Field | Description
--- | ---
size | **int64**<br>Number of instances in the instance group. Acceptable values are 1 to 100, inclusive.


### DeployPolicy {#DeployPolicy}

Field | Description
--- | ---
max_unavailable | **int64**<br>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If `max_expansion` is not specified or set to zero, `max_unavailable` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
max_deleting | **int64**<br>The maximum number of instances that can be deleted at the same time. Acceptable values are 0 to 100, inclusive.
max_creating | **int64**<br>The maximum number of instances that can be created at the same time. Acceptable values are 0 to 100, inclusive.
max_expansion | **int64**<br>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If `max_unavailable` is not specified or set to zero, `max_expansion` must be set to a non-zero value. Acceptable values are 0 to 100, inclusive.
startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Instance startup duration. Instance will be considered up and running (and start receiving traffic) only after startup_duration has elapsed and all health checks are passed. See `yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status` for more information. Acceptable values are 0m to 1h, inclusive.


### AllocationPolicy {#AllocationPolicy}

Field | Description
--- | ---
zones[] | **[Zone](#Zone3)**<br>List of availability zones. The minimum number of elements is 1.


### Zone {#Zone}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone where the instance resides. false


### HealthChecksSpec {#HealthChecksSpec}

Field | Description
--- | ---
health_check_specs[] | **[HealthCheckSpec](#HealthCheckSpec3)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). The minimum number of elements is 1.


### HealthCheckSpec {#HealthCheckSpec}

Field | Description
--- | ---
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>The interval between health checks. The default is 2 seconds. Acceptable values are 1s to 300s, inclusive.
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Timeout for the managed instance to return a response for the health check. The default is 1 second. Acceptable values are 1s to 60s, inclusive.
unhealthy_threshold | **int64**<br>The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
healthy_threshold | **int64**<br>The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2. Value must be equal to 0,2,3,4,5,6,7,8,9,10.
health_check_options | **oneof:** `tcp_options` or `http_options`<br>
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions3)**<br>Configuration options for a TCP health check. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions3)**<br>Configuration options for an HTTP health check. 


### TcpOptions {#TcpOptions}

Field | Description
--- | ---
port | **int64**<br>Port to use for TCP health checks. Acceptable values are 1 to 65535, inclusive.


### HttpOptions {#HttpOptions}

Field | Description
--- | ---
port | **int64**<br>Port to use for HTTP health checks. Acceptable values are 1 to 65535, inclusive.
path | **string**<br>URL path to set for health checking requests. 


### LoadBalancerSpec {#LoadBalancerSpec}

Field | Description
--- | ---
target_group_spec | **[TargetGroupSpec](#TargetGroupSpec3)**<br>Specification of the target group that the instance group will be added to. For more information, see [Target groups and resources](/docs/load-balancer/target-resources). 


### TargetGroupSpec {#TargetGroupSpec}

Field | Description
--- | ---
name | **string**<br>Name of the target group. Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the target group. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.


### Variable {#Variable}

Field | Description
--- | ---
key | **string**<br> The string length in characters must be 1-128. Value must match the regular expression ` [a-zA-Z0-9._-]* `.
value | **string**<br> The maximum string length in characters is 128.


### Operation {#Operation}

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


### InstanceGroup {#InstanceGroup}

Field | Description
--- | ---
id | **string**<br>ID of the instance group. 
folder_id | **string**<br>ID of the folder that the instance group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the instance group. The name is unique within the folder. 
description | **string**<br>Description of the instance group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
instance_template | **[InstanceTemplate](#InstanceTemplate4)**<br>Instance template for creating the instance group. For more information, see [Instance Templates](/docs/compute/concepts/ig-instance-templates). 
scale_policy | **[ScalePolicy](#ScalePolicy4)**<br>[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. 
deploy_policy | **[DeployPolicy](#DeployPolicy4)**<br>Deployment policy of the instance group. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy4)**<br>Allocation policy of the instance group by zones and regions. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState2)**<br>Information that indicates which entities can be related to this load balancer. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState2)**<br>States of instances for this instance group. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec4)**<br>Load balancing specification. 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec4)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
status | enum **Status**<br>Status of the instance group. <ul><li>`STARTING`: Instance group is being started and will become active soon.</li><li>`ACTIVE`: Instance group is active. In this state the group manages its instances and monitors their health, creating, deleting, stopping, updating and starting instances as needed. To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Instance group is being stopped. Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.</li><li>`STOPPED`: Instance group is stopped. In this state the group cannot be updated and does not react to any changes made to its instances. To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/grpc/instance_group_service#Start).</li><li>`DELETING`: Instance group is being deleted.</li><ul/>
variables[] | **[Variable](#Variable4)**<br> 
deletion_protection | **bool**<br>Flag that inhibits deletion of the instance group 


## UpdateFromYaml {#UpdateFromYaml}

Updates the specified instance group from a YAML file. This method starts an operation that can be cancelled by another operation.

**rpc UpdateFromYaml ([UpdateInstanceGroupFromYamlRequest](#UpdateInstanceGroupFromYamlRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateInstanceGroupMetadata](#UpdateInstanceGroupMetadata1)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](#InstanceGroup5)<br>

### UpdateInstanceGroupFromYamlRequest {#UpdateInstanceGroupFromYamlRequest}

Field | Description
--- | ---
instance_group_id | **string**<br>Required. ID of the instance group to update. To get the instance group ID, use a [InstanceGroupService.List](#List) request. false The maximum string length in characters is 50.
instance_group_yaml | **string**<br>Required. [InstanceGroupService.Update](#Update) request in YAML format. false The maximum string length in characters is 1048576.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateInstanceGroupMetadata](#UpdateInstanceGroupMetadata1)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstanceGroup](#InstanceGroup5)>**<br>if operation finished successfully. 


### UpdateInstanceGroupMetadata {#UpdateInstanceGroupMetadata}

Field | Description
--- | ---
instance_group_id | **string**<br>ID of the InstanceGroup resource that is being updated. To get the instance group ID, use a [InstanceGroupService.List](#List) request. 


### InstanceGroup {#InstanceGroup}

Field | Description
--- | ---
id | **string**<br>ID of the instance group. 
folder_id | **string**<br>ID of the folder that the instance group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the instance group. The name is unique within the folder. 
description | **string**<br>Description of the instance group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
instance_template | **[InstanceTemplate](#InstanceTemplate4)**<br>Instance template for creating the instance group. For more information, see [Instance Templates](/docs/compute/concepts/ig-instance-templates). 
scale_policy | **[ScalePolicy](#ScalePolicy4)**<br>[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. 
deploy_policy | **[DeployPolicy](#DeployPolicy4)**<br>Deployment policy of the instance group. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy4)**<br>Allocation policy of the instance group by zones and regions. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState2)**<br>Information that indicates which entities can be related to this load balancer. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState2)**<br>States of instances for this instance group. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec4)**<br>Load balancing specification. 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec4)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
status | enum **Status**<br>Status of the instance group. <ul><li>`STARTING`: Instance group is being started and will become active soon.</li><li>`ACTIVE`: Instance group is active. In this state the group manages its instances and monitors their health, creating, deleting, stopping, updating and starting instances as needed. To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Instance group is being stopped. Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.</li><li>`STOPPED`: Instance group is stopped. In this state the group cannot be updated and does not react to any changes made to its instances. To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/grpc/instance_group_service#Start).</li><li>`DELETING`: Instance group is being deleted.</li><ul/>
variables[] | **[Variable](#Variable4)**<br> 
deletion_protection | **bool**<br>Flag that inhibits deletion of the instance group 


## Stop {#Stop}

Stops the specified instance group.

**rpc Stop ([StopInstanceGroupRequest](#StopInstanceGroupRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopInstanceGroupMetadata](#StopInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](#InstanceGroup6)<br>

### StopInstanceGroupRequest {#StopInstanceGroupRequest}

Field | Description
--- | ---
instance_group_id | **string**<br>Required. ID of the instance group to stop. To get the instance group ID, use a [InstanceGroupService.List](#List) request. false The maximum string length in characters is 50.


### Operation {#Operation}

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


### InstanceGroup {#InstanceGroup}

Field | Description
--- | ---
id | **string**<br>ID of the instance group. 
folder_id | **string**<br>ID of the folder that the instance group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the instance group. The name is unique within the folder. 
description | **string**<br>Description of the instance group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
instance_template | **[InstanceTemplate](#InstanceTemplate4)**<br>Instance template for creating the instance group. For more information, see [Instance Templates](/docs/compute/concepts/ig-instance-templates). 
scale_policy | **[ScalePolicy](#ScalePolicy4)**<br>[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. 
deploy_policy | **[DeployPolicy](#DeployPolicy4)**<br>Deployment policy of the instance group. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy4)**<br>Allocation policy of the instance group by zones and regions. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState2)**<br>Information that indicates which entities can be related to this load balancer. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState2)**<br>States of instances for this instance group. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec4)**<br>Load balancing specification. 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec4)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
status | enum **Status**<br>Status of the instance group. <ul><li>`STARTING`: Instance group is being started and will become active soon.</li><li>`ACTIVE`: Instance group is active. In this state the group manages its instances and monitors their health, creating, deleting, stopping, updating and starting instances as needed. To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Instance group is being stopped. Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.</li><li>`STOPPED`: Instance group is stopped. In this state the group cannot be updated and does not react to any changes made to its instances. To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/grpc/instance_group_service#Start).</li><li>`DELETING`: Instance group is being deleted.</li><ul/>
variables[] | **[Variable](#Variable4)**<br> 
deletion_protection | **bool**<br>Flag that inhibits deletion of the instance group 


## Start {#Start}

Starts the specified instance group.

**rpc Start ([StartInstanceGroupRequest](#StartInstanceGroupRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartInstanceGroupMetadata](#StartInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstanceGroup](#InstanceGroup7)<br>

### StartInstanceGroupRequest {#StartInstanceGroupRequest}

Field | Description
--- | ---
instance_group_id | **string**<br>Required. ID of the instance group to start. To get the instance group ID, use a [InstanceGroupService.List](#List) request. false The maximum string length in characters is 50.


### Operation {#Operation}

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


### InstanceGroup {#InstanceGroup}

Field | Description
--- | ---
id | **string**<br>ID of the instance group. 
folder_id | **string**<br>ID of the folder that the instance group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the instance group. The name is unique within the folder. 
description | **string**<br>Description of the instance group. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
instance_template | **[InstanceTemplate](#InstanceTemplate4)**<br>Instance template for creating the instance group. For more information, see [Instance Templates](/docs/compute/concepts/ig-instance-templates). 
scale_policy | **[ScalePolicy](#ScalePolicy4)**<br>[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. 
deploy_policy | **[DeployPolicy](#DeployPolicy4)**<br>Deployment policy of the instance group. 
allocation_policy | **[AllocationPolicy](#AllocationPolicy4)**<br>Allocation policy of the instance group by zones and regions. 
load_balancer_state | **[LoadBalancerState](#LoadBalancerState2)**<br>Information that indicates which entities can be related to this load balancer. 
managed_instances_state | **[ManagedInstancesState](#ManagedInstancesState2)**<br>States of instances for this instance group. 
load_balancer_spec | **[LoadBalancerSpec](#LoadBalancerSpec4)**<br>Load balancing specification. 
health_checks_spec | **[HealthChecksSpec](#HealthChecksSpec4)**<br>Health checking specification. For more information, see [Health check](/docs/load-balancer/concepts/health-check). 
service_account_id | **string**<br>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
status | enum **Status**<br>Status of the instance group. <ul><li>`STARTING`: Instance group is being started and will become active soon.</li><li>`ACTIVE`: Instance group is active. In this state the group manages its instances and monitors their health, creating, deleting, stopping, updating and starting instances as needed. To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/grpc/instance_group_service#Stop).</li><li>`STOPPING`: Instance group is being stopped. Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.</li><li>`STOPPED`: Instance group is stopped. In this state the group cannot be updated and does not react to any changes made to its instances. To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/grpc/instance_group_service#Start).</li><li>`DELETING`: Instance group is being deleted.</li><ul/>
variables[] | **[Variable](#Variable4)**<br> 
deletion_protection | **bool**<br>Flag that inhibits deletion of the instance group 


## Delete {#Delete}

Deletes the specified instance group.

**rpc Delete ([DeleteInstanceGroupRequest](#DeleteInstanceGroupRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteInstanceGroupMetadata](#DeleteInstanceGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteInstanceGroupRequest {#DeleteInstanceGroupRequest}

Field | Description
--- | ---
instance_group_id | **string**<br>Required. ID of the instance group to delete. To get the instance group ID, use a [InstanceGroupService.List](#List) request. false The maximum string length in characters is 50.


### Operation {#Operation}

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
instance_group_id | **string**<br>Required. ID of the InstanceGroup resource to list instances for. To get the instance group ID, use a [InstanceGroupService.List](#List) request. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListInstanceGroupInstancesResponse.next_page_token](#ListInstanceGroupInstancesResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListInstanceGroupInstancesResponse.next_page_token](#ListInstanceGroupInstancesResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. Currently you can use filtering only on the [InstanceGroup.name](#InstanceGroup8) field. The maximum string length in characters is 1000.


### ListInstanceGroupInstancesResponse {#ListInstanceGroupInstancesResponse}

Field | Description
--- | ---
instances[] | **[ManagedInstance](#ManagedInstance)**<br>Lists instances for the specified instance group. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is more than [ListInstanceGroupInstancesRequest.page_size](#ListInstanceGroupInstancesRequest1), use `next_page_token` as the value for the [ListInstanceGroupInstancesRequest.page_token](#ListInstanceGroupInstancesRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### ManagedInstance {#ManagedInstance}

Field | Description
--- | ---
id | **string**<br>ID of the managed instance. 
status | enum **Status**<br>Status of the managed instance. <ul><li>`CREATING_INSTANCE`: Instance is being created.</li><li>`UPDATING_INSTANCE`: Instance is being updated.</li><li>`DELETING_INSTANCE`: Instance is being deleted.</li><li>`STARTING_INSTANCE`: Instance is being started.</li><li>`STOPPING_INSTANCE`: Instance is being stopped.</li><li>`AWAITING_STARTUP_DURATION`: Instance has been created successfully, but startup duration has not elapsed yet.</li><li>`CHECKING_HEALTH`: Instance has been created successfully and startup duration has elapsed, but health checks have not passed yet and the managed instance is not ready to receive traffic.</li><li>`OPENING_TRAFFIC`: Instance Groups is initiating health checks and routing traffic to the instances.</li><li>`AWAITING_WARMUP_DURATION`: Instance is now receiving traffic, but warmup duration has not elapsed yet.</li><li>`CLOSING_TRAFFIC`: Instance Groups has initiated the process of stopping routing traffic to the instances.</li><li>`RUNNING_ACTUAL`: Instance is running normally and its attributes match the current InstanceTemplate.</li><li>`RUNNING_OUTDATED`: Instance is running normally, but its attributes do not match the current InstanceTemplate. It will be updated, recreated or deleted shortly.</li><li>`STOPPED`: Instance was stopped.</li><li>`DELETED`: Instance was deleted.</li><ul/>
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


### OneToOneNat {#OneToOneNat}

Field | Description
--- | ---
address | **string**<br>An IPv4 external network address that is assigned to the managed instance for this network interface. 
ip_version | enum **IpVersion**<br>External IP address version. <ul><li>`IPV4`: IPv4 address, for example 192.168.0.0.</li><li>`IPV6`: IPv6 address, not available yet.</li><ul/>


## ListOperations {#ListOperations}

Lists operations for the specified instance group.

**rpc ListOperations ([ListInstanceGroupOperationsRequest](#ListInstanceGroupOperationsRequest)) returns ([ListInstanceGroupOperationsResponse](#ListInstanceGroupOperationsResponse))**

### ListInstanceGroupOperationsRequest {#ListInstanceGroupOperationsRequest}

Field | Description
--- | ---
instance_group_id | **string**<br>Required. ID of the InstanceGroup resource to list operations for. To get the instance group ID, use a [InstanceGroupService.List](#List) request. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is more than `page_size`, the service returns a [ListInstanceGroupOperationsResponse.next_page_token](#ListInstanceGroupOperationsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListInstanceGroupOperationsResponse.next_page_token](#ListInstanceGroupOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. Currently you can use filtering only on the [InstanceGroup.name](#InstanceGroup8) field. The maximum string length in characters is 1000.


### ListInstanceGroupOperationsResponse {#ListInstanceGroupOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation7)**<br>Lists operations for the specified instance group. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is more than [ListInstanceGroupOperationsRequest.page_size](#ListInstanceGroupOperationsRequest1), use the `next_page_token` as the value for the [ListInstanceGroupOperationsRequest.page_token](#ListInstanceGroupOperationsRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation}

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
instance_group_id | **string**<br>Required. ID of the InstanceGroup resource to list logs for. To get the instance group ID, use a [InstanceGroupService.List](#List) request. false
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListInstanceGroupLogRecordsResponse.next_page_token](#ListInstanceGroupLogRecordsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListInstanceGroupLogRecordsResponse.next_page_token](#ListInstanceGroupLogRecordsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. Currently you can use filtering only on the [InstanceGroup.name](#InstanceGroup8) field. The maximum string length in characters is 1000.


### ListInstanceGroupLogRecordsResponse {#ListInstanceGroupLogRecordsResponse}

Field | Description
--- | ---
log_records[] | **[LogRecord](#LogRecord)**<br>Lists logs for the specified instance group. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListInstanceGroupLogRecordsRequest.page_size](#ListInstanceGroupLogRecordsRequest1), use `next_page_token` as the value for the [ListInstanceGroupLogRecordsRequest.page_token](#ListInstanceGroupLogRecordsRequest1) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


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
resource_id | **string**<br>Required. ID of the resource to list access bindings for. <br>To get the resource ID, use a corresponding List request. For example, use the [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/grpc/cloud_service#List) request to get the Cloud resource ID. false
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
role_id | **string**<br>ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. false


### Subject {#Subject}

Field | Description
--- | ---
id | **string**<br><ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul> The maximum string length in characters is 50.
type | **string**<br><ul><li>`userAccount`: An account on Yandex or [Yandex.Connect](./disk#Connect)(https://connect.yandex.com), added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul> 


## SetAccessBindings {#SetAccessBindings}

Sets access bindings for the specified instance group.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation8))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### SetAccessBindingsRequest {#SetAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource for which access bindings are being set. <br>To get the resource ID, use a corresponding List request. false
access_bindings[] | **[AccessBinding](#AccessBinding)**<br>Required. Access bindings to be set. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings). false


### AccessBinding {#AccessBinding}

Field | Description
--- | ---
role_id | **string**<br>ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. false


### Subject {#Subject}

Field | Description
--- | ---
id | **string**<br><ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul> The maximum string length in characters is 50.
type | **string**<br><ul><li>`userAccount`: An account on Yandex or [Yandex.Connect](./disk#Connect)(https://connect.yandex.com), added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul> 


### Operation {#Operation}

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

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation9))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateAccessBindingsRequest {#UpdateAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource for which access bindings are being updated. false
access_binding_deltas[] | **[AccessBindingDelta](#AccessBindingDelta)**<br>Required. Updates to access bindings. false


### AccessBindingDelta {#AccessBindingDelta}

Field | Description
--- | ---
action | enum **AccessBindingAction**<br>Required. The action that is being performed on an access binding. false<ul><li>`ADD`: Addition of an access binding.</li><li>`REMOVE`: Removal of an access binding.</li><ul/>
access_binding | **[AccessBinding](#AccessBinding)**<br>Required. Access binding. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings). false


### AccessBinding {#AccessBinding}

Field | Description
--- | ---
role_id | **string**<br>ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. false


### Subject {#Subject}

Field | Description
--- | ---
id | **string**<br><ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul> The maximum string length in characters is 50.
type | **string**<br><ul><li>`userAccount`: An account on Yandex or [Yandex.Connect](./disk#Connect)(https://connect.yandex.com), added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul> 


### Operation {#Operation}

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


