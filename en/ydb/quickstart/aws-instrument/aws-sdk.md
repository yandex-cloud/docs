# Working with the AWS SDK

After you [set up the parameters](setup.md) to work with the AWS SDK, try to perform operations with a table via the AWS SDK for Python.

## Creating a table {#create}

To create a table named `Series`:

1. Create a file named `SeriesCreateTable.py` and copy the following code to it:

  ```python
  import boto3 # You should first install this module 
               # using the pip install boto3 command
  
  def create_series_table(ydb = None):
      if not ydb:
          ydb = boto3.resource('dynamodb', 
                                endpoint_url = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87mbaomkfvsleds/etn02g38m12h9r0cdivp")
  
      table = ydb.create_table(
          TableName = 'Series', # Series is the table name 
          KeySchema = [
              {
                  'AttributeName': 'series_id',
                  'KeyType': 'HASH'  # Partition key
              },
              {
                  'AttributeName': 'title',
                  'KeyType': 'RANGE'  # Sort key
              }
          ],
          AttributeDefinitions = [
              {
                  'AttributeName': 'series_id',
                  'AttributeType': 'N'
              },
              {
                  'AttributeName': 'title',
                  'AttributeType': 'S'
              },
          ],
          ProvisionedThroughput = {
              'ReadCapacityUnits': 10,
              'WriteCapacityUnits': 10
          } # This parameter is specified for databases with dedicated servers
      )
      return table
  
  if __name__ == '__main__':
      series_table = create_series_table()
      print("Table status:", series_table.table_status)
  ```

   {% note info %}

  The `ProvisionedThroughput` parameter is required for a Dedicated database configuration. For a Serverless database configuration, this parameter is not specified.

  {% endnote %}

  To work with your database, specify as the `endpoint_url` the Document API endpoint available on the Overview tab for your database in the [management console]({{ link-console-main }}).

  The example uses the `print` function from Python 3. To use this function in Python 2.6 and later, add the `from __future__ import print_function` line at the beginning of the file.

2. To start the program, run the command:

  ```
  python SeriesCreateTable.py
  ```

  Execution result:

  ```
  Table status: ACTIVE
  ```

## Adding an entry {#add}

To add a new entry to the table:

1. Create a file named `SeriesCreateItem.py` and copy the following code to it:

  ```python
  from pprint import pprint
  import boto3
  
  def put_serie(series_id, title, release_date, series_info, ydb = None):
      if not ydb:
          ydb = boto3.resource('dynamodb', 
                                endpoint_url = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87mbaomkfvsleds/etn02g38m12h9r0cdivp")
  
      table = ydb.Table('Series')
      response = table.put_item(
        Item = {
              'series_id': series_id,
              'title': title,
              'info': {
                  'release_date': release_date,
                  'series_info': series_info
               }
          }
      )
      return response
  
  if __name__ == '__main__':
      serie_resp = put_serie(3, "Supernatural", "2015-09-13",
                            "Supernatural is an American television series created by Eric Kripke")
      print ("Series added:")
      pprint(serie_resp, sort_dicts = False)
  ```

  {% note info %}

  * The primary key is required. In this example, an entry with the primary key (`series_id`, `title`) and the `info` attribute is added. The `info` attribute contains additional information about the series.
  * The `DecimalEncoder` class is used to output numbers stored using the `Decimal` class. In the Boto SDK, the `Decimal` class stores YDB numeric values.

  {% endnote %}

1. To start the program, run the command:

  ```
  python SeriesCreateItem.py
  ```

  Execution result:

  ```
  The series has been added:
  {'ResponseMetadata': {'HTTPStatusCode': 200,
                        'HTTPHeaders': {'content-type': 'application/x-amz-json-1.0',
                                        'x-amz-crc32': '2745614147',
                                        'x-request-id': '92a5fafe-169c-48e8-8071-4f8c8cca7004',
                                        'date': 'Sat, 26 Dec 2020 17:21:01 GMT',
                                        'content-length': '2'},
                        'RetryAttempts': 0}}
  ```

## Reading entries {#read}

To read data written to the table, use the `get_item` method that passes the primary key of the desired item.

To read a table entry:

1. Create a file named `SeriesReadItem.py` and copy the following code to it:

  ```python
  from pprint import pprint
  import boto3
  from botocore.exceptions import ClientError
  
  def get_serie(title, series_id, ydb = None):
      if not ydb:
          ydb = boto3.resource('dynamodb', 
                                endpoint_url = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87mbaomkfvsleds/etn02g38m12h9r0cdivp")
  
      table = ydb.Table('Series')
  
      try:
          response = table.get_item(Key = {'series_id': series_id, 'title': title})
      except ClientError as e:
          print(e.response['Error']['Message'])
      else:
          return response['Item']
  
  
  if __name__ == '__main__':
      serie = get_serie("Supernatural", 3,)
      if serie:
          print("Item received:")
          pprint(serie, sort_dicts=False)
  ```

1. To start the program, run the command:

  ```
  python SeriesReadItem.py
  ```

  Execution result:

  ```
  Item received:
  {'series_id': Decimal('3'),
  'title': ' Supernatural,
  'info': {'release_date': 2015-09-13',
            'series_info': 'Supernatural is an American television series '
                           'created by Eric Kripke'}}
  ```

## Deleting a table {#delete}

{% note warning %}

Deleting a table is an irreversible operation.

{% endnote %}

To delete the `Series` table:

1. Create a file named `SeriesDeleteTable.py` and copy the following code to it:

  ```python
  import boto3
  
  def delete_serie_table(ydb = None):
      if not ydb:
          ydb = boto3.resource('dynamodb', 
                                endpoint_url="https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87mbaomkfvsleds/etn02g38m12h9r0cdivp")
  
      table = ydb.Table('Series')
      table.delete()
  
  if __name__ == '__main__':
      delete_serie_table()
      print("Series table deleted")
  ```

1. To start the program, run the command:

  ```
  python SeriesDeleteTable.py
  ```

  Execution result:

  ```
  The Series table has been deleted.
  ```

