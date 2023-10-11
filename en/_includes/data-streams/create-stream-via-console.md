{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create a [data stream](../../data-streams/concepts/glossary.md#stream-concepts) in.
   1. Select **{{ yds-name }}**.
   1. Click **Create stream**.
   1. Specify the {{ ydb-full-name }} database or [create](../../ydb/quickstart.md#create-db) a new one. If you chose to create a new database, click **Update** after creating it to update the list of databases.
   1. Enter a name for the stream. The naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Specify the number of [data shards](../../data-streams/concepts/glossary.md#shard).

      {% note warning %}

      You cannot reduce the number of shards for the created stream.

      {% endnote %}

   1. Set the maximum [shard throughput](../../data-streams/concepts/glossary.md#shard-thoughput). A stream's throughput is equal to the product of the number of shards by the throughput of each of them.
   1. Select a [pricing mode](../../data-streams/pricing.md) (for [serverless databases](../../ydb/concepts/serverless-and-dedicated.md#serverless)).
   1. Select data storage settings:
      * Size limit: Specify the maximum data storage size.
      * Time limit: Specify the maximum [data retention time](../../data-streams/concepts/glossary.md#retention-time) for a stream.
   1. Click **Create**.

   Wait for the stream to start. Once the stream is ready for use, its status will change from `CREATING` to `ACTIVE`.

{% endlist %}
