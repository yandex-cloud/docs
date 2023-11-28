---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/Instance/relocate.md
---

# Compute Cloud API, REST: Instance.relocate
Moves the specified instance to another availability zone
 
Running instance will be restarted during this operation.
 
## HTTP request {#https-request}
```
POST https://compute.{{ api-host }}/compute/v1/instances/{instanceId}:relocate
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
instanceId | <p>Required. ID of the instance to move.</p> <p>To get the instance ID, make a <a href="/docs/compute/api-ref/Instance/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "destinationZoneId": "string",
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
  "bootDiskPlacement": {
    "placementGroupId": "string",
    "placementGroupPartition": "string"
  },
  "secondaryDiskPlacements": [
    {
      "diskId": "string",
      "diskPlacementPolicy": {
        "placementGroupId": "string",
        "placementGroupPartition": "string"
      }
    }
  ]
}
```

 
Field | Description
--- | ---
destinationZoneId | **string**<br><p>Required. ID of the availability zone to move the instance to.</p> <p>To get the zone ID, make a <a href="/docs/compute/api-ref/Zone/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
networkInterfaceSpecs[] | **object**<br><p>Required. Network configuration for the instance. Specifies how the network interface is configured to interact with other services on the internal network and on the internet. Currently only one network interface is supported per instance.</p> <p>Must contain exactly 1 element.</p> 
networkInterfaceSpecs[].<br>subnetId | **string**<br><p>Required. ID of the subnet.</p> <p>The maximum string length in characters is 50.</p> 
networkInterfaceSpecs[].<br>primaryV4AddressSpec | **object**<br><p>Primary IPv4 address that will be assigned to the instance for this network interface.</p> 
networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>address | **string**<br><p>An IPv4 internal network address that is assigned to the instance for this network interface. If not specified by the user, an unused internal IP is assigned by the system.</p> 
networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec | **object**<br><p>An external IP address configuration. If not specified, then this instance will have no external internet access.</p> 
networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>External IP address version.</p> <ul> <li>IPV4: IPv4 address, for example 192.0.2.235.</li> <li>IPV6: IPv6 address. Not available yet.</li> </ul> 
networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>address | **string**
networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[] | **object**<br><p>External DNS configuration</p> 
networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>fqdn | **string**<br><p>Required. FQDN (required)</p> 
networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, private zone used)</p> 
networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>ttl | **string** (int64)<br><p>DNS record ttl, values in 0-86400 (optional)</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>ptr | **boolean** (boolean)<br><p>When set to true, also create PTR DNS record (optional)</p> 
networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[] | **object**<br><p>Internal DNS configuration</p> 
networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>fqdn | **string**<br><p>Required. FQDN (required)</p> 
networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, private zone used)</p> 
networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>ttl | **string** (int64)<br><p>DNS record ttl, values in 0-86400 (optional)</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>ptr | **boolean** (boolean)<br><p>When set to true, also create PTR DNS record (optional)</p> 
networkInterfaceSpecs[].<br>primaryV6AddressSpec | **object**<br><p>Primary IPv6 address that will be assigned to the instance for this network interface. IPv6 not available yet.</p> 
networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>address | **string**<br><p>An IPv4 internal network address that is assigned to the instance for this network interface. If not specified by the user, an unused internal IP is assigned by the system.</p> 
networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec | **object**<br><p>An external IP address configuration. If not specified, then this instance will have no external internet access.</p> 
networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>External IP address version.</p> <ul> <li>IPV4: IPv4 address, for example 192.0.2.235.</li> <li>IPV6: IPv6 address. Not available yet.</li> </ul> 
networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>address | **string**
networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[] | **object**<br><p>External DNS configuration</p> 
networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>fqdn | **string**<br><p>Required. FQDN (required)</p> 
networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, private zone used)</p> 
networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>ttl | **string** (int64)<br><p>DNS record ttl, values in 0-86400 (optional)</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>ptr | **boolean** (boolean)<br><p>When set to true, also create PTR DNS record (optional)</p> 
networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[] | **object**<br><p>Internal DNS configuration</p> 
networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[].<br>fqdn | **string**<br><p>Required. FQDN (required)</p> 
networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, private zone used)</p> 
networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[].<br>ttl | **string** (int64)<br><p>DNS record ttl, values in 0-86400 (optional)</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[].<br>ptr | **boolean** (boolean)<br><p>When set to true, also create PTR DNS record (optional)</p> 
networkInterfaceSpecs[].<br>securityGroupIds[] | **string**<br><p>ID's of security groups attached to the interface</p> 
bootDiskPlacement | **object**<br><p>Boot disk placement policy configuration in target zone. Must be specified if disk has placement policy.</p> 
bootDiskPlacement.<br>placementGroupId | **string**<br><p>Placement group ID.</p> 
bootDiskPlacement.<br>placementGroupPartition | **string** (int64)
secondaryDiskPlacements[] | **object**<br><p>Secondary disk placement policy configurations in target zone. Must be specified for each disk that has placement policy.</p> 
secondaryDiskPlacements[].<br>diskId | **string**<br><p>Disk ID.</p> 
secondaryDiskPlacements[].<br>diskPlacementPolicy | **object**<br><p>Placement policy configuration for given disk.</p> 
secondaryDiskPlacements[].<br>diskPlacementPolicy.<br>placementGroupId | **string**<br><p>Placement group ID.</p> 
secondaryDiskPlacements[].<br>diskPlacementPolicy.<br>placementGroupPartition | **string** (int64)
 
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