---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/Instance/addOneToOneNat.md
---

# Compute Cloud API, REST: Instance.addOneToOneNat
Enables One-to-one NAT on the network interface.
 

 
## HTTP request {#https-request}
```
POST https://compute.{{ api-host }}/compute/v1/instances/{instanceId}/addOneToOneNat
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
instanceId | <p>ID of the instance to enable One-to-One NAT on.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "networkInterfaceIndex": "string",
  "internalAddress": "string",
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
  }
}
```
Enables One-to-one NAT on the network interface.
 
Field | Description
--- | ---
networkInterfaceIndex | **string**<br><p>The index of the network interface to enable One-to-One NAT on.</p> 
internalAddress | **string**<br><p>The network address that is assigned to the instance for this network interface.</p> 
oneToOneNatSpec | **object**<br><p>An external IP address configuration. If not specified, then this instance will have no external internet access.</p> 
oneToOneNatSpec.<br>ipVersion | **string**<br><p>External IP address version.</p> <ul> <li>IPV4: IPv4 address, for example 192.0.2.235.</li> <li>IPV6: IPv6 address. Not available yet.</li> </ul> 
oneToOneNatSpec.<br>address | **string**
oneToOneNatSpec.<br>dnsRecordSpecs[] | **object**<br><p>External DNS configuration</p> 
oneToOneNatSpec.<br>dnsRecordSpecs[].<br>fqdn | **string**<br><p>Required. FQDN (required)</p> 
oneToOneNatSpec.<br>dnsRecordSpecs[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, private zone used)</p> 
oneToOneNatSpec.<br>dnsRecordSpecs[].<br>ttl | **string** (int64)<br><p>DNS record ttl, values in 0-86400 (optional)</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
oneToOneNatSpec.<br>dnsRecordSpecs[].<br>ptr | **boolean** (boolean)<br><p>When set to true, also create PTR DNS record (optional)</p> 
 
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