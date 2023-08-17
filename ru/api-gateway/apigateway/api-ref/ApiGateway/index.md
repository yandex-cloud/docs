---
editable: false
sourcePath: en/_api-ref/serverless/apigateway/v1/apigateway/api-ref/ApiGateway/index.md
---

# API Gateway Service, REST: ApiGateway methods
A set of methods for managing API gateways.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string",
  "domain": "string",
  "logGroupId": "string",
  "attachedDomains": [
    {
      "domainId": "string",
      "certificateId": "string",
      "enabled": true,
      "domain": "string"
    }
  ],
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

  }
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the API gateway. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the API gateway belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp for the API-gateway.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the API gateway. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the API gateway.</p> 
labels | **object**<br><p>API gateway labels as ``key:value`` pairs.</p> 
status | **string**<br><p>Status of the API gateway.</p> <ul> <li>CREATING: API gateway is being created.</li> <li>ACTIVE: API gateway is ready for use.</li> <li>DELETING: API gateway is being deleted.</li> <li>ERROR: API gateway failed. The only allowed action is delete.</li> <li>UPDATING: API gateway is being updated.</li> </ul> 
domain | **string**<br><p>Default domain for the API gateway. Generated at creation time.</p> 
logGroupId | **string**<br><p>ID of the log group for the API gateway.</p> 
attachedDomains[] | **object**<br><p>List of domains attached to API gateway.</p> 
attachedDomains[].<br>domainId | **string**<br><p>ID of the domain.</p> 
attachedDomains[].<br>certificateId | **string**<br><p>ID of the domain certificate.</p> 
attachedDomains[].<br>enabled | **boolean** (boolean)<br><p>Enabling flag.</p> 
attachedDomains[].<br>domain | **string**<br><p>Name of the domain.</p> 
connectivity | **object**<br><p>Network access. If specified the gateway will be attached to specified network/subnet(s).</p> <p>Gateway connectivity specification.</p> 
connectivity.<br>networkId | **string**<br><p>Network the gateway will have access to. It's essential to specify network with subnets in all availability zones.</p> 
connectivity.<br>subnetId[] | **string**<br><p>Complete list of subnets (from the same network) the gateway can be attached to. It's essential to specify at least one subnet for each availability zones.</p> 
logOptions | **object**<br><p>Options for logging from the API gateway.</p> 
logOptions.<br>disabled | **boolean** (boolean)<br><p>Is logging from API gateway disabled.</p> 
logOptions.<br>minLevel | **string**<br>Minimum log entry level.  See [LogLevel.Level] for details.<br><ul> <li> <p>TRACE: Trace log level.</p> <p>Possible use case: verbose logging of some business logic.</p> </li> <li> <p>DEBUG: Debug log level.</p> <p>Possible use case: debugging special cases in application logic.</p> </li> <li> <p>INFO: Info log level.</p> <p>Mostly used for information messages.</p> </li> <li> <p>WARN: Warn log level.</p> <p>May be used to alert about significant events.</p> </li> <li> <p>ERROR: Error log level.</p> <p>May be used to alert about errors in infrastructure, logic, etc.</p> </li> <li> <p>FATAL: Fatal log level.</p> <p>May be used to alert about unrecoverable failures and events.</p> </li> </ul> 
logOptions.<br>logGroupId | **string** <br>`logOptions` includes only one of the fields `logGroupId`, `folderId`<br><br><p>Entry should be written to log group resolved by ID.</p> 
logOptions.<br>folderId | **string** <br>`logOptions` includes only one of the fields `logGroupId`, `folderId`<br><br><p>Entry should be written to default log group for specified folder.</p> 

## Methods {#methods}
Method | Description
--- | ---
[addDomain](addDomain.md) | Attaches domain to the specified API gateway.
[create](create.md) | Creates an API gateway in the specified folder.
[delete](delete.md) | Deletes the specified API gateway.
[get](get.md) | Returns the specified API gateway. Note that only API gateway basic attributes are returned. To get associated openapi specification, make a [GetOpenapiSpec](#GetOpenapiSpec) request.
[getOpenapiSpec](getOpenapiSpec.md) | Returns the OpenAPI specification of specified API gateway.
[list](list.md) | Retrieves the list of API gateways in the specified folder.
[listAccessBindings](listAccessBindings.md) | Lists existing access bindings for the specified API gateway.
[listOperations](listOperations.md) | Lists operations for the specified API gateway.
[removeDomain](removeDomain.md) | Detaches domain from the specified API gateway.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the specified API gateway.
[update](update.md) | Updates the specified API gateway.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified API gateway.