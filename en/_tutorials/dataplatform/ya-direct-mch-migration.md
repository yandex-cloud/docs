# Loading data from {{ yandex-direct }} to a {{ mch-full-name }} data mart using {{ sf-full-name }}, {{ objstorage-full-name }}, and {{ data-transfer-full-name }}


You can transfer data from {{ yandex-direct }} to {{ mch-name }} using {{ sf-name }}, {{ objstorage-name }}, and {{ data-transfer-name }}. To do this:

1. [Transfer your data from {{ yandex-direct }} to {{ objstorage-name }} using {{ sf-name }}](#direct-objstorage).
1. [Transfer your data from {{ objstorage-name }} to {{ mch-name }} using {{ data-transfer-name }}](#objstorage-mch).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* Fee for an {{ objstorage-name }} bucket: Covers data storage and bucket operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* Fee for function invocations (see [{{ sf-full-name }} pricing](../../functions/pricing.md)).
* Fee for storing the secret and requests to the secret (see [{{ lockbox-full-name }} pricing](../../lockbox/pricing.md)).
* {{ mch-name }} cluster fee: Covers the use of computational resources allocated to hosts (including ZooKeeper hosts) and disk storage (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).
* Fee for using public IP addresses for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Getting started {#before-you-begin}

1. Prepare the test data to load from {{ yandex-direct }}:

    1. [Register the test application in {{ yandex-oauth }}](https://yandex.ru/dev/direct/doc/dg/concepts/register.html#oauth).

        Select **Web services** as the platform. In the **Redirect URI** field, paste the URL for debugging: `https://oauth.yandex.ru/verification_code`.

    1. [Get a debug token](https://yandex.ru/dev/id/doc/ru/tokens/debug-token) for the application.
    1. [Request](https://yandex.ru/dev/direct/doc/dg/concepts/register.html#request) test access to {{ yandex-direct }} for the application and wait for approval.
    1. [Set up the sandbox](https://yandex.ru/dev/direct/doc/dg/concepts/sandbox-init.html) in {{ yandex-direct }} with the **Client** role.
    1. (Optional) Check your setup by sending a request to the sandbox API from the application:

        {% cut "Request example" %}

        ```bash
        curl \
          --header 'Authorization: Bearer <debug_token>' \
          --header 'Accept-Language: en' \
          --data '
              {
                "method":"get",
                "params": {
                  "SelectionCriteria": {},
                  "FieldNames": [
                    "Id",
                    "Name"
                  ]
                }
              }' \
          "https://api-sandbox.direct.yandex.com/json/v5/campaigns" | jq
        ```

        {% endcut %}

        {% cut "Response example" %}

        ```json
        {
          "result": {
            "Campaigns": [
              {
                  "Id": 463476,
                  "Name": "Test API Sandbox campaign 1"
              },
              {
                  "Id": 463477,
                  "Name": "Test API Sandbox campaign 2"
              },
              {
                  "Id": 463478,
                  "Name": "Test API Sandbox campaign 3"
              }
            ]
          }
        }
        ```

        {% endcut %}

1. Prepare your {{ yandex-cloud }} infrastructure:

    {% list tabs group=resources %}

    - Manually {#manual}

        1. [Create a service account](../../iam/operations/sa/create.md) named `storage-lockbox-sa` and assign the `storage.uploader` and `lockbox.payloadViewer` roles to it.
        1. [Create a static access key](../../iam/operations/authentication/manage-access-keys.md#create-access-key) for the `storage-lockbox-sa` service account.
        1. [Create a secret in {{ lockbox-full-name }}](../../lockbox/operations/secret-create.md) with three `key:value` pairs:

            * `access_key:<public_key>`
            * `secret_key:<private_key>`
            * `app_token:<application_debug_token>`

        1. [Create a bucket](../../storage/operations/buckets/create.md) in {{ objstorage-short-name }}.
        1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md) in any suitable configuration with publicly available hosts.
        1. If using security groups, make sure they are [configured correctly](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups) and allow inbound connections to your {{ mch-name }} cluster.

    - {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [ya-direct-to-mch.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-direct-to-clickhouse/blob/main/ya-direct-to-mch.tf) configuration file to the same working directory.

            This file describes:

            * [Network](../../vpc/concepts/network.md#network).
            * [Subnet](../../vpc/concepts/network.md#subnet).
            * [Security group](../../vpc/concepts/security-groups.md) and rules required to connect to a {{ mch-name }} cluster.
            * Service account with the `storage.uploader` and `lockbox.payloadViewer` roles.
            * Static key for the service account.
            * {{ lockbox-name }} secret.
            * {{ objstorage-short-name }} bucket.
            * {{ sf-name }} serverless function.
            * {{ mch-name }} target cluster.
            * {{ mch-name }} target endpoint.
            * Transfer.

        1. In the `ya-direct-to-mch.tf` file, specify these variables:

            * `folder_id`: Cloud folder ID matching the one in your provider settings.
            * `app_token`: Application debug token.
            * `bucket_name`: {{ objstorage-short-name }} bucket name. The name must be unique within the service.
            * `ch_password`: {{ mch-name }} cluster admin user password.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

## Transfer your data from {{ yandex-direct }} to {{ objstorage-name }} using {{ sf-name }} {#direct-objstorage}

1. [Download the `example-py.zip` archive file](https://github.com/yandex-cloud-examples/yc-data-transfer-direct-to-clickhouse/blob/main/example-py.zip) with a Python function.

    The function uses an application token to read marketing campaign IDs and names from the sandbox, then writes this data to an {{ objstorage-name }} bucket in Parquet format.

    The function accepts the following input:

    * Service account key
    * Application token
    * Bucket name

    {% note tip %}

    You can use this function to obtain real campaign data or make requests on behalf of the agency. To do this, extract the archive file and uncomment all the required parameters in `example.py`. See the code comments for details.

    {% endnote %}

1. Create and configure [a function in the {{ sf-name }} service](../../functions/concepts/function.md):

    {% list tabs group=resources %}

    - Manually {#manual}

        1. [Create a function](../../functions/operations/function/function-create.md).
        1. In the editor that opens, select **Python** as the runtime environment and click**{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
        1. Specify the required settings:

            * **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}**: `ZIP archive`.
            * **{{ ui-key.yacloud.serverless-functions.item.editor.field_file }}**: Select the `example-py.zip` file you downloaded earlier.
            * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `example.foo`.
            * **{{ ui-key.yacloud.forms.label_service-account-select }}**: Select `storage-lockbox-sa` from the list.
            * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**: Enter the bucket name in the `key=value` format:

                * Key: `BUCKET`.
                * Value: Name of the bucket created earlier (without the `s3://` prefix).

            * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret }}**: Specify the path to the three previously created {{ lockbox-name }} secrets as environment variables:

                * `AWS_ACCESS_KEY_ID`: `access_key`
                * `AWS_SECRET_ACCESS_KEY`: `secret_key`
                * `TOKEN`: `app_token`

            You can leave the other settings at their defaults.

        1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}** and wait for the function to compile.

    - {{ TF }} {#tf}

        1. In the `ya-direct-to-mch.tf` file, specify these variables:

            * `path_to_zip_cf`: Path to the ZIP archive file with the function code.
            * `create_function`: `1` to create a function.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% endlist %}

1. Open the function you created in the management console. Select **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}** in the left-hand panel.
1. Click **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}** and wait for the function to complete.

You will see a Parquet file in the bucket.

## Transfer your data from {{ objstorage-name }} to {{ mch-name }} using {{ data-transfer-name }} {#objstorage-mch}

1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create) with the following parameters:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Yandex Object Storage`.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.bucket.title }}**: Bucket name in {{ objstorage-name }}.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.service_account_id.title }}**: Select the service account [you created earlier](#before-you-begin) from the list.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.endpoint.title }}**: `https://{{ s3-storage-host }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.region.title }}**: `{{ region-id }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.format.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.parquet.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.schema.title }}**: `{"Id": "int64", "Name": "string"}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.RenameTablesTransformer.rename_tables.array_item_label }}**: Name of the Parquet file in the bucket, e.g., `ac05e4fe818e463f88a8a299d290734d.snappy.parquet`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.result_schema.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageDataSchema.data_schema.title }}` and specify field names and data types:

        * `Id`: `Int64`
        * `Name`: `String`

    Leave the default values for the other properties.

1. Create an endpoint for the target and transfer:

    {% list tabs group=resources %}

    - Manually {#manual}

        1. [Create a {{ mch-name }} target endpoint](../../data-transfer/operations/endpoint/index.md#create) using the parameters of the cluster you created earlier.

        1. [Create a transfer](../../data-transfer/operations/transfer.md#create) that will use the created endpoints.

    - {{ TF }} {#tf}

        1. In the `ya-direct-to-mch.tf` file, specify these variables:

            * `source_endpoint_id`: Source endpoint ID.
            * `transfer_enabled`: `1` to create a transfer.

        1. Make sure the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% endlist %}

1. Activate the transfer and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.

1. Make sure the {{ objstorage-name }} source data was transferred to the {{ mch-name }} database:

    1. [Connect to the cluster](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) using `clickhouse-client`.

    1. Run this query:

        ```sql
        SELECT * FROM ac05e4fe818e463f88a8a299d290734d_snappy_parquet;
        ```

        Where `ac05e4fe818e463f88a8a299d290734d` is the Parquet file name.

        {% cut "Response example" %}

        ```sql
        ┌─────Id─┬─Name────────────────────────┬─__file_name─────────────────────────────────────┬─__row_index─┐
        │ 463476 │ Test API Sandbox campaign 1 │ ac05e4fe818e463f88a8a299d290734d.snappy.parquet │           1 │
        │ 463477 │ Test API Sandbox campaign 2 │ ac05e4fe818e463f88a8a299d290734d.snappy.parquet │           2 │
        │ 463478 │ Test API Sandbox campaign 3 │ ac05e4fe818e463f88a8a299d290734d.snappy.parquet │           3 │
        └────────┴─────────────────────────────┴─────────────────────────────────────────────────┴─────────────┘
        ```

        {% endcut %}

## Delete the resources you created {#clear-out}

Some resources incur charges. To avoid unnecessary charges, delete the resources you no longer need:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete the source endpoint](../../data-transfer/operations/endpoint/index.md#delete).
1. [Delete the objects](../../storage/operations/objects/delete.md) from the bucket.

Delete other resources using the method matching their creation method:

{% list tabs group=resources %}

- Manually {#manual}

    * Target [endpoint](../../data-transfer/operations/endpoint/index.md#delete).
    * [{{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-delete.md).
    * [{{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md).
    * [Function](../../functions/operations/function/function-delete.md).
    * [Secret in {{ lockbox-name }}](../../lockbox/operations/secret-delete.md).
    * [Service account](../../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
