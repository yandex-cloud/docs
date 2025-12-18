# Fixing the `Must be superuser to create this extension` error


## Issue description {#issue-description}

You get the `Must be superuser to create this extension` error when:
- You are trying to install a PostgreSQL extension.
- You are restoring a database from dump using `pg_restore`. 

## Solution {#issue-resolution}

In {{ mpg-name }}, you do not get superuser permissions for the cluster security reasons. {{ mpg-name }} manages certain operations on its own; it also replicates data across hosts, where any user interference may cause the cluster to fail. You can view the full list of such limits [here](../../../managed-postgresql/concepts/sql-limits.md). 

Thus, you can only install extensions through the cloud console, CLI, or API. For the full list of supported extensions, see [this article](../../../managed-postgresql/operations/extensions/cluster-extensions.md) on managing extensions. 

### When the error appears when restoring the dump

For restoring from a **non-text archive**, follow the steps below: 

1\. Get the list of objects to restore:
  ```
  pg_restore -l <path to archive> > restore.list
  ```

2\. In the **restore.list** file you get, comment out or delete the lines that refer to `EXTENSIONS`, such as `CREATE EXTENSION ...`.

3\. Run recovery using the list you just edited:

```
pg_restore --use-list restore.list ...
```

To restore dump from a **text archive**, do the following:

1\. Check whether the dump has any requests for creating extensions:

```
grep "CREATE EXTENSION" dump.sql
```

2\. Copy the dump to a new file, and then comment out or delete all requests for creating extensions:

```
cp dump.sql dump_edited.sql
sed -i 's/CREATE EXTENSION/-- CREATE EXTENSION/g' dump_edited.sql
```

3\. Restore the dump:

```
psql -h <host> -p 6432 -U <user> -d <database> -f dump_edited.sql
```
