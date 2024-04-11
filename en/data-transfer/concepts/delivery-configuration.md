# Data delivery guarantees

There are three data delivery strategies:

* **At-most-once**: Producer sends a message only once. If the consumer fails to receive the message, it will be irrevocably lost. The rate of data transmission is higher, but its delivery is not guaranteed.
* **At-least-once**: Producer keeps sending a message until its receipt is confirmed by the consumer. This strategy provides a full delivery guarantee, but may lead to message duplicates on the consumer side.
* **Exactly-once**: Producer keeps sending a message until its receipt is confirmed by the consumer. Once the message is delivered, the consumer handles it in a manner to avoid duplicate messages. This strategy provides a full delivery guarantee with no duplicate messages, but it requires more computing resources and is harder to implement.

For all consumer-producer pairs, {{ data-transfer-name }} supports the **At-least-once** data delivery strategy. The consumer writes all messages received from the producer to a database and sends a write confirmation to the producer. If, for some reason, the producer fails to receive the write confirmation from the consumer, it will resend the message to it. This may result in duplicate data in the consumer database.

In this case, the **Exactly-once** strategy is implemented for DMBS-level data if the following two requirements are met:

* The table being delivered has a primary key.
* The consumer database deduplicates data by primary key:

   | Consumer | Deduplication by primary key |
   |-------------------------------------------------------------------------------|:-----------------------------------------------------------------:|
   | {{ KF }} topic: Your own or as part of the [{{ mkf-short-name }} service](../../managed-kafka/). | ![no](../../_assets/common/no.svg) |
   | {{ CH }} database: Your own or as part of the [{{ mch-short-name }} service](../../managed-clickhouse/) | ![no](../../_assets/common/no.svg) |
   | Your own {{ ES }} database | ![yes](../../_assets/common/yes.svg) |
   | {{ GP }} database: Your own or as part of the [{{ mgp-short-name }} service](../../managed-greenplum/) | ![yes](../../_assets/common/yes.svg) |
   | {{ MG }} database: Your own or as part of the [{{ mmg-short-name }} service](../../managed-mongodb/) | ![yes](../../_assets/common/yes.svg) |
   | {{ MY }} database: Your own or as part of the [{{ mmy-short-name }} service](../../managed-mysql/) | ![yes](../../_assets/common/yes.svg) |
   | {{ PG }} database: Your own or as part of the [{{ mpg-short-name }} service](../../managed-postgresql/) | ![yes](../../_assets/common/yes.svg) |
   | {{ OS }} database: Your own or as part of the [{{ mos-short-name }} service](../../managed-opensearch/) | ![yes](../../_assets/common/yes.svg) |
   | {{ ydb-name }} database: as part of the [{{ ydb-name }} service](../../ydb/). | ![yes](../../_assets/common/yes.svg) |
   | [{{ objstorage-full-name }}](../../storage/) bucket | ![no](../../_assets/common/no.svg) |
   |[{{ yds-full-name }}](../../data-streams/) data stream                                                    | ![no](../../_assets/common/no.svg) |

{% note tip %}

To perform background deduplication in the {{ CH }} consumer database, you can use the [ReplacingMergeTree engine](https://clickhouse.com/docs/ru/engines/table-engines/mergetree-family/replacingmergetree) that deduplicates data by sort key when merging data chunks. However, this engine does not guarantee that there are no duplicates on the consumer side at each point in time.

{% endnote %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
