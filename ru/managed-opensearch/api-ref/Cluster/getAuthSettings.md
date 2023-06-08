---
editable: false
sourcePath: en/_api-ref/mdb/opensearch/v1/api-ref/Cluster/getAuthSettings.md
---

# Managed Service for OpenSearch API, REST: Cluster.getAuthSettings
Retrieves auth settings for specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}/auth
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. Required. ID of the OpenSearch cluster.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "saml": {
    "enabled": true,
    "idpEntityId": "string",
    "idpMetadataFile": "string",
    "spEntityId": "string",
    "dashboardsUrl": "string",
    "rolesKey": "string",
    "subjectKey": "string"
  }
}
```

 
Field | Description
--- | ---
saml | **object**<br><p>SAML settings</p> 
saml.<br>enabled | **boolean** (boolean)
saml.<br>idpEntityId | **string**<br><p>Required. The entity ID of your IdP.</p> <p>The maximum string length in characters is 250.</p> 
saml.<br>idpMetadataFile | **string** (byte)<br><p>Required. The SAML 2.0 metadata file of your IdP.</p> <p>The maximum string length in characters is 10000.</p> 
saml.<br>spEntityId | **string**<br><p>Required. The entity ID of the service provider.</p> <p>The maximum string length in characters is 250.</p> 
saml.<br>dashboardsUrl | **string**<br><p>Required. The OpenSearch Dashboards base URL.</p> <p>The maximum string length in characters is 250.</p> 
saml.<br>rolesKey | **string**<br><p>Optional. The attribute in the SAML response where the roles are stored. If not configured, no roles are used.</p> <p>The maximum string length in characters is 250.</p> 
saml.<br>subjectKey | **string**<br><p>Optional. The attribute in the SAML response where the subject is stored. If not configured, the NameID attribute is used.</p> <p>The maximum string length in characters is 250.</p> 