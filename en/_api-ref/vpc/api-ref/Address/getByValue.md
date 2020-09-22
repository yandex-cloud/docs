---
editable: false
---

# Method getByValue

 

 
## HTTP request {#https-request}
```
GET https://vpc.api.cloud.yandex.net/vpc/v1/addresses:byValue
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
externalIpv4Address | 
 
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
  "reserved": true,
  "used": true,
  "externalIpv4Address": {
    "address": "string",
    "zoneId": "string",
    "requirements": {
      "ddosProtectionProvider": "string",
      "outgoingSmtpCapability": "string"
    }
  }
}
```

 
Field | Description
--- | ---
id | **string**<br>
folderId | **string**<br>
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br>
description | **string**<br>
labels | **object**<br>
reserved | **boolean** (boolean)<br>
used | **boolean** (boolean)<br>
externalIpv4Address | **object**<br>
externalIpv4Address.<br>address | **string**<br>
externalIpv4Address.<br>zoneId | **string**<br>
externalIpv4Address.<br>requirements | **object**<br>
externalIpv4Address.<br>requirements.<br>ddosProtectionProvider | **string**<br>
externalIpv4Address.<br>requirements.<br>outgoingSmtpCapability | **string**<br>