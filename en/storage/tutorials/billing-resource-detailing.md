# Cost analysis by type of resource

Set up automatic export of the expense details for your [billing account](../../billing/concepts/billing-account.md) and generate a report with information about the costs associated with the resources within a folder. The data will be retrieved from the {{ objstorage-name }} bucket using the [S3 Select](../concepts/s3-select-language.md) query language.

To analyze costs:

1. [Prepare your cloud](#before-you-begin).
1. [Create an {{ objstorage-name }} bucket](#create-bucket).
1. [Get expense details](#get-billing-detail).
1. [Generate a report](#create-report).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of analyzing expense details includes fees for bucket data storage and operations with data (see [{{ objstorage-name }} pricing](../pricing.md)).


### Configure the environment {#setup-environment}

Install and configure the [AWS CLI](../tools/aws-cli.md).

## Create an {{ objstorage-name }} bucket {#create-bucket}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. At the top right, click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
   1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, enter a name for the bucket.
   1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

## Get expense details {#get-billing-detail}

{% list tabs %}

- Management console

   1. {% include [move-to-billing-step](../../billing/_includes/move-to-billing-step.md) %}
   1. Select the billing account you need from the list.
   1. Go to the **{{ ui-key.yacloud.billing.account.switch_detail }}** tab.
   1. At the top right, click **{{ ui-key.yacloud.billing.account.detail.button_export }}** and select **{{ ui-key.yacloud.billing.account.detail.button_create-periodic-export }}**.
   1. In the window that opens:
      * In the **{{ ui-key.yacloud.billing.account.exports.field_bucket }}** field, enter the name of the bucket you [created earlier](#create-bucket). A CSV file with your expense details will be kept there.
      * In the **{{ ui-key.yacloud.billing.account.exports.field_prefix }}** field, enter the name of the directory for the file. The last character must be `/`.
      * In the **{{ ui-key.yacloud.billing.account.exports.field_locale }}** field, select the language to display product names in: **{{ ui-key.yacloud.billing.account.exports.locale_value_en-lang }}** or **{{ ui-key.yacloud.billing.account.exports.locale_value_ru-lang }}**.
      * In the **{{ ui-key.yacloud.billing.account.exports.field_detail-type }}** field, select the **{{ ui-key.yacloud.billing.account.exports.label_include-resources }}** type of details.
   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Generate a report {#create-report}

{% list tabs %}

- Bash

   1. Run the query against {{ objstorage-name }} and save the output to a file:

      1. For convenience, save:

         * Name of the bucket containing the details, to a variable named `$bucket`:

            ```bash
            bucket=<bucket_name>
            ```

         * [Key](../concepts/object.md#key) of the object containing the details, to a variable named `$key`:

            ```bash
            key=<object_key>
            ```

         * S3 Select expression to request the data from the details file, to a variable named `$query`:

            ```bash
            query="select service_name,resource_id,sku_id,sku_name,\"date\",cost from S3Object where service_name='Compute Cloud'"
            ```

      1. Run this command:

         ```bash
         aws --endpoint https://{{ s3-storage-host }} s3api select-object-content \
           --bucket $bucket \
           --key $key \
           --expression "$query" \
           --expression-type 'SQL' \
           --input-serialization 'CSV={FileHeaderInfo=USE,FieldDelimiter=,}' \
           --output-serialization 'CSV={}' \
           "output.csv"
         ```

   1. To output the total cost for each resource, run an aggregation query using the `awk` utility:

      ```bash
      < output.csv awk -F, '{n[$2]+=$6} END{for(i in n){print n[i] "\t" i}}' | sort -nrk1
      ```

      Result:

      ```bash
      591.206 c8rska9493**********
      254.092 c8rk36jv5n**********
      93.4481 a7l9vsb1bt**********
      ...
      0.742366 fdv0u8gkl**********
      0.694901 c8rhi3km7**********
      0.545707 a7l7fb0at**********
      ```

{% endlist %}

## How to delete the resources you created {#clear-out}

To shut down the created resources and stop paying for them:

1. [Delete](../operations/objects/delete.md) all objects from the bucket.
1. [Delete](../operations/buckets/delete.md) the bucket.
