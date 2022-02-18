# Description of access rights differentiation in YDB

## Authentication {#authentication}

YDB uses token-based authentication, where tokens are sent by the user within a query.
The following token types are currently supported:

* OAuth (a regular OAuth token, links to apps are currently not checked, so any works, authentication is via blackbox).
* Session_id (a session cookie for the user in the yandex-team.ru domain. Authentication via blackbox).
* TVM2 (offline authentication)

After successful authentication with the token, the user ID (except for TVM2) is retrieved, which, when possible, is used to get a list of the user's groups (from Staff). All the data retrieved is used for further authorization.

## Authorization {#login}

In YDB, access rights are configured for each schema element and automatically inherited down the tree. The rights can be granted to any user or group (access subject). It is written as <login>@<subsystem>. For example, for users received from Staff, it will look like username@staff.

The following rights can currently be configured:

* ydb.generic.read: Read data and schema attributes.
* ydb.generic.write: Write data and schema attributes.
* ydb.access.grant: Grant access rights to other users.
* ydb.generic.use: Read, write, and grant rights (read + write + grant).
* ydb.generic.manage: Manage the database service. Available only to service administrators.
* ydb.generic.full: Full and unlimited access to the service (use + manage).

## Creating a database {#db-creation}

When creating via the [YDB web interface](https://ydb.yandex-team.ru/), databases for the user are created by the `robot-kikimr` user. The `robot-kikimr` user gets **full** rights for the database. The user that initiated database creation is granted **use** rights.

With use rights you can:

* Create and delete tables and directories in the database.
* Perform read and write operations.
* Grant access rights to other users, but only within the scope of the aforementioned use rights.

Users can't change database parameters or delete a database.

To change database parameters, please submit a [request form](https://st.yandex-team.ru/createTicket?template=1918&queue=YDBREQUESTS).

To delete a database, please submit a [request form](https://st.yandex-team.ru/createTicket?template=1919&queue=YDBREQUESTS).

