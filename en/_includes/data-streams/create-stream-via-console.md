{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create a data stream in.
   1. Select **{{ yds-full-name }}**.
   1. Click **Create stream**.
   1. Specify a [serverless](../../ydb/concepts/serverless-and-dedicated.md#serverless) {{ ydb-short-name }} database or [create](../../ydb/quickstart.md#create-db) a new one. If you chose to create a new database, click **Update** after creating it to update the list of databases.
   1. Enter the name of the stream. Naming requirements:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Specify the number of [data shards](../../data-streams/concepts/glossary.md#shard).

      {% note warning %}

      You can't reduce the number of shards for the created stream.

      {% endnote %}

   1. Set the maximum [shard throughput](../../data-streams/concepts/glossary.md#shard-thoughput). A stream's throughput is equal to the product of the number of shards by the throughput of each of them.
   1. Select a [pricing plan](../../data-streams/pricing.md).
   1. Select data storage settings:
      * Size limit: Specify the maximum data storage size.
      * Time limit: Specify the maximum [data retention time](../../data-streams/concepts/glossary.md#retention-time) for a stream.
   1. Click **Create**.

   Wait for the stream to start. Once the stream is ready for use, its status changes from `CREATING` to `ACTIVE`.

{% endlist %}