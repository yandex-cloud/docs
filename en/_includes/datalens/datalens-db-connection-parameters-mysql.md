* **Hostname**: Specify the path to a master host or a {{ MY }} master host IP address. You can specify multiple hosts in a comma-separated list. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
* **Port**: Specify the {{ MY }} connection port. The default port is 3306.
* **Path to database**: Specify the name of the database to connect to.
* **Username**. Specify the username for the {{ MY }} connection.
* **Password**: Enter the password for the user.
* **Cache TTL in seconds**: Specify the cache time-to-live or leave the default value. The recommended value is 300 seconds (5 minutes).
* **Raw SQL level**: Enables you to use an ad-hoc SQL query to [generate a dataset](../../datalens/dataset/settings.md#sql-request-in-datatset).