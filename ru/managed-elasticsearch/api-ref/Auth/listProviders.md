---
editable: false
sourcePath: en/_api-ref/mdb/elasticsearch/api-ref/Auth/listProviders.md
---

# Method listProviders
Retrieves the list of registered auth providers for Elasticsearch cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/auth/providers
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. Required. ID of the ElasticSearch cluster.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "providers": [
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
  ]
}
```

 
Field | Description
--- | ---
providers[] | **object**<br><p>List of auth providers of the Elasticsearch cluster.</p> 
providers[].<br>type | **string**
providers[].<br>name | **string**<br><p>The maximum string length in characters is 50. Value must match the regular expression ``[a-z][a-z0-9_-]*``.</p> 
providers[].<br>order | **string** (int64)
providers[].<br>enabled | **boolean** (boolean)
providers[].<br>hidden | **boolean** (boolean)<br><p>selector ui settings</p> 
providers[].<br>description | **string**<br><p>The maximum string length in characters is 50.</p> 
providers[].<br>hint | **string**<br><p>The maximum string length in characters is 250.</p> 
providers[].<br>icon | **string**<br><p>The maximum string length in characters is 250.</p> 
providers[].<br>saml | **object**
providers[].<br>saml.<br>idpEntityId | **string**<br><p>The maximum string length in characters is 250.</p> 
providers[].<br>saml.<br>idpMetadataFile | **string** (byte)<br><p>The maximum string length in characters is 10000.</p> 
providers[].<br>saml.<br>spEntityId | **string**<br><p>The maximum string length in characters is 250.</p> 
providers[].<br>saml.<br>kibanaUrl | **string**<br><p>The maximum string length in characters is 250.</p> 
providers[].<br>saml.<br>attributePrincipal | **string**<br><p>The maximum string length in characters is 50.</p> 
providers[].<br>saml.<br>attributeGroups | **string**<br><p>The maximum string length in characters is 50.</p> 
providers[].<br>saml.<br>attributeName | **string**<br><p>The maximum string length in characters is 50.</p> 
providers[].<br>saml.<br>attributeEmail | **string**<br><p>The maximum string length in characters is 50.</p> 
providers[].<br>saml.<br>attributeDn | **string**<br><p>The maximum string length in characters is 50.</p> 