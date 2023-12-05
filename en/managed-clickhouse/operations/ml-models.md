# Managing machine learning models in {{ mch-name }}

{{ mch-short-name }} allows you to analyze data by applying [CatBoost](https://catboost.ai/) machine learning models without additional tools.

To apply a model, add it to your cluster and call it in an SQL query using the built-in `catboostEvaluate()` function. After running this query, you get model predictions for each row of input data.

You can learn more about the `catboostEvaluate()` function in the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/functions/other-functions/#catboostevaluatepath_to_model-feature_1-feature_2--feature_n).

## Before adding a model {#prereq}

{{ mch-short-name }} only works with readable models uploaded to {{ objstorage-full-name }}:


1. [Upload](../../storage/operations/objects/upload.md) the trained model file to {{ objstorage-full-name }}.

1. Configure access to the model file using a [service account](../../iam/concepts/users/service-accounts.md):

   1. [Connect a service account to a cluster](s3-access.md#connect-service-account).
   1. [Assign the account the role](s3-access.md#configure-acl) of `storage.viewer`.
   1. In the bucket ACL, [grant](../../storage/operations/buckets/edit-acl.md) the `READ` permission to the account.

1. [Get a link](s3-access.md#get-link-to-object) to the model file.


## Getting a list of models in a cluster {#list}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_ml-models }}** tab in the left-hand panel.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of models in a cluster, run the command:

   ```bash
   {{ yc-mdb-ch }} ml-model list --cluster-name=<cluster_name>
   ```

   You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get a list of models in a cluster, use the [list](../api-ref/MlModel/list.md) REST API method for the [MlModel](../api-ref/MlModel/index.md) resource or the [MlModelService/List](../api-ref/grpc/ml_model_service.md#List) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Getting detailed information about a model {#get}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_ml-models }}** tab in the left-hand panel.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get model details, run this command:

   ```bash
   {{ yc-mdb-ch }} ml-model get <model_name> \
     --cluster-name=<cluster_name>
   ```

   You can request the model name with a [list of cluster models](#list) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get model details, use the [get](../api-ref/MlModel/get.md) REST API method for the [MlModel](../api-ref/MlModel/index.md) resource or the [MlModelService/Get](../api-ref/grpc/ml_model_service.md#Get) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter.
   * Model name in the `mlModelName` parameter.

   You can request the model name with a [list of cluster models](#list) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Adding a model {#add}

{% note info %}

The only supported model type is CatBoost: `ML_MODEL_TYPE_CATBOOST`.

{% endnote %}

{% list tabs %}

- Management console

   1. Select the cluster:

      1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
      1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_ml-models }}** tab in the left-hand panel.
      1. Click **{{ ui-key.yacloud.clickhouse.cluster.ml-models.button-action_add-ml-model }}**.

   1. Configure the model parameters:

      * **{{ ui-key.yacloud.clickhouse.cluster.ml-models.field_ml-model-type }}**: `ML_MODEL_TYPE_CATBOOST`.
      * **{{ ui-key.yacloud.clickhouse.cluster.ml-models.field_ml-model-name }}**: Model name. Model name is one of the arguments of the `catboostEvaluate()` function, which is used to call the model in {{ CH }}.
      * **{{ ui-key.yacloud.clickhouse.cluster.ml-models.field_ml-model-uri }}**: Model address in {{ objstorage-full-name }}.

   1. Click **{{ ui-key.yacloud.clickhouse.cluster.ml-models.label_add-ml-model }}** and wait for the model to be added.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add a model to a cluster, run the command:

   ```bash
   {{ yc-mdb-ch }} ml-model create <model_name \
     --cluster-name=<cluster_name> \
     --type=ML_MODEL_TYPE_CATBOOST \
     --uri=<link_to_model_file_in_Object_Storage>
   ```

   You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

   1. To the {{ mch-name }} cluster description, add the `ml_model` block with a description of the added machine learning model:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
        ...
        ml_model {
          name = "<model_name>"
          type = "ML_MODEL_TYPE_CATBOOST"
          uri  = "<link_to_model_file_in_Object_Storage>"
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mch }}).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   To add a model, use the [create](../api-ref/MlModel/create.md) REST API method for the [MlModel](../api-ref/MlModel/index.md) resource or the [MlModelService/Create](../api-ref/grpc/ml_model_service.md#Create) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter.
   * Model name in the `mlModelName` parameter.
   * `ML_MODEL_TYPE_CATBOOST` model type in the `type` parameter.
   * Link to the model file in {{ objstorage-full-name }} in the `uri` parameter.

   You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Applying a model {#apply}

To apply the model to data stored in a {{ CH }} cluster:

1. Connect to the cluster [using the client](../../managed-clickhouse/operations/connect.md#cli) {{ CH }} CLI or go to the [SQL](../../managed-clickhouse/operations/web-sql-query.md) tab in the cluster management console.
1. Execute an SQL query in the format:

   ```
   SELECT
       catboostEvaluate('<model_file_path>',
                     <name_of_column_1>,
                     <name_of_column_2>,
                     ...
                     <name_of_column_N>)
   FROM <table_name>
   ```

Specify the following arguments for the `catboostEvaluate()` function:

* Path to the model file in the format `/var/lib/clickhouse/models/<model_name>.bin`.
* Names of columns containing the input data.

The result of the query execution will be a column with model predictions for each row of the source table.

## Updating a model {#update}

{{ mch-name }} does not track changes in the model file located in the {{ objstorage-full-name }} bucket.

To update the contents of a model that is already connected to the cluster:


1. [Upload the file](../../storage/operations/objects/upload.md) with the current model to {{ objstorage-full-name }}.
1. [Get a link](s3-access.md#get-link-to-object) to this file.
1. Change the parameters of the model connected to {{ mch-name }} by providing a new link to the model file.


{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_ml-models }}** tab in the left-hand panel.
   1. Select the appropriate model, click ![image](../../_assets/dots.svg), and select **{{ ui-key.yacloud.clickhouse.cluster.ml-models.button_action-edit-ml-model }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the link to the model file in the {{ objstorage-full-name }} bucket, run the command:

   ```bash
   {{ yc-mdb-ch }} ml-model update <model_name> \
     --cluster-name=<cluster_name> \
     --uri=<new_link_to_file_in_Object_Storage>
   ```

   You can request the model name with a [list of cluster models](#list) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

   1. In the {{ mch-name }} cluster description, change the `uri` parameter value under `ml_model`:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
      ...
        ml_model {
          name = "<model_name>"
          type = "ML_MODEL_TYPE_CATBOOST"
          uri  = "<new_link_to_model_file_in_Object_Storage>"
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mch }}).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   To update a model, use the [update](../api-ref/MlModel/update.md) REST API method for the [MlModel](../api-ref/MlModel/index.md) resource or the [MlModelService/Update](../api-ref/grpc/ml_model_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterID` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
   * Model name in the `mlModelName` parameter.
   * New link to the model file in {{ objstorage-full-name }} in the `uri` parameter.
   * List of cluster configuration fields to update in the `UpdateMask` parameter.

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Disabling a model {#disable}

{% note info %}


After disabling a model, the corresponding object is kept in the {{ objstorage-full-name }} bucket. If you no longer need this model object, you can [delete](../../storage/operations/objects/delete.md) it.


{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and select the **{{ ui-key.yacloud.clickhouse.cluster.switch_ml-models }}** tab in the left-hand panel.
   1. Select the appropriate model, click ![image](../../_assets/dots.svg), and select **{{ ui-key.yacloud.clickhouse.cluster.ml-models.button_action-delete-ml-model }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To disable a model, run the command:

   ```bash
   {{ yc-mdb-ch }} ml-model delete <model_name> \
     --cluster-name=<cluster_name>
   ```

   You can request the model name with a [list of cluster models](#list) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

   1. Delete from the {{ mch-name }} cluster description the appropriate `ml_model` description block.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mch }}).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   To delete a model, use the [delete](../api-ref/MlModel/delete.md) REST API method for the [MlModel](../api-ref/MlModel/index.md) resource or the [MlModelService/Delete](../api-ref/grpc/ml_model_service.md#Delete) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter.
   * Model name in the `mlModelName` parameter.

   You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters) and the model name with a [list of models in the cluster](#list-ml).

{% endlist %}

## Example {#example-ml-model}

If you do not have a suitable data set or model to process it, you can test machine learning in {{ mch-short-name }} using this example. We prepared a data file for it and trained a model to analyze it. You can upload data to {{ CH }} and see model predictions for different rows of the table.

{% note info %}

In this example, we are going to use public data from the [Amazon Employee Access Challenge](https://www.kaggle.com/c/amazon-employee-access-challenge). The model is trained to predict values in the `ACTION` column. The same data and model are used on [GitHub](https://github.com/ClickHouse/clickhouse-presentations/blob/master/tutorials/catboost_with_clickhouse_ru.md).

{% endnote %}

To upload data to {{ CH }} and test the model:

1. In the [management console]({{ link-console-main }}), add the test model:

   * **{{ ui-key.yacloud.clickhouse.cluster.ml-models.field_ml-model-type }}**: `ML_MODEL_TYPE_CATBOOST`
   * **{{ ui-key.yacloud.clickhouse.cluster.ml-models.field_ml-model-name }}**: `ml_test`
   * **{{ ui-key.yacloud.clickhouse.cluster.ml-models.field_ml-model-uri }}**: `https://{{ s3-storage-host }}/managed-clickhouse/catboost_model.bin`

1. Install the [{{ CH }} CLI]({{ ch.docs }}/interfaces/cli/) and configure your cluster connection as described in the [documentation](../../managed-clickhouse/operations/connect.md#cli).


1. Download the [file](https://{{ s3-storage-host }}/doc-files/managed-clickhouse/train.csv) with data to analyze.


1. [Connect to the database](../../managed-clickhouse/operations/connect.md#cli) via the {{ CH }} CLI.

1. Create a test table:

   ```sql
   CREATE TABLE
               ml_test_table (date Date MATERIALIZED today(),
                             ACTION UInt8,
                             RESOURCE UInt32,
                             MGR_ID UInt32,
                             ROLE_ROLLUP_1 UInt32,
                             ROLE_ROLLUP_2 UInt32,
                             ROLE_DEPTNAME UInt32,
                             ROLE_TITLE UInt32,
                             ROLE_FAMILY_DESC UInt32,
                             ROLE_FAMILY UInt32,
                             ROLE_CODE UInt32)
               ENGINE = MergeTree()
   PARTITION BY date
   ORDER BY date;
   ```

1. Upload the data to the table:

   ```sql
   INSERT INTO ml_test_table FROM INFILE '<file_path>/train.csv' FORMAT CSVWithNames;
   ```

1. Test the model:

   * Get predicted values in the `ACTION` column for the first 10 rows in the table:

      ```sql
      SELECT
          catboostEvaluate('/var/lib/clickhouse/models/ml_test.bin',
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
      LIMIT 10;
      ```

   * Get the probability prediction for the first 10 rows in the table:

      ```sql
      SELECT
          catboostEvaluate('/var/lib/clickhouse/models/ml_test.bin',
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
      LIMIT 10;
      ```
