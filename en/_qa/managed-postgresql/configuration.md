#### Is autovacuum enabled for all tables by default? {#autovacuum}

Yes, `AUTOVACUUM` is enabled for all tables by default.

Autovacuuming does not run at a specific time. Instead, it runs when a certain value specified in the [settings](../../managed-postgresql/concepts/settings-list.md#dbms-cluster-settings) is reached, for example, when the share of updated or deleted table records becomes equal to the **Autovacuum vacuum scale factor**.

For more information, see [this {{ PG }} guide](https://www.postgresql.org/docs/11/runtime-config-autovacuum.html).

#### What are the default values for LC_COLLATE and LC_CTYPE database settings? {#lc-default}

The default settings for new databases are `LC_CTYPE=C` and `LC_COLLATE=C`. You cannot change these settings for the database created alongside the cluster. However, you can [create a new database](../../managed-postgresql/operations/databases.md) and specify the required values for it.

#### Can I change the LC_COLLATE and LC_CTYPE values? {#lc-edit}

Once a database is created, you cannot change its locale settings. However, you can:
* [Create](../../managed-postgresql/operations/databases.md#add-db) a new database with the required settings.
* Specify the collation locale (`LC_COLLATE`) for the database objects:
   * When calling a function:
      ```sql
      SELECT lower(t1 COLLATE "ru_RU.utf8") FROM test;
      ```
   * When creating or altering a table:
      ```sql
      CREATE TABLE test (t1 text COLLATE "ru_RU.utf8");
      ```

#### Can I change the database owner? {#db-owner}

Once a database is created, you cannot change its owner. An attemp to change the owner of a database [created using {{ TF }}](../../managed-postgresql/operations/databases.md#add-db) by editing its `owner` setting will trigger the database recreation, resulting in data loss.
