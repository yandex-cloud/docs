---
editable: false
---

# Monitoring API, REST: Channel.get
Returns the specified Channel resource.
 
To get the list of available Channel resources, make a [list](/docs/monitoring/api-ref/Channel/list) request.
 
## HTTP request {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v3/channels/{channelId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
channelId | <p>Required. ID of the Channel resource to return.</p> <p>The maximum string length in characters is 50.</p> 
 
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the channel.</p> 
description | **string**<br><p>Description of the channel.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
cloudEmail | **object**<br>E-Mail channel. <br> includes only one of the fields `cloudEmail`, `cloudSms`, `cloudMobilePush`<br>
cloudEmail.<br>recipients[] | **string**
cloudSms | **object**<br>Sms channel. <br> includes only one of the fields `cloudEmail`, `cloudSms`, `cloudMobilePush`<br>
cloudSms.<br>recipients[] | **string**
cloudMobilePush | **object**<br>Mobile application push channel. <br> includes only one of the fields `cloudEmail`, `cloudSms`, `cloudMobilePush`<br>
cloudMobilePush.<br>recipients[] | **string**