---
editable: false
sourcePath: en/_api-ref/serverless/apigateway/v1/apigateway/api-ref/ApiGateway/update.md
---

# API Gateway Service, REST: ApiGateway.update
Updates the specified API gateway.
 

 
## HTTP request {#https-request}
```
PATCH https://serverless-apigateway.{{ api-host }}/apigateways/v1/apigateways/{apiGatewayId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
apiGatewayId | <p>Required. ID of the API gateway to update.</p> <p>To get a API gateway ID make a <a href="/docs/functions/api-gateway/api-ref/ApiGateway/list">list</a> request.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "connectivity": {
    "networkId": "string",
    "subnetId": [
      "string"
    ]
  },
  "logOptions": {
    "disabled": true,
    "minLevel": "string",

    // `logOptions` includes only one of the fields `logGroupId`, `folderId`
    "logGroupId": "string",
    "folderId": "string",
    // end of the list of possible fields`logOptions`

  },
  "variables": "object",
  "canary": {
    "weight": "string",
    "variables": "object"
  },
  "executionTimeout": "string",
  "openapiSpec": "string"
}
```

 
Field | Description
--- | ---
updateMask | **string**<br>Field mask that specifies which attributes of the API gateway should be updated.
name | **string**<br><p>New name for the API gateway. The name must be unique within the folder.</p> <p>Value must match the regular expression ``\|[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
description | **string**<br><p>New description for the API gateway.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>API gateway labels as ``key:value`` pairs.</p> <p>Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label, request the current set of labels with a <a href="/docs/functions/api-gateway/api-ref/ApiGateway/get">get</a> request.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\@0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_./\@0-9a-z]*``.</p> 
connectivity | **object**<br>Gateway connectivity. If specified the gateway will be attached to specified network/subnet(s).
connectivity.<br>networkId | **string**<br><p>Network the gateway will have access to. It's essential to specify network with subnets in all availability zones.</p> 
connectivity.<br>subnetId[] | **string**<br><p>Complete list of subnets (from the same network) the gateway can be attached to. It's essential to specify at least one subnet for each availability zones.</p> 
logOptions | **object**<br>Options for logging from the API gateway.
logOptions.<br>disabled | **boolean** (boolean)<br><p>Is logging from API gateway disabled.</p> 
logOptions.<br>minLevel | **string**<br>Minimum log entry level.  See [LogLevel.Level] for details.<br><ul> <li> <p>TRACE: Trace log level.</p> <p>Possible use case: verbose logging of some business logic.</p> </li> <li> <p>DEBUG: Debug log level.</p> <p>Possible use case: debugging special cases in application logic.</p> </li> <li> <p>INFO: Info log level.</p> <p>Mostly used for information messages.</p> </li> <li> <p>WARN: Warn log level.</p> <p>May be used to alert about significant events.</p> </li> <li> <p>ERROR: Error log level.</p> <p>May be used to alert about errors in infrastructure, logic, etc.</p> </li> <li> <p>FATAL: Fatal log level.</p> <p>May be used to alert about unrecoverable failures and events.</p> </li> </ul> 
logOptions.<br>logGroupId | **string** <br>`logOptions` includes only one of the fields `logGroupId`, `folderId`<br><br><p>Entry should be written to log group resolved by ID.</p> 
logOptions.<br>folderId | **string** <br>`logOptions` includes only one of the fields `logGroupId`, `folderId`<br><br><p>Entry should be written to default log group for specified folder.</p> 
variables | **object**<br><p>Values of variables defined in the specification.</p> 
canary | **object**<br>Canary release of the gateway.
canary.<br>weight | **string** (int64)<br><p>It describes percentage of requests, which will be processed by canary.</p> <p>Acceptable values are 0 to 99, inclusive.</p> 
canary.<br>variables | **object**<br><p>Required. Values specification variables, associated with canary.</p> <p>At least one per resource.</p> 
executionTimeout | **string**<br><p>Timeout for gateway call execution</p> <p>The maximum value is 600 seconds.</p> 
openapiSpec | **string**<br><p>The text of specification, JSON or YAML.</p> 
 
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