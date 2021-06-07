---
editable: false
---

# Method get
Returns the specified Channel resource.
 
To get the list of available Channel resources, make a [list](/docs/monitoring/api-ref/Channel/list) request.
 
## HTTP request {#https-request}
```
GET https://monitoring.api.cloud.yandex.net/monitoring/v3/channels/{channelId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
channelId | Required. ID of the Channel resource to return.  The maximum string length in characters is 50.
 
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

  //  includes only one of the fields `cloudEmail`, `cloudSms`, `cloudMobilePush`
  "cloudEmail": {
    "recipients": [
      "string"
    ]
  },
  "cloudSms": {
    "recipients": [
      "string"
    ]
  },
  "cloudMobilePush": {
    "recipients": [
      "string"
    ]
  },
  // end of the list of possible fields

}
```
An Channel resource.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the channel.</p> 
folderId | **string**<br><p>ID of the folder that the channel belongs on.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the channel.</p> 
description | **string**<br><p>Description of the channel.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
cloudEmail | **object**<br>E-Mail channel. <br> includes only one of the fields `cloudEmail`, `cloudSms`, `cloudMobilePush`<br><br>
cloudEmail.<br>recipients[] | **string**<br>
cloudSms | **object**<br>Sms channel. <br> includes only one of the fields `cloudEmail`, `cloudSms`, `cloudMobilePush`<br><br>
cloudSms.<br>recipients[] | **string**<br>
cloudMobilePush | **object**<br>Mobile application push channel. <br> includes only one of the fields `cloudEmail`, `cloudSms`, `cloudMobilePush`<br><br>
cloudMobilePush.<br>recipients[] | **string**<br>