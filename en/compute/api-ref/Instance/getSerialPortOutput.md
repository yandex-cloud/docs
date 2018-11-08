# Method getSerialPortOutput
Returns the serial port output of the specified Instance resource.
 

 
## HTTP request {#https-request}
`GET https://compute.api.cloud.yandex.net/compute/v1/instances/{instanceId}:serialPortOutput`
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
instanceId | Required. ID of the instance to return the serial port output for.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**


 
Field | Description
--- | ---
contents | **string**<br><p>The contents of the serial port output, starting from the time when the instance started to boot.</p> 