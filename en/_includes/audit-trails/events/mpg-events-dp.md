Event name | Description
--- | ---
`CreateDatabase` | Creating a database
`CreateUser` | Creating a database user
`DatabaseUserLogin` | Connecting a user to a database
`DatabaseUserLogout`| Disconnecting a user from a database
`DatabaseUserSQLRequest`| User SQL query to a database^1^
`DeleteDatabase` | Deleting a database
`DeleteUser` | Deleting a database user
`GrantUserPermission` | Assigning privileges to a database user
`RevokeUserPermission` | Revoking a database user's privileges
`UpdateDatabase` | Updating a database
`UpdateUser` | Editing a database user

^1^ Requires additional setup on the {{ mpg-name }} side. For more information, see [{#T}](../../../managed-postgresql/operations/extensions/pgaudit.md).