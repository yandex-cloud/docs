---
editable: false
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/Agent/create.md
---

# Load Testing API, REST: Agent.create
Creates an agent in the specified folder.
 
Also creates a corresponding compute instance.
 
## HTTP request {#https-request}
```
POST https://loadtesting.{{ api-host }}/loadtesting/api/v1/agent
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "computeInstanceParams": {
    "labels": "object",
    "zoneId": "string",
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
      "autoDelete": true,

      // `computeInstanceParams.bootDiskSpec` includes only one of the fields `diskSpec`, `diskId`
      "diskSpec": {
        "name": "string",
        "description": "string",
        "typeId": "string",
        "size": "string",
        "blockSize": "string",
        "diskPlacementPolicy": {
          "placementGroupId": "string",
          "placementGroupPartition": "string"
        },

        // `computeInstanceParams.bootDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`
        "imageId": "string",
        "snapshotId": "string",
        // end of the list of possible fields`computeInstanceParams.bootDiskSpec.diskSpec`

      },
      "diskId": "string",
      // end of the list of possible fields`computeInstanceParams.bootDiskSpec`

    },
    "networkInterfaceSpecs": [
      {
        "subnetId": "string",
        "primaryV4AddressSpec": {
          "address": "string",
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
          ]
        },
        "primaryV6AddressSpec": {
          "address": "string",
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
          ]
        },
        "securityGroupIds": [
          "string"
        ]
      }
    ],
    "serviceAccountId": "string",
    "platformId": "string"
  },
  "agentVersion": "string",
  "labels": "object"
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create an agent in.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Name of the agent.</p> <p>A created compute instance will have the same name.</p> <p>Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
description | **string**<br><p>Description of the agent.</p> <p>A created compute instance will have the same description.</p> <p>The maximum string length in characters is 256.</p> 
computeInstanceParams | **object**<br><p>Parameters for compute instance to be created.</p> 
computeInstanceParams.<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\@0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_./\@0-9a-z]*``.</p> 
computeInstanceParams.<br>zoneId | **string**<br><p>Required. ID of the availability zone where the instance resides. To get a list of available zones, use the <a href="/docs/compute/api-ref/Zone/list">list</a> request</p> <p>The maximum string length in characters is 50.</p> 
computeInstanceParams.<br>resourcesSpec | **object**<br><p>Required. Computing resources of the instance, such as the amount of memory and number of cores. To get a list of available values, see <a href="/docs/compute/concepts/performance-levels">Levels of core performance</a>.</p> 
computeInstanceParams.<br>resourcesSpec.<br>memory | **string** (int64)<br><p>Required. The amount of memory available to the instance, specified in bytes.</p> <p>The maximum value is 274877906944.</p> 
computeInstanceParams.<br>resourcesSpec.<br>cores | **string** (int64)<br><p>Required. The number of cores available to the instance.</p> <p>Value must be one of 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76 or 80.</p> 
computeInstanceParams.<br>resourcesSpec.<br>coreFraction | **string** (int64)<br><p>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core.</p> <p>For example, if you need only 5% of the CPU performance, you can set core_fraction=5. For more information, see <a href="/docs/compute/concepts/performance-levels">Levels of core performance</a>.</p> <p>Value must be one of 0, 5, 20, 50 or 100.</p> 
computeInstanceParams.<br>resourcesSpec.<br>gpus | **string** (int64)<br><p>The number of GPUs available to the instance.</p> <p>Value must be one of 0, 1, 2 or 4.</p> 
computeInstanceParams.<br>metadata | **object**<br><p>The metadata ``key:value`` pairs that will be assigned to this instance. This includes custom metadata and predefined keys. The total size of all keys and values must be less than 512 KB.</p> <p>Values are free-form strings, and only have meaning as interpreted by the programs which configure the instance. The values must be 256 KB or less.</p> <p>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see <a href="/docs/compute/concepts/vm-metadata">Metadata</a>.</p> 
computeInstanceParams.<br>bootDiskSpec | **object**<br><p>Required. Boot disk to attach to the instance.</p> 
computeInstanceParams.<br>bootDiskSpec.<br>mode | **string**<br>The mode in which to attach this disk.<br><ul> <li>READ_ONLY: Read-only access.</li> <li>READ_WRITE: Read/Write access. Default value.</li> </ul> 
computeInstanceParams.<br>bootDiskSpec.<br>deviceName | **string**<br><p>Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance.</p> <p>This value can be used to reference the device for mounting, resizing, and so on, from within the instance. If not specified, a random value will be generated.</p> <p>Value must match the regular expression ``[a-z][a-z0-9-_]{,19}``.</p> 
computeInstanceParams.<br>bootDiskSpec.<br>autoDelete | **boolean** (boolean)<br><p>Specifies whether the disk will be auto-deleted when the instance is deleted.</p> 
computeInstanceParams.<br>bootDiskSpec.<br>diskSpec | **object**<br>Disk specification. <br>`computeInstanceParams.bootDiskSpec` includes only one of the fields `diskSpec`, `diskId`<br>
computeInstanceParams.<br>bootDiskSpec.<br>diskSpec.<br>name | **string**<br><p>Name of the disk.</p> <p>Value must match the regular expression ``\|[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
computeInstanceParams.<br>bootDiskSpec.<br>diskSpec.<br>description | **string**<br><p>Description of the disk.</p> <p>The maximum string length in characters is 256.</p> 
computeInstanceParams.<br>bootDiskSpec.<br>diskSpec.<br>typeId | **string**<br><p>ID of the disk type. To get a list of available disk types, use the <a href="/docs/compute/api-ref/DiskType/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
computeInstanceParams.<br>bootDiskSpec.<br>diskSpec.<br>size | **string** (int64)<br><p>Required. Size of the disk, specified in bytes.</p> <p>Acceptable values are 4194304 to 4398046511104, inclusive.</p> 
computeInstanceParams.<br>bootDiskSpec.<br>diskSpec.<br>blockSize | **string** (int64)<br><p>Block size of the disk, specified in bytes. The default is 4096.</p> 
computeInstanceParams.<br>bootDiskSpec.<br>diskSpec.<br>diskPlacementPolicy | **object**<br>Placement policy configuration.
computeInstanceParams.<br>bootDiskSpec.<br>diskSpec.<br>diskPlacementPolicy.<br>placementGroupId | **string**<br><p>Placement group ID.</p> 
computeInstanceParams.<br>bootDiskSpec.<br>diskSpec.<br>diskPlacementPolicy.<br>placementGroupPartition | **string** (int64)
computeInstanceParams.<br>bootDiskSpec.<br>diskSpec.<br>imageId | **string** <br>`computeInstanceParams.bootDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`<br><br><p>ID of the image to create the disk from.</p> <p>The maximum string length in characters is 50.</p> 
computeInstanceParams.<br>bootDiskSpec.<br>diskSpec.<br>snapshotId | **string** <br>`computeInstanceParams.bootDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`<br><br><p>ID of the snapshot to restore the disk from.</p> <p>The maximum string length in characters is 50.</p> 
computeInstanceParams.<br>bootDiskSpec.<br>diskId | **string** <br>`computeInstanceParams.bootDiskSpec` includes only one of the fields `diskSpec`, `diskId`<br><br><p>ID of the disk that should be attached.</p> <p>The maximum string length in characters is 50.</p> 
computeInstanceParams.<br>networkInterfaceSpecs[] | **object**<br><p>Required. Network configuration for the instance. Specifies how the network interface is configured to interact with other services on the internal network and on the internet. Currently only one network interface is supported per instance.</p> <p>Must contain exactly 1 element.</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>subnetId | **string**<br><p>Required. ID of the subnet.</p> <p>The maximum string length in characters is 50.</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec | **object**<br><p>Primary IPv4 address that will be assigned to the instance for this network interface.</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>address | **string**<br><p>An IPv4 internal network address that is assigned to the instance for this network interface. If not specified by the user, an unused internal IP is assigned by the system.</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec | **object**<br><p>An external IP address configuration. If not specified, then this instance will have no external internet access.</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>External IP address version.</p> <ul> <li>IPV4: IPv4 address, for example 192.0.2.235.</li> <li>IPV6: IPv6 address. Not available yet.</li> </ul> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>address | **string**
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[] | **object**<br><p>External DNS configuration</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>fqdn | **string**<br><p>Required. FQDN (required)</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, private zone used)</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>ttl | **string** (int64)<br><p>DNS record ttl, values in 0-86400 (optional)</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>ptr | **boolean** (boolean)<br><p>When set to true, also create PTR DNS record (optional)</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[] | **object**<br><p>Internal DNS configuration</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>fqdn | **string**<br><p>Required. FQDN (required)</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, private zone used)</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>ttl | **string** (int64)<br><p>DNS record ttl, values in 0-86400 (optional)</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>ptr | **boolean** (boolean)<br><p>When set to true, also create PTR DNS record (optional)</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec | **object**<br><p>Primary IPv6 address that will be assigned to the instance for this network interface. IPv6 not available yet.</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>address | **string**<br><p>An IPv4 internal network address that is assigned to the instance for this network interface. If not specified by the user, an unused internal IP is assigned by the system.</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec | **object**<br><p>An external IP address configuration. If not specified, then this instance will have no external internet access.</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>External IP address version.</p> <ul> <li>IPV4: IPv4 address, for example 192.0.2.235.</li> <li>IPV6: IPv6 address. Not available yet.</li> </ul> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>address | **string**
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[] | **object**<br><p>External DNS configuration</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>fqdn | **string**<br><p>Required. FQDN (required)</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, private zone used)</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>ttl | **string** (int64)<br><p>DNS record ttl, values in 0-86400 (optional)</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>ptr | **boolean** (boolean)<br><p>When set to true, also create PTR DNS record (optional)</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[] | **object**<br><p>Internal DNS configuration</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[].<br>fqdn | **string**<br><p>Required. FQDN (required)</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, private zone used)</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[].<br>ttl | **string** (int64)<br><p>DNS record ttl, values in 0-86400 (optional)</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[].<br>ptr | **boolean** (boolean)<br><p>When set to true, also create PTR DNS record (optional)</p> 
computeInstanceParams.<br>networkInterfaceSpecs[].<br>securityGroupIds[] | **string**<br><p>ID's of security groups attached to the interface</p> 
computeInstanceParams.<br>serviceAccountId | **string**<br><p>ID of the service account to use for <a href="/docs/compute/operations/vm-connect/auth-inside-vm">authentication inside the instance</a>. To get the service account ID, use a <a href="/docs/iam/api-ref/ServiceAccount/list">list</a> request.</p> 
computeInstanceParams.<br>platformId | **string**<br><p>ID of the <a href="docs/compute/concepts/vm-platforms">Compute VM platform</a> on which the agent will be created. Default value: "standard-v2"</p> 
agentVersion | **string**<br><p>Version of the agent.</p> <p>If not provided, the most recent agent version will be used.</p> 
labels | **object**<br><p>Agent labels as ``key:value`` pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 