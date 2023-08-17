# Managing machine learning models in {{ mch-name }}

{{ mch-short-name }} allows you to analyze data by applying [CatBoost](https://catboost.ai/) machine learning models without additional tools. To apply a model, connect to a cluster and access it in a SQL query using the built-in [`modelEvaluate()`]({{ ch.docs }}/sql-reference/functions/other-functions#function-modelevaluate) function. After running this query, you get model predictions for each row of input data.

## Before adding a model {#prereq}

{{ mch-short-name }} only works with readable models uploaded to {{ objstorage-full-name }}:


1. [Upload](../../storage/operations/objects/upload.md) the trained model file to {{ objstorage-full-name }}.

1. Configure access to the model file using a [service account](../../iam/concepts/users/service-accounts.md):

   1. [Connect a service account to a cluster](s3-access.md#connect-service-account).
   1. [Assign the account the role](s3-access.md#configure-acl) of `storage.viewer`.
   1. In the bucket ACL, [grant the account](../../storage/operations/buckets/edit-acl.md) `READ` permission.

1. [Get a link](s3-access.md#get-link-to-object) to the model file.


## Getting a list of models in a cluster {#list}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mch-name }}**.
   1. Click the name of the cluster and select the **Machine learning** tab from the left-hand panel.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of models in a cluster, run the command:

   ```bash
   {{ yc-mdb-ch }} ml-model list --cluster-name=<cluster name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get a list of models in a cluster, use the [list](../api-ref/MlModel/list.md) REST API method for the [MlModel](../api-ref/MlModel/index.md) resource or the [MlModelService/List](../api-ref/grpc/ml_model_service.md#List) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Getting detailed information about a model {#get}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mch-name }}**.
   1. Click the name of the cluster and select the **Machine learning** tab from the left-hand panel.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get model details, run this command:

   ```bash
   {{ yc-mdb-ch }} ml-model get <model name> \
     --cluster-name=<cluster name>
   ```

   You can request the model name with a [list of cluster models](#list) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get model details, use the [get](../api-ref/MlModel/get.md) REST API method for the [MlModel](../api-ref/MlModel/index.md) resource or the [MlModelService/Get](../api-ref/grpc/ml_model_service.md#Get) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterID` parameter.
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

      1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mch-name }}**.
      1. Click the name of the cluster and select the **Machine learning** tab from the left-hand panel.
      1. Click **Add model**.

   1. Configure the model parameters:

      * **Type**: `ML_MODEL_TYPE_CATBOOST`.
      * **Name**: Model name. Model name is one of the arguments of the `modelEvaluate()` function, which is used to call the model in {{ CH }}.
      * **URL**: Model address in {{ objstorage-full-name }}.

   1. Click **Add** and wait for the model to be added.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To add a model to a cluster, run the command:

   ```bash
   {{ yc-mdb-ch }} ml-model create <model name> \
     --cluster-name=<cluster name> \
     --type=ML_MODEL_TYPE_CATBOOST \
     --uri=<link to model file in {{ objstorage-full-name }}>
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

   1. To the {{ mch-name }} cluster description, add the `ml_model` block with a description of the added machine learning model:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        ml_model {
          name = "<model name>"
          type = "ML_MODEL_TYPE_CATBOOST"
          uri  = "<link to model file in {{ objstorage-full-name }}>"
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mch }}).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   To add a model, use the [create](../api-ref/MlModel/create.md) REST API method for the [MlModel](../api-ref/MlModel/index.md) resource or the [MlModelService/Create](../api-ref/grpc/ml_model_service.md#Create) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterID` parameter.
   * Model name in the `mlModelName` parameter.
   * `ML_MODEL_TYPE_CATBOOST` model type in the `type` parameter.
   * Link to the model file in {{ objstorage-full-name }} in the `uri` parameter.

   The cluster ID can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Applying a model {#apply}

To apply the model to data stored in a {{ CH }} cluster:

1. Connect to the cluster [using the client](../../managed-clickhouse/operations/connect.md#cli) {{ CH }} CLI or go to the [SQL](../../managed-clickhouse/operations/web-sql-query.md) tab in the cluster management console.
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

## Updating a model {#update}

{{ mch-name }} doesn't track changes in the model file located in the {{ objstorage-full-name }} bucket.

To update the contents of a model that is already connected to the cluster:


1. [Upload the file](../../storage/operations/objects/upload.md) with the current model to {{ objstorage-full-name }}.
1. [Get a link](s3-access.md#get-link-to-object) to this file.
1. Change the parameters of the model connected to {{ mch-name }} by providing a new link to the model file.


{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mch-name }}**.
   1. Click the name of the cluster and select the **Machine learning** tab from the left-hand panel.
   1. Select the appropriate model, click ![image](../../_assets/dots.svg), and select **Edit**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the link to the model file in the {{ objstorage-full-name }} bucket, run the command:

   ```bash
   {{ yc-mdb-ch }} ml-model update <model name> \
     --cluster-name=<cluster name> \
     --uri=<new link to file in {{ objstorage-full-name }}>
   ```

   You can request the model name with a [list of cluster models](#list) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

   1. In the {{ mch-name }} cluster description, change the `uri` parameter value under `ml_model`:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
      ...
        ml_model {
          name = "<model name>"
          type = "ML_MODEL_TYPE_CATBOOST"
          uri  = "<new link to model file in {{ objstorage-full-name }}>"
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mch }}).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   To update a model, use the [update](../api-ref/MlModel/update.md) REST API method for the [MlModel](../api-ref/MlModel/index.md) resource or the [MlModelService/Update](../api-ref/grpc/ml_model_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](./cluster-list.md#list-clusters).
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

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mch-name }}**.
   1. Click the name of the cluster and select the **Machine learning** tab from the left-hand panel.
   1. Select the appropriate model, click ![image](../../_assets/dots.svg), and select **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To disable a model, run the command:

   ```bash
   {{ yc-mdb-ch }} ml-model delete <model name> \
     --cluster-name=<cluster name>
   ```

   You can request the model name with a [list of cluster models](#list) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

   1. Delete from the {{ mch-name }} cluster description the appropriate `ml_model` description block.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mch }}).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   To delete a model, use the [delete](../api-ref/MlModel/delete.md) REST API method for the [MlModel](../api-ref/MlModel/index.md) resource or the [MlModelService/Delete](../api-ref/grpc/ml_model_service.md#Delete) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterID` parameter.
   * Model name in the `mlModelName` parameter.

   You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters) and the model name with a [list of models in the cluster](#list-ml).

{% endlist %}

## Example {#example-ml-model}

If you don't have a suitable data set or model to process it, you can test machine learning in {{ mch-short-name }} using this example. We prepared a data file for it and trained a model to analyze it. You can upload data to {{ CH }} and see model predictions for different rows of the table.

{% note info %}

In this example, we'll use public data from the [Amazon Employee Access Challenge](https://www.kaggle.com/c/amazon-employee-access-challenge). The model is trained to predict values in the `ACTION` column. The same data and model are used on [GitHub](https://github.com/ClickHouse/clickhouse-presentations/blob/master/tutorials/catboost_with_clickhouse_ru.md).

{% endnote %}

To upload data to {{ CH }} and test the model:

1. Install the [{{ CH }} CLI]({{ ch.docs }}/interfaces/cli/) and configure your cluster connection as described in the [documentation](../../managed-clickhouse/operations/connect.md#cli).


1. Download the [file](https://{{ s3-storage-host }}/doc-files/managed-clickhouse/train.csv) with data to analyze:

   ```bash
   wget https://{{ s3-storage-host }}/doc-files/managed-clickhouse/train.csv
   ```


1. Create a table for the data:

   ```bash
   clickhouse-client --host <host FQDN> \
                     --database <DB name>
                     --secure \
                     --user <DB username> \
                     --password <DB user password> \
                     --port 9440 \
                     -q 'CREATE TABLE ml_test_table (date Date MATERIALIZED today(), ACTION UInt8, RESOURCE UInt32, MGR_ID UInt32, ROLE_ROLLUP_1 UInt32, ROLE_ROLLUP_2 UInt32, ROLE_DEPTNAME UInt32, ROLE_TITLE UInt32, ROLE_FAMILY_DESC UInt32, ROLE_FAMILY UInt32, ROLE_CODE UInt32) ENGINE = MergeTree() PARTITION BY date ORDER BY date'
   ```

1. Upload the data to the table:

   ```bash
   clickhouse-client --host <host FQDN> \
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
   * **URL**: `https://{{ s3-storage-host }}/managed-clickhouse/catboost_model.bin`.

1. Test the model:
   1. Connect to the cluster [using the client](../../managed-clickhouse/operations/connect.md#cli) {{ CH }} CLI or go to the [SQL](../../managed-clickhouse/operations/web-sql-query.md) tab in the cluster management console.
   1. Test the model using queries:
      * Predicted values for first 10 rows of the `ACTION` column:

         ```sql
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

         ```sql
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
