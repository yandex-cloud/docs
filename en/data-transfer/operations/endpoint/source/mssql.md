# Configuring a Microsoft SQL Server source endpoint

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, configure access to {{ MS }}.

## Settings {#settings}

{% list tabs %}

- Management console

   * **Host**: IP address or FQDN of the host you want to connect to.

   * **Port**: Port number {{ data-transfer-name }} will use for connections to the host.

   * **Database**: Name of the DB to connect to.

   * **Username**, **Password**: DB username and password.

   * **Replication method**: Replication method used to retrieve data from the database. `STANDARD` replication requires setup on the DB side, while it does not show data changes. `CDC` replication allows identifying data inserts, updates, and deletes.

   * **SSL method**: Encryption method used when exchanging data with the database:

      * `UNENCRYPTED`: Saving the password as plain text.

      * `ENCRYPTER (trust cert)`: Using a certificate from a trusted source.

      * `ENCRYPTER (verify cert)`: Using a self-signed certificate.

{% endlist %}

For more information about settings, see the [Airbyte® documentation](https://docs.airbyte.com/integrations/sources/mssql/).

{% include [airbyte-trademark](../../../../_includes/data-transfer/airbyte-trademark.md) %}
