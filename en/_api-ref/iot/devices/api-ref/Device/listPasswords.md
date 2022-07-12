---
editable: false
---

# Method listPasswords
Retrieves the list of passwords for the specified device.
 

 
## HTTP request {#https-request}
```
GET https://iot-devices.{{ api-host }}/iot-devices/v1/devices/{deviceId}/passwords
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
deviceId | <p>Required. ID of the registry to list passwords in.</p> <p>To get a registry ID make a <a href="/docs/iot-core/api-ref/Registry/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "passwords": [
    {
      "deviceId": "string",
      "id": "string",
      "createdAt": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
passwords[] | **object**<br><p>List of passwords for the specified device.</p> 
passwords[].<br>deviceId | **string**<br><p>ID of the device that the password belongs to.</p> 
passwords[].<br>id | **string**<br><p>ID of the password.</p> 
passwords[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 