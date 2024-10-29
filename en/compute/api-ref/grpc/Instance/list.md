---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/Instance/list.md
---

# Compute Cloud API, gRPC: InstanceService.List {#List}

Retrieves the list of Instance resources in the specified folder.

## gRPC request

**rpc List ([ListInstancesRequest](#yandex.cloud.compute.v1.ListInstancesRequest)) returns ([ListInstancesResponse](#yandex.cloud.compute.v1.ListInstancesResponse))**

## ListInstancesRequest {#yandex.cloud.compute.v1.ListInstancesRequest}

```json
{
  "folderId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string",
  "orderBy": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the Folder to list instances in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListInstancesResponse.nextPageToken](#yandex.cloud.compute.v1.ListInstancesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results,
set `pageToken` to the [ListInstancesResponse.nextPageToken](#yandex.cloud.compute.v1.ListInstancesResponse)
returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression consists of one or more conditions united by `AND` operator: `<condition1> [AND <condition2> [<...> AND <conditionN>]]`.

Each condition has the form `<field> <operator> <value>`, where:
1. `<field>` is the field name. Currently you can use filtering only on the limited number of fields.
2. `<operator>` is a logical operator, one of `=`, `!=`, `IN`, `NOT IN`.
3. `<value>` represents a value.
String values should be written in double (`"`) or single (`'`) quotes. C-style escape sequences are supported (`\"` turns to `"`, `\'` to `'`, `\\` to backslash). ||
|| orderBy | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
The default sorting order is ascending ||
|#

## ListInstancesResponse {#yandex.cloud.compute.v1.ListInstancesResponse}

```json
{
  "instances": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "string",
      "zoneId": "string",
      "platformId": "string",
      "resources": {
        "memory": "int64",
        "cores": "int64",
        "coreFraction": "int64",
        "gpus": "int64"
      },
      "status": "Status",
      "metadata": "string",
      "metadataOptions": {
        "gceHttpEndpoint": "MetadataOption",
        "awsV1HttpEndpoint": "MetadataOption",
        "gceHttpToken": "MetadataOption",
        "awsV1HttpToken": "MetadataOption"
      },
      "bootDisk": {
        "mode": "Mode",
        "deviceName": "string",
        "autoDelete": "bool",
        "diskId": "string"
      },
      "secondaryDisks": [
        {
          "mode": "Mode",
          "deviceName": "string",
          "autoDelete": "bool",
          "diskId": "string"
        }
      ],
      "localDisks": [
        {
          "size": "int64",
          "deviceName": "string"
        }
      ],
      "filesystems": [
        {
          "mode": "Mode",
          "deviceName": "string",
          "filesystemId": "string"
        }
      ],
      "networkInterfaces": [
        {
          "index": "string",
          "macAddress": "string",
          "subnetId": "string",
          "primaryV4Address": {
            "address": "string",
            "oneToOneNat": {
              "address": "string",
              "ipVersion": "IpVersion",
              "dnsRecords": [
                {
                  "fqdn": "string",
                  "dnsZoneId": "string",
                  "ttl": "int64",
                  "ptr": "bool"
                }
              ]
            },
            "dnsRecords": [
              {
                "fqdn": "string",
                "dnsZoneId": "string",
                "ttl": "int64",
                "ptr": "bool"
              }
            ]
          },
          "primaryV6Address": {
            "address": "string",
            "oneToOneNat": {
              "address": "string",
              "ipVersion": "IpVersion",
              "dnsRecords": [
                {
                  "fqdn": "string",
                  "dnsZoneId": "string",
                  "ttl": "int64",
                  "ptr": "bool"
                }
              ]
            },
            "dnsRecords": [
              {
                "fqdn": "string",
                "dnsZoneId": "string",
                "ttl": "int64",
                "ptr": "bool"
              }
            ]
          },
          "securityGroupIds": [
            "string"
          ]
        }
      ],
      "serialPortSettings": {
        "sshAuthorization": "SSHAuthorization"
      },
      "gpuSettings": {
        "gpuClusterId": "string"
      },
      "fqdn": "string",
      "schedulingPolicy": {
        "preemptible": "bool"
      },
      "serviceAccountId": "string",
      "networkSettings": {
        "type": "Type"
      },
      "placementPolicy": {
        "placementGroupId": "string",
        "hostAffinityRules": [
          {
            "key": "string",
            "op": "Operator",
            "values": [
              "string"
            ]
          }
        ],
        "placementGroupPartition": "int64"
      },
      "hostGroupId": "string",
      "hostId": "string",
      "maintenancePolicy": "MaintenancePolicy",
      "maintenanceGracePeriod": "google.protobuf.Duration",
      "hardwareGeneration": {
        // Includes only one of the fields `legacyFeatures`, `generation2Features`
        "legacyFeatures": {
          "pciTopology": "PCITopology"
        },
        "generation2Features": "Generation2HardwareFeatures"
        // end of the list of possible fields
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| instances[] | **[Instance](#yandex.cloud.compute.v1.Instance)**

List of Instance resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListInstancesRequest.pageSize](#yandex.cloud.compute.v1.ListInstancesRequest), use
the `nextPageToken` as the value
for the [ListInstancesRequest.pageToken](#yandex.cloud.compute.v1.ListInstancesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Instance {#yandex.cloud.compute.v1.Instance}

An Instance resource. For more information, see [Instances](/docs/compute/concepts/vm).

#|
||Field | Description ||
|| id | **string**

ID of the instance. ||
|| folderId | **string**

ID of the folder that the instance belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| name | **string**

Name of the instance. 1-63 characters long. ||
|| description | **string**

Description of the instance. 0-256 characters long. ||
|| labels | **string**

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| zoneId | **string**

ID of the availability zone where the instance resides. ||
|| platformId | **string**

ID of the hardware platform configuration for the instance. ||
|| resources | **[Resources](#yandex.cloud.compute.v1.Resources)**

Computing resources of the instance such as the amount of memory and number of cores. ||
|| status | enum **Status**

Status of the instance.

- `STATUS_UNSPECIFIED`
- `PROVISIONING`: Instance is waiting for resources to be allocated.
- `RUNNING`: Instance is running normally.
- `STOPPING`: Instance is being stopped.
- `STOPPED`: Instance stopped.
- `STARTING`: Instance is being started.
- `RESTARTING`: Instance is being restarted.
- `UPDATING`: Instance is being updated.
- `ERROR`: Instance encountered a problem and cannot operate.
- `CRASHED`: Instance crashed and will be restarted automatically.
- `DELETING`: Instance is being deleted. ||
|| metadata | **string**

The metadata `key:value` pairs assigned to this instance. This includes custom metadata and predefined keys.

For example, you may use the metadata in order to provide your public SSH key to the instance.
For more information, see [Metadata](/docs/compute/concepts/vm-metadata). ||
|| metadataOptions | **[MetadataOptions](#yandex.cloud.compute.v1.MetadataOptions)**

Options allow user to configure access to instance's metadata ||
|| bootDisk | **[AttachedDisk](#yandex.cloud.compute.v1.AttachedDisk)**

Boot disk that is attached to the instance. ||
|| secondaryDisks[] | **[AttachedDisk](#yandex.cloud.compute.v1.AttachedDisk)**

Array of secondary disks that are attached to the instance. ||
|| localDisks[] | **[AttachedLocalDisk](#yandex.cloud.compute.v1.AttachedLocalDisk)**

Array of local disks that are attached to the instance. ||
|| filesystems[] | **[AttachedFilesystem](#yandex.cloud.compute.v1.AttachedFilesystem)**

Array of filesystems that are attached to the instance. ||
|| networkInterfaces[] | **[NetworkInterface](#yandex.cloud.compute.v1.NetworkInterface)**

Array of network interfaces that are attached to the instance. ||
|| serialPortSettings | **[SerialPortSettings](#yandex.cloud.compute.v1.SerialPortSettings)**

Serial port settings ||
|| gpuSettings | **[GpuSettings](#yandex.cloud.compute.v1.GpuSettings)**

GPU settings ||
|| fqdn | **string**

A domain name of the instance. FQDN is defined by the server
in the format `<hostname>.<region_id>.internal` when the instance is created.
If the hostname were not specified when the instance was created, FQDN would be `<id>.auto.internal`. ||
|| schedulingPolicy | **[SchedulingPolicy](#yandex.cloud.compute.v1.SchedulingPolicy)**

Scheduling policy configuration. ||
|| serviceAccountId | **string**

ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm).
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request. ||
|| networkSettings | **[NetworkSettings](#yandex.cloud.compute.v1.NetworkSettings)**

Network Settings ||
|| placementPolicy | **[PlacementPolicy](#yandex.cloud.compute.v1.PlacementPolicy)**

Placement policy configuration. ||
|| hostGroupId | **string**

ID of the dedicated host group that the instance belongs to. ||
|| hostId | **string**

ID of the dedicated host that the instance belongs to. ||
|| maintenancePolicy | enum **MaintenancePolicy**

Behaviour on maintenance events

- `MAINTENANCE_POLICY_UNSPECIFIED`
- `RESTART`: Restart instance to move it to another host during maintenance
- `MIGRATE`: Use live migration to move instance to another host during maintenance ||
|| maintenanceGracePeriod | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Time between notification via metadata service and maintenance ||
|| hardwareGeneration | **[HardwareGeneration](#yandex.cloud.compute.v1.HardwareGeneration)**

This feature set is inherited from the image/disk used as a boot one at the creation of the instance. ||
|#

## Resources {#yandex.cloud.compute.v1.Resources}

#|
||Field | Description ||
|| memory | **int64**

The amount of memory available to the instance, specified in bytes. ||
|| cores | **int64**

The number of cores available to the instance. ||
|| coreFraction | **int64**

Baseline level of CPU performance with the ability to burst performance above that baseline level.
This field sets baseline performance for each core. ||
|| gpus | **int64**

The number of GPUs available to the instance. ||
|#

## MetadataOptions {#yandex.cloud.compute.v1.MetadataOptions}

#|
||Field | Description ||
|| gceHttpEndpoint | enum **MetadataOption**

Enabled access to GCE flavored metadata

- `METADATA_OPTION_UNSPECIFIED`
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| awsV1HttpEndpoint | enum **MetadataOption**

Enabled access to AWS flavored metadata (IMDSv1)

- `METADATA_OPTION_UNSPECIFIED`
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| gceHttpToken | enum **MetadataOption**

Enabled access to IAM credentials with GCE flavored metadata

- `METADATA_OPTION_UNSPECIFIED`
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| awsV1HttpToken | enum **MetadataOption**

Enabled access to IAM credentials with AWS flavored metadata (IMDSv1)

- `METADATA_OPTION_UNSPECIFIED`
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|#

## AttachedDisk {#yandex.cloud.compute.v1.AttachedDisk}

#|
||Field | Description ||
|| mode | enum **Mode**

Access mode to the Disk resource.

- `MODE_UNSPECIFIED`
- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. ||
|| deviceName | **string**

Serial number that is reflected into the /dev/disk/by-id/ tree
of a Linux operating system running within the instance.

This value can be used to reference the device for mounting, resizing, and so on, from within the instance. ||
|| autoDelete | **bool**

Specifies whether the disk will be auto-deleted when the instance is deleted. ||
|| diskId | **string**

ID of the disk that is attached to the instance. ||
|#

## AttachedLocalDisk {#yandex.cloud.compute.v1.AttachedLocalDisk}

#|
||Field | Description ||
|| size | **int64**

Size of the disk, specified in bytes. ||
|| deviceName | **string**

Serial number that is reflected into the /dev/disk/by-id/ tree
of a Linux operating system running within the instance.

This value can be used to reference the device for mounting, resizing, and so on, from within the instance. ||
|#

## AttachedFilesystem {#yandex.cloud.compute.v1.AttachedFilesystem}

#|
||Field | Description ||
|| mode | enum **Mode**

Access mode to the filesystem.

- `MODE_UNSPECIFIED`
- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. ||
|| deviceName | **string**

Name of the device representing the filesystem on the instance.

The name should be used for referencing the filesystem from within the instance
when it's being mounted, resized etc. ||
|| filesystemId | **string**

ID of the filesystem that is attached to the instance. ||
|#

## NetworkInterface {#yandex.cloud.compute.v1.NetworkInterface}

#|
||Field | Description ||
|| index | **string**

The index of the network interface, will be generated by the server, 0,1,2... etc if not specified. ||
|| macAddress | **string**

MAC address that is assigned to the network interface. ||
|| subnetId | **string**

ID of the subnet. ||
|| primaryV4Address | **[PrimaryAddress](#yandex.cloud.compute.v1.PrimaryAddress)**

Primary IPv4 address that is assigned to the instance for this network interface. ||
|| primaryV6Address | **[PrimaryAddress](#yandex.cloud.compute.v1.PrimaryAddress)**

Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. ||
|| securityGroupIds[] | **string**

ID's of security groups attached to the interface ||
|#

## PrimaryAddress {#yandex.cloud.compute.v1.PrimaryAddress}

#|
||Field | Description ||
|| address | **string**

An IPv4 internal network address that is assigned to the instance for this network interface. ||
|| oneToOneNat | **[OneToOneNat](#yandex.cloud.compute.v1.OneToOneNat)**

One-to-one NAT configuration. If missing, NAT has not been set up. ||
|| dnsRecords[] | **[DnsRecord](#yandex.cloud.compute.v1.DnsRecord)**

Internal DNS configuration ||
|#

## OneToOneNat {#yandex.cloud.compute.v1.OneToOneNat}

#|
||Field | Description ||
|| address | **string**

An external IP address associated with this instance. ||
|| ipVersion | enum **IpVersion**

IP version for the external IP address.

- `IP_VERSION_UNSPECIFIED`
- `IPV4`: IPv4 address, for example 192.0.2.235.
- `IPV6`: IPv6 address. Not available yet. ||
|| dnsRecords[] | **[DnsRecord](#yandex.cloud.compute.v1.DnsRecord)**

External DNS configuration ||
|#

## DnsRecord {#yandex.cloud.compute.v1.DnsRecord}

#|
||Field | Description ||
|| fqdn | **string**

Name of the A/AAAA record as specified when creating the instance.
Note that if `fqdn' has no trailing '.', it is specified relative to the zone (@see dns_zone_id). ||
|| dnsZoneId | **string**

DNS zone id for the record (optional, if not set, some private zone is used). ||
|| ttl | **int64**

DNS record ttl (optional, if not set, a reasonable default is used.) ||
|| ptr | **bool**

When true, indicates there is a corresponding auto-created PTR DNS record. ||
|#

## SerialPortSettings {#yandex.cloud.compute.v1.SerialPortSettings}

#|
||Field | Description ||
|| sshAuthorization | enum **SSHAuthorization**

Authentication and authorization in serial console when using SSH protocol

- `SSH_AUTHORIZATION_UNSPECIFIED`
- `INSTANCE_METADATA`: Authentication and authorization using SSH keys in instance metadata
- `OS_LOGIN`: Authentication and authorization using Oslogin service ||
|#

## GpuSettings {#yandex.cloud.compute.v1.GpuSettings}

#|
||Field | Description ||
|| gpuClusterId | **string**

Attach instance to specified GPU cluster. ||
|#

## SchedulingPolicy {#yandex.cloud.compute.v1.SchedulingPolicy}

#|
||Field | Description ||
|| preemptible | **bool**

True for short-lived compute instances. For more information, see [Preemptible VMs](/docs/compute/concepts/preemptible-vm). ||
|#

## NetworkSettings {#yandex.cloud.compute.v1.NetworkSettings}

#|
||Field | Description ||
|| type | enum **Type**

Network Type

- `TYPE_UNSPECIFIED`
- `STANDARD`: Standard network.
- `SOFTWARE_ACCELERATED`: Software accelerated network.
- `HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use). ||
|#

## PlacementPolicy {#yandex.cloud.compute.v1.PlacementPolicy}

#|
||Field | Description ||
|| placementGroupId | **string**

Placement group ID. ||
|| hostAffinityRules[] | **[HostAffinityRule](#yandex.cloud.compute.v1.PlacementPolicy.HostAffinityRule)**

List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. ||
|| placementGroupPartition | **int64**

Placement group partition ||
|#

## HostAffinityRule {#yandex.cloud.compute.v1.PlacementPolicy.HostAffinityRule}

Affinity definition

#|
||Field | Description ||
|| key | **string**

Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' ||
|| op | enum **Operator**

Include or exclude action

- `OPERATOR_UNSPECIFIED`
- `IN`
- `NOT_IN` ||
|| values[] | **string**

Affinity value or host ID or host group ID ||
|#

## HardwareGeneration {#yandex.cloud.compute.v1.HardwareGeneration}

A set of features, specific to a particular Compute hardware generation.
They are not necessary supported by every host OS or distro, thus they are fixed to an image
and are applied to all instances created with it as their boot disk image.
These features significantly determine how the instance is created, thus cannot be changed after the fact.

#|
||Field | Description ||
|| legacyFeatures | **[LegacyHardwareFeatures](#yandex.cloud.compute.v1.LegacyHardwareFeatures)**

Includes only one of the fields `legacyFeatures`, `generation2Features`. ||
|| generation2Features | **[Generation2HardwareFeatures](#yandex.cloud.compute.v1.Generation2HardwareFeatures)**

Includes only one of the fields `legacyFeatures`, `generation2Features`. ||
|#

## LegacyHardwareFeatures {#yandex.cloud.compute.v1.LegacyHardwareFeatures}

A first hardware generation, by default compatible with all legacy images.
Allows switching to PCI_TOPOLOGY_V2 and back.

#|
||Field | Description ||
|| pciTopology | enum **PCITopology**

- `PCI_TOPOLOGY_UNSPECIFIED`
- `PCI_TOPOLOGY_V1`
- `PCI_TOPOLOGY_V2` ||
|#

## Generation2HardwareFeatures {#yandex.cloud.compute.v1.Generation2HardwareFeatures}

A second hardware generation, which by default assumes PCI_TOPOLOGY_V2
and UEFI boot (with UEFI related features).

#|
||Field | Description ||
|| Empty | > ||
|#