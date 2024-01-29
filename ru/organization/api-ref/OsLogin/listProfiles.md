---
editable: false
sourcePath: en/_api-ref/organizationmanager/v1/api-ref/OsLogin/listProfiles.md
---

# Cloud Organization API, REST: OsLogin.listProfiles

 

 
## HTTP request {#https-request}
```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/osLoginProfiles
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
organizationId | <p>Required. The maximum string length in characters is 50.</p> 
pageSize | <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>The maximum string length in characters is 2000.</p> 
filter | <p>A filter expression that filters profiles listed in the response. The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering by subject_id, uid or login.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). E.g. login="example-login"</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "profiles": [
    {
      "id": "string",
      "organizationId": "string",
      "subjectId": "string",
      "login": "string",
      "uid": "string",
      "isDefault": true,
      "homeDirectory": "string",
      "shell": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
profiles[] | **object**
profiles[].<br>id | **string**
profiles[].<br>organizationId | **string**
profiles[].<br>subjectId | **string**
profiles[].<br>login | **string**
profiles[].<br>uid | **string** (int64)
profiles[].<br>isDefault | **boolean** (boolean)
profiles[].<br>homeDirectory | **string**
profiles[].<br>shell | **string**
nextPageToken | **string**