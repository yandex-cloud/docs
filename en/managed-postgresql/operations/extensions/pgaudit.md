# Using pgaudit in {{ mpg-name }}

The [pgaudit](https://www.pgaudit.org/) extension provides additional logging tools and enhances the audit features.

## Installing the pgaudit extension into a {{ PG }} cluster {#install}

1. [Enable the shared library](./cluster-extensions.md#libraries-connection) named `pgaudit` for your cluster.
1. [Add](./cluster-extensions.md#update-extensions) `pgaudit` to the database.
1. For users whose actions should be logged to an audit log, specify the required [Pg audit log](../../concepts/settings-list.md#setting-pg-audit-log) setting values. For more information, see [{#T}](../cluster-users.md#update-settings).

Audit logs will be available when [viewing cluster logs](../cluster-logs.md).


To learn more about the `pgaudit` extension, see the [official documentation](https://github.com/pgaudit/pgaudit/blob/master/README.md).
