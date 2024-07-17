# Getting {{ objstorage-full-name }} object query statistics with {{ yq-full-name }}


Get query statistics for {{ objstorage-name }} objects using [{{ yq-full-name }}](../../query/concepts/index.md).

{% note info %}

To get information on object queries, [enable logging](../operations/buckets/enable-logging.md#enable).

{% endnote %}

## Configuring connections in {{ yq-full-name }} {#yq}

1. Go to [{{ yq-full-name }}](https://yq.yandex.cloud).
1. Click **Create connection** to establish a [connection](../../query/concepts/glossary.md#connection) to the bucket containing the statistics. Fill in the fields as follows:
   1. In the **Name** field, specify a name for your connection, e.g., `bucket_logs_connection`.
   1. In the **Type** field, select **Object Storage**.
   1. In the **Bucket authentication** field, select **Private**.
   1. In the **Cloud and folder** field, select the cloud and folder storing object query statistics.
   1. In the **Bucket** field, select the bucket storing object query statistics.
   1. In the **Service account** field, select the [service account](../../iam/concepts/users/service-accounts.md) to use to access the bucket data.
   1. Click **Check**. If successful, click **Create**.
1. Go to the **Bindings** section and click **Create** to use the connection you created. Learn more about [data bindings](../../query/concepts/glossary.md#binding).
1. Fill in the following fields:
   1. In the **Type** field, select **Object Storage**.
   1. In the **Name** field, specify a name for your connection, e.g., `bucket_logs`.
   1. In the **Connection** field, specify the name of the connection you created at the previous step.
   1. Click **Automatically fill in settings for** and select **Object Storage Access Logs** from the drop-down list.
   1. In the **Path** field, specify the path to statistics data within the bucket. If statistics data is stored in the bucket's root directory, specify `/`.
   1. Click **Preview** to verify the settings are correct.
   1. Click **Create** to complete data binding creation.

## Getting query statistics {#request-stat}

### Basic query

```sql
SELECT `timestamp`, request_id, handler, object_key, status, request_time
FROM bucket_logs
LIMIT 100
```

This query will return 100 records of query statistics for {{ objstorage-full-name }} objects. You can remove the record limit and filter results using `WHERE`. Below you can see a few such scenarios.

### Retrieving queries by response code

```sql
SELECT `timestamp`, request_id, handler, object_key, status, request_time
FROM bucket_logs
WHERE status >= 400
```

### Searching for long-running queries

```sql
SELECT `timestamp`, request_id, handler, object_key, status, request_time
FROM bucket_logs
WHERE request_time >= 1000
```

### Average query processing time

The example uses the `AVG` aggregate function.

```sql
SELECT AVG(request_time) AS `avg` FROM bucket_logs
```

