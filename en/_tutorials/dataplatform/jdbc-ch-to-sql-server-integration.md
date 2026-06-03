With [{{ CH }} JDBC Bridge]({{ ch.docs }}{{ lang }}/integrations/jdbc/jdbc-with-clickhouse), you can:

* [Query a table](#jdbc-table-function) in an external Microsoft SQL Server database using the [JDBC table function]({{ ch.docs }}{{ lang }}/sql-reference/table-functions/jdbc).
* [Create {{ CH }} tables](#jdbc-table-engine) linked to corresponding tables in an external Microsoft SQL Server database, using the [JDBC table engine]({{ ch.docs }}{{ lang }}/engines/table-engines/integrations/jdbc).

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

    This rule allows all outgoing traffic, enabling {{ CH }} JDBC Bridge to connect to external databases such as Microsoft SQL Server.

1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md).

    When creating a cluster, specify the security group you prepared earlier.

    Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** and add the **jdbcBridge** option with the following configuration:

    * **Host**: Microsoft SQL Server IP address.
    * **Port**: `9019`.

1. If you do not plan to enable public access to your {{ mch-name }} cluster, create a [NAT gateway](../../vpc/operations/create-nat-gateway.md) for the subnet where your cluster will reside.

## Prepare the external Microsoft SQL Server database {#prepare-source}

1. Make sure the host where your Microsoft SQL Server database is installed allows connection on ports `9019` and `1433`.

1. Connect to your Microsoft SQL Server host and download the [JDBC driver](https://mvnrepository.com/artifact/com.microsoft.sqlserver/mssql-jdbc) into the `/opt/drivers` directory:

    ```bash
    sudo mkdir -p /opt/drivers && \
    curl -s https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/ | grep -oP '(?<=href=")[^"]+(?=/")' | grep 'jre8$' | grep -v 'preview' | sort -V | tail -n1 | xargs -I{} bash -c 'ver="{}"; file=$(curl -s https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/$ver/ | grep -oP "(?<=href=\")[^\"]+\.jar" | grep -vE "javadoc|sources" | head -n1); sudo curl -o /opt/drivers/$file https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/$ver/$file'
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

1. Create a file named `init.sql` with the following contents:

    ```sql
    CREATE LOGIN jdbc_user WITH PASSWORD = '<user_password>';
    GO
    CREATE DATABASE mydb;
    GO
    USE mydb;
    GO
    CREATE USER jdbc_user FOR LOGIN jdbc_user;
    GO
    ALTER ROLE db_owner ADD MEMBER jdbc_user;
    GO
    CREATE SCHEMA jdbc_schema AUTHORIZATION jdbc_user;
    GO
    ALTER USER jdbc_user WITH DEFAULT_SCHEMA = jdbc_schema;
    GO
    ```

    The `<user_password>` must be at at least eight characters long and contain at least three of the following four character types:

    * Uppercase letters
    * Lowercase letters
    * Numbers
    * Special characters

1. Execute the `init.sql` script via `sqlcmd` as the `SA` user:

    ```bash
    sqlcmd -S <Microsoft_SQL_Server_host> -U SA -P '<administrator_password>' -i init.sql
    ```

    Where:
    
    * `<Microsoft_SQL_Server_host>`: Microsoft SQL Server IP address.
    * `<administrator_password>`: `SA` password.

    The script will create the following entities:
    
    * `mydb` database
    * `jdbc_user` user
    * `jdbc_schema` schema

1. Connect using the `jdbc_user` account:

    ```bash
    sqlcmd -S <Microsoft_SQL_Server_host> -U jdbc_user -P '<user_password>' -i init.sql
    ```

1. Create a test dataset:

    ```sql
    CREATE TABLE Employees (
        Id INT PRIMARY KEY IDENTITY(1,1),
        Name NVARCHAR(100),
        Position NVARCHAR(100),
        Salary DECIMAL(10,2)
    );
    GO

    INSERT INTO Employees (Name, Position, Salary) VALUES
    ('Alice Johnson', 'Developer', 75000),
    ('Bob Smith', 'Manager', 90000),
    ('Charlie Rose', 'Analyst', 65000);
    GO

    SELECT * FROM Employees;
    GO
    ```

## Query the data using the JDBC table function {#jdbc-table-function}

1. [Connect to the {{ mch-name }} cluster](../../managed-clickhouse/operations/connect/index.md).

1. Send a query to the external Microsoft SQL Server database using the JDBC table function:

    ```sql
    SELECT * FROM jdbc('jdbc:sqlserver://<Microsoft_SQL_Server_DB_host>:1433;databaseName=mydb;user=jdbc_user;password=<user_password>;encrypt=false;', 'jdbc_schema', 'Employees')
    ```

    Where:

    * `<user_password>`: `jdbc_user` password.
    * `<Microsoft_SQL_Server_DB_host>`: Microsoft SQL Server IP address.

    If successful, the query will return data from the external Microsoft SQL Server database.

## Create a table using the JDBC table engine {#jdbc-table-engine}

With the JDBC table engine, you can query data using the `SELECT` statement. To use the JDBC table engine:

1. [Connect to the {{ mch-name }} cluster](../../managed-clickhouse/operations/connect/index.md).

1. Create a table with the JDBC table engine that links to an external Microsoft SQL Server table.

    ```sql
    CREATE TABLE mssql_employees
    (
        Id Int32,
        Name String,
        Position String,
        Salary Decimal(10, 2)
    )
    ENGINE = JDBC(
        'jdbc:sqlserver://<Microsoft_SQL_Server_DB_host>:1433;databaseName=mydb;user=jdbc_user;password=<user_password>;encrypt=false;',
        'jdbc_schema',
        'Employees'
    );
    ```

    You can create a table with only a subset of columns defined.

1. Check the result:

    ```sql
    SELECT * FROM mssql_employees;
    ```

    If created successfully, querying the table will return data from the external Microsoft SQL Server database.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

* [Delete the {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-delete.md).
* [Delete the NAT gateway](../../vpc/operations/delete-nat-gateway.md).
