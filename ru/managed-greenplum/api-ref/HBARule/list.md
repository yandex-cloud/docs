---
editable: false
sourcePath: en/_api-ref/mdb/greenplum/v1/api-ref/HBARule/list.md
---

# Managed Service for Greenplum® API, REST: HBARule.list
Retrieves a list of HBA rules for Greenplum clusters.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/{clusterId}/hbaRules
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Greenplum cluster. To get the Greenplum cluster ID use a <a href="/docs/managed-greenplum/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "hbaRules": [
    {
      "priority": "string",
      "connectionType": "string",
      "database": "string",
      "user": "string",
      "address": "string",
      "authMethod": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
hbaRules[] | **object**<br><p>Requested list of hba rules for the cluster.</p> 
hbaRules[].<br>priority | **string** (int64)<br><p>Priority of the Greenplum cluster rule.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
hbaRules[].<br>connectionType | **string**<br><ul> <li>HOST: Matches connection attempts made using TCP/IP.</li> <li>HOSTSSL: Matches connection attempts made using TCP/IP, but only when the connection is made with SSL encryption.</li> <li>HOSTNOSSL: Matches connection attempts made over TCP/IP that do not use SSL.</li> </ul> 
hbaRules[].<br>database | **string**<br><p>Required. Specifies which database names this record matches.</p> 
hbaRules[].<br>user | **string**<br><p>Required. Specifies which database role names this user matches.</p> 
hbaRules[].<br>address | **string**<br><p>Required. Specifies the client machine addresses that this record matches.</p> 
hbaRules[].<br>authMethod | **string**<br><p>Specifies the authentication method to use when a connection matches this record. https://gpdb.docs.pivotal.io/6-6/security-guide/topics/Authenticate.html</p> <ul> <li>MD5: Perform SCRAM-SHA-256 or MD5 authentication to verify the user's password.</li> <li>LDAP: Perform LDAP authentication, if MDB_GREENPLUM_LDAP flag is set</li> <li>REJECT: Disable authentication</li> </ul> 