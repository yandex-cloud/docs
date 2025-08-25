- **Hostname**: Specify the path to a master host or a {{ CH }} master host IP address. You can specify multiple hosts in a comma-separated list. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
- **HTTP interface port**: Specify the {{ CH }} connection port. The default port is 8443.
- **Username**: Specify the username for the {{ CH }} connection.

  {% include [datalens-db-note](datalens-db-note.md) %}

- **Password**: Enter the password for the user.
- **Cache TTL in seconds**: Specify the cache time-to-live or leave the default value. The recommended value is 300 seconds (5 minutes).

{% include [datalens-db-sql-level](./datalens-db-connection-sql-level.md) %}
