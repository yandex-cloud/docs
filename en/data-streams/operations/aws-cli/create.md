# Creating a stream in AWS CLI

{% list tabs %}

- CLI

  To create a [stream](../../concepts/glossary.md#stream-concepts), run the command:

  ```bash
  aws kinesis create-stream \
    --endpoint <endpoint> \
    --stream-name <stream_ID> \
    --shard-count <number_of_shards>
  ```

  * `--endpoint`: Specify the `https://yds.serverless.yandexcloud.net` endpoint to create a stream that will receive data over the AWS Kinesis Data Streams protocol.

  * `--stream-name`: Consists of the availability zone, the folder ID, the {{ ydb-full-name }} database ID, and the stream name.

     > For example, specify the stream ID `/{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream` if:
     >* `aws_stream`: Stream name.
     >* `{{ region-id }}`: Availability zone.
     >* `aoeu1kuk2dhtaupdb1es`: Folder ID.
     >* `cc8029jgtuabequtgtbv`: {{ ydb-short-name }} database ID.
  * `--shard-count`: The number of [stream shards](../../concepts/glossary.md#shard).

  {% note info %}

  Since you can't specify the data stream rate in Amazon Kinesis, all data streams are created with a shard throughput of 1 MB/s and a retention period of 24 hours for compatibility purposes.

  {% endnote %}

  Command example:

  ```bash
  aws kinesis create-stream \
    --endpoint https://yds.serverless.yandexcloud.net \
    --stream-name /{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream \
    --shard-count 1
  ```

{% endlist %}
