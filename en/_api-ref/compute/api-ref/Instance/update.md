---
editable: false
---

# Method update
Updates the specified instance.
 

 
## HTTP request {#https-request}
```
PATCH https://compute.api.cloud.yandex.net/compute/v1/instances/{instanceId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
instanceId | Required. ID of the Instance resource to update. To get the instance ID, use a [list](/docs/compute/api-ref/Instance/list) request.  The maximum string length in characters is 50.
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "name": "string",
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
  "serviceAccountId": "string",
  "networkSettings": {
    "type": "string"
  },
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
  }
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>Field mask that specifies which fields of the Instance resource are going to be updated.</p> <p>A comma-separated names off ALL fields to be updated. Оnly the specified fields will be changed. The others will be left untouched. If the field is specified in `` updateMask `` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If `` updateMask `` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
name | **string**<br><p>Name of the instance.</p> <p>Value must match the regular expression `` \|<a href="%5B-a-z0-9%5D%7B0,61%7D%5Ba-z0-9%5D">a-z</a>? ``.</p> 
description | **string**<br><p>Description of the instance.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Resource labels as `key:value` pairs.</p> <p>Existing set of `labels` is completely replaced by the provided set.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression `` [a-z][-<em>./@0-9a-z]* ``. The maximum string length in characters for each value is 63. Each value must match the regular expression `` [-</em>./@0-9a-z]* ``.</p> 
platformId | **string**<br><p>ID of the hardware platform configuration for the instance. This field affects the available values in <a href="/docs/compute/api-ref/Instance/update#body_params">resourcesSpec</a> field.</p> <p>Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see <a href="/docs/compute/concepts/vm-platforms">Platforms</a>.</p> 
resourcesSpec | **object**<br><p>Computing resources of the instance, such as the amount of memory and number of cores. To get a list of available values, see <a href="/docs/compute/concepts/performance-levels">Levels of core performance</a>.</p> 
resourcesSpec.<br>memory | **string** (int64)<br><p>Required. The amount of memory available to the instance, specified in bytes.</p> <p>The maximum value is 274877906944.</p> 
resourcesSpec.<br>cores | **string** (int64)<br><p>Required. The number of cores available to the instance.</p> <p>Value must be one of 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76 or 80.</p> 
resourcesSpec.<br>coreFraction | **string** (int64)<br><p>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core.</p> <p>For example, if you need only 5% of the CPU performance, you can set core_fraction=5. For more information, see <a href="/docs/compute/concepts/performance-levels">Levels of core performance</a>.</p> <p>Value must be one of 0, 5, 20, 50 or 100.</p> 
resourcesSpec.<br>gpus | **string** (int64)<br><p>The number of GPUs available to the instance.</p> <p>Value must be one of 0, 1, 2 or 4.</p> 
metadata | **object**<br><p>The metadata `key:value` pairs that will be assigned to this instance. This includes custom metadata and predefined keys. The total size of all keys and values must be less than 512 KB.</p> <p>Existing set of `metadata` is completely replaced by the provided set.</p> <p>Values are free-form strings, and only have meaning as interpreted by the programs which configure the instance. The values must be 256 KB or less.</p> <p>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see <a href="/docs/compute/concepts/vm-metadata">Metadata</a>.</p> 
serviceAccountId | **string**<br><p>ID of the service account to use for <a href="/docs/compute/operations/vm-connect/auth-inside-vm">authentication inside the instance</a>. To get the service account ID, use a <a href="/docs/iam/api-ref/ServiceAccount/list">list</a> request.</p> 
networkSettings | **object**<br><p>Network settings.</p> 
networkSettings.<br>type | **string**<br><p>Network Type</p> <ul> <li>STANDARD: Standard network.</li> <li>SOFTWARE_ACCELERATED: Software accelerated network.</li> <li>HARDWARE_ACCELERATED: Hardware accelerated network (not available yet, reserved for future use).</li> </ul> 
placementPolicy | **object**<br><p>Placement policy configuration.</p> 
placementPolicy.<br>placementGroupId | **string**<br><p>Placement group ID.</p> 
placementPolicy.<br>hostAffinityRules[] | **object**<br><p>Affinitity definition</p> 
placementPolicy.<br>hostAffinityRules[].<br>key | **string**<br><p>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId'</p> 
placementPolicy.<br>hostAffinityRules[].<br>op | **string**<br><p>Include or exclude action</p> 
placementPolicy.<br>hostAffinityRules[].<br>values[] | **string**<br><p>Affinity value or host ID or host group ID</p> 
 
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