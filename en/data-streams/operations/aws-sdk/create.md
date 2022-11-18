# Creating a stream

{% list tabs %}

- Python

   Use the `create_stream` method to create a stream. When calling this method, specify the following parameters:
   * The name of a stream to create, for example, `example-stream`.
   * [ID of the folder](../../../resource-manager/operations/folder/get-id.md) in which the stream is created, for example, `aoeu1kuj2dhtaupdb5es`.
   * ID of an existing [serverless]{% if audience == "external" %}(../../../ydb/pricing/serverless.md){% else %}(https://cloud.yandex.com/en/docs/ydb/pricing/serverless){% endif %} {{ ydb-full-name }} database, for example, `cc8028jgtuabcqutgtbv`. For information about how to create a database, see [{{ ydb-short-name }} documentation]{% if audience == "external" %}(../../../ydb/quickstart.md#create-db){% else %}(https://cloud.yandex.com/en/docs/ydb/quickstart#create-db){% endif %}.
   * The number of shards, for example, `1`.

   To create a stream with the parameters specified above:

   1. Create a file named `stream_create.py` and copy the following code into it:

      ```python
      import boto3
      from pprint import pprint

      def create_stream(folder, database, stream_name, shard_count):
          client = boto3.client('kinesis', endpoint_url="https://yds.serverless.yandexcloud.net")
          response = client.create_stream(
            StreamName="/{{ region-id }}/{folder}/{database}/{stream}".format(folder=folder,
                                                                          database=database,
                                                                          stream=stream_name),
            ShardCount=shard_count
          )
          return response

      if __name__ == '__main__':
        create_stream_response = create_stream(
          folder="aoeu1kuj2dhtaupdb5es",
          database="cc8028jgtuabcqutgtbv",
          stream_name="example-stream",
          shard_count=1)
        print("The stream has been created successfully")
        pprint(create_stream_response)
      ```

   1. Run the program:

      ```bash
      python3 stream_create.py
      ```

      Result:

      ```text
      The stream has been created successfully
      {
        'ResponseMetadata': {
          'HTTPHeaders': {
            'connection': 'keep-alive',
            'content-length': '3',
            'content-type': 'application/json',
            'date': ''
            'GMT',
            'server': 'nginx/1.19.5'},
            'HTTPStatusCode': 200,
            'RetryAttempts': 0
          }
        }
      }
      ```

{% endlist %}