# Using pgaudit in {{ mpg-name }}

The [pgaudit](https://www.pgaudit.org/) extension provides additional logging tools and enhanced auditing capabilities.

## Installing the pgaudit extension in a {{ PG }} cluster {#install}

1. [Load the `pgaudit` shared library](./cluster-extensions.md#libraries-connection) into your cluster.
1. [Enable](./cluster-extensions.md#update-extensions) the `pgaudit` extension in your database.
1. For users whose actions should be audited, specify the required [Pg audit log](../../concepts/settings-list.md#setting-pg-audit-log) values. For more information, see [{#T}](../cluster-users.md#update-settings).

Audit logs will be included in the [cluster logs](../cluster-logs.md).


Learn more about the `pgaudit` extension in [this official guide](https://github.com/pgaudit/pgaudit/blob/master/README.md).
