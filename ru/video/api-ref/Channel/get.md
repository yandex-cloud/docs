---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Channel/get.md
---

# Video API, REST: Channel.get
Returns the specific channel.
 

 
## HTTP request {#https-request}
```
GET https://video.{{ api-host }}/video/v1/channels/{channelId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
channelId | <p>ID of the channel.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "organizationId": "string",
  "title": "string",
  "description": "string",
  "createdAt": "string",
  "updatedAt": "string",
  "labels": "object"
}
```
Root entity for content separation.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the channel.</p> 
organizationId | **string**<br><p>ID of the organization where channel should be created.</p> 
title | **string**<br><p>Channel title.</p> 
description | **string**<br><p>Channel description.</p> 
createdAt | **string** (date-time)<br><p>Time when channel was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
updatedAt | **string** (date-time)<br><p>Time of last channel update.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
labels | **object**<br><p>Custom labels as ``key:value`` pairs. Maximum 64 per resource.</p> 