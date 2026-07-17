Specify the external database credentials for connection over a public network:

* **Host name**: Specify the {{ TR }} coordinator path or IP address.
* **Port**: Specify the {{ TR }} connection port. The default port is 8443.
* **Username**: Specify a username for the {{ TR }} connection. If authentication is off, you can use any username as it will not affect the connection. The field value will be sent to the source with the queries.
* **Password**: If the `Password` authentication type was selected, specify the password for the user.
* **JWT**: If the `JWT` authentication type was selected, specify the [JWT](https://{{ lang }}.wikipedia.org/wiki/JSON_Web_Token).

{% include [datalens-db-sql-level-2](datalens-db-connection-sql-level-2.md) %}
