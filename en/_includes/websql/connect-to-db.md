1. Go to the **Connection manager** (![image](../../_assets/console-icons/folder-tree.svg)) section and click ![image](../../_assets/console-icons/square-plus.svg) in the top-right corner.
1. Click **External connection**.
1. Specify the connection parameters:
   * **Database type**: Select {{ PG }}, {{ CH }}, or {{ MY }}.
   * **Database URL**: Specify the DB host address in `https://<address>` format.
   * **Port**: Specify the number of the port for connections.
   * **Database**: Enter the DB name.
   * **User** and **Password**: Enter the username and password to access the database.
   * **SSL certificate**: Enable this option if your cluster uses a secure SSL connection. The {{ websql-full-name }} certificate is used by default.
1. Click **Connect**.