# Integrating with {{ dataproc-full-name }}

You can use the Apache Spark™ clusters deployed in {{ dataproc-full-name }}, in your {{ ml-platform-full-name }} projects. To set up integration with {{ dataproc-name }} in {{ ml-platform-name }}:

1. [Prepare your infrastructure](#infra).
1. [Create a bucket](#create-bucket).
1. [Create a {{ dataproc-name }} cluster](#create-cluster).
1. [Set up the {{ ml-platform-name }} project](#project).
1. [Run your computations](#run-code).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}


### Required paid resources {#paid-resources}

The {{ dataproc-name }} cluster support cost covers the computing resources of the cluster and the storage size (see the [{{ dataproc-name }} pricing](../../data-proc/pricing.md)).


## Prepare the infrastructure {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Create a folder and network {#create-folder}

Create a folder where your {{ dataproc-name }} cluster will run.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../_assets/console-icons/plus.svg)**{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Give your folder a name, e.g., `data-folder`.
   1. Select **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}**. This will create a [network](../../vpc/concepts/network.md#network) with subnets in each [availability zone](../../overview/concepts/geo-scope.md).
   1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

[Learn more about clouds and folders](../../resource-manager/concepts/resources-hierarchy.md).

#### Create an egress NAT gateway {#create-nat}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the `data-folder` folder, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/arrows-opposite-to-dots.svg) **{{ ui-key.yacloud.vpc.switch_gateways }}**.
   1. Click **{{ ui-key.yacloud.common.create }}** and set the gateway parameters:
      * Enter the gateway name, e.g., `nat-for-cluster`.
      * Gateway **{{ ui-key.yacloud.vpc.gateways.field_type }}**: **{{ ui-key.yacloud.vpc.gateways.value_gateway-type-egress-nat }}**.
      * Click **{{ ui-key.yacloud.common.save }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
   1. Click **{{ ui-key.yacloud.common.create }}** and specify the route table parameters:
      1. Enter the name, e.g., `route-table`.
      1. Select the `data-network` network.
      1. Click **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
         * In the window that opens, select **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}** in the **{{ ui-key.yacloud.vpc.add-static-route.field_next-hop-address }}** field.
         * In the **{{ ui-key.yacloud.vpc.add-static-route.value_gateway }}** field, select the NAT gateway you created. The destination prefix will be propagated automatically.
         * Click **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
   1. Click **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.

   Next, link the route table to a subnet to route traffic from it via the NAT gateway:

   1. In the left-hand panel, select ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. In the line with the subnet you need, click ![image](../../_assets/console-icons/ellipsis.svg).
   1. In the menu that opens, select **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
   1. In the window that opens, select the created table from the list.
   1. Click **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

{% endlist %}

### Create a service account for the cluster {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the `data-folder` folder.
   1. In the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab, click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter the name of the [service account](../../iam/concepts/users/service-accounts.md), for example, `sa-for-data-proc`.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the following [roles](../../iam/concepts/access-control/roles.md) to the service account:
      * `dataproc.agent` to create and use {{ dataproc-name }} clusters.
      * `dataproc.provisioner` to enable [subcluster autoscaling](../../data-proc/concepts/autoscaling.md).
      * `vpc.user` to use the {{ dataproc-name }} cluster network.
      * `iam.serviceAccounts.user` to create resources in the folder on behalf of the service account.

   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Create an SSH key pair {#ssh}

To ensure a safe connection to the {{ dataproc-name }} cluster hosts, you will need SSH keys. You may skip this step if you have already generated your SSH keys.

{% cut "How to generate an SSH key pair" %}

{% include [vm-ssh-prepare-key](../../_includes/vm-ssh-prepare-key.md) %}

{% note warning %}

Save the private key in a secure location, as you will not be able to connect to the VM without it.

{% endnote %}

{% endcut %}

## Configure {{ ml-platform-name }} {#project}

To work with {{ dataproc-name }} clusters in {{ ml-platform-name }}, create and set up a project.

### Create a project {#create-project}

{% include [include](../../_includes/datasphere/ui-create-project.md) %}

### Edit the project settings {#change-settings}

1. Go to the **{{ ui-key.yc-ui-datasphere.project-page.tab.settings }}** tab.
1. Under **{{ ui-key.yc-ui-datasphere.edit-project-page.advanced-settings }}**, click **![pencil](../../_assets/console-icons/pencil-to-line.svg) {{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Specify the parameters:
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.default-folder }}**: `data-folder`.
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.service-account }}**: `sa-for-data-proc`.
   * **{{ ui-key.yc-ui-datasphere.project-page.settings.subnet }}**: Subnet of the `{{ region-id }}-a` availability zone in the `data-folder` folder.

      {% include [subnet-create](../../_includes/subnet-create.md) %}

   * [Security groups](../../vpc/concepts/security-groups.md), if used in your organization.

1. Click **{{ ui-key.yc-ui-datasphere.common.save }}**.

## Create a bucket {#create-bucket}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
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
   1. In the **{{ ui-key.yacloud.mdb.forms.config_field_version }}** field, select `2.0`.
   1. In the **{{ ui-key.yacloud.mdb.forms.config_field_services }}** field, select: `LIVY`, `SPARK`, `YARN`, and `HDFS`.
   1. Enter the public part of your SSH key in the **{{ ui-key.yacloud.mdb.forms.config_field_public-keys }}** field.
   1. In the **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** field, select `sa-for-data-proc`.
   1. In the **{{ ui-key.yacloud.mdb.forms.config_field_zone }}** field, select `{{ region-id }}-a`.
   1. If required, set the properties of Hadoop and its components in the **{{ ui-key.yacloud.mdb.forms.config_field_properties }}** field, such as:

      ```
      hdfs:dfs.replication : 2
      hdfs:dfs.blocksize : 1073741824
      spark:spark.driver.cores : 1
      ```

      {% cut "The available properties are listed in the official documentation for the components" %}

      * [Flume 1.8.0](https://flume.apache.org/releases/content/1.8.0/FlumeUserGuide.html#flume-properties)
      * [Hadoop](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/core-default.xml)
      * [HBASE](https://hbase.apache.org/book.html#hbase_default_configurations)
      * [HDFS](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml)
      * [HIVE](https://cwiki.apache.org/confluence/display/Hive/Configuration+Properties)
      * [mapreduce](https://hadoop.apache.org/docs/current/hadoop-mapreduce-client/hadoop-mapreduce-client-core/mapred-default.xml)
      * [Spark](https://spark.apache.org/docs/2.2.3/configuration.html#available-properties)
      * [SQOOP](https://sqoop.apache.org/docs/1.4.6/SqoopUserGuide.html#_additional_import_configuration_properties)
      * [Tez 0.9.1](https://tez.apache.org/releases/0.9.1/tez-api-javadocs/configs/TezConfiguration.html)
      * [YARN](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-common/yarn-default.xml)
      * [Zeppelin 0.7.3](https://zeppelin.apache.org/docs/0.7.3/install/configuration.html)
      * [ZooKeeper 3.4.6](http://zookeeper.apache.org/doc/r3.4.6/zookeeperAdmin#sc_configuration)

      {% endcut %}

   1. Select the created bucket in the **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}** field.
   1. Select a network for the cluster.
   1. Enable **{{ ui-key.yacloud.mdb.forms.config_field_ui_proxy }}** to access the [web interfaces of {{ dataproc-name }} components](../../data-proc/concepts/interfaces.md).
   1. Configure subclusters: no more than one main subcluster with a **{{ ui-key.yacloud.mdb.forms.label_master-subcluster }}** host and subclusters for data storage or computing.

      {% note info %}

      To run computations on clusters, make sure you have at least one `Compute` or `Data` subcluster.

      {% endnote %}

      The roles of `Compute` and `Data` subclusters are different: you can deploy data storage components on `Data` subclusters, and data processing components on `Compute` subclusters. The `Compute` subcluster storage is only used to temporarily store processed files.
   1. For each subcluster, you can configure:
      * Number of hosts.
      * [Host class](../../data-proc/concepts/instance-types.md): Platform and computing resources available to the host.
      * Storage size and type.
      * Subnet of the network where the cluster is located.
   1. For `Compute` subclusters, you can specify the [autoscaling](../../data-proc/concepts/autoscaling.md) parameters.
   1. When you have set up all the subclusters, click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

{% endlist %}

{{ dataproc-name }} will run the cluster create operation. After the cluster status changes to **{{ ui-key.yc-ui-datasphere.data-proc.running }}**, you can [connect](../../data-proc/operations/connect.md) to any active subcluster using the specified SSH key.

The {{ dataproc-name }} cluster you created will be added to your {{ ml-platform-name }} project under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** ⟶ **{{ ui-key.yc-ui-datasphere.resources.dataProc }}** ⟶ **{{ ui-key.yc-ui-datasphere.data-proc.available-clusters }}**.

## Run your computations on the cluster {#run-code}

1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}
1. In the cell, insert the code to compute. For example:

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

   Wait for the computation to start. While it is in progress, you will see logs under the cell.

1. Write data to S3 by specifying the bucket name:

   ```python
   #!spark
   data = [[1, "tiger"], [2, "lion"], [3, "snow leopard"]]
   df = spark.createDataFrame(df, schema="id LONG, name STRING")
   df.repartition(1).write.option("header", True).csv("s3://<bucket_name>/")
   ```

1. Run the cells. To do this, select **Run** ⟶ **Run Selected Cells** or press **Shift** + **Enter**.

The file will appear in the bucket. To view bucket contents in the {{ jlab }}Lab interface, create and activate an [S3 connector](../../datasphere/operations/data/s3-connectors.md) in your project.

{% include [dataproc-s3-connector](../../_includes/datasphere/dataproc-s3-connector.md) %}

To learn more about running computations on {{ dataproc-name }} clusters in {{ ml-platform-name }}, see [this concept](../../datasphere/concepts/data-proc.md#existing-clusters).

## Delete the resources you created {#clear-out}

{% note warning %}

As a user of a cluster deployed in {{ dataproc-name }}, you manage its lifecycle yourself. The cluster will run, and fees will be [charged](../../data-proc/pricing.md), until you shut it down.

{% endnote %}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

* [Objects](../../storage/operations/objects/delete-all.md) from the bucket
* [Bucket](../../storage/operations/buckets/delete.md)
* [Cluster](../../data-proc/operations/cluster-delete.md)
* [Project](../../datasphere/operations/projects/delete.md)
* [Subnet](../../vpc/operations/subnet-delete.md)
* [Route table](../../vpc/operations/delete-route-table.md)
* [NAT gateway](../../vpc/operations/delete-nat-gateway.md)
* [Network](../../vpc/operations/network-delete.md)
* [Service account](../../iam/operations/sa/delete.md)
