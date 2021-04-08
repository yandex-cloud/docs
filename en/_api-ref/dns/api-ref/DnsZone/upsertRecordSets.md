---
editable: false
---

# Method upsertRecordSets
Method without strict control for changing zone state. Nothing happens if deleted record doesn't exist.
Deletes records that match all specified fields which allows to delete only specified records from a record set.
 

 
## HTTP request {#https-request}
```
POST https://dns.api.cloud.yandex.net/dns/v1/zones/{dnsZoneId}:upsertRecordSets
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
dnsZoneId | ID of the DNS zone to upsert record sets to.   To get a DNS zone ID, make a [list](/docs/dns/api-ref/DnsZone/list) request.  The string length in characters must be equal to 20.
 
## Body parameters {#body_params}
 
```json 
{
  "deletions": [
    {
      "name": "string",
      "type": "string",
      "ttl": "string",
      "data": [
        "string"
      ]
    }
  ],
  "replacements": [
    {
      "name": "string",
      "type": "string",
      "ttl": "string",
      "data": [
        "string"
      ]
    }
  ],
  "merges": [
    {
      "name": "string",
      "type": "string",
      "ttl": "string",
      "data": [
        "string"
      ]
    }
  ]
}
```

 
Field | Description
--- | ---
deletions[] | **object**<br><p>A record set. For details about the concept, see <a href="/docs/dns/concepts/resource-record">Resource record</a>.</p> 
deletions[].<br>name | **string**<br><p>Domain name.</p> <p>The string length in characters must be 1-254.</p> 
deletions[].<br>type | **string**<br><p>Record type.</p> <p>The string length in characters must be 1-20.</p> 
deletions[].<br>ttl | **string** (int64)<br><p>Time to live in seconds.</p> <p>Acceptable values are 0 to 2147483647, inclusive.</p> 
deletions[].<br>data[] | **string**<br><p>Required. Data of the record set.</p> <p>The number of elements must be in the range 1-100. The string length in characters for each value must be 1-255.</p> 
replacements[] | **object**<br><p>A record set. For details about the concept, see <a href="/docs/dns/concepts/resource-record">Resource record</a>.</p> 
replacements[].<br>name | **string**<br><p>Domain name.</p> <p>The string length in characters must be 1-254.</p> 
replacements[].<br>type | **string**<br><p>Record type.</p> <p>The string length in characters must be 1-20.</p> 
replacements[].<br>ttl | **string** (int64)<br><p>Time to live in seconds.</p> <p>Acceptable values are 0 to 2147483647, inclusive.</p> 
replacements[].<br>data[] | **string**<br><p>Required. Data of the record set.</p> <p>The number of elements must be in the range 1-100. The string length in characters for each value must be 1-255.</p> 
merges[] | **object**<br><p>A record set. For details about the concept, see <a href="/docs/dns/concepts/resource-record">Resource record</a>.</p> 
merges[].<br>name | **string**<br><p>Domain name.</p> <p>The string length in characters must be 1-254.</p> 
merges[].<br>type | **string**<br><p>Record type.</p> <p>The string length in characters must be 1-20.</p> 
merges[].<br>ttl | **string** (int64)<br><p>Time to live in seconds.</p> <p>Acceptable values are 0 to 2147483647, inclusive.</p> 
merges[].<br>data[] | **string**<br><p>Required. Data of the record set.</p> <p>The number of elements must be in the range 1-100. The string length in characters for each value must be 1-255.</p> 
 
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 