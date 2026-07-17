* **Host name**: Specify the path to a master host or a {{ MY }} master host IP address. You can specify multiple hosts in a comma-separated list. If you fail to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
* **Port**: Specify the {{ MY }} connection port. The default port is 3306.
* **Path to database**: Specify the database name.
* **Username**: Specify a username for the {{ MY }} connection.
* **Password**: Specify a password for the user.
* **Cache TTL in seconds**: Specify cache TTL or leave the default value. The recommended value is 300 seconds (5 minutes).

{% include [datalens-db-sql-level](./datalens-db-connection-sql-level-3.md) %}