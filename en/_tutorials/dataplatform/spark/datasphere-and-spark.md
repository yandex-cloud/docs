# Using {{ msp-full-name }} in {{ ml-platform-name }}

In {{ ml-platform-name }}, you can use [{{ SPRK }}](../../../managed-spark/) clusters deployed in {{ msp-full-name }}. {{ SPRK }} clusters are connected via [Spark connectors](../../../datasphere/concepts/spark-connector.md). To run computations, a `SparkConnect` job is initiated in a cluster.

To set up integration with {{ msp-name }} in {{ ml-platform-name }}:

1. [Set up your infrastructure](#infra).
1. [Set up the {{ ml-platform-name }} project](#project).
1. [Create a {{ msp-name }} cluster and a Spark connector](#create-spark).
1. [Run your computations](#run-code).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin-datasphere.md) %}

### Required paid resources {#paid-resources}

* {{ msp-name }} cluster: computing resources of cluster components (see [{{ msp-name }} pricing](../../../managed-spark/pricing.md)).
* NAT gateway: hourly use of the gateway and its outgoing traffic (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).

## Set up your infrastructure {#infra}

### Create a folder {#create-folder}

Create a folder where your {{ SPRK }} cluster will run.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Name your folder, e.g., `data-folder`.
   1. Disable **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}** to create your network and subnets manually.
   1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

[Learn more about clouds and folders](../../../resource-manager/concepts/resources-hierarchy.md).

### Create a network {#create-network}

Create a network the {{ SPRK }} cluster will operate in.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to `data-folder` you [created earlier](#create-folder).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the top-right corner, click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, enter a name for the network: `data-network`.

      This will automatically create three subnets in different availability zones.

  1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.

{% endlist %}

### Create and set up a NAT gateway for internet access {#create-nat}

{% list tabs group=instructions %}

- Management console {#console}

   1. In `data-folder`, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/arrows-opposite-to-dots.svg) **{{ ui-key.yacloud.vpc.switch_gateways }}**.
   1. Click **{{ ui-key.yacloud.common.create }}** and set the gateway parameters:
      1. Name the gateway, e.g., `nat-for-cluster`.
      1. Select the gateway **{{ ui-key.yacloud.vpc.gateways.field_type }}**: **{{ ui-key.yacloud.vpc.gateways.value_gateway-type-egress-nat }}**.
      1. Click **{{ ui-key.yacloud.common.save }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
   1. Click **{{ ui-key.yacloud.common.create }}** and specify the route table parameters:
      1. Enter a name, e.g., `route-table`.
      1. Select `data-network`.
      1. Click **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
      1. In the window that opens, select **{{ ui-key.yacloud.vpc.add-static-route.field_next-hop-address }}** in the **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}** field.
      1. In the **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}** field, select the NAT gateway you created. The destination prefix will apply automatically.
      1. Click **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
      1. Click **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.
   1. Associate the route table with a subnet to route traffic from it through the NAT gateway:
      1. In the left-hand panel, select ![image](../../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
      1. In the row with the subnet you need, click ![image](../../../_assets/console-icons/ellipsis.svg).
      1. In the menu that opens, select **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
      1. In the window that opens, select your route table from the list.
      1. Click **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

{% endlist %}

### Create a service account for the {{ msp-full-name }} cluster {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

   1. Navigate to `data-folder`.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Name the [service account](../../../iam/concepts/users/service-accounts.md), e.g., `sa-for-spark`.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the following [roles](../../../iam/concepts/access-control/roles.md) to the service account:
      * `managed-spark.user` to use {{ SPRK }} clusters.
      * `dataproc.agent` to get job information.
      * `dataproc.user` to run jobs in {{ SPRK }} clusters.
      * `vpc.user` to use the {{ SPRK }} cluster network.
      * `iam.serviceAccounts.user` to create resources in the folder on behalf of the service account.

   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Configure {{ ml-platform-name }} {#project}

To work with {{ SPRK }} clusters in {{ ml-platform-name }}, create and set up a project.

### Create a project {#create-project}

{% include [include](../../../_includes/datasphere/ui-create-project.md) %}

### Edit the project settings {#change-settings}

1. Navigate to the **{{ ui-key.yc-ui-datasphere.project-page.tab.settings }}** tab.
1. Under **{{ ui-key.yc-ui-datasphere.edit-project-page.advanced-settings }}**, click ![pencil](../../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Specify the parameters:
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.default-folder }}**: `data-folder`.
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.service-account }}**: `sa-for-spark`.
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.subnet }}**: `data-network-{{ region-id }}-a`.

     {% include [subnet-create](../../../_includes/subnet-create.md) %}

   * [Security groups](../../../vpc/concepts/security-groups.md), if used in your organization.

