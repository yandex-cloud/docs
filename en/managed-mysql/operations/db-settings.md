# Database setup

You can manage some database settings using {{ mmy-name }} interfaces.

## Setting SQL mode (sql_mode) {#sql-mode}

You can set or change the value of the [sql_mode](https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html) variable defining the SQL mode for the database. This operation restarts the cluster hosts.

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mmy-name }}**.
  1. Select the cluster and click **Edit cluster** in the top panel.
  1. Under **DBMS settings**, click **Settings**.
  1. In the list of the settings, locate the **Sql mode** parameter.
  1. Configure a set of SQL modes in the drop-down list. To restore default settings, click **Reset**.
  1. Click **Save** in the DBMS settings dialog box.
  1. Click **Save changes**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Set the SQL modes in the `--set` parameter, for example:

  ```bash
  $ {{ yc-mdb-my }} cluster update-config
       --cluster-name=<cluster name>
       --set '"sql_mode=NO_KEY_OPTIONS,NO_TABLE_OPTIONS"'
  ```

  Pay close attention to quotation marks: the entire string must constitute the parameter value, including `sql_mode=`.

  You can get the cluster name when you [list clusters in the folder](cluster-list.md).

- API

  Pass the `sqlMode` array in the new {{ MY }} configuration by making the [update](../api-ref/Cluster/update.md) query.

{% endlist %}

## Changing a character set and collation rules (CHARACTER SET, COLLATE) {#charset-collate}

To configure the database character settings, use the [ALTER DATABASE](https://dev.mysql.com/doc/refman/5.7/en/charset-database.html) command. To do this, you need to run a query on behalf of a user with the `ALL` or `ALTER` privilege for the applicable database, for example:

```sql
ALTER DATABASE dbname CHARACTER SET = 'utf8mb4' COLLATE = 'utf8mb4_unicode_ci';
```

To apply settings to the database tables along with the database, convert the tables with the same settings:

```sql
ALTER TABLE dbname.tablename CONVERT TO CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';
```

