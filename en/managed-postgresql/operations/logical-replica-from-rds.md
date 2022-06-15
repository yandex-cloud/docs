# Creating a logical replica of Amazon RDS for PostgreSQL in {{ mpg-name }}

If you use Amazon RDS for PostgreSQL, you can create a copy of your data in {{ mpg-name }}.

## Settings for Amazon RDS for PostgreSQL {#amazon-set}

Available for Amazon RDS for PostgreSQL version 10.4 and higher.

{% note warning %}

The DB instance must have public access: `Public accessibility = yes`.

{% endnote %}

1. Set up logical replication.

   1. Set the parameter to `parameter group` of your DB instance:

      ```
      rds.logical_replication = 1
      ```

   1. Restart the cluster to apply the changes.

1. Create a separate user with the role `rds_replication`. To do this, execute the following statements on behalf of the user with the `rds_superuser` role:

   ```
   CREATE ROLE <user> WITH LOGIN PASSWORD <password>;
   GRANT rds_replication TO <user>;
   ```

1. Grant the `SELECT` privilege to all the replicated tables:

   ```
   GRANT SELECT ON <table>, <table2> TO <user>;
   ```

1. Create a publication:

   ```
   CREATE PUBLICATION pub FOR TABLE <table>, <table2>;
   ```

   {% note info %}

   We don't recommend using `FOR ALL TABLES` publications as you won't be able to edit the table list later.

   {% endnote %}


1. Add the `inbound` rule to [VPC security groups](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html).
   For example:

   ```
   protocol: tcp, port: 5432, source: 84.201.175.90/32
   ```

   Where `84.201.175.90` is a public IP address.

## Settings for {{ mpg-name }} {#mdb-pg-set}

{% note warning %}

The hosts must have public access.

{% endnote %}

1. To create a `subscription`, grant the `mdb_admin` role to the user:

   ```
   yc managed-postgresql user update {user_name} --grants mdb_admin --cluster-id {cluster_id}
   ```

1. On the {{ mpg-name }} cluster host, create a subscription with the Amazon RDS connection string:

   ```
   CREATE SUBSCRIPTION s_data_migration CONNECTION 'host=<Amazon RDS server address> port=<port> user=<username> sslmode=prefer dbname=<database name>' PUBLICATION pub;
   ```

To learn more about creating subscriptions, see the [documentation for {{ PG }}](https://www.postgresql.org/docs/10/sql-createsubscription.html).

## Using logical replication {#logical-replica-specific}

* Changes to the database schema and DDL are not replicated.

   First apply the new schema changes on the subscriber side and then on the publication side.

* Sequences are not replicated.

   When the table is replicated, the data in the `serial` columns or ID columns that is generated using sequences are also replicated. However, the sequence on the subscriber side will preserve its starting value.

   If you switch to the subscriber database, restart the sequence using the latest value:

   ```
   ALTER SEQUENCE serial RESTART WITH <new value>;
   ```

* When you create a subscription, data from the source tables is fully copied.

   To accelerate the copy process, only create the `primary key` indexes. Create all the other indexes after the copying is complete.

* If a table doesn't have the `primary key`, you'll get errors like:

   ```
   ERROR:  55000: cannot update table "t2" because it does not have a replica identity and publishes updates
   HINT:  To enable updating the table, set REPLICA IDENTITY using ALTER TABLE.
   ```

   To run `UPDATE` and `DELETE` replications on tables without the `primary key`, change `REPLICA IDENTITY`:

   ```
   alter table t2 replica identity full;
   ```

* In PostgreSQL version 10, the `TRUNCATE` command is not replicated.

   You can use `DELETE` instead.

* External tables are not replicated.
* To view errors relating to logical replication, see the {{ mpg-name }} logs.
* If you need to re-create a subscription, delete all data from the tables on the subscriber side to prevent `primary key` restriction errors.
