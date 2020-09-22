---
editable: false
---

# User
A set of methods for managing SQL Server users.
## JSON Representation {#representation}
```json 
{
  "name": "string",
  "clusterId": "string",
  "permissions": [
    {
      "databaseName": "string",
      "roles": [
        "string"
      ]
    }
  ]
}
```
 
Field | Description
--- | ---
name | **string**<br><p>Name of the SQL Server user.</p> 
clusterId | **string**<br><p>ID of the SQL Server cluster the user belongs to.</p> 
permissions[] | **object**<br><p>Set of permissions granted to the user.</p> 
permissions[].<br>databaseName | **string**<br><p>Name of the database the permission grants access to.</p> 
permissions[].<br>roles[] | **string**<br><ul> <li>DB_OWNER: Members of this fixed database role can perform all configuration and maintenance activities on the database, and can also drop the database in SQL Server.</li> <li>DB_SECURITYADMIN: Members of this fixed database role can modify role membership for custom roles only and manage permissions. They can potentially elevate their privileges and their actions should be monitored.</li> <li>DB_ACCESSADMIN: Members of this fixed database role can add or remove access to the database for Windows logins, Windows groups, and SQL Server logins.</li> <li>DB_BACKUPOPERATOR: Members of this fixed database role can back up the database.</li> <li>DB_DDLADMIN: Members of this fixed database role can run any Data Definition Language (DDL) command in a database.</li> <li>DB_DATAWRITER: Members of this fixed database role can add, delete, or change data in all user tables.</li> <li>DB_DATAREADER: Members of this fixed database role can read all data from all user tables.</li> <li>DB_DENYDATAWRITER: Members of this fixed database role cannot add, modify, or delete any data in the user tables within a database. Denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li> <li>DB_DENYDATAREADER: Members of this fixed database role cannot read any data in the user tables within a database. Denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li> </ul> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates an SQL Server user in the specified cluster.
[delete](delete.md) | Deletes the specified SQL Server user.
[get](get.md) | Returns the specified SQL Server user.
[grantPermission](grantPermission.md) | Grants a permission to the specified SQL Server user.
[list](list.md) | Retrieves a list of SQL Server users in the specified cluster.
[revokePermission](revokePermission.md) | Revokes a permission from the specified SQL Server user.
[update](update.md) | Modifies the specified SQL Server user.