---
editable: false
sourcePath: en/_api-ref/iot/devices/api-ref/DeviceData/publish.md
---


# Method publish
Publishes message on behalf of specified device
 

 
## HTTP request {#https-request}
```
POST https://iot-devices.api.cloud.yandex.net/iot-devices/v1/devices/{deviceId}/publish
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
deviceId | Required. ID of device publishing message  The maximum string length in characters is 50.
 
## Body parameters {#body_params}
 
```json 
{
  "topic": "string",
  "data": "string"
}
```

 
Field | Description
--- | ---
topic | **string**<br><p>Required. Topic where message should be published</p> <p>The maximum string length in characters is 1024.</p> 
data | **string** (byte)<br><p>Content of the message</p> <p>The maximum string length in characters is 262144.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{}
```

 
Field | Description
--- | ---