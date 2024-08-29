* **Hostname**: Specify the path to a [master host](https://www.postgresql.org/docs/16/runtime-config-replication.html#RUNTIME-CONFIG-REPLICATION-PRIMARY) or a {{ PG }} master host IP address. You can specify multiple hosts in a comma-separated list. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
* **Port**: Specify the {{ PG }} connection port. In {{ yandex-cloud }}, the default port is 6432.
* **Path to database**: Specify the name of the database to connect to.
* **Username**: Specify the username for the {{ PG }} connection.
* **Password**: Enter the password for the user.
* **Cache TTL in seconds**: Specify the cache time-to-live or leave the default value. The recommended value is 300 seconds (5 minutes).
* **Raw SQL level**: Enables you to use an ad-hoc SQL query to [generate a dataset](../../datalens/concepts/dataset/settings.md#sql-request-in-datatset).
