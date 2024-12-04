# User authentication

User authentication in {{ mgp-name }} is set up under **{{ ui-key.yacloud.greenplum.cluster.user-auth.title_page-auth-user }}** using [rules](../operations/user-auth-rules.md). This section is an interface for the [pg_hba.conf]({{ pg-docs }}/auth-pg-hba-conf.html) file management with some limitations:

* Some connection types and authentication methods are not available.
* Using system databases and users is not allowed.
* Special values and regular expressions for databases and users are not available.

For more information about these limitations, see [Authentication rule settings](#auth-settings).

Each authentication rule determines the connection type, DB name, user name or user group name, host FQDN or IP range to connect from, and authentication method. Rules are read from top to bottom, and the first suitable one is applied for authentication. If authentication based on the first suitable rule fails, other rules are not applied.

If no authentication rules are set, the default rule is used; it allows authentication for all users in any database and from any host using the `md5` method (password-based authentication). If the authentication rules are set, the default rule is read last.

## Authentication rule settings {#auth-settings}

You can specify the following authentication settings when [adding](../operations/user-auth-rules.md#add-rules) or [updating](../operations/user-auth-rules.md#edit-rules) rules:

Available connection types:

* `{{ ui-key.yacloud.greenplum.cluster.user-auth.value_hba-type-host }}`: TCP/IP with or without SSL encryption
* `{{ ui-key.yacloud.greenplum.cluster.user-auth.value_hba-type-hostssl }}`: TCP/IP with SSL encryption
* `{{ ui-key.yacloud.greenplum.cluster.user-auth.value_hba-type-hostnossl }}`: TCP/IP without SSL encryption

The following is not available to databases and users:

* System databases, e.g., `postgres`.
* System users, e.g., [mdb_admin](cluster-users.md#mdb_admin).
* Special values, e.g., `all` or `sameuser`.
* [Regular expressions]({{ pg-docs }}/functions-matching.html#POSIX-SYNTAX-DETAILS)

The name of a database user group must begin with `+`, e.g, `+dbwriters`.

As an address, you can use a host's FQDN, IP range, or the special `all` value that allows connections from any host:

* `rc1b-drajz6j1rv******.mdb.yandexcloud.net`
* `172.20.143.89/32`
* `::0/0`
* `all`

The following authentication methods are supported:

* `md5`: Password-based authentication. For more information, see the [{{ PG }} documentation]({{ pg-docs }}/auth-password.html).
* `reject`: User connection is not allowed.

For more information about the settings, see the [{{ PG }} documentation]({{ pg-docs }}/auth-pg-hba-conf.html).

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