1. Click **{{ ui-key.yc-ui-datasphere.common.save }}**.

### Edit the community settings {#change-settings-community}

To set up a connection to {{ SPRK }} clusters:

1. Select the community you [created the project](#create-project) in.
1. Navigate to the **{{ ui-key.yc-ui-datasphere.common.settings-key-value }}** tab.
1. Under **{{ ui-key.yc-ui-datasphere.spaces-page.ssa.settings.title }}**, click **{{ ui-key.yc-ui-datasphere.spaces-page.ssa.add-service-account.button }}**.
1. In the window that opens, select the service account you [created earlier](#create-sa) and click **{{ ui-key.yc-ui-datasphere.common.add }}**.
1. Under **{{ ui-key.yc-ui-datasphere.spaces-page.data-processing-sa.title }}**, click **{{ ui-key.yc-ui-datasphere.spaces-page.ssa.add-service-account.button }}** and select the service account you created earlier.

## Create a {{ msp-name }} cluster and a Spark connector {#create-spark}

1. [Create a {{ msp-name }} cluster](../../../managed-spark/operations/cluster-create.md) with your preferred configuration and the following properties:

    * **Service account**: `sa-for-spark`.
    * **Network**: `data-network`.
    * **Subnet**: `data-network-{{ region-id }}-a`.

1. Go to your [{{ ml-platform-name }} workspace]({{ link-datasphere-main }}).
1. In the left-hand panel, select ![image](../../../_assets/console-icons/circles-concentric.svg) **{{ ui-key.yc-ui-datasphere.common.spaces }}**.
1. Open the community you [created the project](#create-project) in and select the project you need.
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![spark-connector](../../../_assets/console-icons/route.svg) **{{ ui-key.yc-ui-datasphere.common.spark-connector }}**.
1. Click **{{ ui-key.yc-ui-datasphere.open-project.create-connector }}**.
1. In the **{{ ui-key.yc-ui-datasphere.common.name }}** field, enter a name for your connector. The name format is as follows:

   {% include [name-format](../../../_includes/name-format-2.md) %}

1. Under **{{ ui-key.yc-ui-datasphere.spark-connector.dataproc-cluster }}**:

   1. Click the **{{ ui-key.yc-ui-datasphere.spark-connector.select-cluster.title }}** tile.
   1. Select the previously created {{ msp-name }} cluster from the list.

1. Optionally, to use an {{ objstorage-name }} bucket for computations, under **{{ ui-key.yc-ui-datasphere.spark-connector.s3-settings }}**, specify the [static access key](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) ID and the [secret](../../../datasphere/concepts/secrets.md) storing the secret part of the static key.
1. Under **{{ ui-key.yc-ui-datasphere.spark-connector.spark-settings }}**, specify the SparkConnect job settings:

    * To use the standard {{ SPRK }} cluster settings for computations, select **{{ ui-key.yc-ui-datasphere.spark-connector.use-default-settings.title }}**.
    * To manually add or update job settings, specify one or more *{{ ui-key.yc-ui-datasphere.common.placeholder.key }}* and *{{ ui-key.yc-ui-datasphere.common.placeholder.value }}* settings.

1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**. You will see a page with detailed info on the connector you created.

## Run the computations {#run-code}

1. {% include [ui-before-begin](../../../_includes/datasphere/ui-before-begin.md) %}
1. In the cell, insert the code to compute, e.g.:

   ```python
   df = spark.createDataFrame([(1, "Sarah"), (2, "Maria")]).toDF(*["id", "name"])
   df.show()
   ```

1. Select **Run** → **Run Selected Cells** from the menu or press **Shift** + **Enter**.
1. In the **{{ ui-key.yc-ui-datasphere.open-project.select-configuration }}** window that opens, go to the **{{ ui-key.yc-ui-datasphere.open-project.with-dataproc-cluster }}** tab.
1. Select the required configuration and connector.
1. Click **{{ ui-key.yc-ui-datasphere.common.select }}**.

   A [local PySpark](https://spark.apache.org/docs/3.5.6/api/python/reference/pyspark.sql/api/pyspark.sql.SparkSession.html) session will become available in the notebook via the `spark` variable. To run code in the notebook cells, the system will create and initiate a SparkConnect [job](../../../managed-spark/concepts/index.md#job) in the {{ SPRK }} cluster.

To terminate the job in the {{ SPRK }} cluster, stop the notebook VM.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [{{ msp-name }} cluster](../../../managed-spark/operations/cluster-delete.md).
1. [NAT gateway](../../../vpc/operations/delete-nat-gateway.md#delete-nat-gateway).

{% endlist %}
