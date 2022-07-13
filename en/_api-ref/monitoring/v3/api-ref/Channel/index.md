---
editable: false
---

# Channel
A set of methods for managing Channel resources.
## JSON Representation {#representation}
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
 
Field | Description
--- | ---
id | **string**<br><p>ID of the channel.</p> 
folderId | **string**<br><p>ID of the folder that the channel belongs on.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the channel.</p> 
description | **string**<br><p>Description of the channel.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
cloudEmail | **object** <br> includes only one of the fields `cloudEmail`, `cloudSms`, `cloudMobilePush`<br>
cloudEmail.<br>recipients[] | **string**
cloudSms | **object** <br> includes only one of the fields `cloudEmail`, `cloudSms`, `cloudMobilePush`<br>
cloudSms.<br>recipients[] | **string**
cloudMobilePush | **object** <br> includes only one of the fields `cloudEmail`, `cloudSms`, `cloudMobilePush`<br>
cloudMobilePush.<br>recipients[] | **string**

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a channel.
[delete](delete.md) | Deletes the specified channel.
[get](get.md) | Returns the specified Channel resource.
[list](list.md) | Retrieves the list of Channel resources.
[listOperations](listOperations.md) | Lists operations for the specified channel.
[update](update.md) | Updates the specified channel.