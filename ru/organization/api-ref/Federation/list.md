---
editable: false
sourcePath: en/_api-ref/organizationmanager/api-ref/Federation/list.md
---

# Method list
Retrieves the list of federations in the specified organization.
 

 
## HTTP request {#https-request}
```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
organizationId | <p>Required. ID of the organization to list federations in. To get the organization ID, make a <a href="/docs/organization/api-ref/Organization/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/organization/api-ref/Federation/list#query_params">pageSize</a>, the service returns a <a href="/docs/organization/api-ref/Federation/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/organization/api-ref/Federation/list#query_params">pageToken</a> to the <a href="/docs/organization/api-ref/Federation/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 50.</p> 
filter | <p>A filter expression that filters resources listed in the response. The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on the <a href="/docs/organization/api-ref/Federation#representation">Federation.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "federations": [
    {
      "id": "string",
      "organizationId": "string",
      "name": "string",
      "description": "string",
      "createdAt": "string",
      "cookieMaxAge": "string",
      "autoCreateAccountOnLogin": true,
      "issuer": "string",
      "ssoBinding": "string",
      "ssoUrl": "string",
      "securitySettings": {
        "encryptedAssertions": true
      },
      "caseInsensitiveNameIds": true,
      "labels": "object"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
federations[] | **object**<br><p>List of federations.</p> 
federations[].<br>id | **string**<br><p>Required. ID of the federation.</p> <p>The maximum string length in characters is 50.</p> 
federations[].<br>organizationId | **string**<br><p>ID of the organization that the federation belongs to.</p> 
federations[].<br>name | **string**<br><p>Required. Name of the federation.</p> <p>Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
federations[].<br>description | **string**<br><p>Description of the federation.</p> <p>The maximum string length in characters is 256.</p> 
federations[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
federations[].<br>cookieMaxAge | **string**<br><p>Browser cookie lifetime in seconds. If the cookie is still valid, the management console authenticates the user immediately and redirects them to the home page.</p> <p>Acceptable values are 600 seconds to 43200 seconds, inclusive.</p> 
federations[].<br>autoCreateAccountOnLogin | **boolean** (boolean)<br><p>Add new users automatically on successful authentication. The user becomes member of the organization automatically, but you need to grant other roles to them.</p> <p>If the value is ``false``, users who aren't added to the organization can't log in, even if they have authenticated on your server.</p> 
federations[].<br>issuer | **string**<br><p>Required. ID of the IdP server to be used for authentication. The IdP server also responds to IAM with this ID after the user authenticates.</p> <p>The maximum string length in characters is 8000.</p> 
federations[].<br>ssoBinding | **string**<br><p>Single sign-on endpoint binding type. Most Identity Providers support the ``POST`` binding type.</p> <p>SAML Binding is a mapping of a SAML protocol message onto standard messaging formats and/or communications protocols.</p> <ul> <li>POST: HTTP POST binding.</li> <li>REDIRECT: HTTP redirect binding.</li> <li>ARTIFACT: HTTP artifact binding.</li> </ul> 
federations[].<br>ssoUrl | **string**<br><p>Required. Single sign-on endpoint URL. Specify the link to the IdP login page here.</p> <p>The maximum string length in characters is 8000.</p> 
federations[].<br>securitySettings | **object**<br><p>Federation security settings.</p> <p>Federation security settings.</p> 
federations[].<br>securitySettings.<br>encryptedAssertions | **boolean** (boolean)<br><p>Enable encrypted assertions.</p> 
federations[].<br>caseInsensitiveNameIds | **boolean** (boolean)<br><p>Use case insensitive Name IDs.</p> 
federations[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/organization/api-ref/Federation/list#query_params">pageSize</a>, use the <a href="/docs/organization/api-ref/Federation/list#responses">nextPageToken</a> as the value for the <a href="/docs/organization/api-ref/Federation/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/organization/api-ref/Federation/list#responses">nextPageToken</a> to continue paging through the results.</p> 