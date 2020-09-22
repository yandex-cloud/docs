---
editable: false
---

# Method list

 

 
## HTTP request {#https-request}
```
GET https://vpc.api.cloud.yandex.net/vpc/v1/addresses
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | 
pageSize | 
pageToken | 
filter | 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "addresses": [
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
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
addresses[] | **object**<br>
addresses[].<br>id | **string**<br>
addresses[].<br>folderId | **string**<br>
addresses[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
addresses[].<br>name | **string**<br>
addresses[].<br>description | **string**<br>
addresses[].<br>labels | **object**<br>
addresses[].<br>reserved | **boolean** (boolean)<br>
addresses[].<br>used | **boolean** (boolean)<br>
addresses[].<br>externalIpv4Address | **object**<br>
addresses[].<br>externalIpv4Address.<br>address | **string**<br>
addresses[].<br>externalIpv4Address.<br>zoneId | **string**<br>
addresses[].<br>externalIpv4Address.<br>requirements | **object**<br>
addresses[].<br>externalIpv4Address.<br>requirements.<br>ddosProtectionProvider | **string**<br>
addresses[].<br>externalIpv4Address.<br>requirements.<br>outgoingSmtpCapability | **string**<br>
nextPageToken | **string**<br>