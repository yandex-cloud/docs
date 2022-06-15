---
editable: false
---

# Method listPasswords
Retrieves the list of passwords for the specified broker.
 

 
## HTTP request {#https-request}
```
GET https://iot-broker.{{ api-host }}/iot-broker/v1/brokers/{brokerId}/passwords
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
brokerId | Required. ID of the broker to list passwords in.  To get a broker ID make a [list](/docs/iot-core/broker/api-ref/Broker/list) request.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "passwords": [
    {
      "brokerId": "string",
      "id": "string",
      "createdAt": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
passwords[] | **object**<br><p>A broker password.</p> 
passwords[].<br>brokerId | **string**<br><p>ID of the broker that the password belongs to.</p> 
passwords[].<br>id | **string**<br><p>ID of the password.</p> 
passwords[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 