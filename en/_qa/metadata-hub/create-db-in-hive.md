The error occurs if you use the following syntax to create a database:

```sql
CREATE DATABASE IF NOT EXISTS <DB_name>;
```

**Solution**
{{ metastore-name }} does not allow creating a database or table in Hive: they are stored in a [{{ objstorage-full-name }} bucket](../../storage/concepts/bucket.md) linked to a {{ dataproc-name }} cluster. To create a database, use the following syntax:

```sql
CREATE DATABASE IF NOT EXISTS <DB_name> LOCATION <DB_location>;
```

In the `LOCATION` parameter, specify the path to the bucket and the database in it in the following format: `s3a://<bucket_name>/<folder_name>/<DB_name>`. Specifying a folder is optional; however, objects will load into a folder faster than into the bucket root.