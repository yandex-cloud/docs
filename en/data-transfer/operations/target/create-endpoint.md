# Creating a target endpoint

To create a target endpoint:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder to create an endpoint in.

  1. In the list of services, select **{{ data-transfer-name }}**.

  1. Click **Create endpoint**.

  1. In the window that opens, set the **Direction** field to **Target**.

  1. Enter the **Name** of the endpoint. Use lowercase Latin letters and numbers.

  1. (optional) Enter a **Description** of the endpoint.

  1. In the **Database** field, select the DBMS you want to transfer data to:

      {% cut "{{mmy-short-name}}" %}

      Under **Endpoint parameters**:
      - Specify the **ID of the cluster** you want to transfer data to.
      - Specify the **Replication user name**.
      - Enter the DB user **Password**.
      - Specify the **Database name** in the cluster.
      - (optional) In the **PEM certificate** field, click **Upload file**:
          - Upload the file or add the certificate body as text.
      - (optional) Specify the **Endpoint network interface** to connect through to the DB cluster.
      - (optional) Set **sql_mode**.
      - (optional) If necessary, select **Disable foreign key checks on target. Use FOREIGN_KEY_CHECKS=0**.

      {% endcut %}

      {% cut "{{mpg-short-name}}" %}

      Under **Endpoint parameters**, specify:
      - **ID of the cluster** you want to transfer data to.
      - **DB username**.
      - **DB user password**.
      - **Database name** in the cluster.
      - (optional) **Endpoint network interface** to connect through to the DB cluster.

      {% endcut %}

      {% cut "{{MY}}" %}

      Under **Endpoint parameters**:
      - Specify the **Database host** you want to transfer data to.
      - In the **Database port** field, set the port for connecting to the DBMS.
      - Enter the **Username**.
      - Enter the DB user **Password**.
      - Specify the **Database name** in the cluster.
      - (optional) In the **PEM certificate** field, click **Upload file**:
          - Upload the file or add the certificate body as text.
      - (optional) Specify the **Endpoint network interface** to connect through to the DB cluster.
      - (optional) Set **sql_mode**.
      - (optional) Select a value for the parameter **Disable foreign key checks on target. Use FOREIGN_KEY_CHECKS=0**.

      {% endcut %}

      {% cut "{{PG}}" %}

      Under **Endpoint parameters**, specify:
      - **DB host** you want to transfer data to.
      - **DB port** to connect to the DBMS.
      - **DB username**.
      - **DB user password**.
      - **Database name** in the cluster.
      - (optional) **Endpoint network interface** to connect through to the DB cluster.

      {% endcut %}

  1. Click **Create**.

{% endlist %}

