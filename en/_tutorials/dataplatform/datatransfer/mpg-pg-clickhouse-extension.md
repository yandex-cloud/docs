# Executing analytical queries in {{ mpg-full-name }} with processing in {{ mch-full-name }} using pg_clickhouse and {{ data-transfer-full-name }}

You can run analytical queries to data from [{{ mpg-full-name }}](../../../managed-postgresql/index.yaml) using [{{ mch-full-name }}](../../../managed-clickhouse/index.yaml) computing resources for query processing. To do this, the {{ mpg-name }} data is copied to {{ mch-name }} using [{{ data-transfer-full-name }}](../../../data-transfer/index.yaml). The data copied is then kept up-to-date. The `pg_clickhouse` extension is added to the {{ mpg-name }} database. Using this extension, external tables are created in {{ mpg-name }} with references to tables in {{ mch-name }}. You can work with external tables the same way as with ordinary tables. Analytical queries to external tables are run in {{ mpg-name }} and processed on the {{ mch-name }} side. After that, the result of these queries is returned to {{ mpg-name }}.

The `pg_clickhouse` extension is available in {{ mpg-name }} clusters of version `17` and higher.

To run analytical queries:

1. [Set up your infrastructure](#infra).
1. [Prepare your test data](#prepare-test-data).
1. [Prepare and activate your transfer](#prepare-transfer).
1. [Test the transfer](#check-transfer).
1. [Configure a connection to {{ mch-name }} and create external tables](#connect-clickhouse).
1. [Run analytical queries to external tables in {{ mpg-name }}](#execute-queries).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

* {{ mpg-name }} cluster: use of computing resources allocated to hosts, storage and backup size (see [{{ mpg-name }} pricing](../../../managed-postgresql/pricing.md)).
* {{ mch-name }} cluster: use of computing resources allocated to hosts, storage and backup size (see [{{ mch-name }} pricing](../../../managed-clickhouse/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-full-name }} pricing](../../../vpc/pricing.md)).
* Each transfer: use of computing resources and the number of transferred data rows (see [{{ data-transfer-name }} pricing](../../../data-transfer/pricing.md)).



## Set up your infrastructure {#infra}


{% include [public-access](../../../_includes/mdb/note-public-access.md) %}


1. [Create a cloud network](../../../vpc/operations/network-create.md) named `demo-network`.
    
    
    When creating a network, three subnets in different availability zones are created automatically.



1. In `demo-network`, [create a security group](../../../vpc/operations/security-group-create.md) named `mch-sg` for the {{ mch-name }} cluster and [add](../../../vpc/operations/security-group-add-rule.md) to the group the following rules required to connect to the cluster over the internet:
    
    * Rule for incoming traffic allowing connections on port `{{ port-mch-http }}`:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mch-http }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

    * Rule for incoming traffic allowing connections on port `{{ port-mch-cli }}`:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mch-cli }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

1. In `demo-network`, create a security group named `mpg-sg` for the {{ mpg-name }} cluster and add to the group the following rules:

    * Rule for incoming traffic allowing connections to the cluster over the internet:
         
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mpg }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.
    
    * Rule for outgoing traffic allowing connections to {{ mch-name }}:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mch-cli }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.


1. [Create a {{ mch-name }} cluster](../../../managed-clickhouse/operations/cluster-create.md) in any suitable configuration with the following settings:

    * **Network**: `demo-network`.
    
    
    * **Security group**: `mch-sg`.
    * Public access to hosts is enabled.
    

    * **Database**: `chdb`.
    * **Username**: `chuser`.

1. [Create a {{ mpg-name }} cluster](../../../managed-postgresql/operations/cluster-create.md) in any suitable configuration with the following settings:

    * **Version**: `17` or higher.
    * **Network**: `demo-network`.

    
    * **Security group**: `mpg-sg`.
    * Public access to hosts is enabled.


    * **Database**: `pgdb`.
    * **Username**: `pguser`.

