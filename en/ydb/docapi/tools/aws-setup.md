---
sourcePath: overlay/quickstart/document-api/aws-setup.md
---
# Setting up AWS tools

To access the database via the Document API in AWS DynamoDB-compatible mode, you can use AWS tools:

* [AWS CLI]{% if lang == "en" %}(https://aws.amazon.com/cli/){% endif %}{% if lang == "ru" %}(https://aws.amazon.com/ru/cli/){% endif %}: The AWS command line interface.
* [AWS SDK]{% if lang == "en" %}(https://aws.amazon.com/tools/#sdk){% endif %}{% if lang == "ru" %}(https://aws.amazon.com/ru/tools/#sdk){% endif %}: The software development kit.

{% include [doc-tables-only.md](../../_includes/doc-tables-only.md) %}

To use the AWS tools, follow these steps:

1. Create a service account on behalf of which you are going to access the database.

   The service account must be created in the same folder with the database.

   {% list tabs %}

   - Management console

      {% include [create-sa-via-console](../../../_includes/iam/create-sa-via-console.md) %}

   - CLI

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      1. See the description of the command for creating a service account:

         ```bash
         yc iam service-account create --help
         ```

      1. Create a service account named `my-robot`:

         ```bash
         yc iam service-account create --name my-robot
         ```

         {% include [name-format](../../../_includes/name-format.md) %}

   - API

      To create a service account, use the [create](../../../iam/api-ref/ServiceAccount/create.md) method for the [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) resource.

   {% endlist %}

1. Assign the `editor` role to the service account.

   {% include [grant-role-for-sa](../../../_includes/iam/grant-role-for-sa.md) %}

1. Get the key ID and access key of the created service account:

   {% list tabs %}

   - Management console

      1. Go to the folder that the service account belongs to.
      1. Go to the **Service accounts** tab.
      1. Choose a service account and click the line with its name.
      1. Click **Create new key** in the top panel.
      1. Click **Create static access key**.
      1. Enter a description of the key so that you can easily find it in the management console.
      1. Save the ID and private key.

         {% note alert %}

         After the dialog is closed, the private key value will be unavailable.

         {% endnote %}

   - CLI

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      1. See the description of the create static access key command:

         ```bash
         yc iam access-key create --help
         ```

      1. Select a service account (for example, `my-robot`):

         ```bash
         yc iam service-account list
         +----------------------+------------------+-------------------------------+
         |          ID          |       NAME       |          DESCRIPTION          |
         +----------------------+------------------+-------------------------------+
         | aje6o61dvog2h6g9a33s | my-robot         |                               |
         ...
         ```

      1. Create an access key for the `my-robot` service account:

         ```bash
         yc iam access-key create --service-account-name my-robot

         access_key:
           id: aje6t3vsbj8lp9r4vk2u
           service_account_id: ajepg0mjt06siuj65usm
           created_at: "2018-11-22T14:37:51Z"
           key_id: 0n8X6WY6S24N7OjXQ0YQ
         secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI9hxtzMP1
         ```

      1. Save the ID `key_id` and `secret` key. You will not be able to get the key value again.

   - API

      To create an access key, use the [create](../../../iam/api-ref/AccessKey/create.md) method for the [AccessKey](../../../iam/api-ref/AccessKey/index.md) resource.

   {% endlist %}

1. Install the [AWS CLI]{% if lang == "en" %}(https://aws.amazon.com/cli/){% endif %}{% if lang == "ru" %}(https://aws.amazon.com/ru/cli/){% endif %}.
1. Configure the AWS CLI environment: Run the `aws configure` command and enter the previously saved key ID and secret access key one-by-one. Use `{{ region-id }}` as the region:

   ```bash
   aws configure
   AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
   AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
   Default region name [None]: {{ region-id }}
   Default output format [None]:
   ```

   As a result, the files `~/.aws/credentials` and `~/.aws/config` will be created (`C:\Users\USERNAME\.aws\credentials` and `C:\Users\USERNAME\.aws\config` on Windows).
1. Check that the settings are correct by running the table listing command against the [created](../../operations/manage-database.md#create-db) DB. As the `--endpoint` value, specify the Document API endpoint available on the **Overview** tab of your database in the [management console]({{ link-console-main }}).

   ```bash
   aws dynamodb list-tables \
   --endpoint {{ ydb.aws-ep }}
   ```

   Result:

   ```text
   {
       "TableNames": [
       ]
   }
   ```
