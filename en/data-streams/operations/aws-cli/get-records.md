# Reading data from a stream

{% list tabs %}

- CLI

  To get data from a [stream's](../../concepts/glossary.md#stream-concepts) _first_ shard, run the command:

  ```bash
  SHARD_ITERATOR=$(aws kinesis get-shard-iterator \
    --endpoint <endpoint> \
    --shard-id shard-000001 \ 
    --shard-iterator-type LATEST \ 
    --stream-name <stream_ID> \
    --query 'ShardIterator'| tr -d \")
  aws kinesis get-records \
    --endpoint <endpoint> \
    --shard-iterator $SHARD_ITERATOR
  ```

  Where:

  * `--endpoint`: To get stream data over the AWS Kinesis Data Streams protocol, specify `https://yds.serverless.yandexcloud.net`.

  * `--stream-name`: Consists of the availability zone, the folder ID, the {{ ydb-full-name }} database ID, and the stream name.

     > For example, specify the stream ID `/{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream` if:
     >* `aws_stream`: Stream name.
     >* `{{ region-id }}`: Availability zone.
     >* `aoeu1kuk2dhtaupdb1es`: Folder ID.
     >* `cc8029jgtuabequtgtbv`: {{ ydb-short-name }} database ID.

  Command example:

  ```bash
  SHARD_ITERATOR=$(aws kinesis get-shard-iterator \
    --endpoint https://yds.serverless.yandexcloud.net \ 
    --shard-id shard-000001 \
    --shard-iterator-type LATEST \ 
    --stream-name /{{ region-id }}/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream 
    --query 'ShardIterator'| tr -d \")
  aws kinesis get-records \ 
    --endpoint https://yds.serverless.yandexcloud.net \
    --shard-iterator $SHARD_ITERATOR
  ```

  Result example:

  ```json
  {
    "Records": [
        {
            "SequenceNumber": "0",
            "Data": "eyJ1c2VyX2lkIjoidXNlcjEiLCJzY29yZSI6MTAwfQ==",
            "PartitionKey": "1"
        },
        {
            "SequenceNumber": "1",
            "Data": "eyJ1c2VyX2lkIjoidXNlcjEiLCJzY29yZSI6MTAwfQ==",
            "PartitionKey": "1"
        },
    ...
  }
  ```

  In the example above, the data output in the `Data` field are BASE64-encoded. If you decode it, the following string is returned:

  ```json
    {"user_id":"user1","score":100}
  ```

{% endlist %}
