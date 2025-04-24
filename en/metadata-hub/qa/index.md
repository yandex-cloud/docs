---
title: '{{ metadata-hub-full-name }}. Troubleshooting'
description: How do I fix the error I get when creating a DB in {{ metastore-name }}? Find the answer to this and other questions in this article.
---

# Troubleshooting in {{ metadata-hub-name }}

This section describes issues you may encounter in the service and how to troubleshoot them.

* [{{ metastore-full-name }}](#metastore)
* [{{ schema-registry-full-name }}](#schema-registry-full-name)

## Troubleshooting in {{ metastore-full-name }} {#metastore}

### Error when creating a database in {{ metastore-full-name }} {#create-db-in-hive}

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

### No permission error when connecting a service account to the cluster {#attach-service-account}

{% include notitle [attach-sa-create-update](../../_qa/attach-sa-create-update.md) %}

## Troubleshooting in {{ schema-registry-full-name }} {#schema-registry-full-name}

### Error when adding or deleting optional parameters {#avoid-errors-while-evolving-schema}

If a `Confluent` [compatibility check policy](../concepts/compatibility-check-policy.md) is configured at the namespace level, the following errors may occur when adding or deleting optional parameters in the schema:

* `PROPERTY_ADDED_TO_OPEN_CONTENT_MODEL`.
* `PROPERTY_REMOVED_FROM_CLOSED_CONTENT_MODEL`.

**Solution**
The `Confluent` compatibility check policy is based on the Confluent Schema Registry standards and implements mathematically accurate compatibility checks. This policy does not allow adding or removing optional parameters in `object` fields, causing the errors mentioned above.

To add or delete optional parameters, select the `optional-friendly` JSON compatibility check policy in the [namespace](../operations/update-name-space.md). It is based on [using various content models](../concepts/schema-registry-content-model#optional-parameters-compatibility-solution) for the producer and the consumer, where only the producer schema is registered. The compatibility check involves converting the consumer schema from an open content model to a closed one and comparing it with the registered producer schemas. This enables you to add or remove optional parameters while maintaining full transitive compatibility.

