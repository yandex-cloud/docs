---
editable: false
---

# Federation
A set of methods for managing federation resources.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "name": "string",
  "description": "string",
  "createdAt": "string",
  "cookieMaxAge": "string",
  "autoCreateAccountOnLogin": true,
  "issuer": "string",
  "ssoBinding": "string",
  "ssoUrl": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>Required. ID of the federation.</p> <p>The maximum string length in characters is 50.</p> 
folderId | **string**<br><p>Required. ID of the folder that the federation belongs to.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Required. Name of the federation. The name is unique within the cloud. 3-63 characters long.</p> <p>Value must match the regular expression <code>\|[a-z][-a-z0-9]{1,61}[a-z0-9]</code>.</p> 
description | **string**<br><p>Description of the federation. 0-256 characters long.</p> <p>The maximum string length in characters is 256.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
cookieMaxAge | **string**<br><p>The 'IAM_COOKIE' cookie max age in seconds. The value should be in range from 10 min to 12 hours. The default value is 8 hours.</p> <p>Acceptable values are 600 seconds to 43200 seconds, inclusive.</p> 
autoCreateAccountOnLogin | **boolean** (boolean)<br><p>Auto create accounts for new user on first login.</p> 
issuer | **string**<br><p>Required. federation issuer (entity Id).</p> <p>The maximum string length in characters is 8000.</p> 
ssoBinding | **string**<br><p>Single sign on endpoint binding type.</p> <p>SAML Binding is a mapping of a SAML protocol message onto standard messaging formats and/or communications protocols.</p> <ul> <li>BINDING_TYPE_UNSPECIFIED: Invalid</li> <li>POST: HTTP POST binding.</li> <li>REDIRECT: HTTP redirect binding.</li> <li>ARTIFACT: HTTP artifact binding.</li> </ul> 
ssoUrl | **string**<br><p>Required. Single sign on endpoint URL.</p> <p>The maximum string length in characters is 8000.</p> 

## Methods {#methods}
Method | Description
--- | ---
[addUserAccounts](addUserAccounts.md) | Adds users to the specified federation resource.
[create](create.md) | Creates a federation resource in the specified folder.
[delete](delete.md) | Deletes the specified federation resource.
[get](get.md) | Returns the specified federation resource.
[list](list.md) | Retrieves the list of federation resources in the specified folder.
[listOperations](listOperations.md) | Lists operations for the specified federation resource.
[update](update.md) | Updates the specified federation resource.