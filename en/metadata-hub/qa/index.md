---
title: '{{ metadata-hub-full-name }}. FAQ'
description: How do I fix the error I get when creating a DB in {{ metastore-name }}? Find the answer to this and other questions in this article.
---

# General questions about {{ metadata-hub-name }}

#### How do I fix the error I get when creating a database in {{ metastore-full-name }}? {#create-db-in-hive}

The error occurs if you use the following syntax to create a database:

```sql
CREATE DATABASE IF NOT EXISTS <DB_name>;
```

{{ metastore-name }} does not allow creating a database or table in Hive: they are stored in a [{{ objstorage-full-name }} bucket](../../storage/concepts/bucket.md) linked to a {{ dataproc-name }} cluster. To create a database, use the following syntax:

```sql
CREATE DATABASE IF NOT EXISTS <DB_name> LOCATION <DB_location>;
```

In the `LOCATION` parameter, specify the path to the bucket and the database in it in the following format: `s3a://<bucket_name>/<folder_name>/<DB_name>`. Specifying a folder is optional; however, objects will load into a folder faster than into the bucket root.
