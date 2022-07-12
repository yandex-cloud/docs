---
editable: false
---

# Method list
Retrieves the list of Channel resources.
 

 
## HTTP request {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v3/channels
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list channels in.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/monitoring/api-ref/Channel/list#query_params">pageSize</a>, the service returns a <a href="/docs/monitoring/api-ref/Channel/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/monitoring/api-ref/Channel/list#query_params">pageToken</a> to the <a href="/docs/monitoring/api-ref/Channel/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response. Currently you can use filtering only on the <a href="/docs/monitoring/api-ref/Channel#representation">Channel.id</a> or <a href="/docs/monitoring/api-ref/Channel#representation">Channel.name</a> field.</p> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "channels": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",

      // `channels[]` includes only one of the fields `cloudEmail`, `cloudSms`, `cloudMobilePush`
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
      // end of the list of possible fields`channels[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
channels[] | **object**<br><p>List of Channel resources.</p> 
channels[].<br>id | **string**<br><p>ID of the channel.</p> 
channels[].<br>folderId | **string**<br><p>ID of the folder that the channel belongs on.</p> 
channels[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
channels[].<br>name | **string**<br><p>Name of the channel.</p> 
channels[].<br>description | **string**<br><p>Description of the channel.</p> 
channels[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
channels[].<br>cloudEmail | **object**<br>E-Mail channel. <br>`channels[]` includes only one of the fields `cloudEmail`, `cloudSms`, `cloudMobilePush`<br><br>
channels[].<br>cloudEmail.<br>recipients[] | **string**<br>
channels[].<br>cloudSms | **object**<br>Sms channel. <br>`channels[]` includes only one of the fields `cloudEmail`, `cloudSms`, `cloudMobilePush`<br><br>
channels[].<br>cloudSms.<br>recipients[] | **string**<br>
channels[].<br>cloudMobilePush | **object**<br>Mobile application push channel. <br>`channels[]` includes only one of the fields `cloudEmail`, `cloudSms`, `cloudMobilePush`<br><br>
channels[].<br>cloudMobilePush.<br>recipients[] | **string**<br>
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/monitoring/api-ref/Channel/list#query_params">pageSize</a>, use the <a href="/docs/monitoring/api-ref/Channel/list#responses">nextPageToken</a> as the value for the <a href="/docs/monitoring/api-ref/Channel/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/monitoring/api-ref/Channel/list#responses">nextPageToken</a> to continue paging through the results.</p> 