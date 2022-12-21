# Deleting a stream in AWS SDK

{% list tabs %}

- Python

  To delete a [stream](../../concepts/glossary.md#stream-concepts), use the `delete_stream` method. When calling this method, specify the following parameters:
  * The name of the stream to delete, for example, `example-stream`.
  * [ID of the folder](../../../resource-manager/operations/folder/get-id.md) to delete the stream from, for example, `aoeu1kuj2dhtaupdb5es`.
  * {{ ydb-full-name }} database ID with the stream, for example, `cc8028jgtuabcqutgtbv`.

  To delete a stream with the parameters specified above:

  1. Create a file named `stream_delete.py` and copy the following code into it:

     ```python
     import boto3
     from pprint import pprint

     def delete_stream(folder, database, stream_name):
       client = boto3.client('kinesis', endpoint_url="https://yds.serverless.yandexcloud.net")
       response = client.delete_stream(
         StreamName="/{{ region-id }}/{folder}/{database}/{stream}".format(folder=folder,
                                                                       database=database,
                                                                       stream=stream_name)
         )
         return response

     if __name__ == '__main__':
       delete_stream_response = delete_stream(
         folder="aoeu1kuj2dhtaupdb5es",
         database="cc8028jgtuabcqutgtbv",
         stream_name="example-stream")

         print("The stream has been deleted successfully")
         pprint(delete_stream_response)
      ```

  1. Run the program:

     ```bash
     python3 stream_delete.py
     ```

     Result:

     ```text
     The stream has been deleted successfully
     {
       'ResponseMetadata': {
         'HTTPHeaders': {
         'connection': 'keep-alive',
         'content-length': '3',
         'content-type': 'application/json',
         'date': ''
         'GMT',
         'server': 'nginx/1.19.5'
         },
       'HTTPStatusCode': 200,
       'RetryAttempts': 0
       }
     }
     ```

{% endlist %}