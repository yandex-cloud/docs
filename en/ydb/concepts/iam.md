# Access rights differentiation

{% if audience == "internal" %}

## Authentication {#authentication}

{{ ydb-short-name }} uses token-based authentication, where users send tokens with each query.
The following token types are currently supported:

* *OAuth* — A regular OAuth token. Links to apps are currently not checked, so any works. Authentication occurs via blackbox.
* *Session_id* — User cookies in the yandex-team.ru domain. Authentication occurs via blackbox.
* *TVM2* — Offline authentication.

After successful authentication with the token, the user ID (except for TVM2) is retrieved, which, when possible, is used to get a list of the user's groups (from Staff). All the data retrieved is used for further authorization.

## Authorization {#authorization}

The access rights in {{ ydb-short-name }} are configured for each schema element and automatically inherited by the nested elements. Access rights can be granted to any user or group (access subject). Information about subjects is provided in the format ```<login>@<subsystem>```. For example, for users received from Staff, the entry looks like ```<login>@staff```.

The following rights can currently be configured:

* *read* — Read data and schema attributes.
* *write* — Write data and schema attributes.
* *grant* — Grant access rights to other users.
* *use* — Read, write, and grant rights (*read* + *write* + *grant*).
* *manage* — Create, modify, and delete databases. Only available to service administrators.
* *full* — Full and unlimited access to the service (*use* + *manage*).

## Creating databases {#create-db}

When creating a database using the [YDB web interface](https://ydb.yandex-team.ru/), the operation is performed on behalf of the `robot-yandexdb` user, which was granted *full* rights to the database. The user that initiated database creation is granted *use* rights.

With *use* rights you can:

* Create and delete tables and directories in the database.
* Perform read and write operations.
* Grant access rights to other users, but only within the scope of the aforementioned *use* rights.

In the current version, rights can only be management from the SDK for [C++](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/cpp/client/ydb_scheme.h) and [Python](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/python/client/scheme.py), which contain methods to grant, revoke, and change the list of rights granted, and a method to change the owner of a table, directory, and database.

Users can't change database parameters or delete a database. These actions can currently only be performed by system administrators.

{% endif %}

