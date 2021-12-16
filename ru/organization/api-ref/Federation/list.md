---
editable: false
sourcePath: en/_api-ref/organizationmanager/api-ref/Federation/list.md
---


# Method list
Retrieves the list of federations in the specified organization.
 

 
## HTTP request {#https-request}
```
GET https://organization-manager.api.cloud.yandex.net/organization-manager/v1/saml/federations
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
organizationId | Required. ID of the organization to list federations in. To get the organization ID, make a [list](/docs/organization-manager/api-ref/Organization/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/organization-manager/api-ref/Federation/list#query_params), the service returns a [nextPageToken](/docs/organization-manager/api-ref/Federation/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/organization-manager/api-ref/Federation/list#query_params) to the [nextPageToken](/docs/organization-manager/api-ref/Federation/list#responses) returned by a previous list request.  The maximum string length in characters is 50.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can use filtering only on the [Federation.name](/docs/organization-manager/api-ref/Federation#representation) field. 2. An `=` operator. 3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.  The maximum string length in characters is 1000.
 
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
federations[] | **object**<br><p>A federation. For more information, see <a href="/docs/iam/concepts/users/identity-federations">SAML-compatible identity federations</a>.</p> 
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
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/organization-manager/api-ref/Federation/list#query_params">pageSize</a>, use the <a href="/docs/organization-manager/api-ref/Federation/list#responses">nextPageToken</a> as the value for the <a href="/docs/organization-manager/api-ref/Federation/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/organization-manager/api-ref/Federation/list#responses">nextPageToken</a> to continue paging through the results.</p> 