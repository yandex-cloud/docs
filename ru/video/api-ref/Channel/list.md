---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Channel/list.md
---

# Video API, REST: Channel.list
List channels for organization.
 

 
## HTTP request {#https-request}
```
GET https://video.{{ api-host }}/video/v1/channels
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
organizationId | <p>ID of the organization.</p> 
pageSize | <p>The maximum number of the results per page to return. Default value: 100.</p> 
pageToken | <p>Page token for getting the next page of the result.</p> 
orderBy | <p>By which column the listing should be ordered and in which direction, format is "createdAt desc". "id asc" if omitted. Possible fields: ["id", "createdAt", "updatedAt"] Both snake_case and camelCase are supported for fields.</p> 
filter | <p>Filter expression that filters resources listed in the response. Expressions are composed of terms connected by logic operators. Value in quotes: ``'`` or ``"`` Example: "key1='value' AND key2='value'" Supported operators: ["AND"]. Supported fields: ["title"] Both snake_case and camelCase are supported for fields.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "channels": [
    {
      "id": "string",
      "organizationId": "string",
      "title": "string",
      "description": "string",
      "createdAt": "string",
      "updatedAt": "string",
      "labels": "object"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
channels[] | **object**<br><p>List of channels for specific organization.</p> 
channels[].<br>id | **string**<br><p>ID of the channel.</p> 
channels[].<br>organizationId | **string**<br><p>ID of the organization where channel should be created.</p> 
channels[].<br>title | **string**<br><p>Channel title.</p> 
channels[].<br>description | **string**<br><p>Channel description.</p> 
channels[].<br>createdAt | **string** (date-time)<br><p>Time when channel was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
channels[].<br>updatedAt | **string** (date-time)<br><p>Time of last channel update.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
channels[].<br>labels | **object**<br><p>Custom labels as ``key:value`` pairs. Maximum 64 per resource.</p> 
nextPageToken | **string**<br><p>Token for getting the next page.</p> 