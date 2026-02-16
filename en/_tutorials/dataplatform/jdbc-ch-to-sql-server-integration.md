With [{{ CH }} JDBC Bridge](https://clickhouse.com/docs/integrations/jdbc/jdbc-with-clickhouse), you can:

* [Query data](#jdbc-table-function) from an external Microsoft SQL Server database table using the [JDBC table function](https://clickhouse.com/docs/sql-reference/table-functions/jdbc).
* Use the [JDBC table engine](https://clickhouse.com/docs/engines/table-engines/integrations/jdbc) to [create tables](#jdbc-table-engine) in {{ CH }} which reference a table in an external Microsoft SQL Server database.

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

    This rule allows all outgoing traffic, enabling {{ CH }} JDBC Bridge to connect to external databases including Microsoft SQL Server.

1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md).

    When creating a cluster, specify the security group prepared earlier.

    Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** and add the **jdbcBridge** option with the following parameters:

    * **Host**: IP address of your Microsoft SQL Server database installation.
    * **Port**: `9019`.

1. If you do not use public access, create a [NAT gateway](../../vpc/operations/create-nat-gateway.md) for the subnet you want to create your {{ mch-name }} cluster in.

## Prepare the external Microsoft SQL Server database {#prepare-source}

1. Make sure your external Microsoft SQL Server database installation allows connection via ports `9019` and `1433`.

1. Connect to your external Microsoft SQL Server database installation and download the [JDBC driver](https://mvnrepository.com/artifact/com.microsoft.sqlserver/mssql-jdbc) into the `/opt/drivers` directory:

    ```bash
    sudo mkdir -p /opt/drivers && \
    curl -s https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/ | grep -oP '(?<=href=")[^"]+(?=/")' | grep 'jre8$' | grep -v 'preview' | sort -V | tail -n1 | xargs -I{} bash -c 'ver="{}"; file=$(curl -s https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/$ver/ | grep -oP "(?<=href=\")[^\"]+\.jar" | grep -vE "javadoc|sources" | head -n1); sudo curl -o /opt/drivers/$file https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/$ver/$file'
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

    Where `<user_password>` must be at at least eight characters long and contain at least three of these four character types:

    * Uppercase letters
    * Lowercase letters
    * Numbers
    * Special characters

1. Execute the `init.sql` script via `sqlcmd` as the `SA` admin user:

    ```bash
    sqlcmd -S <Microsoft_SQL_Server_host> -U SA -P '<administrator_password>' -i init.sql
    ```

    Where:
    
    * `<Microsoft_SQL_Server_host>`: IP address of your Microsoft SQL Server installation.
    * `<administrator_password>`: `SA` admin account password.

    This script creates:
    
    * `mydb` database
    * `jdbc_user`
    * `jdbc_schema`

1. Connect as the new `jdbc_user` user:

    ```bash
    sqlcmd -S <Microsoft_SQL_Server_host> -U jdbc_user -P '<user_password>' -i init.sql
    ```

1. Create a set of test data:

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

## Query data using the JDBC table function {#jdbc-table-function}

1. [Connect to the {{ mch-name }} cluster](../../managed-clickhouse/operations/connect/index.md).

1. Send a query to the external Microsoft SQL Server database using the JDBC table function:

    ```sql
    SELECT * FROM jdbc('jdbc:sqlserver://<Microsoft_SQL_Server_DB_host>:1433;databaseName=mydb;user=jdbc_user;password=<user_password>;encrypt=false;', 'jdbc_schema', 'Employees')
    ```

    Where:

    * `<user_password>`: `jdbc_user` user password.
    * `<Microsoft_SQL_Server_DB_host>`: IP address of your Microsoft SQL Server database installation.

    If the query is successful, you will get data from the external Microsoft SQL Server database.

## Create a table using the JDBC table engine {#jdbc-table-engine}

With the JDBC table engine, you can query data via `SELECT`. To use the JDBC table engine:

1. [Connect to the {{ mch-name }} cluster](../../managed-clickhouse/operations/connect/index.md).

1. Create a table with the JDBC table engine based on the table from the external Microsoft SQL Server database.

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

    You can also create a table by specifying only some of the fields.

1. Check the result:

    ```sql
    SELECT * FROM mssql_employees;
    ```

    If the table was created correctly, the output will return data from the external Microsoft SQL Server database table.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

* [Delete the {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-delete.md).
* [Delete the NAT gateway](../../vpc/operations/delete-nat-gateway.md).
