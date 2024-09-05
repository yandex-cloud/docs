---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/InstanceGroup/get.md
---

# Compute Cloud Instance Groups API, REST: InstanceGroup.get
Returns the specified InstanceGroup resource.
 
To get the list of available InstanceGroup resources, make a [list](/docs/compute/api-ref/InstanceGroup/list) request.
 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/instanceGroups/{instanceGroupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
instanceGroupId | <p>Required. ID of the InstanceGroup resource to return. To get the instance group ID, use a <a href="/docs/compute/api-ref/InstanceGroup/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
view | <p>Defines which information about the Instance template should be returned in the server response.</p> <ul> <li>BASIC: Doesn't include the metadata of the instance template in the server response.</li> <li>FULL: Returns the metadata of the instance template in the server response.</li> </ul> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "instanceTemplate": {
    "description": "string",
    "labels": "object",
    "platformId": "string",
    "resourcesSpec": {
      "memory": "string",
      "cores": "string",
      "coreFraction": "string",
      "gpus": "string"
    },
    "metadata": "object",
    "bootDiskSpec": {
      "mode": "string",
      "deviceName": "string",
      "diskSpec": {
        "description": "string",
        "typeId": "string",
        "size": "string",
        "preserveAfterInstanceDelete": true,

        // `instanceTemplate.bootDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`
        "imageId": "string",
        "snapshotId": "string",
        // end of the list of possible fields`instanceTemplate.bootDiskSpec.diskSpec`

      },
      "diskId": "string",
      "name": "string"
    },
    "secondaryDiskSpecs": [
      {
        "mode": "string",
        "deviceName": "string",
        "diskSpec": {
          "description": "string",
          "typeId": "string",
          "size": "string",
          "preserveAfterInstanceDelete": true,

          // `instanceTemplate.secondaryDiskSpecs[].diskSpec` includes only one of the fields `imageId`, `snapshotId`
          "imageId": "string",
          "snapshotId": "string",
          // end of the list of possible fields`instanceTemplate.secondaryDiskSpecs[].diskSpec`

        },
        "diskId": "string",
        "name": "string"
      }
    ],
    "networkInterfaceSpecs": [
      {
        "networkId": "string",
        "subnetIds": [
          "string"
        ],
        "primaryV4AddressSpec": {
          "oneToOneNatSpec": {
            "ipVersion": "string",
            "address": "string",
            "dnsRecordSpecs": [
              {
                "fqdn": "string",
                "dnsZoneId": "string",
                "ttl": "string",
                "ptr": true
              }
            ]
          },
          "dnsRecordSpecs": [
            {
              "fqdn": "string",
              "dnsZoneId": "string",
              "ttl": "string",
              "ptr": true
            }
          ],
          "address": "string"
        },
        "primaryV6AddressSpec": {
          "oneToOneNatSpec": {
            "ipVersion": "string",
            "address": "string",
            "dnsRecordSpecs": [
              {
                "fqdn": "string",
                "dnsZoneId": "string",
                "ttl": "string",
                "ptr": true
              }
            ]
          },
          "dnsRecordSpecs": [
            {
              "fqdn": "string",
              "dnsZoneId": "string",
              "ttl": "string",
              "ptr": true
            }
          ],
          "address": "string"
        },
        "securityGroupIds": [
          "string"
        ]
      }
    ],
    "schedulingPolicy": {
      "preemptible": true
    },
    "serviceAccountId": "string",
    "networkSettings": {
      "type": "string"
    },
    "name": "string",
    "hostname": "string",
    "placementPolicy": {
      "placementGroupId": "string",
      "hostAffinityRules": [
        {
          "key": "string",
          "op": "string",
          "values": [
            "string"
          ]
        }
      ]
    },
    "filesystemSpecs": [
      {
        "mode": "string",
        "deviceName": "string",
        "filesystemId": "string"
      }
    ],
    "metadataOptions": {
      "gceHttpEndpoint": "string",
      "awsV1HttpEndpoint": "string",
      "gceHttpToken": "string",
      "awsV1HttpToken": "string"
    }
  },
  "scalePolicy": {
    "testAutoScale": {
      "minZoneSize": "string",
      "maxSize": "string",
      "measurementDuration": "string",
      "warmupDuration": "string",
      "stabilizationDuration": "string",
      "initialSize": "string",
      "cpuUtilizationRule": {
        "utilizationTarget": "number"
      },
      "customRules": [
        {
          "ruleType": "string",
          "metricType": "string",
          "metricName": "string",
          "labels": "object",
          "target": "number",
          "folderId": "string",
          "service": "string"
        }
      ],
      "autoScaleType": "string"
    },

    // `scalePolicy` includes only one of the fields `fixedScale`, `autoScale`
    "fixedScale": {
      "size": "string"
    },
    "autoScale": {
      "minZoneSize": "string",
      "maxSize": "string",
      "measurementDuration": "string",
      "warmupDuration": "string",
      "stabilizationDuration": "string",
      "initialSize": "string",
      "cpuUtilizationRule": {
        "utilizationTarget": "number"
      },
      "customRules": [
        {
          "ruleType": "string",
          "metricType": "string",
          "metricName": "string",
          "labels": "object",
          "target": "number",
          "folderId": "string",
          "service": "string"
        }
      ],
      "autoScaleType": "string"
    },
    // end of the list of possible fields`scalePolicy`

  },
  "deployPolicy": {
    "maxUnavailable": "string",
    "maxDeleting": "string",
    "maxCreating": "string",
    "maxExpansion": "string",
    "startupDuration": "string",
    "strategy": "string",
    "minimalAction": "string"
  },
  "allocationPolicy": {
    "zones": [
      {
        "zoneId": "string",
        "instanceTagsPool": [
          "string"
        ]
      }
    ]
  },
  "loadBalancerState": {
    "targetGroupId": "string",
    "statusMessage": "string"
  },
  "managedInstancesState": {
    "targetSize": "string",
    "runningActualCount": "string",
    "runningOutdatedCount": "string",
    "processingCount": "string"
  },
  "loadBalancerSpec": {
    "targetGroupSpec": {
      "name": "string",
      "description": "string",
      "labels": "object"
    },
    "maxOpeningTrafficDuration": "string",
    "ignoreHealthChecks": true
  },
  "healthChecksSpec": {
    "healthCheckSpecs": [
      {
        "interval": "string",
        "timeout": "string",
        "unhealthyThreshold": "string",
        "healthyThreshold": "string",

        // `healthChecksSpec.healthCheckSpecs[]` includes only one of the fields `tcpOptions`, `httpOptions`
        "tcpOptions": {
          "port": "string"
        },
        "httpOptions": {
          "port": "string",
          "path": "string"
        },
        // end of the list of possible fields`healthChecksSpec.healthCheckSpecs[]`

      }
    ],
    "maxCheckingHealthDuration": "string"
  },
  "serviceAccountId": "string",
  "status": "string",
  "variables": [
    {
      "key": "string",
      "value": "string"
    }
  ],
  "deletionProtection": true,
  "applicationLoadBalancerSpec": {
    "targetGroupSpec": {
      "name": "string",
      "description": "string",
      "labels": "object"
    },
    "maxOpeningTrafficDuration": "string",
    "ignoreHealthChecks": true
  },
  "applicationLoadBalancerState": {
    "targetGroupId": "string",
    "statusMessage": "string"
  },
  "autoHealingPolicy": {
    "autoHealingAction": "string"
  }
}
```

 
Field | Description
--- | ---
id | **string**<br><p>ID of the instance group.</p> 
folderId | **string**<br><p>ID of the folder that the instance group belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the instance group. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the instance group.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
instanceTemplate | **object**<br><p>Instance template for creating the instance group. For more information, see <a href="/docs/compute/concepts/instance-groups/instance-template">Instance Templates</a>.</p> 
instanceTemplate.<br>description | **string**<br><p>Description of the instance template.</p> <p>The maximum string length in characters is 256.</p> 
instanceTemplate.<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\@0-9a-z]*``. The maximum string length in characters for each value is 128.</p> 
instanceTemplate.<br>platformId | **string**<br><p>Required. ID of the hardware platform configuration for the instance. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see <a href="/docs/compute/concepts/vm-platforms">Platforms</a>.</p> 
instanceTemplate.<br>resourcesSpec | **object**<br><p>Required. Computing resources of the instance such as the amount of memory and number of cores.</p> 
instanceTemplate.<br>resourcesSpec.<br>memory | **string** (int64)<br><p>The amount of memory available to the instance, specified in bytes.</p> <p>The maximum value is 824633720832.</p> 
instanceTemplate.<br>resourcesSpec.<br>cores | **string** (int64)<br><p>The number of cores available to the instance.</p> <p>Value must be one of 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76 or 80.</p> 
instanceTemplate.<br>resourcesSpec.<br>coreFraction | **string** (int64)<br><p>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core.</p> <p>Value must be one of 0, 5, 20, 50 or 100.</p> 
instanceTemplate.<br>resourcesSpec.<br>gpus | **string** (int64)<br><p>The number of GPUs available to the instance.</p> <p>Value must be one of 0, 1, 2 or 4.</p> 
instanceTemplate.<br>metadata | **object**<br><p>The metadata ``key:value`` pairs assigned to this instance template. This includes custom metadata and predefined keys.</p> <p>Metadata values may contain one of the supported placeholders: {instance_group.id} {instance.short_id} {instance.index} {instance.index_in_zone} {instance.zone_id} InstanceGroup and Instance labels may be copied to metadata following way: {instance_group.labels.some_label_key} {instance.labels.another_label_key} These placeholders will be substituted for each created instance anywhere in the value text. In the rare case the value requires to contain this placeholder explicitly, it must be escaped with double brackets, in example {instance.index}.</p> <p>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see <a href="/docs/compute/concepts/vm-metadata">Metadata</a>.</p> <p>No more than 128 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 262144.</p> 
instanceTemplate.<br>bootDiskSpec | **object**<br><p>Required. Boot disk specification that will be attached to the instance.</p> 
instanceTemplate.<br>bootDiskSpec.<br>mode | **string**<br><p>Required. Access mode to the Disk resource.</p> <ul> <li>READ_ONLY: Read-only access.</li> <li>READ_WRITE: Read/Write access.</li> </ul> 
instanceTemplate.<br>bootDiskSpec.<br>deviceName | **string**<br><p>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance.</p> <p>This value can be used to reference the device for mounting, resizing, and so on, from within the instance.</p> <p>Value must match the regular expression ``\|[a-z][-_0-9a-z]{0,19}``.</p> 
instanceTemplate.<br>bootDiskSpec.<br>diskSpec | **object**<br><p>Required. oneof disk_spec or disk_id Disk specification that is attached to the instance. For more information, see <a href="/docs/compute/concepts/disk">Disks</a>.</p> 
instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>description | **string**<br><p>Description of the disk.</p> <p>The maximum string length in characters is 256.</p> 
instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>typeId | **string**<br><p>Required. ID of the disk type.</p> 
instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>size | **string** (int64)<br><p>Size of the disk, specified in bytes.</p> <p>Acceptable values are 4194304 to 28587302322176, inclusive.</p> 
instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>preserveAfterInstanceDelete | **boolean** (boolean)<br><p>When set to true, disk will not be deleted even after managed instance is deleted. It will be a user's responsibility to delete such disks.</p> 
instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>imageId | **string** <br>`instanceTemplate.bootDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`<br><br><p>ID of the image that will be used for disk creation.</p> <p>The maximum string length in characters is 50.</p> 
instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>snapshotId | **string** <br>`instanceTemplate.bootDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`<br><br><p>ID of the snapshot that will be used for disk creation.</p> <p>The maximum string length in characters is 50.</p> 
instanceTemplate.<br>bootDiskSpec.<br>diskId | **string**<br><p>Set to use an existing disk. To set use variables.</p> <p>The maximum string length in characters is 128. Value must match the regular expression ``[-a-zA-Z0-9._{}]*``.</p> 
instanceTemplate.<br>bootDiskSpec.<br>name | **string**<br><p>When set can be later used to change DiskSpec of actual disk.</p> <p>The maximum string length in characters is 128.</p> 
instanceTemplate.<br>secondaryDiskSpecs[] | **object**<br><p>Array of secondary disks that will be attached to the instance.</p> <p>The maximum number of elements is 3.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>mode | **string**<br><p>Required. Access mode to the Disk resource.</p> <ul> <li>READ_ONLY: Read-only access.</li> <li>READ_WRITE: Read/Write access.</li> </ul> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>deviceName | **string**<br><p>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance.</p> <p>This value can be used to reference the device for mounting, resizing, and so on, from within the instance.</p> <p>Value must match the regular expression ``\|[a-z][-_0-9a-z]{0,19}``.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec | **object**<br><p>Required. oneof disk_spec or disk_id Disk specification that is attached to the instance. For more information, see <a href="/docs/compute/concepts/disk">Disks</a>.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>description | **string**<br><p>Description of the disk.</p> <p>The maximum string length in characters is 256.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>typeId | **string**<br><p>Required. ID of the disk type.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>size | **string** (int64)<br><p>Size of the disk, specified in bytes.</p> <p>Acceptable values are 4194304 to 28587302322176, inclusive.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>preserveAfterInstanceDelete | **boolean** (boolean)<br><p>When set to true, disk will not be deleted even after managed instance is deleted. It will be a user's responsibility to delete such disks.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>imageId | **string** <br>`instanceTemplate.secondaryDiskSpecs[].diskSpec` includes only one of the fields `imageId`, `snapshotId`<br><br><p>ID of the image that will be used for disk creation.</p> <p>The maximum string length in characters is 50.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>snapshotId | **string** <br>`instanceTemplate.secondaryDiskSpecs[].diskSpec` includes only one of the fields `imageId`, `snapshotId`<br><br><p>ID of the snapshot that will be used for disk creation.</p> <p>The maximum string length in characters is 50.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>diskId | **string**<br><p>Set to use an existing disk. To set use variables.</p> <p>The maximum string length in characters is 128. Value must match the regular expression ``[-a-zA-Z0-9._{}]*``.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>name | **string**<br><p>When set can be later used to change DiskSpec of actual disk.</p> <p>The maximum string length in characters is 128.</p> 
instanceTemplate.<br>networkInterfaceSpecs[] | **object**<br><p>Required. Array of network interfaces that will be attached to the instance.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>networkId | **string**<br><p>ID of the network.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>subnetIds[] | **string**<br><p>IDs of the subnets.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec | **object**<br><p>Primary IPv4 address that is assigned to the instance for this network interface.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec | **object**<br><p>An external IP address configuration. If not specified, then this managed instance will have no external internet access.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>IP version for the public IP address.</p> <ul> <li>IPV4: IPv4 address, for example 192.168.0.0.</li> <li>IPV6: IPv6 address, not available yet.</li> </ul> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>address | **string**<br><p>Manual set static public IP. To set use variables. (optional)</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[] | **object**<br><p>External DNS configuration</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>fqdn | **string**<br><p>Required. FQDN (required)</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, private zone used)</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>ttl | **string** (int64)<br><p>DNS record ttl, values in 0-86400 (optional)</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>ptr | **boolean** (boolean)<br><p>When set to true, also create PTR DNS record (optional)</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[] | **object**<br><p>Internal DNS configuration</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>fqdn | **string**<br><p>Required. FQDN (required)</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, private zone used)</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>ttl | **string** (int64)<br><p>DNS record ttl, values in 0-86400 (optional)</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>ptr | **boolean** (boolean)<br><p>When set to true, also create PTR DNS record (optional)</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>address | **string**<br><p>Optional. Manual set static internal IP. To set use variables.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec | **object**<br><p>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec | **object**<br><p>An external IP address configuration. If not specified, then this managed instance will have no external internet access.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>IP version for the public IP address.</p> <ul> <li>IPV4: IPv4 address, for example 192.168.0.0.</li> <li>IPV6: IPv6 address, not available yet.</li> </ul> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>address | **string**<br><p>Manual set static public IP. To set use variables. (optional)</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[] | **object**<br><p>External DNS configuration</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>fqdn | **string**<br><p>Required. FQDN (required)</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, private zone used)</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>ttl | **string** (int64)<br><p>DNS record ttl, values in 0-86400 (optional)</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>ptr | **boolean** (boolean)<br><p>When set to true, also create PTR DNS record (optional)</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[] | **object**<br><p>Internal DNS configuration</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[].<br>fqdn | **string**<br><p>Required. FQDN (required)</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, private zone used)</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[].<br>ttl | **string** (int64)<br><p>DNS record ttl, values in 0-86400 (optional)</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[].<br>ptr | **boolean** (boolean)<br><p>When set to true, also create PTR DNS record (optional)</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>address | **string**<br><p>Optional. Manual set static internal IP. To set use variables.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>securityGroupIds[] | **string**<br><p>IDs of security groups.</p> 
instanceTemplate.<br>schedulingPolicy | **object**<br><p>Scheduling policy for the instance.</p> 
instanceTemplate.<br>schedulingPolicy.<br>preemptible | **boolean** (boolean)<br><p>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see <a href="/docs/compute/concepts/preemptible-vm">Preemptible Virtual Machines</a>.</p> 
instanceTemplate.<br>serviceAccountId | **string**<br><p>Service account ID for the instance.</p> 
instanceTemplate.<br>networkSettings | **object**<br><p>Network settings for the instance.</p> 
instanceTemplate.<br>networkSettings.<br>type | **string**<br><p>Type of instance network.</p> 
instanceTemplate.<br>name | **string**<br><p>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list.</p> <p>The maximum string length in characters is 128.</p> 
instanceTemplate.<br>hostname | **string**<br><p>Host name for the instance. This field is used to generate the <a href="/docs/compute/api-ref/Instance#representation">Instance.fqdn</a> value. The host name must be unique within the network and region. If not specified, the host name will be equal to <a href="/docs/compute/api-ref/Instance#representation">Instance.id</a> of the instance and FQDN will be ``<id>.auto.internal``. Otherwise FQDN will be ``<hostname>.<region_id>.internal``.</p> <p>In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, ``name`` value will be used It may also contain another placeholders, see metadata doc for full list.</p> <p>The maximum string length in characters is 128.</p> 
instanceTemplate.<br>placementPolicy | **object**<br><p>Placement Group</p> 
instanceTemplate.<br>placementPolicy.<br>placementGroupId | **string**<br><p>Identifier of placement group</p> 
instanceTemplate.<br>placementPolicy.<br>hostAffinityRules[] | **object**<br><p>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules.</p> 
instanceTemplate.<br>placementPolicy.<br>hostAffinityRules[].<br>key | **string**<br><p>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId'</p> 
instanceTemplate.<br>placementPolicy.<br>hostAffinityRules[].<br>op | **string**<br><p>Include or exclude action</p> 
instanceTemplate.<br>placementPolicy.<br>hostAffinityRules[].<br>values[] | **string**<br><p>Affinity value or host ID or host group ID</p> 
instanceTemplate.<br>filesystemSpecs[] | **object**<br><p>Array of filesystems to attach to the instance.</p> <p>The filesystems must reside in the same availability zone as the instance.</p> <p>To use the instance with an attached filesystem, the latter must be mounted. For details, see <a href="/docs/compute/operations/filesystem/attach-to-vm">documentation</a>.</p> 
instanceTemplate.<br>filesystemSpecs[].<br>mode | **string**<br><p>Mode of access to the filesystem that should be attached.</p> <ul> <li>READ_ONLY: Read-only access.</li> <li>READ_WRITE: Read/Write access. Default value.</li> </ul> 
instanceTemplate.<br>filesystemSpecs[].<br>deviceName | **string**<br><p>Name of the device representing the filesystem on the instance.</p> <p>The name should be used for referencing the filesystem from within the instance when it's being mounted, resized etc.</p> <p>If not specified, a random value will be generated.</p> <p>Value must match the regular expression ``\|[a-z][-_0-9a-z]{0,19}``.</p> 
instanceTemplate.<br>filesystemSpecs[].<br>filesystemId | **string**<br><p>ID of the filesystem that should be attached.</p> <p>The maximum string length in characters is 128. Value must match the regular expression ``[-a-zA-Z0-9._{}]*``.</p> 
instanceTemplate.<br>metadataOptions | **object**<br><p>Metadata options for the instance</p> 
instanceTemplate.<br>metadataOptions.<br>gceHttpEndpoint | **string**<br><p>Enabled access to GCE flavored metadata</p> <ul> <li>ENABLED: Option is enabled</li> <li>DISABLED: Option is disabled</li> </ul> 
instanceTemplate.<br>metadataOptions.<br>awsV1HttpEndpoint | **string**<br><p>Enabled access to AWS flavored metadata (IMDSv1)</p> <ul> <li>ENABLED: Option is enabled</li> <li>DISABLED: Option is disabled</li> </ul> 
instanceTemplate.<br>metadataOptions.<br>gceHttpToken | **string**<br><p>Enabled access to IAM credentials with GCE flavored metadata</p> <ul> <li>ENABLED: Option is enabled</li> <li>DISABLED: Option is disabled</li> </ul> 
instanceTemplate.<br>metadataOptions.<br>awsV1HttpToken | **string**<br><p>Enabled access to IAM credentials with AWS flavored metadata (IMDSv1)</p> <ul> <li>ENABLED: Option is enabled</li> <li>DISABLED: Option is disabled</li> </ul> 
scalePolicy | **object**<br><p><a href="/docs/compute/concepts/instance-groups/scale">Scaling policy</a> of the instance group.</p> 
scalePolicy.<br>testAutoScale | **object**<br>[Automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group.
scalePolicy.<br>testAutoScale.<br>minZoneSize | **string** (int64)<br><p>Lower limit for instance count in each zone.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
scalePolicy.<br>testAutoScale.<br>maxSize | **string** (int64)<br><p>Upper limit for total instance count (across all zones). 0 means maximum limit = 100.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
scalePolicy.<br>testAutoScale.<br>measurementDuration | **string**<br><p>Time in seconds allotted for averaging metrics. 1 minute by default.</p> <p>Acceptable values are 60 seconds to 600 seconds, inclusive.</p> 
scalePolicy.<br>testAutoScale.<br>warmupDuration | **string**<br><p>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected.</p> <p>The maximum value is 600 seconds.</p> 
scalePolicy.<br>testAutoScale.<br>stabilizationDuration | **string**<br><p>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should.</p> <p>Acceptable values are 60 seconds to 1800 seconds, inclusive.</p> 
scalePolicy.<br>testAutoScale.<br>initialSize | **string** (int64)<br><p>Target group size.</p> <p>The minimum value is 1.</p> 
scalePolicy.<br>testAutoScale.<br>cpuUtilizationRule | **object**<br><p>Defines an autoscaling rule based on the average CPU utilization of the instance group.</p> <p>If more than one rule is specified, e.g. CPU utilization and one or more Monitoring metrics (``customRules``), the size of the instance group will be equal to the maximum of sizes calculated according to each metric.</p> 
scalePolicy.<br>testAutoScale.<br>cpuUtilizationRule.<br>utilizationTarget | **number** (double)<br><p>Target CPU utilization level. Instance Groups maintains this level for each availability zone.</p> <p>Acceptable values are 10 to 100, inclusive.</p> 
scalePolicy.<br>testAutoScale.<br>customRules[] | **object**<br><p>Defines an autoscaling rule based on a <a href="/docs/monitoring/operations/metric/add">custom metric</a> from Monitoring.</p> <p>If more than one rule is specified, e.g. CPU utilization (``cpuUtilizationRule``) and one or more Monitoring metrics, the size of the instance group will be equal to the maximum of sizes calculated according to each metric.</p> <p>The maximum number of elements is 3.</p> 
scalePolicy.<br>testAutoScale.<br>customRules[].<br>ruleType | **string**<br><p>Required. Custom metric rule type. This field affects which label from the custom metric should be used: ``zone_id`` or ``instance_id``.</p> <ul> <li>UTILIZATION: This type means that the metric applies to one instance. First, Instance Groups calculates the average metric value for each instance, then averages the values for instances in one availability zone or in whole group depends on autoscaling type. This type of metric must have the ``instance_id`` label.</li> <li>WORKLOAD: This type means that the metric applies to instances in one availability zone or to whole group depends on autoscaling type. This type of metric must have the ``zone_id`` label if ZONAL autoscaling type is chosen.</li> </ul> 
scalePolicy.<br>testAutoScale.<br>customRules[].<br>metricType | **string**<br><p>Required. Type of custom metric. This field affects how Instance Groups calculates the average metric value.</p> <ul> <li> <p>GAUGE: This type is used for metrics that show the metric value at a certain point in time, such as requests per second to the server on an instance.</p> <p>Instance Groups calculates the average metric value for the period specified in the ``measurementDuration`` field.</p> </li> <li> <p>COUNTER: This type is used for metrics that monotonically increase over time, such as the total number of requests to the server on an instance.</p> <p>Instance Groups calculates the average value increase for the period specified in the ``measurementDuration`` field.</p> </li> </ul> 
scalePolicy.<br>testAutoScale.<br>customRules[].<br>metricName | **string**<br><p>Required. Name of custom metric in Monitoring that should be used for scaling.</p> <p>Value must match the regular expression ``[a-zA-Z0-9./@_][ 0-9a-zA-Z./@_,:;()\[\]<>-]{0,198}``.</p> 
scalePolicy.<br>testAutoScale.<br>customRules[].<br>labels | **object**<br><p>Labels of custom metric in Monitoring that should be used for scaling.</p> <p>Each key must match the regular expression ``^[a-zA-Z][0-9a-zA-Z_]{0,31}$``. Each value must match the regular expression ``[a-zA-Z0-9./@_][ 0-9a-zA-Z./@_,:;()\[\]<>-]{0,198}``.</p> 
scalePolicy.<br>testAutoScale.<br>customRules[].<br>target | **number** (double)<br><p>Target value for the custom metric. Instance Groups maintains this level for each availability zone.</p> <p>Value must be greater than 0.</p> 
scalePolicy.<br>testAutoScale.<br>customRules[].<br>folderId | **string**<br><p>Folder id of custom metric in Monitoring that should be used for scaling.</p> <p>The maximum string length in characters is 50.</p> 
scalePolicy.<br>testAutoScale.<br>customRules[].<br>service | **string**<br><p>Service of custom metric in Monitoring that should be used for scaling.</p> <p>The maximum string length in characters is 200.</p> 
scalePolicy.<br>testAutoScale.<br>autoScaleType | **string**<br><p>Autoscaling type.</p> <ul> <li>ZONAL: Scale each zone independently. This is the default.</li> <li>REGIONAL: Scale group as a whole.</li> </ul> 
scalePolicy.<br>fixedScale | **object**<br>[Manual scaling policy](/docs/compute/concepts/instance-groups/scale#fixed-policy) of the instance group. <br>`scalePolicy` includes only one of the fields `fixedScale`, `autoScale`<br>
scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>Number of instances in the instance group.</p> <p>Acceptable values are 1 to 100, inclusive.</p> 
scalePolicy.<br>autoScale | **object**<br>Test spec for [automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. <br>`scalePolicy` includes only one of the fields `fixedScale`, `autoScale`<br>
scalePolicy.<br>autoScale.<br>minZoneSize | **string** (int64)<br><p>Lower limit for instance count in each zone.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
scalePolicy.<br>autoScale.<br>maxSize | **string** (int64)<br><p>Upper limit for total instance count (across all zones). 0 means maximum limit = 100.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
scalePolicy.<br>autoScale.<br>measurementDuration | **string**<br><p>Time in seconds allotted for averaging metrics. 1 minute by default.</p> <p>Acceptable values are 60 seconds to 600 seconds, inclusive.</p> 
scalePolicy.<br>autoScale.<br>warmupDuration | **string**<br><p>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected.</p> <p>The maximum value is 600 seconds.</p> 
scalePolicy.<br>autoScale.<br>stabilizationDuration | **string**<br><p>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should.</p> <p>Acceptable values are 60 seconds to 1800 seconds, inclusive.</p> 
scalePolicy.<br>autoScale.<br>initialSize | **string** (int64)<br><p>Target group size.</p> <p>The minimum value is 1.</p> 
scalePolicy.<br>autoScale.<br>cpuUtilizationRule | **object**<br><p>Defines an autoscaling rule based on the average CPU utilization of the instance group.</p> <p>If more than one rule is specified, e.g. CPU utilization and one or more Monitoring metrics (``customRules``), the size of the instance group will be equal to the maximum of sizes calculated according to each metric.</p> 
scalePolicy.<br>autoScale.<br>cpuUtilizationRule.<br>utilizationTarget | **number** (double)<br><p>Target CPU utilization level. Instance Groups maintains this level for each availability zone.</p> <p>Acceptable values are 10 to 100, inclusive.</p> 
scalePolicy.<br>autoScale.<br>customRules[] | **object**<br><p>Defines an autoscaling rule based on a <a href="/docs/monitoring/operations/metric/add">custom metric</a> from Monitoring.</p> <p>If more than one rule is specified, e.g. CPU utilization (``cpuUtilizationRule``) and one or more Monitoring metrics, the size of the instance group will be equal to the maximum of sizes calculated according to each metric.</p> <p>The maximum number of elements is 3.</p> 
scalePolicy.<br>autoScale.<br>customRules[].<br>ruleType | **string**<br><p>Required. Custom metric rule type. This field affects which label from the custom metric should be used: ``zone_id`` or ``instance_id``.</p> <ul> <li>UTILIZATION: This type means that the metric applies to one instance. First, Instance Groups calculates the average metric value for each instance, then averages the values for instances in one availability zone or in whole group depends on autoscaling type. This type of metric must have the ``instance_id`` label.</li> <li>WORKLOAD: This type means that the metric applies to instances in one availability zone or to whole group depends on autoscaling type. This type of metric must have the ``zone_id`` label if ZONAL autoscaling type is chosen.</li> </ul> 
scalePolicy.<br>autoScale.<br>customRules[].<br>metricType | **string**<br><p>Required. Type of custom metric. This field affects how Instance Groups calculates the average metric value.</p> <ul> <li> <p>GAUGE: This type is used for metrics that show the metric value at a certain point in time, such as requests per second to the server on an instance.</p> <p>Instance Groups calculates the average metric value for the period specified in the ``measurementDuration`` field.</p> </li> <li> <p>COUNTER: This type is used for metrics that monotonically increase over time, such as the total number of requests to the server on an instance.</p> <p>Instance Groups calculates the average value increase for the period specified in the ``measurementDuration`` field.</p> </li> </ul> 
scalePolicy.<br>autoScale.<br>customRules[].<br>metricName | **string**<br><p>Required. Name of custom metric in Monitoring that should be used for scaling.</p> <p>Value must match the regular expression ``[a-zA-Z0-9./@_][ 0-9a-zA-Z./@_,:;()\[\]<>-]{0,198}``.</p> 
scalePolicy.<br>autoScale.<br>customRules[].<br>labels | **object**<br><p>Labels of custom metric in Monitoring that should be used for scaling.</p> <p>Each key must match the regular expression ``^[a-zA-Z][0-9a-zA-Z_]{0,31}$``. Each value must match the regular expression ``[a-zA-Z0-9./@_][ 0-9a-zA-Z./@_,:;()\[\]<>-]{0,198}``.</p> 
scalePolicy.<br>autoScale.<br>customRules[].<br>target | **number** (double)<br><p>Target value for the custom metric. Instance Groups maintains this level for each availability zone.</p> <p>Value must be greater than 0.</p> 
scalePolicy.<br>autoScale.<br>customRules[].<br>folderId | **string**<br><p>Folder id of custom metric in Monitoring that should be used for scaling.</p> <p>The maximum string length in characters is 50.</p> 
scalePolicy.<br>autoScale.<br>customRules[].<br>service | **string**<br><p>Service of custom metric in Monitoring that should be used for scaling.</p> <p>The maximum string length in characters is 200.</p> 
scalePolicy.<br>autoScale.<br>autoScaleType | **string**<br><p>Autoscaling type.</p> <ul> <li>ZONAL: Scale each zone independently. This is the default.</li> <li>REGIONAL: Scale group as a whole.</li> </ul> 
deployPolicy | **object**<br><p>Deployment policy of the instance group.</p> 
deployPolicy.<br>maxUnavailable | **string** (int64)<br><p>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If ``maxExpansion`` is not specified or set to zero, ``maxUnavailable`` must be set to a non-zero value.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
deployPolicy.<br>maxDeleting | **string** (int64)<br><p>The maximum number of instances that can be deleted at the same time.</p> <p>The value 0 is any number of virtual machines within the allowed values.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
deployPolicy.<br>maxCreating | **string** (int64)<br><p>The maximum number of instances that can be created at the same time.</p> <p>The value 0 is any number of virtual machines within the allowed values.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
deployPolicy.<br>maxExpansion | **string** (int64)<br><p>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If ``maxUnavailable`` is not specified or set to zero, ``maxExpansion`` must be set to a non-zero value.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
deployPolicy.<br>startupDuration | **string**<br><p>Instance startup duration. Instance will be considered up and running (and start receiving traffic) only after startup_duration has elapsed and all health checks are passed. See ``ManagedInstanceStatus`` for more information.</p> <p>Acceptable values are 0 seconds to 3600 seconds, inclusive.</p> 
deployPolicy.<br>strategy | **string**<br><p>Affects the lifecycle of the instance during deployment.</p> <ul> <li>PROACTIVE: Instance Groups can forcefully stop a running instance. This is the default.</li> <li>OPPORTUNISTIC: Instance Groups does not stop a running instance. Instead, it will wait until the instance stops itself or becomes unhealthy.</li> </ul> 
deployPolicy.<br>minimalAction | **string**<br><p>If instance update requires a less disruptive action than ``minimalAction``, Instance Groups performs ``minimalAction`` to execute the update</p> <ul> <li>LIVE_UPDATE: Updating an instance without stopping. This is the default.</li> <li>RESTART: Updating an instance with restart: stopping and then starting the instance.</li> <li>RECREATE: Re-creating an instance: deleting an instance and creating a new one.</li> </ul> 
allocationPolicy | **object**<br><p>Allocation policy of the instance group by zones and regions.</p> 
allocationPolicy.<br>zones[] | **object**<br><p>Required. List of availability zones.</p> <p>The minimum number of elements is 1.</p> 
allocationPolicy.<br>zones[].<br>zoneId | **string**<br><p>Required. ID of the availability zone where the instance resides.</p> 
allocationPolicy.<br>zones[].<br>instanceTagsPool[] | **string**<br><p>Each instance in a zone will be associated with exactly one of a tag from a pool below. All specified tags must be unique across the whole group not only the zone. It is guaranteed that during whole deploy only tags from prefix of the specified list will be used. It is possible to use tag associated with instance in templating via {instance.tag}.</p> <p>The string length in characters for each value must be 3-50.</p> 
loadBalancerState | **object**<br><p>Status of the Network Load Balancer target group attributed to the instance group.</p> 
loadBalancerState.<br>targetGroupId | **string**<br><p>ID of the Network Load Balancer target group attributed to the instance group.</p> 
loadBalancerState.<br>statusMessage | **string**<br><p>Status message of the target group.</p> 
managedInstancesState | **object**<br><p>States of instances for this instance group.</p> 
managedInstancesState.<br>targetSize | **string** (int64)<br><p>Target number of instances for this instance group.</p> 
managedInstancesState.<br>runningActualCount | **string** (int64)<br><p>The number of running instances that match the current instance template. For more information, see ``RUNNING_ACTUAL``.</p> 
managedInstancesState.<br>runningOutdatedCount | **string** (int64)<br><p>The number of running instances that does not match the current instance template. For more information, see ``RUNNING_OUTDATED``.</p> 
managedInstancesState.<br>processingCount | **string** (int64)<br><p>The number of instances in flight (for example, updating, starting, deleting). For more information, see ``ManagedInstanceStatus``.</p> 
loadBalancerSpec | **object**<br><p>Settings for balancing load between instances via <a href="/docs/network-load-balancer/concepts">Network Load Balancer</a> (OSI model layer 3).</p> 
loadBalancerSpec.<br>targetGroupSpec | **object**<br><p>Specification of the target group that the instance group will be added to. For more information, see <a href="/docs/network-load-balancer/concepts/target-resources">Target groups and resources</a>.</p> 
loadBalancerSpec.<br>targetGroupSpec.<br>name | **string**<br><p>Name of the target group.</p> <p>Value must match the regular expression ``\|[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
loadBalancerSpec.<br>targetGroupSpec.<br>description | **string**<br><p>Description of the target group.</p> <p>The maximum string length in characters is 256.</p> 
loadBalancerSpec.<br>targetGroupSpec.<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\@0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_./\@0-9a-z]*``.</p> 
loadBalancerSpec.<br>maxOpeningTrafficDuration | **string**<br><p>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds.</p> <p>The minimum value is 1 seconds.</p> 
loadBalancerSpec.<br>ignoreHealthChecks | **boolean** (boolean)<br><p>Do not wait load balancer health checks.</p> 
healthChecksSpec | **object**<br><p>Health checking specification. For more information, see <a href="/docs/network-load-balancer/concepts/health-check">Health check</a>.</p> 
healthChecksSpec.<br>healthCheckSpecs[] | **object**<br><p>Required. Health checking specification. For more information, see <a href="/docs/network-load-balancer/concepts/health-check">Health check</a>.</p> <p>The minimum number of elements is 1.</p> 
healthChecksSpec.<br>healthCheckSpecs[].<br>interval | **string**<br><p>The interval between health checks. The default is 2 seconds.</p> <p>Acceptable values are 1 seconds to 300 seconds, inclusive.</p> 
healthChecksSpec.<br>healthCheckSpecs[].<br>timeout | **string**<br><p>Timeout for the managed instance to return a response for the health check. The default is 1 second.</p> <p>Acceptable values are 1 seconds to 60 seconds, inclusive.</p> 
healthChecksSpec.<br>healthCheckSpecs[].<br>unhealthyThreshold | **string** (int64)<br><p>The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2.</p> <p>Value must be one of 0, 2, 3, 4, 5, 6, 7, 8, 9 or 10.</p> 
healthChecksSpec.<br>healthCheckSpecs[].<br>healthyThreshold | **string** (int64)<br><p>The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2.</p> <p>Value must be one of 0, 2, 3, 4, 5, 6, 7, 8, 9 or 10.</p> 
healthChecksSpec.<br>healthCheckSpecs[].<br>tcpOptions | **object**<br>Configuration options for a TCP health check. <br>`healthChecksSpec.healthCheckSpecs[]` includes only one of the fields `tcpOptions`, `httpOptions`<br>
healthChecksSpec.<br>healthCheckSpecs[].<br>tcpOptions.<br>port | **string** (int64)<br><p>Port to use for TCP health checks.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
healthChecksSpec.<br>healthCheckSpecs[].<br>httpOptions | **object**<br>Configuration options for an HTTP health check. <br>`healthChecksSpec.healthCheckSpecs[]` includes only one of the fields `tcpOptions`, `httpOptions`<br>
healthChecksSpec.<br>healthCheckSpecs[].<br>httpOptions.<br>port | **string** (int64)<br><p>Port to use for HTTP health checks.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
healthChecksSpec.<br>healthCheckSpecs[].<br>httpOptions.<br>path | **string**<br><p>URL path to set for health checking requests.</p> 
healthChecksSpec.<br>maxCheckingHealthDuration | **string**<br><p>Timeout for waiting for the VM to become healthy. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds.</p> <p>The minimum value is 1 seconds.</p> 
serviceAccountId | **string**<br><p>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see <a href="/docs/iam/concepts/users/service-accounts">Service accounts</a>. To get the service account ID, use a <a href="/docs/iam/api-ref/ServiceAccount/list">list</a> request.</p> 
status | **string**<br><p>Status of the instance group.</p> <ul> <li> <p>STARTING: Instance group is being started and will become active soon.</p> </li> <li> <p>ACTIVE: Instance group is active. In this state the group manages its instances and monitors their health, creating, deleting, stopping, updating and starting instances as needed.</p> <p>To stop the instance group, call <a href="/docs/compute/api-ref/InstanceGroup/stop">stop</a>. To pause the processes in the instance group, i.e. scaling, checking instances' health, auto-healing and updating them, without stopping the instances, call <a href="/docs/compute/api-ref/InstanceGroup/pauseProcesses">pauseProcesses</a>.</p> </li> <li> <p>STOPPING: Instance group is being stopped. Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.</p> </li> <li> <p>STOPPED: Instance group is stopped. In this state the group cannot be updated and does not react to any changes made to its instances. To start the instance group, call <a href="/docs/compute/api-ref/InstanceGroup/start">start</a>.</p> </li> <li> <p>DELETING: Instance group is being deleted.</p> </li> <li> <p>PAUSED: Instance group is paused. In this state all the processes regarding the group management, i.e. scaling, checking instances' health, auto-healing and updating them, are paused. The instances that were running prior to pausing the group, however, may still be running.</p> <p>To resume the processes in the instance group, call <a href="/docs/compute/api-ref/InstanceGroup/resumeProcesses">resumeProcesses</a>. The group status will change to ``ACTIVE``.</p> </li> </ul> 
variables[] | **object**
variables[].<br>key | **string**<br><p>The string length in characters must be 1-128. Value must match the regular expression ``[a-zA-Z0-9._-]*``.</p> 
variables[].<br>value | **string**<br><p>The maximum string length in characters is 128.</p> 
deletionProtection | **boolean** (boolean)<br><p>Flag prohibiting deletion of the instance group.</p> <p>Allowed values:</br>- ``false``: The instance group can be deleted.</br>- ``true``: The instance group cannot be deleted.</p> <p>The default is ``false``.</p> 
applicationLoadBalancerSpec | **object**<br><p>Settings for balancing load between instances via <a href="/docs/application-load-balancer/concepts">Application Load Balancer</a> (OSI model layer 7).</p> 
applicationLoadBalancerSpec.<br>targetGroupSpec | **object**<br><p>Required. Basic properties of the Application Load Balancer target group attributed to the instance group.</p> 
applicationLoadBalancerSpec.<br>targetGroupSpec.<br>name | **string**<br><p>Name of the target group.</p> 
applicationLoadBalancerSpec.<br>targetGroupSpec.<br>description | **string**<br><p>Description of the target group.</p> 
applicationLoadBalancerSpec.<br>targetGroupSpec.<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
applicationLoadBalancerSpec.<br>maxOpeningTrafficDuration | **string**<br><p>Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded, the VM will be turned off based on the deployment policy. Specified in seconds.</p> <p>The minimum value is 1 seconds.</p> 
applicationLoadBalancerSpec.<br>ignoreHealthChecks | **boolean** (boolean)<br><p>Do not wait load balancer health checks.</p> 
applicationLoadBalancerState | **object**<br><p>Status of the Application Load Balancer target group attributed to the instance group.</p> <p>Returned if there is a working load balancer that the target group is connected to.</p> 
applicationLoadBalancerState.<br>targetGroupId | **string**<br><p>ID of the Application Load Balancer target group attributed to the instance group.</p> 
applicationLoadBalancerState.<br>statusMessage | **string**<br><p>Status message of the target group.</p> 
autoHealingPolicy | **object**<br><p>AutoHealingPolicy policy of the instance group.</p> 
autoHealingPolicy.<br>autoHealingAction | **string**<br><p>Instance Groups performs ``autoHealingAction`` when instance becomes unhealthy.</p> <ul> <li>RESTART: Re-starting an instance with restart: stopping and then starting the instance.</li> <li>RECREATE: Re-creating an instance: deleting an instance and creating a new one.</li> <li>NONE: No action</li> </ul> 