1. In the {{ mpg-name }} cluster, [add](../../../managed-postgresql/operations/extensions/cluster-extensions.md#update-extensions) the `pg_clickhouse` extension to the `pgdb` database.

1. In the {{ mpg-name }} cluster, [assign](../../../managed-postgresql/operations/grant.md#grant-role) the following roles to the `pguser` user:

    * [mdb_replication](../../../managed-postgresql/concepts/roles.md#mdb-replication): To replicate data using {{ data-transfer-name }}.
    * [mdb_admin](../../../managed-postgresql/concepts/roles.md#mdb-admin): To connect to {{ mch-name }} via `pg_clickhouse`.


## Prepare your test data {#prepare-test-data}

1. [Connect to the {{ mpg-name }} cluster](../../../managed-postgresql/operations/connect/clients.md).
1. Create two tables named `customers` and `orders`:
        
    ```sql
    CREATE TABLE public.customers (
      id INT PRIMARY KEY,
      name TEXT NOT NULL,
      city TEXT
    );

    CREATE TABLE public.orders (
      id INT PRIMARY KEY,
      customer_id INT NOT NULL,
      amount NUMERIC(10, 2) NOT NULL,
      order_date DATE NOT NULL,
      status TEXT NOT NULL
    );
    ```

1. Populate the tables with data:

    ```sql
    INSERT INTO public.customers (id, name, city) VALUES
    (1, 'Anna', 'Volgograd'),
    (2, 'Ivan', 'Novosibirsk'),
    (3, 'Victoria', 'Voronezh'),
    (4, 'Boris', 'Krasnodar'),
    (5, 'Maria', 'Nizhny Novgorod');

    INSERT INTO public.orders (id, customer_id, amount, order_date, status) VALUES
    (1, 1, 1500.00, '2024-03-01', 'new'),
    (2, 2, 2300.50, '2024-03-02', 'new'),
    (3, 1, 999.99, '2024-03-03', 'completed'),
    (4, 3, 4500.00, '2024-03-04', 'shipped'),
    (5, 4, 1200.75, '2024-03-05', 'new'),
    (6, 5, 3100.25, '2024-03-06', 'shipped'),
    (7, 2, 1750.00, '2024-03-07', 'completed'),
    (8, 3, 800.00, '2024-03-08', 'new'),
    (9, 4, 5500.99, '2024-03-09', 'shipped'),
    (10, 5, 2200.00, '2024-03-10', 'completed');
    ```


## Prepare and activate a transfer {#prepare-transfer}

1. [Create a source endpoint](../../../data-transfer/operations/endpoint/index.md#create) with the following settings:
    
    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ PG }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
    * **Managed database cluster**: Name of the previously created {{ mpg-name }} cluster.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: `pgdb`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}**: `pguser`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}**: `pguser` password.

1. Create a target endpoint with the following settings:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `ClickHouse`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnectionType.managed.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}**: Name of the previously created {{ mch-name }} cluster.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: `chdb`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}**: `chuser`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}**: `chuser` password.

1. [Create a transfer](../../../data-transfer/operations/transfer.md#create) configured to use the new endpoints. As the transfer [type](../../../data-transfer/concepts/index.md#transfer-type), select **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}**.

1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate).

1. Wait for the transfer status to switch to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.


## Test the transfer {#check-transfer}

1. [Connect to the {{ mch-name }} cluster](../../../managed-clickhouse/operations/connect/clients.md).
1. Make sure the `customers` and `orders` tables have been created in the `chdb` database:
        
    ```sql
    SHOW TABLES FROM chdb;
    ```
    
1. Make sure the tables have been populated with data:
        
    ```sql
    SELECT * FROM customers;
        
    SELECT * FROM orders;
    ```

