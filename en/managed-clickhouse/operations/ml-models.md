# Enabling machine learning models

{{ mch-short-name }} lets you analyze data by applying [CatBoost](https://catboost.ai/) machine learning models without additional tools. To apply a model, add it to your cluster and call it in an SQL query using the built-in [`modelEvaluate()`](https://{{ ch-domain }}/docs/en/query_language/functions/other_functions/#function-modelevaluate) function. After running this query, you get model predictions for each row of input data. For more information about machine learning, {{ CH }} see the [documentation](https://{{ ch-domain }}/docs/en/guides/apply_catboost_model/).

## Before adding a model {#prereq}

{{ mch-short-name }} works only with publicly readable models that are uploaded to {{ objstorage-name }}:

1. [Upload](../../storage/operations/objects/upload.md) the trained model file to {{ objstorage-name }}.

1. [Set up public read access](../../storage/operations/objects/edit-acl.md) to the model file.

1. [Get](../../storage/operations/objects/link-for-download.md) a public link to the model.

## Adding a model {#add-ml-model}

{% list tabs %}

- Management console

  1. Select the cluster:
     1. Go to the folder page and select **{{ mch-name }}**.
     1. Click on the name of the cluster and select the **Machine learning** tab from the left panel.
     1. Click **Add model**.

  1. Configure the model parameters:
     * **Type**: Model type. The only supported model type is CatBoost: `ML_MODEL_TYPE_CATBOOST`.
     * **Name**: Model name. The model name is one of the arguments of the `modelEvaluate()` function, which is used to call the model in {{ CH }}.
     * **URL**: Model address in {{ objstorage-name }}.

  1. Click **Add** and wait for the model to be added.

- Terraform

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For information about how to create this file, see [{#T}](cluster-create.md).

    1. To the {{ mch-name }} cluster description, add the `ml_model` block with a description of the added machine learning model:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
          ...
          ml_model {
            name = "<model name>"
            type = "<model type: ML_MODEL_TYPE_CATBOOST>"
            uri  = "<public link to the model file in {{ objstorage-name }}>"
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm the update of resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mch }}).

{% endlist %}

## Applying a model {#apply-ml-model}

To apply the model to data stored in a {{ CH }} cluster:

1. Connect to the cluster [using the CLI client](../../managed-clickhouse/operations/connect.md#cli) for {{ CH }} or go to the [SQL](../../managed-clickhouse/operations/web-sql-query.md) tab in the cluster management console.

1. Execute an SQL query like:

   ```
   SELECT 
       modelEvaluate('<model name>', 
                     <name of column 1>,
                     <name of column 2>,
                     ...
                     <name of column N>)
   FROM <table name>
   ```

Specify the model name and the names of the columns with input data as the `modelEvaluate()` function arguments. The query results in a column with model predictions for each row of the source table.

## Example {#example-ml-model}

If you don't have a suitable data set or model to process it, you can test machine learning in {{ mch-short-name }} using this example. We prepared a data file for it and trained a model to analyze it. You can upload data to {{ CH }} and see model predictions for different rows of the table.

{% note info %}

In this example, we'll use public data from the [Amazon Employee Access Challenge](https://www.kaggle.com/c/amazon-employee-access-challenge). The model is trained to predict values in the `ACTION` column. The same data and model are used in the examples provided in the [{{ CH }} documentation](https://{{ ch-domain }}/docs/en/guides/apply_catboost_model/) and on [GitHub](https://github.com/ClickHouse/clickhouse-presentations/blob/master/tutorials/catboost_with_clickhouse_en.md).

{% endnote %}

To upload data to {{ CH }} and test the model:

1. Install the [{{ CH }} CLI](https://{{ ch-domain }}/docs/en/interfaces/cli/) and set up a cluster connection as described in the [documentation](../../managed-clickhouse/operations/connect.md#cli).
1. Download the [data file](https://storage.yandexcloud.net/managed-clickhouse/train.csv) for analysis:

   ```bash
   $ wget https://storage.yandexcloud.net/managed-clickhouse/train.csv  
   ```
1. Create a table for the data:

   ```bash
   $ clickhouse-client --host <host FQDN> \
                     --database <DB name>
                     --secure \
                     --user <DB username> \
                     --password <DB user password> \
                     --port 9440 \
                     -q 'CREATE TABLE ml_test_table (date Date MATERIALIZED today(), ACTION UInt8, RESOURCE UInt32, MGR_ID UInt32, ROLE_ROLLUP_1 UInt32, ROLE_ROLLUP_2 UInt32, ROLE_DEPTNAME UInt32, ROLE_TITLE UInt32, ROLE_FAMILY_DESC UInt32, ROLE_FAMILY UInt32, ROLE_CODE UInt32) ENGINE = MergeTree() PARTITION BY date ORDER BY date'
   ```
1. Upload the data to the table:

   ```bash
   $ clickhouse-client --host <host FQDN> \
                     --database <DB name>
                     --secure \
                     --user <DB username> \
                     --password <DB user password> \
                     --port 9440 \
                     -q 'INSERT INTO ml_test_table FORMAT CSVWithNames' \
                     < train.csv
   ```
1. In the [management console]({{ link-console-main }}), add the test model:

  * **Type**: `ML_MODEL_TYPE_CATBOOST`.
  * **Name**: `ml_test`.
  * **URL**: `https://storage.yandexcloud.net/managed-clickhouse/catboost_model.bin`.

1. Test the model:
  1. Connect to the cluster [using the CLI client](../../managed-clickhouse/operations/connect.md#cli) for {{ CH }} or go to the [SQL](../../managed-clickhouse/operations/web-sql-query.md) tab in the cluster management console.
  1. Test the model using queries:
     * Predicted values for first 10 rows of the `ACTION` column:

         ```
         SELECT 
             modelEvaluate('ml_test', 
                           RESOURCE,
                           MGR_ID,
                           ROLE_ROLLUP_1,
                           ROLE_ROLLUP_2,
                           ROLE_DEPTNAME,
                           ROLE_TITLE,
                           ROLE_FAMILY_DESC,
                           ROLE_FAMILY,
                           ROLE_CODE) > 0 AS prediction, 
             ACTION AS target
         FROM ml_test_table
         LIMIT 10
         ```
     * Predicted probability for the first 10 rows of the table:

        ```
        SELECT 
            modelEvaluate('ml_test', 
                          RESOURCE,
                          MGR_ID,
                          ROLE_ROLLUP_1,
                          ROLE_ROLLUP_2,
                          ROLE_DEPTNAME,
                          ROLE_TITLE,
                          ROLE_FAMILY_DESC,
                          ROLE_FAMILY,
                          ROLE_CODE) AS prediction,
            1. / (1 + exp(-prediction)) AS probability, 
            ACTION AS target
        FROM ml_test_table
        LIMIT 10
        ```

