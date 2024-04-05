---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/Instance/attachNetworkInterface.md
---

# Compute Cloud API, REST: Instance.attachNetworkInterface
Attaches the network-interface to the instance.
 
To attach a network-interface, the instance must have a `STOPPED` status ([Instance.status](/docs/compute/api-ref/Instance#representation)).
To check the instance status, make a [get](/docs/compute/api-ref/Instance/get) request.
To stop the running instance, make a [stop](/docs/compute/api-ref/Instance/stop) request.
 
## HTTP request {#https-request}
```
POST https://compute.{{ api-host }}/compute/v1/instances/{instanceId}:attachNetworkInterface
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
instanceId | <p>Required. ID of the instance that in which network interface is being attached to.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "networkInterfaceIndex": "string",
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
  "securityGroupIds": [
    "string"
  ]
}
```

 
Field | Description
--- | ---
networkInterfaceIndex | **string**<br><p>Required. The index of the network interface</p> 
subnetId | **string**<br><p>Required. ID of the subnet.</p> 
primaryV4AddressSpec | **object**<br><p>Primary IPv4 address that will be assigned to the instance for this network interface.</p> 
primaryV4AddressSpec.<br>address | **string**<br><p>An IPv4 internal network address that is assigned to the instance for this network interface. If not specified by the user, an unused internal IP is assigned by the system.</p> 
primaryV4AddressSpec.<br>oneToOneNatSpec | **object**<br><p>An external IP address configuration. If not specified, then this instance will have no external internet access.</p> 
primaryV4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>External IP address version.</p> <ul> <li>IPV4: IPv4 address, for example 192.0.2.235.</li> <li>IPV6: IPv6 address. Not available yet.</li> </ul> 
primaryV4AddressSpec.<br>oneToOneNatSpec.<br>address | **string**
primaryV4AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[] | **object**<br><p>External DNS configuration</p> 
primaryV4AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>fqdn | **string**<br><p>Required. FQDN (required)</p> 
primaryV4AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, private zone used)</p> 
primaryV4AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>ttl | **string** (int64)<br><p>DNS record ttl, values in 0-86400 (optional)</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
primaryV4AddressSpec.<br>oneToOneNatSpec.<br>dnsRecordSpecs[].<br>ptr | **boolean** (boolean)<br><p>When set to true, also create PTR DNS record (optional)</p> 
primaryV4AddressSpec.<br>dnsRecordSpecs[] | **object**<br><p>Internal DNS configuration</p> 
primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>fqdn | **string**<br><p>Required. FQDN (required)</p> 
primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, private zone used)</p> 
primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>ttl | **string** (int64)<br><p>DNS record ttl, values in 0-86400 (optional)</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>ptr | **boolean** (boolean)<br><p>When set to true, also create PTR DNS record (optional)</p> 
securityGroupIds[] | **string**<br><p>Required. ID's of security groups attached to the interface.</p> 
 
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