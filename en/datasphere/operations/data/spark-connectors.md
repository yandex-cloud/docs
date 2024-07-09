# Working with Spark connectors

In {{ ml-platform-name }}, you can use [Spark connectors](../../concepts/spark-connector.md) to work with existing or automatically created [{{ dataproc-full-name }}](../../../data-proc/) clusters.

## Getting started {#before-begin}

{% include [settings-for-dataproc](../../../_includes/datasphere/settings-for-dataproc.md) %}

## Creating a Spark connector {#create}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![spark-connector](../../../_assets/console-icons/route.svg)**{{ ui-key.yc-ui-datasphere.common.spark-connector }}**.
1. Click **{{ ui-key.yc-ui-datasphere.open-project.create-connector }}**.
1. In the **{{ ui-key.yc-ui-datasphere.common.name }}** field, enter a name for the connector. The name format is as follows:

   {% include [name-format](../../../_includes/name-format-2.md) %}

1. Under **{{ ui-key.yc-ui-datasphere.spark-connector.dataproc-cluster }}**, choose which cluster you plan to work with:

   * **{{ ui-key.yc-ui-datasphere.spark-connector.select-cluster.title }}**: Select an existing {{ dataproc-name }} cluster or click **{{ ui-key.yc-ui-datasphere.spark-connector.create-cluster-in-dataproc }}** to go to {{ dataproc-name }} and create a new one. The {{ dataproc-name }} persistent cluster must have the `livy:livy.spark.deploy-mode : client` setting.
   * **{{ ui-key.yc-ui-datasphere.spark-connector.create-temporary-cluster.title }}**: Select to create a temporary {{ dataproc-name }} cluster. A temporary cluster will be created the first time you run computations in the project notebook.

1. (Optional) Under **{{ ui-key.yc-ui-datasphere.spark-connector.s3-settings }}**, specify the [static access key](../../../iam/operations/sa/create-access-key.md) ID and the [secret](../../concepts/secrets.md) in which the secret part of the static key for the [S3 connector](../../concepts/s3-connector.md) is stored.

   **{{ ui-key.yc-ui-datasphere.spark-connector.s3-settings }}** allows you to specify data for connecting to an S3 bucket. We recommend this when working with {{ objstorage-name }} buckets in any clusters, especially in {{ dataproc-name }} clusters without the HDFS option enabled.

1. Under **{{ ui-key.yc-ui-datasphere.spark-connector.spark-settings }}**, select **{{ ui-key.yc-ui-datasphere.spark-connector.use-default-settings.title }}** to use the default {{ dataproc-name }} cluster settings or specify the *{{ ui-key.yc-ui-datasphere.common.placeholder.key }}* and *{{ ui-key.yc-ui-datasphere.common.placeholder.value }}* parameters to manually add or modify the {{ dataproc-name }} cluster settings.

   {% note tip %}

   For {{ dataproc-name }} clusters without the HDFS option enabled, set the additional `spark.hadoop.fs.s3a.fast.upload.buffer=bytebuffer` parameter.

   {% endnote %}

1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**. You will see a page with detailed information about the created connector.

## Using a {{ dataproc-name }} cluster in a project {#usage}

{% include [dataproc-spark-connector](../../../_includes/datasphere/dataproc-spark-connector.md) %}

{% include [ui-before-begin](../../../_includes/datasphere/ui-before-begin.md) %}

1. Run any cell by selecting **Run** → **Run Selected Cells** or pressing **Shift** + **Enter**.
1. In the **{{ ui-key.yc-ui-datasphere.open-project.select-configuration }}** window that opens, go to the **{{ ui-key.yc-ui-datasphere.open-project.with-dataproc-cluster }}** tab.
1. Select the required configuration and connector.
1. Click **{{ ui-key.yc-ui-datasphere.common.select }}**.

To disable the {{ dataproc-name }} temporary cluster created with the Spark connector, stop the notebook VM.

To stop paying for the {{ dataproc-name }} persistent cluster, [delete it](../../../data-proc/operations/cluster-delete.md) using the management console.

## Editing a Spark connector {#change}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![spark-connector](../../../_assets/console-icons/route.svg) **{{ ui-key.yc-ui-datasphere.common.spark-connector }}**.
1. In the list of Spark connectors, select the one you want to edit. Click ![pencil](../../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Edit the Spark connector by changing its name or parameters.
1. Click **{{ ui-key.yc-ui-datasphere.common.save }}**.

## Sharing a Spark connector {#share}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![spark-connector](../../../_assets/console-icons/route.svg) **{{ ui-key.yc-ui-datasphere.common.spark-connector }}**.
1. Select the required Spark connector from the list.
1. Go to the **{{ ui-key.yc-ui-datasphere.common.access }}** tab.
1. Enable the visibility option next to the name of the community you want to share the Spark connector with.

To make a Spark connector available for use in another project, the project administrator should [add](../projects/use-shared-resource.md) it to the **{{ ui-key.yc-ui-datasphere.common.shared-with-project-resources }}** tab.

## Deleting a Spark connector {#delete}

You can only delete a connector that is not available in the community.

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![spark-connector](../../../_assets/console-icons/route.svg) **{{ ui-key.yc-ui-datasphere.common.spark-connector }}**.
1. In the list of Spark connectors, select the one you want to delete. Click **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Click **{{ ui-key.yc-ui-datasphere.common.submit }}**.

You will see a message saying that the connector has been deleted.