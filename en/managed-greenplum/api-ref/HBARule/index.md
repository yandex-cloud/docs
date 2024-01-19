---
editable: false
sourcePath: en/_api-ref/mdb/greenplum/v1/api-ref/HBARule/index.md
---

# Managed Service for Greenplum® API, REST: HBARule methods
A set of methods for managing Greenplum clusters.
## JSON Representation {#representation}
```json 
{
  "priority": "string",
  "connectionType": "string",
  "database": "string",
  "user": "string",
  "address": "string",
  "authMethod": "string"
}
```
 
Field | Description
--- | ---
priority | **string** (int64)<br><p>Priority of the Greenplum cluster rule.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
connectionType | **string**<br><ul> <li>HOST: Matches connection attempts made using TCP/IP.</li> <li>HOSTSSL: Matches connection attempts made using TCP/IP, but only when the connection is made with SSL encryption.</li> <li>HOSTNOSSL: Matches connection attempts made over TCP/IP that do not use SSL.</li> </ul> 
database | **string**<br><p>Required. Specifies which database names this record matches.</p> 
user | **string**<br><p>Required. Specifies which database role names this user matches.</p> 
address | **string**<br><p>Required. Specifies the client machine addresses that this record matches.</p> 
authMethod | **string**<br><p>Specifies the authentication method to use when a connection matches this record. https://gpdb.docs.pivotal.io/6-6/security-guide/topics/Authenticate.html</p> <ul> <li>MD5: Perform SCRAM-SHA-256 or MD5 authentication to verify the user's password.</li> <li>LDAP: Perform LDAP authentication, if MDB_GREENPLUM_LDAP flag is set</li> <li>REJECT: Disable authentication</li> </ul> 

## Methods {#methods}
Method | Description
--- | ---
[batchUpdate](batchUpdate.md) | Modifies all HBA rules for the specified Greenplum cluster.
[create](create.md) | Create single HBA rule for the specified Greenplum cluster to the end of HBA rules list.
[delete](delete.md) | Delete specified HBA rule for the specified Greenplum cluster.
[list](list.md) | Retrieves a list of HBA rules for Greenplum clusters.
[listAtRevision](listAtRevision.md) | Retrieves a list of HBA rules for Greenplum clusters for particular revision.
[update](update.md) | Update specified HBA rule for the specified Greenplum cluster without changind it order.