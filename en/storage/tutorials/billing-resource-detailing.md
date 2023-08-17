# Cost analysis by type of resource

This scenario describes the steps required to get a report containing information on the amount of spending on resources in a folder. Data is retrieved using the [S3 Select](../concepts/s3-select-language.md) query language.

## Getting started {#before-you-begin}

Install and configure the [AWS CLI](../tools/aws-cli.md).

## Getting itemized spending details {#get-billing-detail}

{% list tabs %}

- Management console

   1. {% include [move-to-billing-step](../../billing/_includes/move-to-billing-step.md) %}
   1. Select the billing account you need from the list.
   1. Click the **{{ ui-key.yacloud.billing.account.switch_detail }}** tab.
   1. At the top right, click **{{ ui-key.yacloud.billing.account.detail.button_export }}** and select **{{ ui-key.yacloud.billing.account.detail.button_create-periodic-export }}**.
   1. In the window that opens:
      * In the **{{ ui-key.yacloud.billing.account.exports.field_bucket }}** field, enter the name of the bucket to store the CSV file with details.
      * In the **{{ ui-key.yacloud.billing.account.exports.field_prefix }}** field, enter the name of the directory for the file. The last character must be `/`.
      * In the **{{ ui-key.yacloud.billing.account.exports.field_locale }}** field, select the language to display product names in: **{{ ui-key.yacloud.billing.account.exports.locale_value_en-lang }}** or **{{ ui-key.yacloud.billing.account.exports.locale_value_ru-lang }}**.
      * In the **{{ ui-key.yacloud.billing.account.exports.field_detail-type }}** field, select the **{{ ui-key.yacloud.billing.account.exports.label_include-resources }}** type of details.
   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Generating a report {#create-report}

1. Run the query against {{ objstorage-name }} and save the output to a file:

    1. For convenience, save:

        * The name of the bucket containing the details, to a variable called `$bucket`:

            ```bash
            bucket=<bucket_name>
            ```

        * The [key](../concepts/object.md#key) of the object containing the details, to a variable called `$key`:

            ```bash
            key=<object_key>
            ```

        * The S3 Select expression to select data from the details, to a variable called `$query`:

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
          --input-serialization '{"CSV": {"FileHeaderInfo": "USE", "FieldDelimiter":","}}' \
          --output-serialization '{"CSV": {}}' \
          "output.csv"
        ```

1. To output the cost total for each resource, run an aggregation query using the `awk` utility:

    ```bash
    < output.csv awk -F, '{n[$2]+=$6} END{for(i in n){print n[i] "\t" i}}' | sort -nrk1
    ```

    Result:

    ```bash
    591.206 c8rska9493s55k8bn00n
    254.092 c8rk36jv5nn4k9oo82ai
    93.4481 a7l9vsb1btl6vvlflaig
    ...
    0.742366 fdv0u8gklc23ibhqdna4
    0.694901 c8rhi3km712q3r0r5vrp
    0.545707 a7l7fb0athcsbnqdh4ee
    ```
