---
editable: false
sourcePath: en/_api-ref/mdb/greenplum/v1/api-ref/HBARule/list.md
---

# Managed Service for Greenplum® API, REST: HBARule.List

Retrieves a list of HBA rules for Greenplum clusters.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/{clusterId}/hbaRules
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Greenplum cluster.
To get the Greenplum cluster ID use a [ClusterService.List](/docs/managed-greenplum/api-ref/Cluster/list#List) request. ||
|#

## Response {#yandex.cloud.mdb.greenplum.v1.ListHBARulesResponse}

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

#|
||Field | Description ||
|| hbaRules[] | **[HBARule](#yandex.cloud.mdb.greenplum.v1.HBARule)**

Requested list of hba rules for the cluster. ||
|#

## HBARule {#yandex.cloud.mdb.greenplum.v1.HBARule}

#|
||Field | Description ||
|| priority | **string** (int64)

Priority of the Greenplum cluster rule. ||
|| connectionType | **enum** (ConnectionType)

- `CONNECTION_TYPE_UNSPECIFIED`
- `HOST`: Matches connection attempts made using TCP/IP.
- `HOSTSSL`: Matches connection attempts made using TCP/IP, but only when the connection is made with SSL encryption.
- `HOSTNOSSL`: Matches connection attempts made over TCP/IP that do not use SSL. ||
|| database | **string**

Required field. Specifies which database names this record matches. ||
|| user | **string**

Required field. Specifies which database role names this user matches. ||
|| address | **string**

Required field. Specifies the client machine addresses that this record matches. ||
|| authMethod | **enum** (AuthMethod)

Specifies the authentication method to use when a connection matches this record.
https://gpdb.docs.pivotal.io/6-6/security-guide/topics/Authenticate.html

- `AUTH_METHOD_UNSPECIFIED`
- `MD5`: Perform SCRAM-SHA-256 or MD5 authentication to verify the user's password.
- `LDAP`: Perform LDAP authentication, if MDB_GREENPLUM_LDAP flag is set
- `REJECT`: Disable authentication ||
|#