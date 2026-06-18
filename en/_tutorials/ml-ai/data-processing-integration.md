# Integration with {{ dataproc-full-name }}

In {{ ml-platform-full-name }} projects, you can use {{ SPRK }} clusters deployed in {{ msp-full-name }}. To set up integration with {{ dataproc-name }} in {{ ml-platform-name }}:

1. [Set up your infrastructure](#infra).
1. [Set up the {{ ml-platform-name }} project](#project).
1. [Create a bucket](#create-bucket).
1. [Create a {{ dataproc-name }} cluster](#create-cluster).
1. [Run your computations](#run-code).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Required paid resources {#paid-resources}

* {{ dataproc-name }} cluster: use of computing resources with a {{ dataproc-name }} markup, use of network drives, retrieval and storage of logs, volume of outgoing traffic (see [{{ dataproc-name }} pricing](../../data-proc/pricing.md)).
* NAT gateway: hourly use of the gateway and its outgoing traffic (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* {{ objstorage-full-name }} bucket: use of storage, data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).

## Set up your infrastructure {#infra}

### Create a folder and network {#create-folder}

Create a folder where your {{ dataproc-name }} cluster will run.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../_assets/console-icons/plus.svg)**{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Name your folder, e.g., `data-folder`.
   1. Disable **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}** to create a network and subnet manually.
   1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

[Learn more about clouds and folders](../../resource-manager/concepts/resources-hierarchy.md).

#### Create a network {#create-network}

Create a network the {{ dataproc-name }} cluster will operate in.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to `data-folder` you [created earlier](#create-folder).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the top-right corner, click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, enter a name for the network: `data-network`.
  1. Disable **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.

{% endlist %}

#### Create a subnet {#create-subnet}

{% list tabs group=instructions %}

- Management console {#console}

    1. In `data-folder`, [navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
    1. Select the `data-network` cloud network.
    1. Click **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.
    1. Enter `data-subnet` as the subnet name.
    1. Select the `{{ region-id }}-a` [availability zone](../../overview/concepts/geo-scope.md).
    1. Enter the subnet **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**, e.g., `10.1.1.0/24`.
    1. Click **{{ ui-key.yacloud.vpc.subnetworks.button_action-create }}**.

{% endlist %}

#### Create an egress NAT gateway {#create-nat}

{% list tabs group=instructions %}

- Management console {#console}

   1. In `data-folder`, [navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/arrows-opposite-to-dots.svg) **{{ ui-key.yacloud.vpc.switch_gateways }}**.
   1. Click **{{ ui-key.yacloud.common.create }}** and set the gateway parameters:
      * Name the gateway, e.g., `nat-for-cluster`.
      * Select the gateway **{{ ui-key.yacloud.vpc.gateways.field_type }}**: **{{ ui-key.yacloud.vpc.gateways.value_gateway-type-egress-nat }}**.
      * Click **{{ ui-key.yacloud.common.save }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
   1. Click **{{ ui-key.yacloud.common.create }}** and specify the route table parameters:
      1. Enter a name, e.g., `route-table`.
      1. Select `data-network`.
      1. Click **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
         * In the window that opens, select **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}** in the **{{ ui-key.yacloud.vpc.add-static-route.field_next-hop-address }}** field.
         * In the **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}** field, select the NAT gateway you created. The destination prefix will apply automatically.
         * Click **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
   1. Click **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.

  Next, associate the route table with the `data-subnet` subnet to route traffic from it through the NAT gateway:

   1. In the left-hand panel, select ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. In the `data-subnet` row, click ![image](../../_assets/console-icons/ellipsis.svg).
   1. In the menu that opens, select **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
   1. In the window that opens, select your route table from the list.
   1. Click **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

{% endlist %}

### Create a service account for the {{ dataproc-name }} cluster {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

   1. Navigate to `data-folder`.
   1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Name the [service account](../../iam/concepts/users/service-accounts.md), e.g., `sa-for-data-proc`.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the following [roles](../../iam/concepts/access-control/roles.md) to the service account:
      * `dataproc.agent` to create and use {{ dataproc-name }} clusters.
      * `dataproc.provisioner` to enable [subcluster autoscaling](../../data-proc/concepts/autoscaling.md).
      * `dataproc.user` to access {{ dataproc-name }} clusters as a [service agent](../../iam/concepts/service-control.md#service-agent).
      * `vpc.user` to use the {{ dataproc-name }} cluster network.
      * `iam.serviceAccounts.user` to create resources in the folder on behalf of the service account.

   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Create an SSH key pair {#ssh}

To ensure a safe connection to the {{ dataproc-name }} cluster hosts, you will need SSH keys. You may skip this step if you have already generated your SSH keys.

{% cut "How to generate an SSH key pair" %}

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  {% include [vm-ssh-prepare-key-linux-macos](../../_includes/vm-ssh-prepare-key-linux-macos.md) %}

- Windows 10/11 {#windows}

  {% include [vm-ssh-prepare-key-win-10-11](../../_includes/vm-ssh-prepare-key-win-10-11.md) %}

- Windows 7/8 {#windows7-8}

  {% include [vm-ssh-prepare-key-win-7-8](../../_includes/vm-ssh-prepare-key-win-7-8.md) %}

{% endlist %}

{% note warning %}

Store your private key securely, as you will not be able to connect to the VM without it.

{% endnote %}

{% endcut %}

## Configure {{ ml-platform-name }} {#project}

To work with {{ dataproc-name }} clusters in {{ ml-platform-name }}, create and set up a project.

### Create a project {#create-project}

{% include [include](../../_includes/datasphere/ui-create-project.md) %}

### Edit the project settings {#change-settings}

1. Navigate to the **{{ ui-key.yc-ui-datasphere.project-page.tab.settings }}** tab.
1. Under **{{ ui-key.yc-ui-datasphere.edit-project-page.advanced-settings }}**, click **![pencil](../../_assets/console-icons/pencil-to-line.svg) {{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Specify the parameters:
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.default-folder }}**: `data-folder`.
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.service-account }}**: `sa-for-data-proc`.
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.subnet }}**: `data-subnet`.
   * [Security groups](../../vpc/concepts/security-groups.md), if used in your organization.

1. Click **{{ ui-key.yc-ui-datasphere.common.save }}**.

### Edit the community settings {#change-settings-community}

To set up a connection to {{ dataproc-name }} clusters:

1. Select the community you [created the project](#create-project) in.
1. Navigate to the **{{ ui-key.yc-ui-datasphere.common.settings-key-value }}** tab.
1. Under **{{ ui-key.yc-ui-datasphere.spaces-page.ssa.settings.title }}**, click **{{ ui-key.yc-ui-datasphere.spaces-page.ssa.add-service-account.button }}**.
1. In the window that opens, select the service account you [created earlier](#create-sa) and click **{{ ui-key.yc-ui-datasphere.common.add }}**.
1. Under **{{ ui-key.yc-ui-datasphere.spaces-page.data-processing-sa.title }}**, click **{{ ui-key.yc-ui-datasphere.spaces-page.ssa.add-service-account.button }}** and select the service account you created earlier.

## Create a bucket {#create-bucket}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to create a bucket in.
  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, enter a name for the bucket.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}**, and **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** fields, select **{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}**.
  1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

## Create a {{ dataproc-name }} cluster {#create-cluster}

Before creating a cluster, make sure that your cloud has enough total SSD space (200 GB is allocated for a new cloud by default).

You can view your current resources under [Quotas]({{ link-console-quotas }}) in the management console.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.
   1. Click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_data-proc }}** from the drop-down list.
   1. Enter a name for the cluster in the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field. It must be unique within the folder.
   1. In the **{{ ui-key.yacloud.mdb.forms.base_field_environment }}** field, select `PRODUCTION`.
   1. In the **{{ ui-key.yacloud.mdb.forms.config_field_version }}** field, select `2.1`.
   1. In the **{{ ui-key.yacloud.mdb.forms.config_field_services }}** field, select `LIVY`, `SPARK`, `YARN`, and `HDFS`.
   1. Enter the public part of your SSH key in the **{{ ui-key.yacloud.mdb.forms.config_field_public-keys }}** field.
   1. In the **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** field, select `sa-for-data-proc`.
   1. In the **{{ ui-key.yacloud.mdb.forms.config_field_zone }}** field, select `{{ region-id }}-a`.
   1. In the **{{ ui-key.yacloud.mdb.forms.config_field_properties }}** field, set up cluster integration with {{ ml-platform-name }}:

      ```text
      livy:livy.spark.deploy-mode : client
      ```

      If necessary, set the properties of Hadoop and its components, for example:

      ```text
      hdfs:dfs.replication : 2
      hdfs:dfs.blocksize : 1073741824
      spark:spark.driver.cores : 1
      ```

      {% cut "Available properties from the official documentation for the components" %}

      * [Hadoop](https://hadoop.apache.org/docs/r3.3.2/hadoop-project-dist/hadoop-common/core-default.xml)
      * [HDFS](https://hadoop.apache.org/docs/r3.3.2/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml)
      * [Spark](https://archive.apache.org/dist/spark/docs/3.3.2/configuration.html#available-properties)
      * [YARN](https://hadoop.apache.org/docs/r3.3.2/hadoop-yarn/hadoop-yarn-common/yarn-default.xml)

      {% endcut %}

   1. Select the created bucket in the **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}** field.
   1. Select `data-network`.
   1. Enable **{{ ui-key.yacloud.mdb.forms.config_field_ui_proxy }}** to access the [web interfaces of {{ dataproc-name }} components](../../data-proc/concepts/interfaces.md).
   1. Configure subclusters: no more than one main subcluster with a **{{ ui-key.yacloud.mdb.forms.label_master-subcluster }}** host and subclusters for data storage or computing.

      {% note info %}

      To run computations on clusters, make sure you have at least one `Compute` or `Data` subcluster.

      {% endnote %}

      The `Compute` and `Data` subcluster roles are different: you can deploy data storage components on `Data` subclusters and data processing components, on `Compute` subclusters. The `Compute` subcluster storage is only used to temporarily store processed files.
   1. For each subcluster, you can configure:
      * Number of hosts.
      * [Host class](../../data-proc/concepts/instance-types.md), i.e., the platform and computing resources available to the host.
      * Storage size and type.
      * Subnet of the network where the cluster is located.
   1. For `Compute` subclusters, you can specify the [autoscaling](../../data-proc/concepts/autoscaling.md) parameters.
   1. When you have set up all the subclusters, click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

{% endlist %}

{{ dataproc-name }} will run the cluster create operation. After the cluster status changes to **{{ ui-key.yc-ui-datasphere.data-proc.running }}**, you can [connect](../../data-proc/operations/connect-ssh.md) to any active subcluster using the specified SSH key.

The {{ dataproc-name }} cluster you created will be added to your {{ ml-platform-name }} project under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** ⟶ **{{ ui-key.yc-ui-datasphere.resources.dataProc }}** ⟶ **{{ ui-key.yc-ui-datasphere.data-proc.available-clusters }}**.

## Run your computations on the cluster {#run-code}

1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}
1. In the cell, insert the code to compute, e.g.:

   ```python
   #!spark --cluster <cluster_name>
   import random

   def inside(p):
       x, y = random.random(), random.random()
       return x*x + y*y < 1
   
   NUM_SAMPLES = 1_000_000
   
   count = sc.parallelize(range(0, NUM_SAMPLES)) \
       .filter(inside).count()
   print("Pi is roughly %f" % (4.0 * count / NUM_SAMPLES))
   ```

   Where `#!spark --cluster <cluster_name>` is a required system command to run computations on a cluster.

1. Create another cell and paste into it the code to write data to S3 stating the bucket name:

   ```python
   #!spark --cluster <cluster_name>
   data = [[1, "tiger"], [2, "lion"], [3, "snow leopard"]]
   df = spark.createDataFrame(data, schema="id LONG, name STRING")
   df.repartition(1).write.option("header", True).mode("overwrite").csv("s3a://<bucket_name>/test")
   ```

1. Run all cells by selecting **Run** ⟶ **Run All Cells**.
1. In the **{{ ui-key.yc-ui-datasphere.open-project.select-configuration }}** window that opens, select a VM configuration and click **{{ ui-key.yc-ui-datasphere.common.select }}**.

   Wait for computations to run. While they are in progress, logs will be displayed under the cell.

The file will appear in the bucket's `test` folder. To view bucket contents in the {{ jlab }}Lab interface, create and activate an [S3 connector](../../datasphere/operations/data/s3-connectors.md) in your project.

{% include [dataproc-s3-connector](../../_includes/datasphere/data-processing-s3-connector.md) %}

To learn more about running computations on {{ dataproc-name }} clusters in {{ ml-platform-name }}, see [this concept](../../datasphere/concepts/data-processing.md#existing-clusters).

## Delete the resources you created {#clear-out}

{% note warning %}

As a user of a cluster deployed in {{ dataproc-name }}, you manage its lifecycle yourself. The cluster will run, and fees will be [charged](../../data-proc/pricing.md), until you shut it down.

{% endnote %}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

* [Objects](../../storage/operations/objects/delete-all.md) from the bucket
* [Bucket](../../storage/operations/buckets/delete.md)
* [{{ dataproc-name }} cluster](../../data-proc/operations/cluster-delete.md)
* [{{ ml-platform-name }} project](../../datasphere/operations/projects/delete.md)
* [Subnet](../../vpc/operations/subnet-delete.md)
* [Route table](../../vpc/operations/delete-route-table.md)
* [NAT gateway](../../vpc/operations/delete-nat-gateway.md)
* [Network](../../vpc/operations/network-delete.md)
* [Service account](../../iam/operations/sa/delete.md)
