---
editable: false
sourcePath: en/_api-ref/iot/broker/v1/broker/api-ref/Broker/get.md
---

# IoT Core Broker Service, REST: Broker.get
Returns the specified broker.
 
To get the list of available brokers, make a [list](/docs/iot-core/broker/api-ref/Broker/list) request.
 
## HTTP request {#https-request}
```
GET https://{{ api-host-iot-broker }}/iot-broker/v1/brokers/{brokerId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
brokerId | <p>Required. ID of the broker to return.</p> <p>To get a broker ID make a <a href="/docs/iot-core/broker/api-ref/Broker/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
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
  "status": "string"
}
```
A broker.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the broker.</p> 
folderId | **string**<br><p>ID of the folder that the broker belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the broker. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the broker. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
status | **string**<br><p>Status of the broker.</p> <ul> <li>CREATING: Broker is being created.</li> <li>ACTIVE: Broker is ready to use.</li> <li>DELETING: Broker is being deleted.</li> </ul> 