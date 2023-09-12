# Error saving an SQL dump of a database from a Managed Service for MySQL cluster using mysqldump

## Issue description {#issue-description}

When you try to save a dump using a mysqldump, you get the error:

```
mysqldump: Couldn't execute 'FLUSH TABLES': Access denied;
you need (at least one of) the RELOAD or FLUSH_TABLES privilege(s) for this operation (1227)
```

## Solution {#issue-resolution}

Some `mysqldump` releases, starting from version 8.0.32, have a [developer-confirmed bug](https://bugs.mysql.com/bug.php?id=109685): the `--single-transaction` option uses the `FLUSH TABLES WITH READ LOCK` command, even if you omit the `--flush-logs` or `--source-data` keys in the utility startup options.

To fix this error, update the `mysqldump` utility to version 8.0.33 (or higher).
