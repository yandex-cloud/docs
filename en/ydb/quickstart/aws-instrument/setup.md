# Setting up the AWS CLI and AWS SDK

To access the database via the Document API in AWS DynamoDB-compatible mode, you can use AWS tools:

* [AWS CLI](https://aws.amazon.com/cli/): The command line interface from AWS.
* [AWS SDK](https://aws.amazon.com/tools/#sdk): The software development kit.

For AWS tools to work correctly, be sure to set up the following parameters:

* [aws_access_key_id](https://docs.aws.amazon.com/credref/latest/refdocs/setting-global-aws_access_key_id.html)
* [aws_secret_access_key](https://docs.aws.amazon.com/credref/latest/refdocs/setting-global-aws_secret_access_key.html)
* [region](https://docs.aws.amazon.com/credref/latest/refdocs/setting-global-region.html)

## Environment setup {#setup}

1. Create a service account on behalf of which you are going to access the database.

    The service account must be created in the same folder with the database.

    {% list tabs %}

    - Management console

      {% include [create-sa-via-console](../../../_includes/iam/create-sa-via-console.md) %}

    - CLI

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      1. See the description of the create service account command:

          ```
          $ yc iam service-account create --help
          ```

      2. Create a service account named `my-robot`:

          ```
          $ yc iam service-account create --name my-robot
          ```

          {% include [name-format](../../../_includes/name-format.md) %}

    - API

      To create a service account, use the [create](../../../iam/api-ref/ServiceAccount/create.md) for the resource [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md).

    {% endlist %}

1. Assign the `editor` role to the service account.

    {% include [grant-role-for-sa](../../../_includes/iam/grant-role-for-sa.md) %}

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

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

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

      To create an access key, use the [create](../../../iam/api-ref/AccessKey/create.md) for the resource [AccessKey](../../../iam/api-ref/AccessKey/index.md).

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

