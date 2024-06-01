### Exceeding the number of database connections {#conn-limit}

{{ PG }} has a [limit on the number of user connections](../../../../managed-postgresql/concepts/settings-list.md#setting-conn-limit) to the database. If this limit is exceeded for a transfer, the transfer will not work properly or work at all.

The **solution** is to configure the [number of user connections](../../../../data-transfer/concepts/work-with-endpoints.md#postgresql-connection-limit) to the database.
