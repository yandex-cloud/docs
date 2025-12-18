# Resolving the `Access denied` error when saving an SQL dump of a database from a {{ mmy-name }} cluster using mysqldump  


## Issue description {#issue-description}

When trying to save a dump using `mysqldump`, you get this error:

```
mysqldump: Couldn't execute 'FLUSH TABLES': Access denied; 
you need (at least one of) the RELOAD or FLUSH_TABLES privilege(s) for this operation (1227)
```

## Solution {#issue-resolution}

Some `mysqldump` releases, starting from version 8.0.32, have a [developer-confirmed bug](https://bugs.mysql.com/bug.php?id=109685): the `--single-transaction` option uses the `FLUSH TABLES WITH READ LOCK` command even if you do not specify the `--flush-logs` or `--source-data` keys in the utility startup options.

To fix this error, update your `mysqldump` to version 8.0.33 or higher.