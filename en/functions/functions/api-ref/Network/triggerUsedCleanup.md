---
editable: false
sourcePath: en/_api-ref/serverless/functions/v1/functions/api-ref/Network/triggerUsedCleanup.md
---

# Cloud Functions Service, REST: Network.triggerUsedCleanup
Forces obsolete used network to start cleanup process as soon as possible.
Invocation does not wait for start or end of the cleanup process.
Second invocation with the same network does nothing until network is completely cleaned-up.
 

 
## HTTP request {#https-request}
```
POST https://serverless-functions.{{ api-host }}/functions/v1/networks/used/{networkId}:triggerCleanup
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
networkId | <p>Required. ID of the obsolete network to start the cleanup process for.</p> 
 
## Body parameters {#body_params}
 
Empty
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "networkCleanupTime": "string"
}
```

 
Field | Description
--- | ---
networkCleanupTime | **string** (date-time)<br><p>Timestamp when cleanup of the specified network will be started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 