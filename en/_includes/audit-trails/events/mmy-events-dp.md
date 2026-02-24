Event name | Description
--- | ---
`CreateDatabase` | Creating a database
`CreateUser` | Creating a database user
`DatabaseUserSQLRequest` | User SQL query to a database^1^
`DeleteDatabase` | Deleting a database
`DeleteUser` | Deleting a database user
`GetDatabase` | Getting database info
`GetUser` | Getting user info
`GrantUserPermission` | Assigning privileges to a database user
`ListDatabases` | Getting a list of databases
`ListUsers` | Getting a list of users
`RevokeUserPermission` | Revoking a database user's privileges
`UpdateUser` | Editing a database user

^1^ Make sure to enable these [{{ MY }} settings](../../../managed-mysql/concepts/settings-list.md#dbms-cluster-settings): **Audit log** and **Audit log policy**. Enabling these settings may result in additional load on your cluster hosts, so we recommend testing your system in dev/stage environments first. Also, to enable them, you may need to restart your services, so make sure to select a time when the cluster load is minimal.