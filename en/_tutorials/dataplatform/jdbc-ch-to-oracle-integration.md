With [{{ CH }} JDBC Bridge]({{ ch.docs }}{{ lang }}/integrations/jdbc/jdbc-with-clickhouse), you can:

* [Query a table](#jdbc-table-function) in an external Oracle database using the [JDBC table function]({{ ch.docs }}{{ lang }}/sql-reference/table-functions/jdbc).
* [Create {{ CH }} tables](#jdbc-table-engine) linked to corresponding tables in an external Oracle database, using the [JDBC table engine]({{ ch.docs }}{{ lang }}/engines/table-engines/integrations/jdbc).

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The solution support costs include:

* Fee for a {{ mch-name }} cluster: using computing resources allocated to hosts (including {{ ZK }} hosts) and disk space (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).
* NAT gateway fee if public access is not enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Fee for using public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Set up the infrastructure {#deploy-infrastructure}

1. [Create a security group](../../vpc/operations/security-group-create.md) and [configure it](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).

    Add the following egress rule:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `0-65535`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

    This rule allows all outgoing traffic, enabling {{ CH }} JDBC Bridge to connect to external databases such as Oracle.

1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md).

    When creating a cluster, specify the security group you prepared earlier.

    Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** and add the **jdbcBridge** option with the following configuration:

    * **Host**: Oracle database server’s IP address.
    * **Port**: `9019`.

1. If you do not plan to enable public access to your {{ mch-name }} cluster, create a [NAT gateway](../../vpc/operations/create-nat-gateway.md) for the subnet where your cluster will reside.

## Prepare the external Oracle database {#prepare-source}

{% note warning %}

In the commands below, all entities created for the Oracle database must be specified in uppercase, in accordance with [Oracle naming conventions](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/Database-Object-Names-and-Qualifiers.html#GUID-75337742-67FD-4EC0-985F-741C93D918DA).

{% endnote %}

1. Make sure the host where your Oracle database is installed allows connection on ports `9019` and `1521`.

1. Connect to your Oracle host and download the [ojdbc8](https://mvnrepository.com/artifact/com.oracle.database.jdbc/ojdbc8) JDBC driver into the `/opt/drivers` directory:

    ```bash
    sudo mkdir -p /opt/drivers && \
    curl -s https://repo1.maven.org/maven2/com/oracle/database/jdbc/ojdbc8/ | grep -oP '(?<=href=")[0-9][^/]+(?=/")' | sort -V | tail -n1 | xargs -I{} sudo curl -o /opt/drivers/ojdbc8-{}.jar https://repo1.maven.org/maven2/com/oracle/database/jdbc/ojdbc8/{}/ojdbc8-{}.jar
    ```

1. Install [Docker Engine](https://docs.docker.com/engine/install/).

1. Run {{ CH }} JDBC Bridge:

    ```bash
    docker run -d --name jdbc_bridge --network host -v /opt/drivers:/app/drivers clickhouse/jdbc-bridge
    ```

    If your {{ CH }} JDBC Bridge container is already running, restart it to load the new drivers:

    ```bash
    docker container restart jdbc_bridge
    ```

1. Connect to the external Oracle database as [SYSDBA](https://docs.oracle.com/en/database/oracle/oracle-database/21/admin/getting-started-with-database-administration.html#GUID-79AB6187-1522-4EB7-8FAD-E4322262AC65). For a local connection, you can use SQL Plus:

    ```bash
    sqlplus / as sysdba
    ```

1. Switch to the target [Pluggable Database (PDB)](https://docs.oracle.com/en/database/oracle/oracle-database/21/cncpt/CDBs-and-PDBs.html#GUID-49C0C90D-5A72-4131-8C3D-B07341C75CB2), e.g., `PDB1`:

    ```sql
    ALTER SESSION SET CONTAINER = PDB1;
    ```

1. Create the `JDBC_USER` account for {{ mch-name }} cluster access:

    ```sql
    CREATE USER JDBC_USER IDENTIFIED BY <user_password>
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP
    QUOTA UNLIMITED ON USERS;
    ```

    Where `<user_password>` is your password for the `JDBC_USER` account.

    {% note tip %}

    To connect to different PDBs, create a [common user](https://docs.oracle.com/en/database/oracle/oracle-database/21/dbseg/managing-security-for-oracle-database-users.html#GUID-A1A3989E-D769-4FFB-9CF2-77175FCE0FE5) with a username prefixed by `C##`, e.g., `C##JDBC_USER`. 

    {% endnote %}

1. Grant permissions required for {{ CH }} JDBC Bridge to run:

    ```sql
    GRANT CONNECT, RESOURCE TO JDBC_USER;
    ```

1. Connect using the account you created:

    ```sql
    CONNECT JDBC_USER/<user_password>@<Oracle_DB_host>/PDB1;
    ```

    Where:

    * `<password>`: `JDBC_USER` password.
    * `<Oracle_DB_host>`: Oracle database server’s IP address.

1. Create a test table named `CUSTOMERS`:

    ```sql
    CREATE TABLE CUSTOMERS (
      NAME       VARCHAR2(100),
      EMAIL      VARCHAR2(100)
    );
    ```

1. Add test data:

    ```sql
    INSERT INTO CUSTOMERS (NAME, EMAIL) VALUES ('Angela Smith', 'angela@example.ru');
    INSERT INTO CUSTOMERS (NAME, EMAIL) VALUES ('Bob Johnson', 'bob@example.ru');
    INSERT INTO CUSTOMERS (NAME, EMAIL) VALUES ('Charlie Brown', 'charlie@example.ru');

    COMMIT;
    ```

1. Verify the data has been added successfully:

    ```sql
    SELECT * FROM CUSTOMERS;
    ```

## Query the data using the JDBC table function {#jdbc-table-function}

1. [Connect to the {{ mch-name }} cluster](../../managed-clickhouse/operations/connect/index.md).

1. Send a query to the external Oracle database using the JDBC table function:

    ```sql
    SELECT * FROM jdbc('jdbc:oracle:thin:JDBC_USER/<user_password>@<Oracle_DB_host>:1521/PDB1', 'SELECT * FROM CUSTOMERS');
    ```

    Where:

    * `<password>`: `JDBC_USER` password.
    * `<Oracle_DB_host>`: Oracle database server’s IP address.

    If successful, the query will return data from the external Oracle database.

## Create a table using the JDBC table engine {#jdbc-table-engine}

With the JDBC table engine, you can:

* Query data using the `SELECT` statement.
* Add new rows using the `INSERT INTO` statement, with the following limitations: 

    * The schema of the table in the {{ mch-name }} cluster database must exactly match the source table schema. 
    * The `INSERT INTO` operation is the only available method for writing data. Modifying existing data with statements such as `UPDATE`, `DELETE`, or `ALTER` is not supported.
    * The fields with auto-generated values, e.g., `DEFAULT`, `GENERATED BY`, `SYSDATE`, etc., will not be populated if you omit them during insertion.

To use the JDBC table engine:

1. [Connect to the {{ mch-name }} cluster](../../managed-clickhouse/operations/connect/index.md).

1. Create a table with the JDBC table engine that links to an external Oracle table.

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

    When creating the target table, you can specify only a subset of the source table’s fields. However, in this case you will not be able to use the `INSERT INTO` statement to add new rows.

1. Check the result:

    ```sql
    SELECT * FROM oracle_customers;
    ```

1. Insert a new row:

    ```sql
    INSERT INTO oracle_customers (NAME, EMAIL)
      VALUES ('Alice Wonderland', 'alice@example.ru');
    ```

    {{ CH }} JDBC Bridge opens and closes a transaction automatically. You do not need to execute the `COMMIT` statement.

1. Check the result again and compare it with the previous output:

    ```sql
    SELECT * FROM oracle_customers;
    ```

    If the insert operation is successful, the output will include the new row.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

* [Delete the {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-delete.md).
* [Delete the NAT gateway](../../vpc/operations/delete-nat-gateway.md).
