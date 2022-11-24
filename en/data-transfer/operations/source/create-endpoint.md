# Creating a source endpoint

To create a source endpoint:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder to create an endpoint in.

  1. In the list of services, select **{{ data-transfer-name }}**.

  1. Click **Create endpoint**.

  1. In the window that opens, make sure that the **Direction** field is set to **Source**.

  1. Enter the **Name** of the endpoint. Use lowercase Latin letters and numbers.

  1. (optional) Enter a **Description** of the endpoint.

  1. In the **Database** field, select the DBMS to transfer data from.

      {% cut "{{mmy-short-name}}" %}

      Under **Endpoint parameters**, specify:
      - **ID of the cluster** to transfer data from.
      - **Database name** in the cluster.
      - **DB username**.
      - **DB user password**.
      - (optional) **ID of the replication slot** to connect to the DB cluster.
      - (optional) **White list of tables**. If set, data is only transferred from whitelisted tables.
      - (optional) **Black list of tables**. Data from blacklisted tables isn't transferred.
      - (optional) **Database time zone** in UTC.
      - (optional) **ID of the subnet** to connect through to the DB cluster.

      {% endcut %}

      {% cut "{{mpg-short-name}}" %}

      Under **Endpoint parameters**:
      - In the **Cluster ID** field, enter the ID of the cluster you want to transfer data from.
      - Specify the **Database name** in the cluster.
      - Specify the DB **Username**.
      - Enter the DB user **Password**.
      - (optional) Add tables to the **White list of tables**. If set, data is only transferred from whitelisted tables.
      - (optional) Add tables to the **Black list of tables**. Data from blacklisted tables isn't transferred.
      - (optional) Specify the **ID of the PostgreSQL replication slot** to connect to the DB cluster.
      - (optional) Set the **Maximum WAL size per replication slot**.
      - (optional) In the **Target DB schema to create a __consumer_keeper dummy table in** field, enter the name of the storage schema.
      - (optional) If necessary, select the **Merge inherited tables** option to merge the contents of tables.
      - (optional) Specify the **Endpoint network interface** to connect through to the DB cluster.

      {% endcut %}

      {% cut "{{MY}}" %}

      Under **Endpoint parameters**, specify:
      - **IP or FQDN of the host** to transfer data from.
      - **DB port** to connect to the DBMS.
      - **Database name** in the cluster.
      - **DB username**.
      - **DB user password**.
      - (optional) **ID of the replication slot** to connect to the DB cluster.
      - (optional) **White list of tables**. If set, data is only transferred from whitelisted tables.
      - (optional) **Black list of tables**. Data from blacklisted tables isn't transferred.
      - (optional) In the **PEM certificate** field, click **Upload file** and upload the [PEM certificate](../../../managed-mysql/operations/connect.md#Configuring-an-SSL-certificate) to encrypt the data you transfer.
      - (optional) **Database time zone** in UTC.
      - (optional) **ID of the subnet** to connect through to the DB cluster.

      {% endcut %}

      {% cut "{{PG}}" %}

      Under **Endpoint parameters**:
      - In the **Host IP or FQDN** field, enter the IP address or domain name of the host to transfer data from.
      - In the **Database port** field, set the port for connecting to the DBMS.
      - Specify the **Database name** in the cluster.
      - Specify the DB **Username**.
      - Enter the DB user **Password**.
      - (optional) Add tables to the **White list of tables**. If set, data is only transferred from whitelisted tables.
      - (optional) Add tables to the **Black list of tables**. Data from blacklisted tables isn't transferred.
      - (optional) Specify the **ID of the PostgreSQL replication slot** to connect to the DB cluster.
      - (optional) Set the **Maximum WAL size per replication slot**.
      - (optional) In the **Target DB schema to create a __consumer_keeper dummy table in** field, enter the name of the storage schema.
      - (optional) If necessary, select the **Merge inherited tables** option to merge the contents of tables.
      - (optional) Specify the **Endpoint network interface** to connect through to the DB cluster.

      {% endcut %}

  1. Click **Create**.

{% endlist %}

