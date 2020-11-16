---
editable: false
---

# InstanceService

A set of methods for managing Instance resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Instance resource. |
| [List](#List) | Retrieves the list of Instance resources in the specified folder. |
| [Create](#Create) | Creates an instance in the specified folder. |
| [Update](#Update) | Updates the specified instance. |
| [Delete](#Delete) | Deletes the specified instance. |
| [UpdateMetadata](#UpdateMetadata) | Updates the metadata of the specified instance. |
| [GetSerialPortOutput](#GetSerialPortOutput) | Returns the serial port output of the specified Instance resource. |
| [Stop](#Stop) | Stops the running instance. |
| [Start](#Start) | Starts the stopped instance. |
| [Restart](#Restart) | Restarts the running instance. |
| [AttachDisk](#AttachDisk) | Attaches the disk to the instance. |
| [DetachDisk](#DetachDisk) | Detaches the disk from the instance. |
| [AddOneToOneNat](#AddOneToOneNat) | net |
| [RemoveOneToOneNat](#RemoveOneToOneNat) |  |
| [UpdateNetworkInterface](#UpdateNetworkInterface) |  |
| [ListOperations](#ListOperations) | Lists operations for the specified instance. |

## Calls InstanceService {#calls}

## Get {#Get}

Returns the specified Instance resource. <br>To get the list of available Instance resources, make a [List](#List) request.

**rpc Get ([GetInstanceRequest](#GetInstanceRequest)) returns ([Instance](#Instance))**

### GetInstanceRequest {#GetInstanceRequest}

Field | Description
--- | ---
instance_id | **string**<br>Required. ID of the Instance resource to return. To get the instance ID, use a [InstanceService.List](#List) request. The maximum string length in characters is 50.
view | enum **InstanceView**<br>Defines which information about the Instance resource should be returned in the server response. <ul><li>`BASIC`: Doesn't include the metadata of the instance in the server response.</li><li>`FULL`: Returns the metadata of the instance in the server response.</li><ul/>


### Instance {#Instance}

Field | Description
--- | ---
id | **string**<br>ID of the instance. 
folder_id | **string**<br>ID of the folder that the instance belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the instance. 1-63 characters long. 
description | **string**<br>Description of the instance. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
zone_id | **string**<br>ID of the availability zone where the instance resides. 
platform_id | **string**<br>ID of the hardware platform configuration for the instance. 
resources | **[Resources](#Resources)**<br>Computing resources of the instance such as the amount of memory and number of cores. 
status | enum **Status**<br>Status of the instance. <ul><li>`PROVISIONING`: Instance is waiting for resources to be allocated.</li><li>`RUNNING`: Instance is running normally.</li><li>`STOPPING`: Instance is being stopped.</li><li>`STOPPED`: Instance stopped.</li><li>`STARTING`: Instance is being started.</li><li>`RESTARTING`: Instance is being restarted.</li><li>`UPDATING`: Instance is being updated.</li><li>`ERROR`: Instance encountered a problem and cannot operate.</li><li>`CRASHED`: Instance crashed and will be restarted automatically.</li><li>`DELETING`: Instance is being deleted.</li><ul/>
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance. This includes custom metadata and predefined keys. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). 
boot_disk | **[AttachedDisk](#AttachedDisk)**<br>Boot disk that is attached to the instance. 
secondary_disks[] | **[AttachedDisk](#AttachedDisk)**<br>Array of secondary disks that are attached to the instance. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface)**<br>Array of network interfaces that are attached to the instance. 
fqdn | **string**<br>A domain name of the instance. FQDN is defined by the server in the format `<hostname>.<region_id>.internal` when the instance is created. If the hostname were not specified when the instance was created, FQDN would be `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy)**<br>Scheduling policy configuration. 
service_account_id | **string**<br>ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
network_settings | **[NetworkSettings](#NetworkSettings)**<br>Network Settings 
placement_policy | **[PlacementPolicy](#PlacementPolicy)**<br>Placement policy configuration. 


### Resources {#Resources}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. 
cores | **int64**<br>The number of cores available to the instance. 
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. 
gpus | **int64**<br>The number of GPUs available to the instance. 


### AttachedDisk {#AttachedDisk}

Field | Description
--- | ---
mode | enum **Mode**<br>Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li><ul/>
device_name | **string**<br>Serial number that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. 
auto_delete | **bool**<br>Specifies whether the disk will be auto-deleted when the instance is deleted. 
disk_id | **string**<br>ID of the disk that is attached to the instance. 


### NetworkInterface {#NetworkInterface}

Field | Description
--- | ---
index | **string**<br>The index of the network interface, generated by the server, 0,1,2... etc. Currently only one network interface is supported per instance. 
mac_address | **string**<br>MAC address that is assigned to the network interface. 
subnet_id | **string**<br>ID of the subnet. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>ID's of security groups attached to the interface 


### PrimaryAddress {#PrimaryAddress}

Field | Description
--- | ---
address | **string**<br>An IPv4 internal network address that is assigned to the instance for this network interface. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat)**<br>One-to-one NAT configuration. If missing, NAT has not been set up. 


### OneToOneNat {#OneToOneNat}

Field | Description
--- | ---
address | **string**<br>An external IP address associated with this instance. 
ip_version | enum **IpVersion**<br>IP version for the external IP address. <ul><li>`IPV4`: IPv4 address, for example 192.0.2.235.</li><li>`IPV6`: IPv6 address. Not available yet.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy}

Field | Description
--- | ---
preemptible | **bool**<br>True for short-lived compute instances. For more information, see [Preemptible VMs](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings}

Field | Description
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Network Type <ul><li>`STANDARD`: Standard network.</li><li>`SOFTWARE_ACCELERATED`: Software accelerated network.</li><li>`HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use).</li><ul/>


### PlacementPolicy {#PlacementPolicy}

Field | Description
--- | ---
placement_group_id | **string**<br>Placement group ID. 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action <ul><ul/>
values[] | **string**<br>Affinity value or host ID or host group ID 


## List {#List}

Retrieves the list of Instance resources in the specified folder.

**rpc List ([ListInstancesRequest](#ListInstancesRequest)) returns ([ListInstancesResponse](#ListInstancesResponse))**

### ListInstancesRequest {#ListInstancesRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the Folder to list instances in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListInstancesResponse.next_page_token](#ListInstancesResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListInstancesResponse.next_page_token](#ListInstancesResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br><ol><li>The field name. Currently you can use filtering only on the [Instance.name](#Instance1) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Must be 3-63 characters long and match the regular expression `^[a-z]([-a-z0-9]{,61}[a-z0-9])?$`.</li></ol> The maximum string length in characters is 1000.


### ListInstancesResponse {#ListInstancesResponse}

Field | Description
--- | ---
instances[] | **[Instance](#Instance1)**<br>List of Instance resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListInstancesRequest.page_size](#ListInstancesRequest), use the `next_page_token` as the value for the [ListInstancesRequest.page_token](#ListInstancesRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Instance {#Instance1}

Field | Description
--- | ---
id | **string**<br>ID of the instance. 
folder_id | **string**<br>ID of the folder that the instance belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the instance. 1-63 characters long. 
description | **string**<br>Description of the instance. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
zone_id | **string**<br>ID of the availability zone where the instance resides. 
platform_id | **string**<br>ID of the hardware platform configuration for the instance. 
resources | **[Resources](#Resources1)**<br>Computing resources of the instance such as the amount of memory and number of cores. 
status | enum **Status**<br>Status of the instance. <ul><li>`PROVISIONING`: Instance is waiting for resources to be allocated.</li><li>`RUNNING`: Instance is running normally.</li><li>`STOPPING`: Instance is being stopped.</li><li>`STOPPED`: Instance stopped.</li><li>`STARTING`: Instance is being started.</li><li>`RESTARTING`: Instance is being restarted.</li><li>`UPDATING`: Instance is being updated.</li><li>`ERROR`: Instance encountered a problem and cannot operate.</li><li>`CRASHED`: Instance crashed and will be restarted automatically.</li><li>`DELETING`: Instance is being deleted.</li><ul/>
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance. This includes custom metadata and predefined keys. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). 
boot_disk | **[AttachedDisk](#AttachedDisk1)**<br>Boot disk that is attached to the instance. 
secondary_disks[] | **[AttachedDisk](#AttachedDisk1)**<br>Array of secondary disks that are attached to the instance. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface1)**<br>Array of network interfaces that are attached to the instance. 
fqdn | **string**<br>A domain name of the instance. FQDN is defined by the server in the format `<hostname>.<region_id>.internal` when the instance is created. If the hostname were not specified when the instance was created, FQDN would be `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy1)**<br>Scheduling policy configuration. 
service_account_id | **string**<br>ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
network_settings | **[NetworkSettings](#NetworkSettings1)**<br>Network Settings 
placement_policy | **[PlacementPolicy](#PlacementPolicy1)**<br>Placement policy configuration. 


### Resources {#Resources1}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. 
cores | **int64**<br>The number of cores available to the instance. 
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. 
gpus | **int64**<br>The number of GPUs available to the instance. 


### AttachedDisk {#AttachedDisk1}

Field | Description
--- | ---
mode | enum **Mode**<br>Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li><ul/>
device_name | **string**<br>Serial number that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. 
auto_delete | **bool**<br>Specifies whether the disk will be auto-deleted when the instance is deleted. 
disk_id | **string**<br>ID of the disk that is attached to the instance. 


### NetworkInterface {#NetworkInterface1}

Field | Description
--- | ---
index | **string**<br>The index of the network interface, generated by the server, 0,1,2... etc. Currently only one network interface is supported per instance. 
mac_address | **string**<br>MAC address that is assigned to the network interface. 
subnet_id | **string**<br>ID of the subnet. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress1)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress1)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>ID's of security groups attached to the interface 


### PrimaryAddress {#PrimaryAddress1}

Field | Description
--- | ---
address | **string**<br>An IPv4 internal network address that is assigned to the instance for this network interface. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat1)**<br>One-to-one NAT configuration. If missing, NAT has not been set up. 


### OneToOneNat {#OneToOneNat1}

Field | Description
--- | ---
address | **string**<br>An external IP address associated with this instance. 
ip_version | enum **IpVersion**<br>IP version for the external IP address. <ul><li>`IPV4`: IPv4 address, for example 192.0.2.235.</li><li>`IPV6`: IPv6 address. Not available yet.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy1}

Field | Description
--- | ---
preemptible | **bool**<br>True for short-lived compute instances. For more information, see [Preemptible VMs](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings1}

Field | Description
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Network Type <ul><li>`STANDARD`: Standard network.</li><li>`SOFTWARE_ACCELERATED`: Software accelerated network.</li><li>`HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use).</li><ul/>


### PlacementPolicy {#PlacementPolicy1}

Field | Description
--- | ---
placement_group_id | **string**<br>Placement group ID. 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule1)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule1}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action <ul><ul/>
values[] | **string**<br>Affinity value or host ID or host group ID 


## Create {#Create}

Creates an instance in the specified folder. Method starts an asynchronous operation that can be cancelled while it is in progress.

**rpc Create ([CreateInstanceRequest](#CreateInstanceRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateInstanceMetadata](#CreateInstanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Instance](#Instance2)<br>

### CreateInstanceRequest {#CreateInstanceRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create an instance in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Name of the instance. Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the instance. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
zone_id | **string**<br>Required. ID of the availability zone where the instance resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/grpc/zone_service#List) request The maximum string length in characters is 50.
platform_id | **string**<br>Required. ID of the hardware platform configuration for the instance. This field affects the available values in `resources_spec` field. <br>Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see [Platforms](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec)**<br>Required. Computing resources of the instance, such as the amount of memory and number of cores. To get a list of available values, see [Levels of core performance](/docs/compute/concepts/performance-levels). 
metadata | **map<string,string>**<br>The metadata `key:value` pairs that will be assigned to this instance. This includes custom metadata and predefined keys. The total size of all keys and values must be less than 512 KB. <br>Values are free-form strings, and only have meaning as interpreted by the programs which configure the instance. The values must be 256 KB or less. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). 
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec)**<br>Required. Boot disk to attach to the instance. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec)**<br>Array of secondary disks to attach to the instance. The maximum number of elements is 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec)**<br>Network configuration for the instance. Specifies how the network interface is configured to interact with other services on the internal network and on the internet. Currently only one network interface is supported per instance. The number of elemets must be exactly 1.
hostname | **string**<br>Host name for the instance. This field is used to generate the [yandex.cloud.compute.v1.Instance.fqdn](#Instance) value. The host name must be unique within the network and region. If not specified, the host name will be equal to [yandex.cloud.compute.v1.Instance.id](#Instance) of the instance and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`. Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy2)**<br>Scheduling policy configuration. 
service_account_id | **string**<br>ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
network_settings | **[NetworkSettings](#NetworkSettings2)**<br>Network settings. 
placement_policy | **[PlacementPolicy](#PlacementPolicy2)**<br>Placement policy configuration. 


### ResourcesSpec {#ResourcesSpec}

Field | Description
--- | ---
memory | **int64**<br>Required. The amount of memory available to the instance, specified in bytes. The maximum value is 274877906944.
cores | **int64**<br>Required. The number of cores available to the instance. Value must be equal to 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64,68,72,76,80.
core_fraction | **int64**<br><ol><li></li></ol> Value must be equal to 0,5,20,50,100.
gpus | **int64**<br>The number of GPUs available to the instance. Value must be equal to 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec}

Field | Description
--- | ---
mode | enum **Mode**<br>The mode in which to attach this disk. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access. Default value.</li><ul/>
device_name | **string**<br>Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. If not specified, a random value will be generated. Value must match the regular expression ` [a-z][a-z0-9-_]{,19} `.
auto_delete | **bool**<br>Specifies whether the disk will be auto-deleted when the instance is deleted. 
disk | **oneof:** `disk_spec` or `disk_id`<br>
&nbsp;&nbsp;disk_spec | **[DiskSpec](#DiskSpec)**<br>Disk specification. 
&nbsp;&nbsp;disk_id | **string**<br>ID of the disk that should be attached. The maximum string length in characters is 50.


### DiskSpec {#DiskSpec}

Field | Description
--- | ---
name | **string**<br>Name of the disk. Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the disk. The maximum string length in characters is 256.
type_id | **string**<br>ID of the disk type. To get a list of available disk types, use the [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/grpc/disk_type_service#List) request. The maximum string length in characters is 50.
size | **int64**<br>Required. Size of the disk, specified in bytes. Acceptable values are 4194304 to 4398046511104, inclusive.
block_size | **int64**<br>Block size of the disk, specified in bytes. The default is 4096. 
disk_placement_policy | **[DiskPlacementPolicy](#DiskPlacementPolicy)**<br>Placement policy configuration. 
source | **oneof:** `image_id` or `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>ID of the image to create the disk from. The maximum string length in characters is 50.
&nbsp;&nbsp;snapshot_id | **string**<br>ID of the snapshot to restore the disk from. The maximum string length in characters is 50.


### NetworkInterfaceSpec {#NetworkInterfaceSpec}

Field | Description
--- | ---
subnet_id | **string**<br>Required. ID of the subnet. The maximum string length in characters is 50.
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec)**<br>Primary IPv4 address that will be assigned to the instance for this network interface. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec)**<br>Primary IPv6 address that will be assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>ID's of security groups attached to the interface 


### PrimaryAddressSpec {#PrimaryAddressSpec}

Field | Description
--- | ---
address | **string**<br>An IPv4 internal network address that is assigned to the instance for this network interface. If not specified by the user, an unused internal IP is assigned by the system. 
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec)**<br>An external IP address configuration. If not specified, then this instance will have no external internet access. 


### OneToOneNatSpec {#OneToOneNatSpec}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>External IP address version. <ul><li>`IPV4`: IPv4 address, for example 192.0.2.235.</li><li>`IPV6`: IPv6 address. Not available yet.</li><ul/>
address | **string**<br> 


### SchedulingPolicy {#SchedulingPolicy2}

Field | Description
--- | ---
preemptible | **bool**<br>True for short-lived compute instances. For more information, see [Preemptible VMs](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings2}

Field | Description
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Network Type <ul><li>`STANDARD`: Standard network.</li><li>`SOFTWARE_ACCELERATED`: Software accelerated network.</li><li>`HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use).</li><ul/>


### PlacementPolicy {#PlacementPolicy2}

Field | Description
--- | ---
placement_group_id | **string**<br>Placement group ID. 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule2)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule2}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action <ul><ul/>
values[] | **string**<br>Affinity value or host ID or host group ID 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateInstanceMetadata](#CreateInstanceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Instance](#Instance2)>**<br>if operation finished successfully. 


### CreateInstanceMetadata {#CreateInstanceMetadata}

Field | Description
--- | ---
instance_id | **string**<br>ID of the instance that is being created. The maximum string length in characters is 50.


### Instance {#Instance2}

Field | Description
--- | ---
id | **string**<br>ID of the instance. 
folder_id | **string**<br>ID of the folder that the instance belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the instance. 1-63 characters long. 
description | **string**<br>Description of the instance. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
zone_id | **string**<br>ID of the availability zone where the instance resides. 
platform_id | **string**<br>ID of the hardware platform configuration for the instance. 
resources | **[Resources](#Resources2)**<br>Computing resources of the instance such as the amount of memory and number of cores. 
status | enum **Status**<br>Status of the instance. <ul><li>`PROVISIONING`: Instance is waiting for resources to be allocated.</li><li>`RUNNING`: Instance is running normally.</li><li>`STOPPING`: Instance is being stopped.</li><li>`STOPPED`: Instance stopped.</li><li>`STARTING`: Instance is being started.</li><li>`RESTARTING`: Instance is being restarted.</li><li>`UPDATING`: Instance is being updated.</li><li>`ERROR`: Instance encountered a problem and cannot operate.</li><li>`CRASHED`: Instance crashed and will be restarted automatically.</li><li>`DELETING`: Instance is being deleted.</li><ul/>
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance. This includes custom metadata and predefined keys. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). 
boot_disk | **[AttachedDisk](#AttachedDisk2)**<br>Boot disk that is attached to the instance. 
secondary_disks[] | **[AttachedDisk](#AttachedDisk2)**<br>Array of secondary disks that are attached to the instance. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface2)**<br>Array of network interfaces that are attached to the instance. 
fqdn | **string**<br>A domain name of the instance. FQDN is defined by the server in the format `<hostname>.<region_id>.internal` when the instance is created. If the hostname were not specified when the instance was created, FQDN would be `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy3)**<br>Scheduling policy configuration. 
service_account_id | **string**<br>ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
network_settings | **[NetworkSettings](#NetworkSettings3)**<br>Network Settings 
placement_policy | **[PlacementPolicy](#PlacementPolicy3)**<br>Placement policy configuration. 


### Resources {#Resources2}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. 
cores | **int64**<br>The number of cores available to the instance. 
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. 
gpus | **int64**<br>The number of GPUs available to the instance. 


### AttachedDisk {#AttachedDisk2}

Field | Description
--- | ---
mode | enum **Mode**<br>Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li><ul/>
device_name | **string**<br>Serial number that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. 
auto_delete | **bool**<br>Specifies whether the disk will be auto-deleted when the instance is deleted. 
disk_id | **string**<br>ID of the disk that is attached to the instance. 


### NetworkInterface {#NetworkInterface2}

Field | Description
--- | ---
index | **string**<br>The index of the network interface, generated by the server, 0,1,2... etc. Currently only one network interface is supported per instance. 
mac_address | **string**<br>MAC address that is assigned to the network interface. 
subnet_id | **string**<br>ID of the subnet. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress2)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress2)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>ID's of security groups attached to the interface 


### PrimaryAddress {#PrimaryAddress2}

Field | Description
--- | ---
address | **string**<br>An IPv4 internal network address that is assigned to the instance for this network interface. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat2)**<br>One-to-one NAT configuration. If missing, NAT has not been set up. 


### OneToOneNat {#OneToOneNat2}

Field | Description
--- | ---
address | **string**<br>An external IP address associated with this instance. 
ip_version | enum **IpVersion**<br>IP version for the external IP address. <ul><li>`IPV4`: IPv4 address, for example 192.0.2.235.</li><li>`IPV6`: IPv6 address. Not available yet.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy3}

Field | Description
--- | ---
preemptible | **bool**<br>True for short-lived compute instances. For more information, see [Preemptible VMs](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings3}

Field | Description
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Network Type <ul><li>`STANDARD`: Standard network.</li><li>`SOFTWARE_ACCELERATED`: Software accelerated network.</li><li>`HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use).</li><ul/>


### PlacementPolicy {#PlacementPolicy3}

Field | Description
--- | ---
placement_group_id | **string**<br>Placement group ID. 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule3)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule3}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action <ul><ul/>
values[] | **string**<br>Affinity value or host ID or host group ID 


## Update {#Update}

Updates the specified instance.

**rpc Update ([UpdateInstanceRequest](#UpdateInstanceRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateInstanceMetadata](#UpdateInstanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Instance](#Instance3)<br>

### UpdateInstanceRequest {#UpdateInstanceRequest}

Field | Description
--- | ---
instance_id | **string**<br>Required. ID of the Instance resource to update. To get the instance ID, use a [InstanceService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the Instance resource are going to be updated. 
name | **string**<br>Name of the instance. Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the instance. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. <br>Existing set of `labels` is completely replaced by the provided set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
platform_id | **string**<br>ID of the hardware platform configuration for the instance. This field affects the available values in `resources_spec` field. <br>Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see [Platforms](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec)**<br>Computing resources of the instance, such as the amount of memory and number of cores. To get a list of available values, see [Levels of core performance](/docs/compute/concepts/performance-levels). 
metadata | **map<string,string>**<br>The metadata `key:value` pairs that will be assigned to this instance. This includes custom metadata and predefined keys. The total size of all keys and values must be less than 512 KB. <br>Existing set of `metadata` is completely replaced by the provided set. <br>Values are free-form strings, and only have meaning as interpreted by the programs which configure the instance. The values must be 256 KB or less. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). 
service_account_id | **string**<br>ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
network_settings | **[NetworkSettings](#NetworkSettings4)**<br>Network settings. 
placement_policy | **[PlacementPolicy](#PlacementPolicy4)**<br>Placement policy configuration. 


### ResourcesSpec {#ResourcesSpec1}

Field | Description
--- | ---
memory | **int64**<br>Required. The amount of memory available to the instance, specified in bytes. The maximum value is 274877906944.
cores | **int64**<br>Required. The number of cores available to the instance. Value must be equal to 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64,68,72,76,80.
core_fraction | **int64**<br><ol><li></li></ol> Value must be equal to 0,5,20,50,100.
gpus | **int64**<br>The number of GPUs available to the instance. Value must be equal to 0,1,2,4.


### NetworkSettings {#NetworkSettings4}

Field | Description
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Network Type <ul><li>`STANDARD`: Standard network.</li><li>`SOFTWARE_ACCELERATED`: Software accelerated network.</li><li>`HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use).</li><ul/>


### PlacementPolicy {#PlacementPolicy4}

Field | Description
--- | ---
placement_group_id | **string**<br>Placement group ID. 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule4)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule4}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action <ul><ul/>
values[] | **string**<br>Affinity value or host ID or host group ID 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateInstanceMetadata](#UpdateInstanceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Instance](#Instance3)>**<br>if operation finished successfully. 


### UpdateInstanceMetadata {#UpdateInstanceMetadata}

Field | Description
--- | ---
instance_id | **string**<br>ID of the Instance resource that is being updated. 


### Instance {#Instance3}

Field | Description
--- | ---
id | **string**<br>ID of the instance. 
folder_id | **string**<br>ID of the folder that the instance belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the instance. 1-63 characters long. 
description | **string**<br>Description of the instance. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
zone_id | **string**<br>ID of the availability zone where the instance resides. 
platform_id | **string**<br>ID of the hardware platform configuration for the instance. 
resources | **[Resources](#Resources3)**<br>Computing resources of the instance such as the amount of memory and number of cores. 
status | enum **Status**<br>Status of the instance. <ul><li>`PROVISIONING`: Instance is waiting for resources to be allocated.</li><li>`RUNNING`: Instance is running normally.</li><li>`STOPPING`: Instance is being stopped.</li><li>`STOPPED`: Instance stopped.</li><li>`STARTING`: Instance is being started.</li><li>`RESTARTING`: Instance is being restarted.</li><li>`UPDATING`: Instance is being updated.</li><li>`ERROR`: Instance encountered a problem and cannot operate.</li><li>`CRASHED`: Instance crashed and will be restarted automatically.</li><li>`DELETING`: Instance is being deleted.</li><ul/>
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance. This includes custom metadata and predefined keys. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). 
boot_disk | **[AttachedDisk](#AttachedDisk3)**<br>Boot disk that is attached to the instance. 
secondary_disks[] | **[AttachedDisk](#AttachedDisk3)**<br>Array of secondary disks that are attached to the instance. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface3)**<br>Array of network interfaces that are attached to the instance. 
fqdn | **string**<br>A domain name of the instance. FQDN is defined by the server in the format `<hostname>.<region_id>.internal` when the instance is created. If the hostname were not specified when the instance was created, FQDN would be `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy4)**<br>Scheduling policy configuration. 
service_account_id | **string**<br>ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
network_settings | **[NetworkSettings](#NetworkSettings5)**<br>Network Settings 
placement_policy | **[PlacementPolicy](#PlacementPolicy5)**<br>Placement policy configuration. 


### Resources {#Resources3}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. 
cores | **int64**<br>The number of cores available to the instance. 
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. 
gpus | **int64**<br>The number of GPUs available to the instance. 


### AttachedDisk {#AttachedDisk3}

Field | Description
--- | ---
mode | enum **Mode**<br>Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li><ul/>
device_name | **string**<br>Serial number that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. 
auto_delete | **bool**<br>Specifies whether the disk will be auto-deleted when the instance is deleted. 
disk_id | **string**<br>ID of the disk that is attached to the instance. 


### NetworkInterface {#NetworkInterface3}

Field | Description
--- | ---
index | **string**<br>The index of the network interface, generated by the server, 0,1,2... etc. Currently only one network interface is supported per instance. 
mac_address | **string**<br>MAC address that is assigned to the network interface. 
subnet_id | **string**<br>ID of the subnet. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress3)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress3)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>ID's of security groups attached to the interface 


### PrimaryAddress {#PrimaryAddress3}

Field | Description
--- | ---
address | **string**<br>An IPv4 internal network address that is assigned to the instance for this network interface. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat3)**<br>One-to-one NAT configuration. If missing, NAT has not been set up. 


### OneToOneNat {#OneToOneNat3}

Field | Description
--- | ---
address | **string**<br>An external IP address associated with this instance. 
ip_version | enum **IpVersion**<br>IP version for the external IP address. <ul><li>`IPV4`: IPv4 address, for example 192.0.2.235.</li><li>`IPV6`: IPv6 address. Not available yet.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy4}

Field | Description
--- | ---
preemptible | **bool**<br>True for short-lived compute instances. For more information, see [Preemptible VMs](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings5}

Field | Description
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Network Type <ul><li>`STANDARD`: Standard network.</li><li>`SOFTWARE_ACCELERATED`: Software accelerated network.</li><li>`HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use).</li><ul/>


### PlacementPolicy {#PlacementPolicy5}

Field | Description
--- | ---
placement_group_id | **string**<br>Placement group ID. 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule5)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule5}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action <ul><ul/>
values[] | **string**<br>Affinity value or host ID or host group ID 


## Delete {#Delete}

Deletes the specified instance.

**rpc Delete ([DeleteInstanceRequest](#DeleteInstanceRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteInstanceMetadata](#DeleteInstanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteInstanceRequest {#DeleteInstanceRequest}

Field | Description
--- | ---
instance_id | **string**<br>Required. ID of the instance to delete. To get the instance ID, use a [InstanceService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteInstanceMetadata](#DeleteInstanceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteInstanceMetadata {#DeleteInstanceMetadata}

Field | Description
--- | ---
instance_id | **string**<br>ID of the instance that is being deleted. 


## UpdateMetadata {#UpdateMetadata}

Updates the metadata of the specified instance.

**rpc UpdateMetadata ([UpdateInstanceMetadataRequest](#UpdateInstanceMetadataRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateInstanceMetadataMetadata](#UpdateInstanceMetadataMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Instance](#Instance4)<br>

### UpdateInstanceMetadataRequest {#UpdateInstanceMetadataRequest}

Field | Description
--- | ---
instance_id | **string**<br>ID of the instance that is being updated. 
delete[] | **string**<br>List of keys to be deleted. 
upsert | **map<string,string>**<br>The metadata `key:value` pairs that will be added or updated to this instance. 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateInstanceMetadataMetadata](#UpdateInstanceMetadataMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Instance](#Instance4)>**<br>if operation finished successfully. 


### UpdateInstanceMetadataMetadata {#UpdateInstanceMetadataMetadata}

Field | Description
--- | ---
instance_id | **string**<br>ID of the instance that is being updated. 


### Instance {#Instance4}

Field | Description
--- | ---
id | **string**<br>ID of the instance. 
folder_id | **string**<br>ID of the folder that the instance belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the instance. 1-63 characters long. 
description | **string**<br>Description of the instance. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
zone_id | **string**<br>ID of the availability zone where the instance resides. 
platform_id | **string**<br>ID of the hardware platform configuration for the instance. 
resources | **[Resources](#Resources4)**<br>Computing resources of the instance such as the amount of memory and number of cores. 
status | enum **Status**<br>Status of the instance. <ul><li>`PROVISIONING`: Instance is waiting for resources to be allocated.</li><li>`RUNNING`: Instance is running normally.</li><li>`STOPPING`: Instance is being stopped.</li><li>`STOPPED`: Instance stopped.</li><li>`STARTING`: Instance is being started.</li><li>`RESTARTING`: Instance is being restarted.</li><li>`UPDATING`: Instance is being updated.</li><li>`ERROR`: Instance encountered a problem and cannot operate.</li><li>`CRASHED`: Instance crashed and will be restarted automatically.</li><li>`DELETING`: Instance is being deleted.</li><ul/>
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance. This includes custom metadata and predefined keys. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). 
boot_disk | **[AttachedDisk](#AttachedDisk4)**<br>Boot disk that is attached to the instance. 
secondary_disks[] | **[AttachedDisk](#AttachedDisk4)**<br>Array of secondary disks that are attached to the instance. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface4)**<br>Array of network interfaces that are attached to the instance. 
fqdn | **string**<br>A domain name of the instance. FQDN is defined by the server in the format `<hostname>.<region_id>.internal` when the instance is created. If the hostname were not specified when the instance was created, FQDN would be `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy5)**<br>Scheduling policy configuration. 
service_account_id | **string**<br>ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
network_settings | **[NetworkSettings](#NetworkSettings6)**<br>Network Settings 
placement_policy | **[PlacementPolicy](#PlacementPolicy6)**<br>Placement policy configuration. 


### Resources {#Resources4}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. 
cores | **int64**<br>The number of cores available to the instance. 
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. 
gpus | **int64**<br>The number of GPUs available to the instance. 


### AttachedDisk {#AttachedDisk4}

Field | Description
--- | ---
mode | enum **Mode**<br>Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li><ul/>
device_name | **string**<br>Serial number that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. 
auto_delete | **bool**<br>Specifies whether the disk will be auto-deleted when the instance is deleted. 
disk_id | **string**<br>ID of the disk that is attached to the instance. 


### NetworkInterface {#NetworkInterface4}

Field | Description
--- | ---
index | **string**<br>The index of the network interface, generated by the server, 0,1,2... etc. Currently only one network interface is supported per instance. 
mac_address | **string**<br>MAC address that is assigned to the network interface. 
subnet_id | **string**<br>ID of the subnet. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress4)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress4)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>ID's of security groups attached to the interface 


### PrimaryAddress {#PrimaryAddress4}

Field | Description
--- | ---
address | **string**<br>An IPv4 internal network address that is assigned to the instance for this network interface. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat4)**<br>One-to-one NAT configuration. If missing, NAT has not been set up. 


### OneToOneNat {#OneToOneNat4}

Field | Description
--- | ---
address | **string**<br>An external IP address associated with this instance. 
ip_version | enum **IpVersion**<br>IP version for the external IP address. <ul><li>`IPV4`: IPv4 address, for example 192.0.2.235.</li><li>`IPV6`: IPv6 address. Not available yet.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy5}

Field | Description
--- | ---
preemptible | **bool**<br>True for short-lived compute instances. For more information, see [Preemptible VMs](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings6}

Field | Description
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Network Type <ul><li>`STANDARD`: Standard network.</li><li>`SOFTWARE_ACCELERATED`: Software accelerated network.</li><li>`HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use).</li><ul/>


### PlacementPolicy {#PlacementPolicy6}

Field | Description
--- | ---
placement_group_id | **string**<br>Placement group ID. 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule6)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule6}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action <ul><ul/>
values[] | **string**<br>Affinity value or host ID or host group ID 


## GetSerialPortOutput {#GetSerialPortOutput}

Returns the serial port output of the specified Instance resource.

**rpc GetSerialPortOutput ([GetInstanceSerialPortOutputRequest](#GetInstanceSerialPortOutputRequest)) returns ([GetInstanceSerialPortOutputResponse](#GetInstanceSerialPortOutputResponse))**

### GetInstanceSerialPortOutputRequest {#GetInstanceSerialPortOutputRequest}

Field | Description
--- | ---
instance_id | **string**<br>Required. ID of the instance to return the serial port output for. The maximum string length in characters is 50.
port | **int64**<br>Serial port to retrieve data from. The default is 1. Value must be equal to 1,2,3,4.


### GetInstanceSerialPortOutputResponse {#GetInstanceSerialPortOutputResponse}

Field | Description
--- | ---
contents | **string**<br>The contents of the serial port output, starting from the time when the instance started to boot. 


## Stop {#Stop}

Stops the running instance. <br>You can start the instance later using the [InstanceService.Start](#Start) method.

**rpc Stop ([StopInstanceRequest](#StopInstanceRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopInstanceMetadata](#StopInstanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### StopInstanceRequest {#StopInstanceRequest}

Field | Description
--- | ---
instance_id | **string**<br>Required. ID of the instance to stop. To get the instance ID, use a [InstanceService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StopInstanceMetadata](#StopInstanceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### StopInstanceMetadata {#StopInstanceMetadata}

Field | Description
--- | ---
instance_id | **string**<br>ID of the instance that is being deleted. 


## Start {#Start}

Starts the stopped instance.

**rpc Start ([StartInstanceRequest](#StartInstanceRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartInstanceMetadata](#StartInstanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Instance](#Instance5)<br>

### StartInstanceRequest {#StartInstanceRequest}

Field | Description
--- | ---
instance_id | **string**<br>Required. ID of the instance to start. To get the instance ID, use a [InstanceService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation5}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StartInstanceMetadata](#StartInstanceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Instance](#Instance5)>**<br>if operation finished successfully. 


### StartInstanceMetadata {#StartInstanceMetadata}

Field | Description
--- | ---
instance_id | **string**<br>ID of the instance. 


### Instance {#Instance5}

Field | Description
--- | ---
id | **string**<br>ID of the instance. 
folder_id | **string**<br>ID of the folder that the instance belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the instance. 1-63 characters long. 
description | **string**<br>Description of the instance. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
zone_id | **string**<br>ID of the availability zone where the instance resides. 
platform_id | **string**<br>ID of the hardware platform configuration for the instance. 
resources | **[Resources](#Resources5)**<br>Computing resources of the instance such as the amount of memory and number of cores. 
status | enum **Status**<br>Status of the instance. <ul><li>`PROVISIONING`: Instance is waiting for resources to be allocated.</li><li>`RUNNING`: Instance is running normally.</li><li>`STOPPING`: Instance is being stopped.</li><li>`STOPPED`: Instance stopped.</li><li>`STARTING`: Instance is being started.</li><li>`RESTARTING`: Instance is being restarted.</li><li>`UPDATING`: Instance is being updated.</li><li>`ERROR`: Instance encountered a problem and cannot operate.</li><li>`CRASHED`: Instance crashed and will be restarted automatically.</li><li>`DELETING`: Instance is being deleted.</li><ul/>
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance. This includes custom metadata and predefined keys. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). 
boot_disk | **[AttachedDisk](#AttachedDisk5)**<br>Boot disk that is attached to the instance. 
secondary_disks[] | **[AttachedDisk](#AttachedDisk5)**<br>Array of secondary disks that are attached to the instance. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface5)**<br>Array of network interfaces that are attached to the instance. 
fqdn | **string**<br>A domain name of the instance. FQDN is defined by the server in the format `<hostname>.<region_id>.internal` when the instance is created. If the hostname were not specified when the instance was created, FQDN would be `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy6)**<br>Scheduling policy configuration. 
service_account_id | **string**<br>ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
network_settings | **[NetworkSettings](#NetworkSettings7)**<br>Network Settings 
placement_policy | **[PlacementPolicy](#PlacementPolicy7)**<br>Placement policy configuration. 


### Resources {#Resources5}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. 
cores | **int64**<br>The number of cores available to the instance. 
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. 
gpus | **int64**<br>The number of GPUs available to the instance. 


### AttachedDisk {#AttachedDisk5}

Field | Description
--- | ---
mode | enum **Mode**<br>Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li><ul/>
device_name | **string**<br>Serial number that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. 
auto_delete | **bool**<br>Specifies whether the disk will be auto-deleted when the instance is deleted. 
disk_id | **string**<br>ID of the disk that is attached to the instance. 


### NetworkInterface {#NetworkInterface5}

Field | Description
--- | ---
index | **string**<br>The index of the network interface, generated by the server, 0,1,2... etc. Currently only one network interface is supported per instance. 
mac_address | **string**<br>MAC address that is assigned to the network interface. 
subnet_id | **string**<br>ID of the subnet. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress5)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress5)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>ID's of security groups attached to the interface 


### PrimaryAddress {#PrimaryAddress5}

Field | Description
--- | ---
address | **string**<br>An IPv4 internal network address that is assigned to the instance for this network interface. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat5)**<br>One-to-one NAT configuration. If missing, NAT has not been set up. 


### OneToOneNat {#OneToOneNat5}

Field | Description
--- | ---
address | **string**<br>An external IP address associated with this instance. 
ip_version | enum **IpVersion**<br>IP version for the external IP address. <ul><li>`IPV4`: IPv4 address, for example 192.0.2.235.</li><li>`IPV6`: IPv6 address. Not available yet.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy6}

Field | Description
--- | ---
preemptible | **bool**<br>True for short-lived compute instances. For more information, see [Preemptible VMs](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings7}

Field | Description
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Network Type <ul><li>`STANDARD`: Standard network.</li><li>`SOFTWARE_ACCELERATED`: Software accelerated network.</li><li>`HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use).</li><ul/>


### PlacementPolicy {#PlacementPolicy7}

Field | Description
--- | ---
placement_group_id | **string**<br>Placement group ID. 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule7)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule7}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action <ul><ul/>
values[] | **string**<br>Affinity value or host ID or host group ID 


## Restart {#Restart}

Restarts the running instance.

**rpc Restart ([RestartInstanceRequest](#RestartInstanceRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestartInstanceMetadata](#RestartInstanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### RestartInstanceRequest {#RestartInstanceRequest}

Field | Description
--- | ---
instance_id | **string**<br>Required. ID of the instance to restart. To get the instance ID, use a [InstanceService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation6}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RestartInstanceMetadata](#RestartInstanceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### RestartInstanceMetadata {#RestartInstanceMetadata}

Field | Description
--- | ---
instance_id | **string**<br>ID of the instance. 


## AttachDisk {#AttachDisk}

Attaches the disk to the instance.

**rpc AttachDisk ([AttachInstanceDiskRequest](#AttachInstanceDiskRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AttachInstanceDiskMetadata](#AttachInstanceDiskMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Instance](#Instance6)<br>

### AttachInstanceDiskRequest {#AttachInstanceDiskRequest}

Field | Description
--- | ---
instance_id | **string**<br>Required. ID of the instance to attach the disk to. To get the instance ID, use a [InstanceService.List](#List) request. The maximum string length in characters is 50.
attached_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec)**<br>Required. Disk that should be attached. 


### AttachedDiskSpec {#AttachedDiskSpec1}

Field | Description
--- | ---
mode | enum **Mode**<br>The mode in which to attach this disk. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access. Default value.</li><ul/>
device_name | **string**<br>Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. If not specified, a random value will be generated. Value must match the regular expression ` [a-z][a-z0-9-_]{,19} `.
auto_delete | **bool**<br>Specifies whether the disk will be auto-deleted when the instance is deleted. 
disk | **oneof:** `disk_spec` or `disk_id`<br>
&nbsp;&nbsp;disk_spec | **[DiskSpec](#DiskSpec1)**<br>Disk specification. 
&nbsp;&nbsp;disk_id | **string**<br>ID of the disk that should be attached. The maximum string length in characters is 50.


### DiskSpec {#DiskSpec1}

Field | Description
--- | ---
name | **string**<br>Name of the disk. Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the disk. The maximum string length in characters is 256.
type_id | **string**<br>ID of the disk type. To get a list of available disk types, use the [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/grpc/disk_type_service#List) request. The maximum string length in characters is 50.
size | **int64**<br>Required. Size of the disk, specified in bytes. Acceptable values are 4194304 to 4398046511104, inclusive.
block_size | **int64**<br>Block size of the disk, specified in bytes. The default is 4096. 
disk_placement_policy | **[DiskPlacementPolicy](#DiskPlacementPolicy)**<br>Placement policy configuration. 
source | **oneof:** `image_id` or `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>ID of the image to create the disk from. The maximum string length in characters is 50.
&nbsp;&nbsp;snapshot_id | **string**<br>ID of the snapshot to restore the disk from. The maximum string length in characters is 50.


### Operation {#Operation7}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AttachInstanceDiskMetadata](#AttachInstanceDiskMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Instance](#Instance6)>**<br>if operation finished successfully. 


### AttachInstanceDiskMetadata {#AttachInstanceDiskMetadata}

Field | Description
--- | ---
instance_id | **string**<br>ID of the instance. 
disk_id | **string**<br>ID of the disk. 


### Instance {#Instance6}

Field | Description
--- | ---
id | **string**<br>ID of the instance. 
folder_id | **string**<br>ID of the folder that the instance belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the instance. 1-63 characters long. 
description | **string**<br>Description of the instance. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
zone_id | **string**<br>ID of the availability zone where the instance resides. 
platform_id | **string**<br>ID of the hardware platform configuration for the instance. 
resources | **[Resources](#Resources6)**<br>Computing resources of the instance such as the amount of memory and number of cores. 
status | enum **Status**<br>Status of the instance. <ul><li>`PROVISIONING`: Instance is waiting for resources to be allocated.</li><li>`RUNNING`: Instance is running normally.</li><li>`STOPPING`: Instance is being stopped.</li><li>`STOPPED`: Instance stopped.</li><li>`STARTING`: Instance is being started.</li><li>`RESTARTING`: Instance is being restarted.</li><li>`UPDATING`: Instance is being updated.</li><li>`ERROR`: Instance encountered a problem and cannot operate.</li><li>`CRASHED`: Instance crashed and will be restarted automatically.</li><li>`DELETING`: Instance is being deleted.</li><ul/>
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance. This includes custom metadata and predefined keys. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). 
boot_disk | **[AttachedDisk](#AttachedDisk6)**<br>Boot disk that is attached to the instance. 
secondary_disks[] | **[AttachedDisk](#AttachedDisk6)**<br>Array of secondary disks that are attached to the instance. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface6)**<br>Array of network interfaces that are attached to the instance. 
fqdn | **string**<br>A domain name of the instance. FQDN is defined by the server in the format `<hostname>.<region_id>.internal` when the instance is created. If the hostname were not specified when the instance was created, FQDN would be `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy7)**<br>Scheduling policy configuration. 
service_account_id | **string**<br>ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
network_settings | **[NetworkSettings](#NetworkSettings8)**<br>Network Settings 
placement_policy | **[PlacementPolicy](#PlacementPolicy8)**<br>Placement policy configuration. 


### Resources {#Resources6}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. 
cores | **int64**<br>The number of cores available to the instance. 
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. 
gpus | **int64**<br>The number of GPUs available to the instance. 


### AttachedDisk {#AttachedDisk6}

Field | Description
--- | ---
mode | enum **Mode**<br>Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li><ul/>
device_name | **string**<br>Serial number that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. 
auto_delete | **bool**<br>Specifies whether the disk will be auto-deleted when the instance is deleted. 
disk_id | **string**<br>ID of the disk that is attached to the instance. 


### NetworkInterface {#NetworkInterface6}

Field | Description
--- | ---
index | **string**<br>The index of the network interface, generated by the server, 0,1,2... etc. Currently only one network interface is supported per instance. 
mac_address | **string**<br>MAC address that is assigned to the network interface. 
subnet_id | **string**<br>ID of the subnet. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress6)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress6)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>ID's of security groups attached to the interface 


### PrimaryAddress {#PrimaryAddress6}

Field | Description
--- | ---
address | **string**<br>An IPv4 internal network address that is assigned to the instance for this network interface. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat6)**<br>One-to-one NAT configuration. If missing, NAT has not been set up. 


### OneToOneNat {#OneToOneNat6}

Field | Description
--- | ---
address | **string**<br>An external IP address associated with this instance. 
ip_version | enum **IpVersion**<br>IP version for the external IP address. <ul><li>`IPV4`: IPv4 address, for example 192.0.2.235.</li><li>`IPV6`: IPv6 address. Not available yet.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy7}

Field | Description
--- | ---
preemptible | **bool**<br>True for short-lived compute instances. For more information, see [Preemptible VMs](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings8}

Field | Description
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Network Type <ul><li>`STANDARD`: Standard network.</li><li>`SOFTWARE_ACCELERATED`: Software accelerated network.</li><li>`HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use).</li><ul/>


### PlacementPolicy {#PlacementPolicy8}

Field | Description
--- | ---
placement_group_id | **string**<br>Placement group ID. 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule8)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule8}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action <ul><ul/>
values[] | **string**<br>Affinity value or host ID or host group ID 


## DetachDisk {#DetachDisk}

Detaches the disk from the instance.

**rpc DetachDisk ([DetachInstanceDiskRequest](#DetachInstanceDiskRequest)) returns ([operation.Operation](#Operation8))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DetachInstanceDiskMetadata](#DetachInstanceDiskMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Instance](#Instance7)<br>

### DetachInstanceDiskRequest {#DetachInstanceDiskRequest}

Field | Description
--- | ---
instance_id | **string**<br>Required. ID of the instance to detach the disk from. To get the instance ID, use a [InstanceService.List](#List) request. The maximum string length in characters is 50.
disk | **oneof:** `disk_id` or `device_name`<br>
&nbsp;&nbsp;disk_id | **string**<br>ID of the disk that should be detached. The maximum string length in characters is 50.
&nbsp;&nbsp;device_name | **string**<br>Serial number of the disk that should be detached. This value is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance. Value must match the regular expression ` [a-z][a-z0-9-_]{,19} `.


### Operation {#Operation8}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DetachInstanceDiskMetadata](#DetachInstanceDiskMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Instance](#Instance7)>**<br>if operation finished successfully. 


### DetachInstanceDiskMetadata {#DetachInstanceDiskMetadata}

Field | Description
--- | ---
instance_id | **string**<br>ID of the instance. 
disk_id | **string**<br>ID of the disk. 


### Instance {#Instance7}

Field | Description
--- | ---
id | **string**<br>ID of the instance. 
folder_id | **string**<br>ID of the folder that the instance belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the instance. 1-63 characters long. 
description | **string**<br>Description of the instance. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
zone_id | **string**<br>ID of the availability zone where the instance resides. 
platform_id | **string**<br>ID of the hardware platform configuration for the instance. 
resources | **[Resources](#Resources7)**<br>Computing resources of the instance such as the amount of memory and number of cores. 
status | enum **Status**<br>Status of the instance. <ul><li>`PROVISIONING`: Instance is waiting for resources to be allocated.</li><li>`RUNNING`: Instance is running normally.</li><li>`STOPPING`: Instance is being stopped.</li><li>`STOPPED`: Instance stopped.</li><li>`STARTING`: Instance is being started.</li><li>`RESTARTING`: Instance is being restarted.</li><li>`UPDATING`: Instance is being updated.</li><li>`ERROR`: Instance encountered a problem and cannot operate.</li><li>`CRASHED`: Instance crashed and will be restarted automatically.</li><li>`DELETING`: Instance is being deleted.</li><ul/>
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance. This includes custom metadata and predefined keys. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). 
boot_disk | **[AttachedDisk](#AttachedDisk7)**<br>Boot disk that is attached to the instance. 
secondary_disks[] | **[AttachedDisk](#AttachedDisk7)**<br>Array of secondary disks that are attached to the instance. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface7)**<br>Array of network interfaces that are attached to the instance. 
fqdn | **string**<br>A domain name of the instance. FQDN is defined by the server in the format `<hostname>.<region_id>.internal` when the instance is created. If the hostname were not specified when the instance was created, FQDN would be `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy8)**<br>Scheduling policy configuration. 
service_account_id | **string**<br>ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
network_settings | **[NetworkSettings](#NetworkSettings9)**<br>Network Settings 
placement_policy | **[PlacementPolicy](#PlacementPolicy9)**<br>Placement policy configuration. 


### Resources {#Resources7}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. 
cores | **int64**<br>The number of cores available to the instance. 
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. 
gpus | **int64**<br>The number of GPUs available to the instance. 


### AttachedDisk {#AttachedDisk7}

Field | Description
--- | ---
mode | enum **Mode**<br>Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li><ul/>
device_name | **string**<br>Serial number that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. 
auto_delete | **bool**<br>Specifies whether the disk will be auto-deleted when the instance is deleted. 
disk_id | **string**<br>ID of the disk that is attached to the instance. 


### NetworkInterface {#NetworkInterface7}

Field | Description
--- | ---
index | **string**<br>The index of the network interface, generated by the server, 0,1,2... etc. Currently only one network interface is supported per instance. 
mac_address | **string**<br>MAC address that is assigned to the network interface. 
subnet_id | **string**<br>ID of the subnet. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress7)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress7)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>ID's of security groups attached to the interface 


### PrimaryAddress {#PrimaryAddress7}

Field | Description
--- | ---
address | **string**<br>An IPv4 internal network address that is assigned to the instance for this network interface. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat7)**<br>One-to-one NAT configuration. If missing, NAT has not been set up. 


### OneToOneNat {#OneToOneNat7}

Field | Description
--- | ---
address | **string**<br>An external IP address associated with this instance. 
ip_version | enum **IpVersion**<br>IP version for the external IP address. <ul><li>`IPV4`: IPv4 address, for example 192.0.2.235.</li><li>`IPV6`: IPv6 address. Not available yet.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy8}

Field | Description
--- | ---
preemptible | **bool**<br>True for short-lived compute instances. For more information, see [Preemptible VMs](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings9}

Field | Description
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Network Type <ul><li>`STANDARD`: Standard network.</li><li>`SOFTWARE_ACCELERATED`: Software accelerated network.</li><li>`HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use).</li><ul/>


### PlacementPolicy {#PlacementPolicy9}

Field | Description
--- | ---
placement_group_id | **string**<br>Placement group ID. 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule9)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule9}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action <ul><ul/>
values[] | **string**<br>Affinity value or host ID or host group ID 


## AddOneToOneNat {#AddOneToOneNat}

net

**rpc AddOneToOneNat ([AddInstanceOneToOneNatRequest](#AddInstanceOneToOneNatRequest)) returns ([operation.Operation](#Operation9))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddInstanceOneToOneNatMetadata](#AddInstanceOneToOneNatMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Instance](#Instance8)<br>

### AddInstanceOneToOneNatRequest {#AddInstanceOneToOneNatRequest}

Field | Description
--- | ---
instance_id | **string**<br> 
network_interface_index | **string**<br> 
internal_address | **string**<br> 
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec)**<br> 


### OneToOneNatSpec {#OneToOneNatSpec1}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>External IP address version. <ul><li>`IPV4`: IPv4 address, for example 192.0.2.235.</li><li>`IPV6`: IPv6 address. Not available yet.</li><ul/>
address | **string**<br> 


### Operation {#Operation9}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddInstanceOneToOneNatMetadata](#AddInstanceOneToOneNatMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Instance](#Instance8)>**<br>if operation finished successfully. 


### AddInstanceOneToOneNatMetadata {#AddInstanceOneToOneNatMetadata}

Field | Description
--- | ---
instance_id | **string**<br> 


### Instance {#Instance8}

Field | Description
--- | ---
id | **string**<br>ID of the instance. 
folder_id | **string**<br>ID of the folder that the instance belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the instance. 1-63 characters long. 
description | **string**<br>Description of the instance. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
zone_id | **string**<br>ID of the availability zone where the instance resides. 
platform_id | **string**<br>ID of the hardware platform configuration for the instance. 
resources | **[Resources](#Resources8)**<br>Computing resources of the instance such as the amount of memory and number of cores. 
status | enum **Status**<br>Status of the instance. <ul><li>`PROVISIONING`: Instance is waiting for resources to be allocated.</li><li>`RUNNING`: Instance is running normally.</li><li>`STOPPING`: Instance is being stopped.</li><li>`STOPPED`: Instance stopped.</li><li>`STARTING`: Instance is being started.</li><li>`RESTARTING`: Instance is being restarted.</li><li>`UPDATING`: Instance is being updated.</li><li>`ERROR`: Instance encountered a problem and cannot operate.</li><li>`CRASHED`: Instance crashed and will be restarted automatically.</li><li>`DELETING`: Instance is being deleted.</li><ul/>
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance. This includes custom metadata and predefined keys. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). 
boot_disk | **[AttachedDisk](#AttachedDisk8)**<br>Boot disk that is attached to the instance. 
secondary_disks[] | **[AttachedDisk](#AttachedDisk8)**<br>Array of secondary disks that are attached to the instance. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface8)**<br>Array of network interfaces that are attached to the instance. 
fqdn | **string**<br>A domain name of the instance. FQDN is defined by the server in the format `<hostname>.<region_id>.internal` when the instance is created. If the hostname were not specified when the instance was created, FQDN would be `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy9)**<br>Scheduling policy configuration. 
service_account_id | **string**<br>ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
network_settings | **[NetworkSettings](#NetworkSettings10)**<br>Network Settings 
placement_policy | **[PlacementPolicy](#PlacementPolicy10)**<br>Placement policy configuration. 


### Resources {#Resources8}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. 
cores | **int64**<br>The number of cores available to the instance. 
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. 
gpus | **int64**<br>The number of GPUs available to the instance. 


### AttachedDisk {#AttachedDisk8}

Field | Description
--- | ---
mode | enum **Mode**<br>Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li><ul/>
device_name | **string**<br>Serial number that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. 
auto_delete | **bool**<br>Specifies whether the disk will be auto-deleted when the instance is deleted. 
disk_id | **string**<br>ID of the disk that is attached to the instance. 


### NetworkInterface {#NetworkInterface8}

Field | Description
--- | ---
index | **string**<br>The index of the network interface, generated by the server, 0,1,2... etc. Currently only one network interface is supported per instance. 
mac_address | **string**<br>MAC address that is assigned to the network interface. 
subnet_id | **string**<br>ID of the subnet. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress8)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress8)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>ID's of security groups attached to the interface 


### PrimaryAddress {#PrimaryAddress8}

Field | Description
--- | ---
address | **string**<br>An IPv4 internal network address that is assigned to the instance for this network interface. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat8)**<br>One-to-one NAT configuration. If missing, NAT has not been set up. 


### OneToOneNat {#OneToOneNat8}

Field | Description
--- | ---
address | **string**<br>An external IP address associated with this instance. 
ip_version | enum **IpVersion**<br>IP version for the external IP address. <ul><li>`IPV4`: IPv4 address, for example 192.0.2.235.</li><li>`IPV6`: IPv6 address. Not available yet.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy9}

Field | Description
--- | ---
preemptible | **bool**<br>True for short-lived compute instances. For more information, see [Preemptible VMs](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings10}

Field | Description
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Network Type <ul><li>`STANDARD`: Standard network.</li><li>`SOFTWARE_ACCELERATED`: Software accelerated network.</li><li>`HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use).</li><ul/>


### PlacementPolicy {#PlacementPolicy10}

Field | Description
--- | ---
placement_group_id | **string**<br>Placement group ID. 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule10)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule10}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action <ul><ul/>
values[] | **string**<br>Affinity value or host ID or host group ID 


## RemoveOneToOneNat {#RemoveOneToOneNat}



**rpc RemoveOneToOneNat ([RemoveInstanceOneToOneNatRequest](#RemoveInstanceOneToOneNatRequest)) returns ([operation.Operation](#Operation10))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RemoveInstanceOneToOneNatMetadata](#RemoveInstanceOneToOneNatMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Instance](#Instance9)<br>

### RemoveInstanceOneToOneNatRequest {#RemoveInstanceOneToOneNatRequest}

Field | Description
--- | ---
instance_id | **string**<br> 
network_interface_index | **string**<br> 
internal_address | **string**<br> 


### Operation {#Operation10}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RemoveInstanceOneToOneNatMetadata](#RemoveInstanceOneToOneNatMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Instance](#Instance9)>**<br>if operation finished successfully. 


### RemoveInstanceOneToOneNatMetadata {#RemoveInstanceOneToOneNatMetadata}

Field | Description
--- | ---
instance_id | **string**<br> 


### Instance {#Instance9}

Field | Description
--- | ---
id | **string**<br>ID of the instance. 
folder_id | **string**<br>ID of the folder that the instance belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the instance. 1-63 characters long. 
description | **string**<br>Description of the instance. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
zone_id | **string**<br>ID of the availability zone where the instance resides. 
platform_id | **string**<br>ID of the hardware platform configuration for the instance. 
resources | **[Resources](#Resources9)**<br>Computing resources of the instance such as the amount of memory and number of cores. 
status | enum **Status**<br>Status of the instance. <ul><li>`PROVISIONING`: Instance is waiting for resources to be allocated.</li><li>`RUNNING`: Instance is running normally.</li><li>`STOPPING`: Instance is being stopped.</li><li>`STOPPED`: Instance stopped.</li><li>`STARTING`: Instance is being started.</li><li>`RESTARTING`: Instance is being restarted.</li><li>`UPDATING`: Instance is being updated.</li><li>`ERROR`: Instance encountered a problem and cannot operate.</li><li>`CRASHED`: Instance crashed and will be restarted automatically.</li><li>`DELETING`: Instance is being deleted.</li><ul/>
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance. This includes custom metadata and predefined keys. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). 
boot_disk | **[AttachedDisk](#AttachedDisk9)**<br>Boot disk that is attached to the instance. 
secondary_disks[] | **[AttachedDisk](#AttachedDisk9)**<br>Array of secondary disks that are attached to the instance. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface9)**<br>Array of network interfaces that are attached to the instance. 
fqdn | **string**<br>A domain name of the instance. FQDN is defined by the server in the format `<hostname>.<region_id>.internal` when the instance is created. If the hostname were not specified when the instance was created, FQDN would be `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy10)**<br>Scheduling policy configuration. 
service_account_id | **string**<br>ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
network_settings | **[NetworkSettings](#NetworkSettings11)**<br>Network Settings 
placement_policy | **[PlacementPolicy](#PlacementPolicy11)**<br>Placement policy configuration. 


### Resources {#Resources9}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. 
cores | **int64**<br>The number of cores available to the instance. 
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. 
gpus | **int64**<br>The number of GPUs available to the instance. 


### AttachedDisk {#AttachedDisk9}

Field | Description
--- | ---
mode | enum **Mode**<br>Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li><ul/>
device_name | **string**<br>Serial number that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. 
auto_delete | **bool**<br>Specifies whether the disk will be auto-deleted when the instance is deleted. 
disk_id | **string**<br>ID of the disk that is attached to the instance. 


### NetworkInterface {#NetworkInterface9}

Field | Description
--- | ---
index | **string**<br>The index of the network interface, generated by the server, 0,1,2... etc. Currently only one network interface is supported per instance. 
mac_address | **string**<br>MAC address that is assigned to the network interface. 
subnet_id | **string**<br>ID of the subnet. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress9)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress9)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>ID's of security groups attached to the interface 


### PrimaryAddress {#PrimaryAddress9}

Field | Description
--- | ---
address | **string**<br>An IPv4 internal network address that is assigned to the instance for this network interface. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat9)**<br>One-to-one NAT configuration. If missing, NAT has not been set up. 


### OneToOneNat {#OneToOneNat9}

Field | Description
--- | ---
address | **string**<br>An external IP address associated with this instance. 
ip_version | enum **IpVersion**<br>IP version for the external IP address. <ul><li>`IPV4`: IPv4 address, for example 192.0.2.235.</li><li>`IPV6`: IPv6 address. Not available yet.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy10}

Field | Description
--- | ---
preemptible | **bool**<br>True for short-lived compute instances. For more information, see [Preemptible VMs](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings11}

Field | Description
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Network Type <ul><li>`STANDARD`: Standard network.</li><li>`SOFTWARE_ACCELERATED`: Software accelerated network.</li><li>`HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use).</li><ul/>


### PlacementPolicy {#PlacementPolicy11}

Field | Description
--- | ---
placement_group_id | **string**<br>Placement group ID. 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule11)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule11}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action <ul><ul/>
values[] | **string**<br>Affinity value or host ID or host group ID 


## UpdateNetworkInterface {#UpdateNetworkInterface}



**rpc UpdateNetworkInterface ([UpdateInstanceNetworkInterfaceRequest](#UpdateInstanceNetworkInterfaceRequest)) returns ([operation.Operation](#Operation11))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateInstanceNetworkInterfaceMetadata](#UpdateInstanceNetworkInterfaceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Instance](#Instance10)<br>

### UpdateInstanceNetworkInterfaceRequest {#UpdateInstanceNetworkInterfaceRequest}

Field | Description
--- | ---
instance_id | **string**<br>Required.  
network_interface_index | **string**<br>Required.  
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
subnet_id | **string**<br> 
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec)**<br> 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec)**<br> 
security_group_ids[] | **string**<br> 


### PrimaryAddressSpec {#PrimaryAddressSpec1}

Field | Description
--- | ---
address | **string**<br>An IPv4 internal network address that is assigned to the instance for this network interface. If not specified by the user, an unused internal IP is assigned by the system. 
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec)**<br>An external IP address configuration. If not specified, then this instance will have no external internet access. 


### OneToOneNatSpec {#OneToOneNatSpec2}

Field | Description
--- | ---
ip_version | enum **IpVersion**<br>External IP address version. <ul><li>`IPV4`: IPv4 address, for example 192.0.2.235.</li><li>`IPV6`: IPv6 address. Not available yet.</li><ul/>
address | **string**<br> 


### Operation {#Operation11}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateInstanceNetworkInterfaceMetadata](#UpdateInstanceNetworkInterfaceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Instance](#Instance10)>**<br>if operation finished successfully. 


### UpdateInstanceNetworkInterfaceMetadata {#UpdateInstanceNetworkInterfaceMetadata}

Field | Description
--- | ---
instance_id | **string**<br> 
network_interface_index | **string**<br> 


### Instance {#Instance10}

Field | Description
--- | ---
id | **string**<br>ID of the instance. 
folder_id | **string**<br>ID of the folder that the instance belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the instance. 1-63 characters long. 
description | **string**<br>Description of the instance. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. Maximum of 64 per resource. 
zone_id | **string**<br>ID of the availability zone where the instance resides. 
platform_id | **string**<br>ID of the hardware platform configuration for the instance. 
resources | **[Resources](#Resources10)**<br>Computing resources of the instance such as the amount of memory and number of cores. 
status | enum **Status**<br>Status of the instance. <ul><li>`PROVISIONING`: Instance is waiting for resources to be allocated.</li><li>`RUNNING`: Instance is running normally.</li><li>`STOPPING`: Instance is being stopped.</li><li>`STOPPED`: Instance stopped.</li><li>`STARTING`: Instance is being started.</li><li>`RESTARTING`: Instance is being restarted.</li><li>`UPDATING`: Instance is being updated.</li><li>`ERROR`: Instance encountered a problem and cannot operate.</li><li>`CRASHED`: Instance crashed and will be restarted automatically.</li><li>`DELETING`: Instance is being deleted.</li><ul/>
metadata | **map<string,string>**<br>The metadata `key:value` pairs assigned to this instance. This includes custom metadata and predefined keys. <br>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see [Metadata](/docs/compute/concepts/vm-metadata). 
boot_disk | **[AttachedDisk](#AttachedDisk10)**<br>Boot disk that is attached to the instance. 
secondary_disks[] | **[AttachedDisk](#AttachedDisk10)**<br>Array of secondary disks that are attached to the instance. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface10)**<br>Array of network interfaces that are attached to the instance. 
fqdn | **string**<br>A domain name of the instance. FQDN is defined by the server in the format `<hostname>.<region_id>.internal` when the instance is created. If the hostname were not specified when the instance was created, FQDN would be `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy11)**<br>Scheduling policy configuration. 
service_account_id | **string**<br>ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm). To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/grpc/service_account_service#List) request. 
network_settings | **[NetworkSettings](#NetworkSettings12)**<br>Network Settings 
placement_policy | **[PlacementPolicy](#PlacementPolicy12)**<br>Placement policy configuration. 


### Resources {#Resources10}

Field | Description
--- | ---
memory | **int64**<br>The amount of memory available to the instance, specified in bytes. 
cores | **int64**<br>The number of cores available to the instance. 
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. 
gpus | **int64**<br>The number of GPUs available to the instance. 


### AttachedDisk {#AttachedDisk10}

Field | Description
--- | ---
mode | enum **Mode**<br>Access mode to the Disk resource. <ul><li>`READ_ONLY`: Read-only access.</li><li>`READ_WRITE`: Read/Write access.</li><ul/>
device_name | **string**<br>Serial number that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance. <br>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. 
auto_delete | **bool**<br>Specifies whether the disk will be auto-deleted when the instance is deleted. 
disk_id | **string**<br>ID of the disk that is attached to the instance. 


### NetworkInterface {#NetworkInterface10}

Field | Description
--- | ---
index | **string**<br>The index of the network interface, generated by the server, 0,1,2... etc. Currently only one network interface is supported per instance. 
mac_address | **string**<br>MAC address that is assigned to the network interface. 
subnet_id | **string**<br>ID of the subnet. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress10)**<br>Primary IPv4 address that is assigned to the instance for this network interface. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress10)**<br>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. 
security_group_ids[] | **string**<br>ID's of security groups attached to the interface 


### PrimaryAddress {#PrimaryAddress10}

Field | Description
--- | ---
address | **string**<br>An IPv4 internal network address that is assigned to the instance for this network interface. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat10)**<br>One-to-one NAT configuration. If missing, NAT has not been set up. 


### OneToOneNat {#OneToOneNat10}

Field | Description
--- | ---
address | **string**<br>An external IP address associated with this instance. 
ip_version | enum **IpVersion**<br>IP version for the external IP address. <ul><li>`IPV4`: IPv4 address, for example 192.0.2.235.</li><li>`IPV6`: IPv6 address. Not available yet.</li><ul/>


### SchedulingPolicy {#SchedulingPolicy11}

Field | Description
--- | ---
preemptible | **bool**<br>True for short-lived compute instances. For more information, see [Preemptible VMs](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings12}

Field | Description
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Network Type <ul><li>`STANDARD`: Standard network.</li><li>`SOFTWARE_ACCELERATED`: Software accelerated network.</li><li>`HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use).</li><ul/>


### PlacementPolicy {#PlacementPolicy12}

Field | Description
--- | ---
placement_group_id | **string**<br>Placement group ID. 
host_affinity_rules[] | **[HostAffinityRule](#HostAffinityRule12)**<br>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. 


### HostAffinityRule {#HostAffinityRule12}

Field | Description
--- | ---
key | **string**<br>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' 
op | enum **Operator**<br>Include or exclude action <ul><ul/>
values[] | **string**<br>Affinity value or host ID or host group ID 


## ListOperations {#ListOperations}

Lists operations for the specified instance.

**rpc ListOperations ([ListInstanceOperationsRequest](#ListInstanceOperationsRequest)) returns ([ListInstanceOperationsResponse](#ListInstanceOperationsResponse))**

### ListInstanceOperationsRequest {#ListInstanceOperationsRequest}

Field | Description
--- | ---
instance_id | **string**<br>Required. ID of the Instance resource to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListInstanceOperationsResponse.next_page_token](#ListInstanceOperationsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListInstanceOperationsResponse.next_page_token](#ListInstanceOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListInstanceOperationsResponse {#ListInstanceOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation12)**<br>List of operations for the specified instance. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListInstanceOperationsRequest.page_size](#ListInstanceOperationsRequest), use the `next_page_token` as the value for the [ListInstanceOperationsRequest.page_token](#ListInstanceOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation12}

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


