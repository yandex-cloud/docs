With [{{ CH }} JDBC Bridge](https://clickhouse.com/docs/integrations/jdbc/jdbc-with-clickhouse), you can:

* [Request data](#jdbc-table-function) from an external Oracle database table using the [JDBC table function](https://clickhouse.com/docs/sql-reference/table-functions/jdbc).
* Use the [JDBC table engine](https://clickhouse.com/docs/engines/table-engines/integrations/jdbc) to [create tables](#jdbc-table-engine) in {{ CH }} which reference a table in an external Oracle database.

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The solution support costs include:

* Fee for a {{ mch-name }} cluster: using computing resources allocated to hosts (including {{ ZK }} hosts) and disk space (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).
* NAT gateway fee if public access is not enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Fee for using public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Set up your infrastructure {#deploy-infrastructure}

1. [Create a security group](../../vpc/operations/security-group-create.md) and [configure it](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).

    Also add a rule for outgoing traffic:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `0-65535`
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

    This rule allows all outgoing traffic, enabling {{ CH }} JDBC Bridge to connect to external databases including Oracle.

1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md).

    When creating a cluster, specify the security group prepared earlier.

    Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** and add the **jdbcBridge** option with the following parameters:

    * **Host**: IP address of your Oracle database installation.
    * **Port**: `9019`.

1. If you do not use public access, create a [NAT gateway](../../vpc/operations/create-nat-gateway.md) for the subnet you want to create your {{ mch-name }} cluster in.

## Prepare the external Oracle database {#prepare-source}

{% note warning %}

In the command below, all entities created for the Oracle database are specified in uppercase according to the [Oracle naming rules](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/Database-Object-Names-and-Qualifiers.html#GUID-75337742-67FD-4EC0-985F-741C93D918DA).

{% endnote %}

1. Make sure your external Oracle database installation allows connection via ports `9019` and `1521`.

1. Connect to your external Oracle database installation and download the [ojdbc8](https://mvnrepository.com/artifact/com.oracle.database.jdbc/ojdbc8) JDBC driver into the `/opt/drivers` directory:

    ```bash
    sudo mkdir -p /opt/drivers && \
    curl -s https://repo1.maven.org/maven2/com/oracle/database/jdbc/ojdbc8/ | grep -oP '(?<=href=")[0-9][^/]+(?=/")' | sort -V | tail -n1 | xargs -I{} sudo curl -o /opt/drivers/ojdbc8-{}.jar https://repo1.maven.org/maven2/com/oracle/database/jdbc/ojdbc8/{}/ojdbc8-{}.jar
    ```

1. Install [Docker Engine](https://docs.docker.com/engine/install/).

1. Run {{ CH }} JDBC Bridge:

    ```bash
    docker run -d --name jdbc_bridge --network host -v /opt/drivers:/app/drivers clickhouse/jdbc-bridge
    ```

    If your container is already running, restart it to load the new drivers to {{ CH }} JDBC Bridge:

    ```bash
    docker container restart jdbc_bridge
    ```

1. Connect to the external Oracle database as an [administrator](https://docs.oracle.com/en/database/oracle/oracle-database/21/admin/getting-started-with-database-administration.html#GUID-79AB6187-1522-4EB7-8FAD-E4322262AC65). For example, you can use SQL Plus if you are connecting locally:

    ```bash
    sqlplus / as sysdba
    ```

1. Switch the session to the required [PDB](https://docs.oracle.com/en/database/oracle/oracle-database/21/cncpt/CDBs-and-PDBs.html#GUID-49C0C90D-5A72-4131-8C3D-B07341C75CB2), e.g., to `PDB1`:

    ```sql
    ALTER SESSION SET CONTAINER = PDB1;
    ```

1. Create a user named `JDBC_USER` for connection from the {{ mch-name }} cluster:

    ```sql
    CREATE USER JDBC_USER IDENTIFIED BY <user_password>
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP
    QUOTA UNLIMITED ON USERS;
    ```

    Where `<user_password>` is your password for the `JDBC_USER` user.

    {% note tip %}

    To connect to different PDBs, create a [common user](https://docs.oracle.com/en/database/oracle/oracle-database/21/dbseg/managing-security-for-oracle-database-users.html#GUID-A1A3989E-D769-4FFB-9CF2-77175FCE0FE5) by adding the `C##` prefix to the username, e.g., `C##JDBC_USER`. 

    {% endnote %}

1. Grant permissions required for {{ CH }} JDBC Bridge to run:

    ```sql
    GRANT CONNECT, RESOURCE TO JDBC_USER;
    ```

1. Connect as the new user:

    ```sql
    CONNECT JDBC_USER/<user_password>@<Oracle_DB_host>/PDB1;
    ```

    Where:

    * `<password>`: `JDBC_USER` user password.
    * `<Oracle_DB_host>`: IP address of your Oracle database installation.

1. Create a test table named `CUSTOMERS`:

    ```sql
    CREATE TABLE CUSTOMERS (
      NAME       VARCHAR2(100),
      EMAIL      VARCHAR2(100)
    );
    ```

1. Add the test data:

    ```sql
    INSERT INTO CUSTOMERS (NAME, EMAIL) VALUES ('Angela Smith', 'angela@example.ru');
    INSERT INTO CUSTOMERS (NAME, EMAIL) VALUES ('Bob Johnson', 'bob@example.ru');
    INSERT INTO CUSTOMERS (NAME, EMAIL) VALUES ('Charlie Brown', 'charlie@example.ru');

    COMMIT;
    ```

1. Make sure the data has been written:

    ```sql
    SELECT * FROM CUSTOMERS;
    ```

## Query data using the JDBC table function {#jdbc-table-function}

1. [Connect to the {{ mch-name }} cluster](../../managed-clickhouse/operations/connect/index.md).

1. Run a query to the external Oracle database using the JDBC table function:

    ```sql
    SELECT * FROM jdbc('jdbc:oracle:thin:JDBC_USER/<user_password>@<Oracle_DB_host>:1521/PDB1', 'SELECT * FROM CUSTOMERS');
    ```

    Where:

    * `<password>`: `JDBC_USER` user password.
    * `<Oracle_DB_host>`: IP address of your Oracle database installation.

    If the query is successful, you will get data from the external Oracle database.

## Create a table using the JDBC table engine {#jdbc-table-engine}

With the JDBC table engine, you can:

* Query data via `SELECT`.
* Add new values via `INSERT INTO` with the following limitations: 

    * The table in the {{ mch-name }} cluster database must exactly mirror the structure of the table it references. 
    * The only available write operation is `INSERT INTO`. You cannot use `UPDATE`, `DELETE`, `ALTER`, or other statements to modify the existing data.
    * If you add new records and do not specify their values for fields with automatic generation (`DEFAULT`, `GENERATED BY`, `SYSDATE`, etc.), these values will not be generated.

To use the JDBC table engine:

1. [Connect to the {{ mch-name }} cluster](../../managed-clickhouse/operations/connect/index.md).

1. Create a table with the JDBC table engine based on the table from the external Oracle database.

    ```sql
    CREATE TABLE oracle_customers
    ENGINE = JDBC(
      'jdbc:oracle:thin:JDBC_USER/<user_password>@<Oracle_DB_host>:1521/XEPDB1',
      'JDBC_USER',
      'CUSTOMERS'
    )
    AS SELECT *
    FROM jdbc(
      'jdbc:oracle:thin:JDBC_USER/<user_password>@<Oracle_DB_host>:1521/XEPDB1',
      'JDBC_USER',
      'SELECT * FROM CUSTOMERS'
    )
    LIMIT 0;
    ```

    You can also create a table specifying only some fields, but in this case you will not be able to add new values via `INSERT INTO`.

1. Check the result:

    ```sql
    SELECT * FROM oracle_customers;
    ```

1. Insert a new row:

    ```sql
    INSERT INTO oracle_customers (NAME, EMAIL)
      VALUES ('Alice Wonderland', 'alice@example.ru');
    ```

    {{ CH }} JDBC Bridge automatically opens and closes a transaction. You do not need to execute `COMMIT` separately.

1. Check the result again and compare it with the previous output:

    ```sql
    SELECT * FROM oracle_customers;
    ```

    If the insertion was successful, you will see a new row in the returned output.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

* [Delete the {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-delete.md).
* [Delete the NAT gateway](../../vpc/operations/delete-nat-gateway.md).
