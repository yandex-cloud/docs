---
editable: false
---

# LifecyclePolicy

## JSON Representation {#representation}
```json 
{
  "id": "string",
  "name": "string",
  "repositoryId": "string",
  "description": "string",
  "status": "string",
  "createdAt": "string",
  "rules": [
    {
      "description": "string",
      "expirePeriod": "string",
      "tagRegexp": "string",
      "untagged": true,
      "retainedTop": "string"
    }
  ]
}
```
 
Field | Description
--- | ---
id | **string**<br>
name | **string**<br>
repositoryId | **string**<br>
description | **string**<br>
status | **string**<br>
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
rules[] | **object**<br>
rules[].<br>description | **string**<br><p>The maximum string length in characters is 256.</p> 
rules[].<br>expirePeriod | **string**<br><p>The minimum value is 86400 seconds.</p> 
rules[].<br>tagRegexp | **string**<br><p>The maximum string length in characters is 256.</p> 
rules[].<br>untagged | **boolean** (boolean)<br>
rules[].<br>retainedTop | **string** (int64)<br><p>The minimum value is 0.</p> 

## Methods {#methods}
Method | Description
--- | ---