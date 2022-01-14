# Deleting a stream

{% list tabs %}

- CLI

  To delete a [stream](../../concepts/glossary.md#stream-concepts), run the command:

  ```bash
  aws kinesis delete-stream \
    --endpoint <endpoint> \
    --stream-name <stream_ID>
  ```

  * `--endpoint`: Specify the `https://yds.serverless.yandexcloud.net` endpoint to delete a stream that receives data over the AWS Kinesis Data Streams protocol.

  * `--stream-name`: Consists of the availability zone, the folder ID, the {{ ydb-full-name }} database ID, and the stream name.

     > For example, specify the stream ID `/ru-central1/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream` if:
     >* `aws_stream`: Stream name.
     >* `ru-central1`: Availability zone.
     >* `aoeu1kuk2dhtaupdb1es`: Folder ID.
     >* `cc8029jgtuabequtgtbv`: {{ ydb-short-name }} database ID.

  Command example:

  ```bash
  aws kinesis delete-stream \
    --endpoint https://yds.serverless.yandexcloud.net \
    --stream-name /ru-central1/aoeu1kuk2dhtaupdb1es/cc8029jgtuabequtgtbv/aws_stream
  ```

{% endlist %}
