---
editable: false
sourcePath: en/_api-ref/iot/broker/broker/api-ref/BrokerData/publish.md
---

# Method publish
Publishes message on behalf of specified registry
 

 
## HTTP request {#https-request}
```
POST https://iot-broker.{{ api-host }}/iot-broker/v1/brokers/{brokerId}/publish
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
brokerId | <p>Required. ID of broker publishing message</p> <p>The maximum string length in characters is 50.</p> 
 
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