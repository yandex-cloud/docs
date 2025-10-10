# Data transfer

In YDB, a transfer is an asynchronous mechanism that moves data from a [topic]({{ ydb.docs }}/concepts/glossary#topic) to a [table]({{ ydb.docs }}/concepts/glossary#table). A transfer instance is [created]({{ ydb.docs }}/yql/reference/syntax/create-transfer), [edited]({{ ydb.docs }}/yql/reference/syntax/alter-transfer), and [deleted]({{ ydb.docs }}/yql/reference/syntax/drop-transfer) using YQL. A transfer runs inside the database in background mode. It serves the function of supplying data from a topic to a table.

In {{ ydb-name }}, transfers are only available in the [dedicated](serverless-and-dedicated.md#dedicated) database operating mode. An use case of creating a transfer that moves data within the same database is described in the article titled [Transfer: quick start]({{ ydb.docs }}/recipes/transfer/quickstart).

A transfer can read data from topics located either in the same [database]({{ ydb.docs }}/concepts/glossary#database) the transfer is created in or in another {{ ydb-short-name }} database or {{ ydb-short-name }} [cluster]({{ ydb.docs }}/concepts/glossary#cluster). If you need to read a topic from another database, you must specify its connection parameters when creating a transfer. The target table must always reside in the database the transfer itself is created in.

To read a topic from another {{ ydb-name }} database in {{ yandex-cloud }}, there is support for authorization via [{{ iam-name }}](../../iam/index.yaml).

## Creating a transfer to read data from another {{ ydb-name }} database in {{ yandex-cloud }} {#other-database}

### Prepare an API key to access the topic

{% note info %}

You should follow the steps to prepare an API key in the same cloud the source topic database is in.

{% endnote %}

1. [Create a service account](../../iam/operations/sa/create.md) where the topic is located.
1. [Assign the following roles to the service account](../../iam/operations/sa/assign-role-for-sa.md):
   * To read from the data stream: `ydb.viewer`.
   * To automatically add a [reader]({{ ydb.docs }}/concepts/glossary#consumer), if applicable: `ydb.admin`.
1. [Create an API key](../../iam/operations/authentication/manage-api-keys.md) with the `yc.ydb.topics.manage` scope.

### Create a secret to access the topic in the source database

Add the secret in the cloud you are going to create your transfer in:

```yql
CREATE OBJECT example_secret (TYPE SECRET) WITH value="ApiKey <your_api_key>";
```

Where:

* `<your_api_key>`: API key you created earlier.

### Create a topic

Create a topic the transfer will be reading data from. You can do it using this SQL query:

```yql
CREATE TOPIC `transfer_recipe/source_topic`;
```

The `transfer_recipe/source_topic` topic allows transferring any unstructured data.

### Create a table

After you create the topic, create a table to receive data from `source_topic`. You can do it using this SQL query:

```yql
CREATE TABLE `transfer_recipe/target_table` (
  partition Uint32 NOT NULL,
  offset Uint64 NOT NULL,
  data String,
  PRIMARY KEY (partition, offset)
);
```

The `transfer_recipe/target_table` table has three columns:

* `partition`: ID of the topic [partition]({{ ydb.docs }}/concepts/glossary.md#partition) the message was received from.
* `offset`: [Sequence number]({{ ydb.docs }}/concepts/glossary.md#offset) that identifies the message within the partition.
* `data`: Message body.

### Create a transfer

After you create the topic and the table, you need to add a data transfer that will move your messages from the one to the other. You can do it using this SQL query:

```yql
$transformation_lambda = ($msg) -> {
    return [
        <|
            partition: $msg._partition,
            offset: $msg._offset,
            data: $msg._data
        |>
    ];
};
CREATE TRANSFER `transfer_recipe/example_transfer`
  FROM `transfer_recipe/source_topic` TO `transfer_recipe/target_table`
  USING $transformation_lambda
WITH (
    CONNECTION_STRING = '<endpoint>',
    TOKEN_SECRET_NAME = 'example_secret'
)
```

Where:

* `<endpoint>`: Endpoint of connection to the source database the topic is in. It has the following format: `grpcs://lb.etn952fh3eo2jd2mrIhK.ydb.mdb.yandexcloud.net:2135/?database=/global/b1gvcqr959dbmi0e5c1B/etn77atb9o1epqUsCGoY`. The endpoint appears in the Endpoint field on the Overview tab of the data stream page in the [management console]({{ link-console-main }}).
* `example_secret`: Secret you created earlier.

### Test the transfer

To test the transfer for correct operation, write several messages into the topic.

Some time after the messages are added to source_topic, the relevant records will appear in transfer_recipe/target_table. To check this, run the following SQL query:

```yql
SELECT *
FROM `transfer_recipe/target_table`;
```

## See also

* [Transfer]({{ ydb.docs }}/concepts/transfer)
* [Transfer: quick start]({{ ydb.docs }}/recipes/transfer/quickstart)
* [Transfer: delivering NGINX access logs into a table]({{ ydb.docs }}/recipes/transfer/nginx)
* [CREATE TRANSFER]({{ ydb.docs }}/yql/reference/syntax/create-transfer)
* [ALTER TRANSFER]({{ ydb.docs }}/yql/reference/syntax/alter-transfer)
* [DROP TRANSFER]({{ ydb.docs }}/yql/reference/syntax/drop-transfer)