# Getting data from external sources using named queries

You can use named queries to retrieve data from external systems through [PXF](../../../managed-greenplum/concepts/external-tables.md) in {{ GP }}.

A _named query_ is a prebuilt SQL query stored in the `mdb_toolkit.pxf_named_queries` table of the {{ GP }} cluster's system database. You specify the query name reference when creating an external table.

Named queries allow you to join tables and aggregate data in an external source when creating a view is not an option. With all computations performed externally, the cluster operates more efficiently.

Named queries can be used with data sources connected to a {{ GP }} cluster through a JDBC connector.

To get data from an external source using a named query:

1. [Prepare the test data](#prepare-data).
1. [Create an external data source](#create-jdbc-source).
1. [Create a named query](#create-named-query).
1. [Create an external table and get data from it](#create-ext-table).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* {{ GP }} cluster fee: Computing resources allocated to hosts, size of storage and backups (see [{{ mgp-name }} pricing](../../../managed-greenplum/pricing/index.md)).
* {{ mpg-full-name }} cluster fee: Computing resources allocated to hosts, size of storage and backups (see [{{ mpg-name }} pricing](../../../managed-postgresql/pricing.md)).
* Fee for hourly usage of NAT gateways and outgoing traffic they handle (see [{{ vpc-full-name }} pricing](../../../vpc/pricing.md)).
* Fee for using public IP addresses (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).


## Getting started {#before-you-begin}

Set up the infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create](../../../managed-greenplum/operations/cluster-create.md) a {{ GP }} cluster with any suitable configuration.
    
    1. In the {{ GP }} cluster [subnet](../../../vpc/concepts/network.md#subnet), [set up a NAT gateway](../../../vpc/operations/create-nat-gateway.md) and [create a security group](../../../vpc/operations/security-group-create.md) allowing all incoming and outgoing traffic from all addresses.

    1. [Create](../../../managed-postgresql/operations/cluster-create.md) a {{ mpg-name }} cluster with publicly available hosts.

    1. In the {{ mpg-name }} cluster subnet, [set up a NAT gateway](../../../vpc/operations/create-nat-gateway.md) and [create a security group](../../../vpc/operations/security-group-create.md) allowing all incoming and outgoing traffic from all addresses.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}
    1. Download the `pxf-named-queries-infrastructure.tf` [file](https://github.com/yandex-cloud-examples/yc-greenplum-pxf-named-queries/blob/main/pxf-named-queries-infrastructure.tf) to the working directory. This file describes:

         * Networks.
         * Subnets.
         * NAT gateways.
         * Security groups.
         * {{ GP }} cluster in {{ mgp-name }}.
         * {{ mpg-name }} cluster.

    1. Specify the following in the file:

         * `mgp_password`: {{ GP }} password.
         * `mgp_version`: {{ GP }} version.
         * `mpg_password`: {{ PG }} database user password.
         * `mpg_version`: {{ PG }} version.

    1. To verify that the config files are correct, run the command below:

         ```bash
         terraform validate
         ```

       {{ TF }} will show any errors found in your configuration files.

    1. Create an infrastructure:

       {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Prepare the test data {#prepare-data}

1. [Connect](../../../managed-postgresql/operations/connect.md#bash) to the {{ PG }} database.

1. Create a table named `customers` and populate it with test data:

   ```sql
   CREATE TABLE customers(id int, name text, city text);
   INSERT INTO customers VALUES (111, 'Benjamin', 'Chicago');
   INSERT INTO customers VALUES (222, 'Mary', 'New York');
   INSERT INTO customers VALUES (333, 'Paul', 'Boston');
   INSERT INTO customers VALUES (444, 'Peter', 'Denver');
   INSERT INTO customers VALUES (555, 'Natalie', 'Austin');
   ```

1. Check the result:

   ```sql
   SELECT * FROM customers;
   ```

   ```text
   id  |  name   |    city
   ----+---------+-------------
   111 | Benjamin   | Chicago
   222 | Mary   | New York
   333 | Paul   | Boston
   444 | Peter    | Denver
   555 | Natalie | Austin
   ```

1. Create a table named `orders` and populate it with test data:

   ```sql
   CREATE TABLE orders(customer_id int, amount int, year int);
   INSERT INTO orders VALUES (111, 12, 2018);
   INSERT INTO orders VALUES (222, 234, 2019);
   INSERT INTO orders VALUES (333, 34, 2018);
   INSERT INTO orders VALUES (444, 456, 2019);
   INSERT INTO orders VALUES (555, 56, 2021);
   ```

1. Check the result:

   ```sql
   SELECT * FROM orders;
   ```

   ```text
   customer_id | amount | year
   ------------+--------+------
           111 |     12 | 2018
           222 |    234 | 2019
           333 |     34 | 2018
           444 |    456 | 2019
           555 |     56 | 2021
   ```

## Create an external data source {#create-jdbc-source}

In the {{ GP }} cluster, [create an external data source](../../../managed-greenplum/operations/pxf/create-jdbc-source.md) with the following settings:

   * **Name**: `pgserver`.
   * **Driver**: `org.postgresql.Driver`.
   * **Url**: `jdbc:postgresql://c-<{{ PG }}_cluster_ID>.rw.{{ dns-zone }}:{{ port-mpg }}/<DB_name_in_{{ PG }}_cluster>`.
   * **User**: `<{{ PG }}_username>`.

   You can [get](../../../managed-postgresql/operations/cluster-list.md#list-clusters) the cluster ID with the list of clusters in the folder.

## Create a named query {#create-named-query}

To create a named query, add it to the `mdb_toolkit.pxf_named_queries` table:

1. [Connect](../../../managed-greenplum/operations/connect.md) to {{ GP }}.

1. Run this query:

   ```sql
   INSERT INTO mdb_toolkit.pxf_named_queries (pxf_profile, name, query) VALUES (
      'pgserver',
      'my_query',
      'SELECT c.name, o.year
      FROM customers c
      JOIN orders o ON c.id = o.customer_id;'
   );
   ```

   Where:

      * `pgserver`: Data source name.
      * `my_query`: Named query name.

   As an example of a named query, we will use one that joins the `customers` and `orders` tables by the `id = customer_id` field and returns the customer name (`c.name`) along with the year of their orders (`o.year`).

1. Check the result:

   ```sql
   SELECT * FROM mdb_toolkit.pxf_named_queries;
   ```

   ```text
   pxf_profile |    name     |              query
   ------------+-------------+--------------------------------------------
   pgserver    | my_query    | SELECT c.name, o.year                       
               |             |       FROM customers c                      
               |             |       JOIN orders o ON c.id = o.customer_id;
   ```

   The `query` column should contain the text of the named query.

## Create an external table and get data from it {#create-ext-table}

1. [Connect](../../../managed-greenplum/operations/connect.md) to {{ GP }}.

1. Create an external table named `pxf_named_query`. It will reference the data the named query retrieves from the `customers` and `orders` tables in the {{ PG }} DB:

   ```sql
   CREATE READABLE EXTERNAL TABLE pxf_named_query(name text, year int)
   LOCATION ('pxf://query:my_query?PROFILE=JDBC&SERVER=pgserver')
   FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');
   ```

   Learn more about the SQL syntax for creating external tables [here](../../../managed-greenplum/operations/pxf/create-table.md#sql-statement).


1. Get the data:

   ```sql
   SELECT * FROM pxf_named_query;
   ```

   Result:

   ```text
     name  | year
   --------+------
   Benjamin   | 2018
   Mary   | 2019
   Paul   | 2018
   Peter    | 2019
   Natalie | 2021
   ```

   {% note tip %}

   If the query fails and returns an error, wait a few minutes and try again. The changes may not have been applied yet.

   {% endnote %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Delete](../../../managed-greenplum/operations/cluster-delete.md) the {{ GP }} cluster.
   1. [Delete](../../../managed-postgresql/operations/cluster-delete.md) the {{ mpg-name }} cluster.
   1. [Delete](../../../vpc/operations/delete-nat-gateway.md) the NAT gateways.

- {{ TF }} {#tf}

   {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
