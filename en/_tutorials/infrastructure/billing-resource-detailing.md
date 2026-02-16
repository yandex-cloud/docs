# Cost analysis by resource using {{ objstorage-full-name }}

Configure the automatic export of expense details for your [billing account](../../billing/concepts/billing-account.md) and generate a report with info on the costs associated with the resources within a folder. To get data from the {{ objstorage-name }} bucket, we will be using the [S3 Select](../../storage/concepts/s3-select-language.md) query language.

To analyze the costs:

1. [Get your cloud ready](#before-you-begin).
1. [Create an {{ objstorage-name }} bucket](#create-bucket).
1. [Get the expense details](#get-billing-detail).
1. [Generate a report](#create-report).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of analyzing expense details includes fees for bucket data storage and data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).


### Set up your environment {#setup-environment}

Install and configure the [AWS CLI](../../storage/tools/aws-cli.md).

## Create an {{ objstorage-name }} bucket {#create-bucket}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. At the top right, click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, enter a name for the bucket.
  1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

## Get the expense details {#get-billing-detail}

{% list tabs group=instructions %}

- Management console {#console}

  1. {% include [move-to-billing-step](../../billing/_includes/move-to-billing-step.md) %}
  1. Select the billing account you need from the list.
  1. Navigate to the **{{ ui-key.yacloud_billing.billing.account.switch_detail }}** tab.
  1. At the top right, click **{{ ui-key.yacloud_billing.billing.account.detail.button_export }}** and select **{{ ui-key.yacloud_billing.billing.account.detail.button_create-periodic-export }}**.
  1. In the window that opens:

     * In the **{{ ui-key.yacloud_billing.billing.account.exports.field_bucket }}** field, enter the name of the bucket you [created earlier](#create-bucket). This bucket will store a CSV file with your expense details.
     * In the **{{ ui-key.yacloud_billing.billing.account.exports.field_prefix }}** field, enter the directory name for the file. It must end with the `/` character.
     * In the **{{ ui-key.yacloud_billing.billing.account.exports.field_locale }}** field, select the language to display product names in: **{{ ui-key.yacloud_billing.billing.account.exports.locale_value_en-lang }}** or **{{ ui-key.yacloud_billing.billing.account.exports.locale_value_ru-lang }}**.
     * In the **{{ ui-key.yacloud_billing.billing.account.exports.field_detail-type }}** field, select ***{{ ui-key.yacloud_billing.billing.account.exports.label_include-resources }}**.

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Generate a report {#create-report}

{% list tabs group=programming_language %}

- Bash {#bash}

  1. Run the query against {{ objstorage-name }} and save the output to a file:

     1. For convenience, save:

        * Name of the details bucket to a variable named `$bucket`:

          ```bash
          bucket=<bucket_name>
          ```

        * [Key](../../storage/concepts/object.md#key) of the details object to a variable named `$key`:

          ```bash
          key=<object_key>
          ```

        * Expression to request data from the details file, to the `$query` variable:

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

  1. To output the total cost for each resource, run an aggregation query using `awk`:

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

To shut down the resources you created and stop paying for them:

1. [Delete](../../storage/operations/objects/delete.md) all objects from the bucket.
1. [Delete](../../storage/operations/buckets/delete.md) the bucket.
