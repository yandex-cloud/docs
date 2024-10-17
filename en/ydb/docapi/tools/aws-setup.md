---
title: Setting up AWS tools in {{ ydb-full-name }}
description: This page describes the AWS tools you can use to access the database via the Document API in the AWS DynamoDB compatibility mode.
sourcePath: overlay/quickstart/document-api/aws-setup.md
---
# Setting up AWS tools

To access the database via the Document API in AWS DynamoDB-compatible mode, you can use AWS tools:

* [AWS CLI](https://aws.amazon.com/cli/) is the AWS command line interface.
* [AWS SDK](https://aws.amazon.com/tools/#sdk) includes development tools.

{% include [doc-tables-only.md](../../_includes/doc-tables-only.md) %}

To use the AWS tools, follow these steps:

1. Create a service account on behalf of which you are going to access the database.

   The service account must be created in the same folder with the database.

   {% list tabs group=instructions %}

   - Management console {#console}

      {% include [create-sa-via-console](../../../_includes/iam/create-sa-via-console-without-role.md) %}

   - CLI {#cli}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      1. Check the description of the command for creating a service account:

         ```bash
         yc iam service-account create --help
         ```

      1. Create a service account named `my-robot`:

         ```bash
         yc iam service-account create --name my-robot
         ```

         Naming requirements for service accounts:

         {% include [name-format](../../../_includes/name-format.md) %}

   - API {#api}

      To create a service account, use the [create](../../../iam/api-ref/ServiceAccount/create.md) method for the [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) resource.

   {% endlist %}

1. Assign the `editor` role to the service account.

   {% include [grant-role-for-sa](../../../_includes/iam/grant-role-for-sa.md) %}

1. Get the key ID and access key of the created service account:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. Go to the folder that the service account belongs to.
      1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
      1. Choose a service account and click the row with its name.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** in the top panel.
      1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
      1. Enter a description of the key so that you can easily find it in the management console.
      1. Save the ID and private key.

         {% note alert %}

         After you close the dialog, the private key value will become unavailable.

         {% endnote %}

   - CLI {#cli}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      1. See the description of the create static access key command:

         ```bash
         yc iam access-key create --help
         ```

      1. Select a service account, e.g., `my-robot`:

         ```bash
         yc iam service-account list
         +----------------------+------------------+-------------------------------+
         |          ID          |       NAME       |          DESCRIPTION          |
         +----------------------+------------------+-------------------------------+
         | aje6o61dvog2******** | my-robot         |                               |
         ...
         ```

      1. Create an access key for the `my-robot` service account:

         ```bash
         yc iam access-key create --service-account-name my-robot

         access_key:
           id: aje6t3vsbj8l********
           service_account_id: ajepg0mjt06s********
           created_at: "2018-11-22T14:37:51Z"
           key_id: 0n8X6WY6S24N********
         secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI********
         ```

      1. Save the ID (`key_id`) and secret key (`secret`). You will not be able to get the key value again.

   - API {#api}

      To create an access key, use the [create](../../../iam/awscompatibility/api-ref/AccessKey/create.md) method for the [AccessKey](../../../iam/awscompatibility/api-ref/AccessKey/index.md) resource.

   {% endlist %}

1. Install the [AWS CLI](https://aws.amazon.com/cli/).
1. Configure the AWS CLI environment: run the `aws configure` command and enter the previously saved key ID and secret access key one by one. Use `{{ region-id }}` as the region:

   ```bash
   aws configure
   AWS Access Key ID [None]: AKIAIOSFODNN********
   AWS Secret Access Key [None]: wJalr********/*******/bPxRfiCYEX********
   Default region name [None]: {{ region-id }}
   Default output format [None]:
   ```

   As a result, the `~/.aws/credentials` and `~/.aws/config` files (`C:\Users\USERNAME\.aws\credentials` and `C:\Users\USERNAME\.aws\config` on Windows) will be created.
1. Check that the settings are correct by running the table listing command against the [created](../../operations/manage-databases.md) DB. As the `--endpoint` value, specify the Document API endpoint available in the **{{ ui-key.yacloud.ydb.database.switch_overview }}** tab of your database in the [management console]({{ link-console-main }}).

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
