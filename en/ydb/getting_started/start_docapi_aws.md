# Setting up the AWS CLI and AWS SDK

To access the database via the Document API in AWS DynamoDB-compatible mode, you can use AWS tools:

* [AWS CLI](https://aws.amazon.com/cli/): The command line interface from AWS.
* [AWS SDK](https://aws.amazon.com/tools/#sdk): The software development kit.

For AWS tools to work correctly, be sure to set up the following parameters:

* [aws_access_key_id](https://docs.aws.amazon.com/credref/latest/refdocs/setting-global-aws_access_key_id.html)
* [aws_secret_access_key](https://docs.aws.amazon.com/credref/latest/refdocs/setting-global-aws_secret_access_key.html)
* [region](https://docs.aws.amazon.com/credref/latest/refdocs/setting-global-region.html)

## Setting up the parameters {#setup}

1. Create a service account on behalf of which you are going to access the database.

    The service account must be created in the same folder with the database.

    {% list tabs %}

    - Management console

      {% include [create-sa-via-console](../../_includes/iam/create-sa-via-console.md) %}

    - CLI

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      1. See the description of the create service account command:

          ```
          $ yc iam service-account create --help
          ```

      2. Create a service account named `my-robot`:

          ```
          $ yc iam service-account create --name my-robot
          ```

          {% include [name-format](../../_includes/name-format.md) %}

    - API

      To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) for the resource [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md).

    {% endlist %}

1. Assign the `editor` role to the service account.

    {% include [grant-role-for-sa](../../_includes/iam/grant-role-for-sa.md) %}

1. Get the static access keys `aws_access_key_id` and `aws_secret_access_key`.

    {% list tabs %}

    - Management console

      1. Go to the folder that the service account belongs to.

      1. Go to the **Service accounts** tab.

      1. Choose a service account and click the line with its name.

      1. Click **Create new key** in the top panel.

      1. Click **Create access key**.

      1. Enter a description of the key so that you can easily find it in the management console.

      1. Save the ID and private key.

          {% note alert %}

          After the dialog is closed, the private key value will be unavailable.

          {% endnote %}

    - CLI

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      1. See the description of the create static access key command:

          ```
          $ yc iam access-key create --help
          ```

      1. Select a service account (for example, `my-robot`):

          ```
          $ yc iam service-account list
          +----------------------+------------------+-------------------------------+
          |          ID          |       NAME       |          DESCRIPTION          |
          +----------------------+------------------+-------------------------------+
          | aje6o61dvog2h6g9a33s | my-robot         |                               |
          | aje9sda1ufvqcmfksd3f | blabla           | bla bla bla is my description |
          +----------------------+------------------+-------------------------------+
          ```

      1. Create an access key for the `my-robot` service account:

          ```
          $ yc iam access-key create --service-account-name my-robot
          
          access_key:
            id: aje6t3vsbj8lp9r4vk2u
            service_account_id: ajepg0mjt06siuj65usm
            created_at: "2018-11-22T14:37:51Z"
            key_id: 0n8X6WY6S24N7OjXQ0YQ
          secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI9hxtzMP1
          ```

      1. Save the ID `key_id` and private key `secret`. You will not be able to get the key value again.

    - API

      To create an access key, use the [create](../../iam/api-ref/AccessKey/create.md) for the resource [AccessKey](../../iam/api-ref/AccessKey/index.md).

    {% endlist %}

1. Install the [AWS CLI](https://aws.amazon.com/cli/).

1. Set up the [environment](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html). One of the easiest setup methods is to run `aws configure`. Use the values obtained above as keys. Use `ru-central1` as a region:

    ```
    $ aws configure
    AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
    AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
    Default region name [None]: ru-central1
    Default output format [None]:
    ```

    As a result, the files `~/.aws/credentials` and `~/.aws/config` will be created (`C:\Users\USERNAME\.aws\credentials` and `C:\Users\USERNAME\.aws\config` on Windows).

1. Check that the settings are correct by running the table listing command against the database. As the `--endpoint` value, specify the Document API endpoint available on the **Overview** tab for your database in the [management console]({{ link-console-main }}).

    ```
    $ aws dynamodb list-tables --endpoint https://docapi.serverless.yandexcloud.net/ru-central1/b1g4ej5ju4rf5kelpk4b/etn03ubijq52j860kvgj
    {
        "TableNames": [
        ]
    }
    ```

## Examples {#examples}

{% list tabs %}

* AWS CLI

  **Creating a table**

  To create a table, run the command:

  ```bash
  aws dynamodb create-table \
    --table-name series \
    --attribute-definitions \
        AttributeName=series_id,AttributeType=N \
        AttributeName=title,AttributeType=S \
        AttributeName=series_info,AttributeType=S \
        AttributeName=release_date,AttributeType=N \
    --key-schema \
        AttributeName=series_id,KeyType=HASH \
    --endpoint https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87bmaomkfvsleds/etn02uhup7vprrt9lc3u
  ```

  This creates a table named `series` with the series ID, title, info, and release date columns. The series ID is used as the primary key column:

  ```bash
  {
      "TableDescription": {
          "AttributeDefinitions": [
              {
                  "AttributeName": "series_id",
                  "AttributeType": "N"
              },
              {
                  "AttributeName": "title",
                  "AttributeType": "S"
              },
              {
                  "AttributeName": "series_info",
                  "AttributeType": "S"
              },
              {
                  "AttributeName": "release_date",
                  "AttributeType": "N"
              }
          ],
          "TableName": "series",
          "KeySchema": [
              {
                  "AttributeName": "series_id",
                  "KeyType": "HASH"
              }
          ],
          "TableStatus": "ACTIVE",
          "CreationDateTime": "2020-12-26T13:48:36+00:00",
          "TableSizeBytes": 0,
          "ItemCount": 0
      }
  }
  ```

  **Viewing table information**

  To view information about the `series` table, run the command:

  ```bash
  aws dynamodb describe-table \
    --table-name series \
    --endpoint https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87bmaomkfvsleds/etn02uhup7vprrt9lc3u
  ```

  Command results:

  ```bash
  {
      "Table": {
          "AttributeDefinitions": [
              {
                  "AttributeName": "title",
                  "AttributeType": "S"
              },
              {
                  "AttributeName": "series_info",
                  "AttributeType": "S"
              },
              {
                  "AttributeName": "release_date",
                  "AttributeType": "N"
              },
              {
                  "AttributeName": "series_id",
                  "AttributeType": "N"
              }
          ],
          "TableName": "series",
          "KeySchema": [
              {
                  "AttributeName": "series_id",
                  "KeyType": "HASH"
              }
          ],
          "TableStatus": "ACTIVE",
          "CreationDateTime": "2020-12-26T13:48:36+00:00",
          "TableSizeBytes": 0,
          "ItemCount": 0
      }
  }
  ```

  **Viewing a list of tables**

  To view a list of tables, run the command:

  ```bash
  aws dynamodb list-tables \
    --endpoint https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87bmaomkfvsleds/etn02uhup7vprrt9lc3u
  ```

  Command results:

  ```bash
  {
      "TableNames": [
          "series"
      ]
  }
  ```

  **Deleting a table**

  {% note warning %}

  Deleting a table is an irreversible operation.

  {% endnote %}

  To delete the `series` table, run the command:

  ```bash
  aws dynamodb delete-table \
    --table-name series \
    --endpoint https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87bmaomkfvsleds/etn02uhup7vprrt9lc3u
  ```

  Command results:

  ```bash
  {
      "TableDescription": {
          "AttributeDefinitions": [
              {
                  "AttributeName": "title",
                  "AttributeType": "S"
              },
              {
                  "AttributeName": "series_info",
                  "AttributeType": "S"
              },
              {
                  "AttributeName": "release_date",
                  "AttributeType": "N"
              },
              {
                  "AttributeName": "series_id",
                  "AttributeType": "N"
              }
          ],
          "TableName": "series",
          "KeySchema": [
              {
                  "AttributeName": "series_id",
                  "KeyType": "HASH"
              }
          ],
          "TableStatus": "ACTIVE",
          "CreationDateTime": "2020-12-26T13:48:36+00:00",
          "TableSizeBytes": 0,
          "ItemCount": 0
      }
  }
  ```

* AWS SDK (Python)

  **Creating a table**

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

  **Adding an entry**

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

  2. To start the program, run the command:

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

  **Reading entries**

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

  2. To start the program, run the command:

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

  **Deleting a table**

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

  2. To start the program, run the command:

      ```
      python SeriesDeleteTable.py
      ```

      Execution result:

      ```
      The Series table has been deleted.
      ```

{% endlist %}

