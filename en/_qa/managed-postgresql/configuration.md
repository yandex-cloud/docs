# Cluster configuration

#### Is the autovacuum setting enabled for all tables by default? {#autovacuum}

Yes, `AUTOVACUUM` is enabled for all tables by default.

Autovacuuming does not run at a specific time. Instead, it runs when a certain value specified in the [settings](../../managed-postgresql/concepts/settings-list.md#dbms-cluster-settings) is reached, for example, when the share of updated or deleted table records becomes equal to the **Autovacuum vacuum scale factor**.

For more information, see the [{{ PG }} documentation](https://www.postgresql.org/docs/11/runtime-config-autovacuum.html).

#### Which LC_COLLATE and LC_CTYPE values are set for databases by default? {#lc-default}

As databases are created, `LC_CTYPE=C` and `LC_COLLATE=C` are set by default. You can't change these settings for the database you create with clusters. However, you can [create a new database](../../managed-postgresql/operations/databases.md) and set the values you need for it.

#### Can I change the LC_COLLATE and LC_CTYPE values? {#lc-edit}

You cannot change locale settings after you create a database. You can:
* [Create](../../managed-postgresql/operations/databases.md#add-db) a new database with the desired settings.
* Set a sorting locale (`LC_COLLATE`) for elements of an existing database:
   * When calling a function:
      ```sql
      SELECT lower(t1 COLLATE "ru_RU.utf8") FROM test;
      ```
   * When creating and updating a table:
      ```sql
      CREATE TABLE test (t1 text COLLATE "ru_RU.utf8");
      ```

#### Can I change the DB owner? {#db-owner}

Once you create a database, you cannot change its owner.