1. In the {{ mpg-name }} cluster, add an row to the `orders` table:
    
    ```sql
    INSERT INTO public.orders (id, customer_id, amount, order_date, status) VALUES
    (11, 1, 520.00, '2024-03-17', 'new');
    ```

1. Run this query in the {{ mch-name }} cluster to make sure the new row has been added to the `orders` table:
    
    ```sql
    SELECT * FROM orders;
    ```


## Configure a connection to {{ mch-name }} and create external tables {#connect-clickhouse}

1. [Connect to the {{ mpg-name }} cluster](../../../managed-postgresql/operations/connect/clients.md).
1. Create an external data source:
    
    ```sql
    CREATE SERVER chserver
    FOREIGN DATA WRAPPER clickhouse_fdw
    OPTIONS (
      driver 'binary',
      host 'c-<ID_of_Managed_Service_for_Clickhouse_cluster>.rw.mdb.yandexcloud.net',
      port '9440',
      dbname 'chdb'
    );
    ```

    You can get the cluster ID with the [list of clusters in the folder](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).

1. Create a mapping between a local user and a user in the external data source:
  
    ```sql
    CREATE USER MAPPING FOR CURRENT_USER
    SERVER chserver
    OPTIONS (
      user 'chuser',
      password '<password>'
    );
    ```

1. Create a schema:
    
    ```sql
    CREATE SCHEMA mch;
    ```

1. In your `mch` schema, create external tables with references to tables in the `chdb` database in {{ mch-name }}:

    ```sql
    IMPORT FOREIGN SCHEMA chdb
    FROM SERVER chserver
    INTO mch;
    ```

1. Make sure the external tables have been successfully created:
    
    ```sql
    SELECT *
    FROM information_schema.foreign_tables
    WHERE foreign_table_schema = 'mch';
    ```

    The output must contain the `customers` and `orders` tables.


## Run analytical queries to external tables in {{ mpg-name }} {#execute-queries}

1. For each city, get the number of orders and their total amount:
    
    ```sql
    SELECT
      c.city,
      COUNT(*) AS orders_count,
      SUM(o.amount) AS total_amount
    FROM mch.orders o
    JOIN mch.customers c
      ON o.customer_id = c.id
    GROUP BY c.city
    ORDER BY total_amount DESC;
    ```

1. Build a query execution plan to make sure it is being processed in {{ mch-name }}:

    ```sql
    EXPLAIN (VERBOSE, COSTS OFF)
    SELECT
      c.city,
      COUNT(*) AS orders_count,
      SUM(o.amount) AS total_amount
    FROM mch.orders o
    JOIN mch.customers c
      ON o.customer_id = c.id
    GROUP BY c.city
    ORDER BY total_amount DESC;
    ```

    If the query execution plan contains `Foreign Scan` or `Remote SQL`, it means that the query is being processed in {{ mch-name }}.

    Example of a query execution plan:

    ```text
    QUERY PLAN
    ----------
    Foreign Scan
      Output: c.city, (count(*)), (sum(o.amount))
      Relations: Aggregate on ((orders o) INNER JOIN (customers c))
      Remote SQL: SELECT r2.city, count(*), sum(r1.amount) FROM chdb.orders r1 ALL INNER JOIN chdb.customers r2 ON (((r1.customer_id = r2.id))) GROUP BY r2.city ORDER BY sum(r1.amount) DESC NULLS FIRST
    Query Identifier: -6142969501942783
    ```


## Delete the resources you created {#clear-out}


Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:


1. [Deactivate](../../../data-transfer/operations/transfer.md#deactivate) and [delete](../../../data-transfer/operations/transfer.md#delete) the transfer.
1. [Delete](../../../data-transfer/operations/endpoint/index.md#delete) the source and target endpoints.
1. [Delete the {{ mch-name }} cluster](../../../managed-clickhouse/operations/cluster-delete.md).
1. [Delete the {{ mpg-name }} cluster](../../../managed-postgresql/operations/cluster-delete.md).

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}