---
editable: false
---

# Method get
Returns community.
 

 
## HTTP request {#https-request}
```
GET https://datasphere.{{ api-host }}/datasphere/v2/communities/{communityId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
communityId | <p>Required. ID of the community.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "createdById": "string",
  "accessType": "string",
  "isPersonal": true,
  "channel": {
    "link": "string",
    "type": "string"
  },
  "organizationId": "string",
  "status": "string"
}
```

 
Field | Description
--- | ---
id | **string**<br><p>ID of the community.</p> 
createdAt | **string** (date-time)<br><p>Time when community was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the community.</p> 
description | **string**<br><p>Description of the comminuty.</p> 
labels | **object**<br><p>Labels of the community.</p> 
createdById | **string**<br><p>ID of the user who created the community.</p> 
accessType | **string**<br><p>Community access type.</p> <p>Community access type.</p> <ul> <li>PUBLIC: Public community.</li> <li>PRIVATE: Private community.</li> </ul> 
isPersonal | **boolean** (boolean)
channel | **object**<br><p>Communication channel for the community.</p> 
channel.<br>link | **string**<br><p>Link to communication channel.</p> 
channel.<br>type | **string**<br><p>Type of communication channel.</p> 
organizationId | **string**<br><p>ID of the organization to which community belongs.</p> 
status | **string**<br><p>Community status.</p> <ul> <li>ACTIVE: Active community.</li> <li>BLOCKED_BY_BILLING: Community blocked by billing.</li> </ul> 