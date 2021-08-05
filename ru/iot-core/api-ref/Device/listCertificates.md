---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Method listCertificates
Retrieves the list of device certificates for the specified device.
 

 
## HTTP request {#https-request}
```
GET https://iot-devices.api.cloud.yandex.net/iot-devices/v1/devices/{deviceId}/certificates
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
deviceId | Required. ID of the device to list certificates for.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "certificates": [
    {
      "deviceId": "string",
      "fingerprint": "string",
      "certificateData": "string",
      "createdAt": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
certificates[] | **object**<br><p>A device certificate. For more information, see <a href="/docs/iot-core/operations/certificates/device-certificates">Managing device certificates</a>.</p> 
certificates[].<br>deviceId | **string**<br><p>ID of the device that the certificate belongs to.</p> 
certificates[].<br>fingerprint | **string**<br><p>SHA256 hash of the certificate.</p> 
certificates[].<br>certificateData | **string**<br><p>Public part of the certificate.</p> 
certificates[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 