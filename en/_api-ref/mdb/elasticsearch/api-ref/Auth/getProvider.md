---
editable: false
---

# Managed Service for Elasticsearch API, REST: Auth.getProvider
Returns registered auth provider by name.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/auth/providers/{name}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. Required. ID of the ElasticSearch cluster.</p> <p>The maximum string length in characters is 50.</p> 
name | <p>Required. Required. Name of the provider to delete.</p> <p>The maximum string length in characters is 50. Value must match the regular expression ``[a-z][a-z0-9_-]*``.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "type": "string",
  "name": "string",
  "order": "string",
  "enabled": true,
  "hidden": true,
  "description": "string",
  "hint": "string",
  "icon": "string",
  "saml": {
    "idpEntityId": "string",
    "idpMetadataFile": "string",
    "spEntityId": "string",
    "kibanaUrl": "string",
    "attributePrincipal": "string",
    "attributeGroups": "string",
    "attributeName": "string",
    "attributeEmail": "string",
    "attributeDn": "string"
  }
}
```

 
Field | Description
--- | ---
type | **string**
name | **string**<br><p>The maximum string length in characters is 50. Value must match the regular expression ``[a-z][a-z0-9_-]*``.</p> 
order | **string** (int64)
enabled | **boolean** (boolean)
hidden | **boolean** (boolean)<br><p>selector ui settings</p> 
description | **string**<br><p>The maximum string length in characters is 50.</p> 
hint | **string**<br><p>The maximum string length in characters is 250.</p> 
icon | **string**<br><p>The maximum string length in characters is 250.</p> 
saml | **object**
saml.<br>idpEntityId | **string**<br><p>The maximum string length in characters is 250.</p> 
saml.<br>idpMetadataFile | **string** (byte)<br><p>The maximum string length in characters is 10000.</p> 
saml.<br>spEntityId | **string**<br><p>The maximum string length in characters is 250.</p> 
saml.<br>kibanaUrl | **string**<br><p>The maximum string length in characters is 250.</p> 
saml.<br>attributePrincipal | **string**<br><p>The maximum string length in characters is 50.</p> 
saml.<br>attributeGroups | **string**<br><p>The maximum string length in characters is 50.</p> 
saml.<br>attributeName | **string**<br><p>The maximum string length in characters is 50.</p> 
saml.<br>attributeEmail | **string**<br><p>The maximum string length in characters is 50.</p> 
saml.<br>attributeDn | **string**<br><p>The maximum string length in characters is 50.</p> 