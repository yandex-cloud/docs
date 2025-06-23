1. Open {{ websql-full-name }} [**Connections**]({{ websql-link }}).
1. In ![image](../../_assets/console-icons/folder-tree.svg) **Connections**, click ![image](../../_assets/console-icons/square-plus.svg).
1. In the bottom-left corner of the window that opens, click **External connection**.
1. **Name** the connection.
1. In the **Database type** field, select the database you need: {{ PG }}, {{ CH }}, {{ MY }}, {{ RD }}, {{ GP }}, {{ VLK }}, or {{ MG }}.
1. Under **Hosts**, configure the hosts:
    * Specify the database host FQDN and port number for connecting to the database.
    * For {{ CH }}, also specify the Native Protocol port and [shard](../../managed-clickhouse/operations/shards.md#list-shards) name.
    * (Optional) Enable TLS.

        If your company has a certification authority (CA), the certificate issued by the CA will be used by default. If the company has no CA, upload the server's TLS certificate.

1. Specify the **Username** you will use to connect to the database.
1. Enter the user **Password**.
1. List the **Databases** you want to connect to. You can only connect to existing databases. The user you specified must have access to them.
1. Click **Create**.
