---
editable: false
sourcePath: en/_api-ref/compute/api-ref/Instance/getSerialPortOutput.md
---


# Method getSerialPortOutput
Returns the serial port output of the specified Instance resource.
 

 
## HTTP request {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/instances/{instanceId}:serialPortOutput
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
instanceId | Required. ID of the instance to return the serial port output for.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
port | Serial port to retrieve data from. The default is 1.  Value must be one of 1, 2, 3 or 4.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "contents": "string"
}
```

 
Field | Description
--- | ---
contents | **string**<br><p>The contents of the serial port output, starting from the time when the instance started to boot.</p> 