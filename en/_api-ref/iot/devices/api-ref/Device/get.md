---
editable: false
---

# Method get
Returns the specified device.
 
To get the list of available devices, make a [list](/docs/iot-core/api-ref/Device/list) request.
 
## HTTP request {#https-request}
```
GET https://iot-devices.api.cloud.yandex.net/iot-devices/v1/devices/{deviceId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
deviceId | Required. ID of the device to return.  To get a device ID make a [list](/docs/iot-core/api-ref/Device/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
deviceView | Specifies which parts of the device resource should be returned in the response.<ul> <li>BASIC: Server responses without monitoring data. The default value.</li> <li>FULL: Server responses with monitoring data.</li> </ul> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "registryId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "topicAliases": "object",
  "status": "string",
  "monitoringData": {
    "lastAuthIp": "string",
    "lastAuthTime": "string",
    "lastPubActivityTime": "string",
    "lastSubActivityTime": "string",
    "lastOnlineTime": "string"
  }
}
```
A device. For more information, see [Device](/docs/iot-core/concepts/index#device).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the device.</p> 
registryId | **string**<br><p>ID of the registry that the device belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the device. The name is unique within the registry.</p> 
description | **string**<br><p>Description of the device. 0-256 characters long.</p> 
topicAliases | **object**<br><p>Alias of a device topic.</p> <p>Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. `my/custom/alias` match to `$device/abcdef/events`.</p> 
status | **string**<br><p>Status of the device.</p> <ul> <li>CREATING: Device is being created.</li> <li>ACTIVE: Device is ready to use.</li> <li>DELETING: Device is being deleted.</li> </ul> 
monitoringData | **object**<br><p>Device monitoring data, returns if FULL view specified.</p> 
monitoringData.<br>lastAuthIp | **string**<br>
monitoringData.<br>lastAuthTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
monitoringData.<br>lastPubActivityTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
monitoringData.<br>lastSubActivityTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
monitoringData.<br>lastOnlineTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 