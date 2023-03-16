# Integrating with {{ dataproc-full-name }}

You can use the Apache Spark™ clusters deployed in {{ dataproc-full-name }}, in your {{ ml-platform-full-name }} projects. To set up integration with {{ dataproc-name }} in {{ ml-platform-name }}:

1. [Prepare the infrastructure](#infra).
2. [Create a {{ dataproc-name }} cluster](#cluster).
3. [Set up the {{ ml-platform-name }} project](#project).
4. [Run your computations](#run-code).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}


### Required paid resources {#paid-resources}

The {{ dataproc-name }} cluster support cost covers the computing resources of the cluster and the storage size (see the [{{ dataproc-name }} pricing](../../data-proc/pricing.md)).


## Prepare the infrastructure {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

### Create a folder and network {#create-folder}

Create a folder where your {{ dataproc-name }} cluster will run.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../_assets/plus-sign.svg) **Create folder**.
   1. Give your folder a name, e.g., `data-folder`.
   1. Select the **Create a default network** option. A [network](../../vpc/concepts/network.md#network) is created with subnets in each [availability zone](../../overview/concepts/geo-scope.md).
   1. Click **Create**.

{% endlist %}

[Learn more about clouds and folders](../../resource-manager/concepts/resources-hierarchy.md).

#### Create an egress NAT gateway {#create-nat}

{% list tabs %}

- Management console

   1. In the `data-folder` folder, select **{{ vpc-name }}**.
   1. In the list of services, select **{{ vpc-name }}**.
   1. On the left-hand panel, select **Gateways**.
   1. Click **Create** and set the gateway parameters:
      * Enter the gateway name, for example `nat-for-cluster`.
      * Gateway **Type**: **Egress NAT**.
      * Click **Save**.
   1. On the left-hand panel, select **Route tables**.
   1. Click **Create** and set up the routing table parameters:
      1. Enter the name, for example `route-table`.
      1. Select the `data-network` network.
      1. Click **Add route**.
         * In the window that opens, select **Gateway** in the **Next hop** field.
         * In the **Gateway** field, select the NAT gateway you created. The destination prefix is set automatically.
         * Click **Add**.
      1. Click **Save**.
   1. Click **Create route table**.

   Next, link the route table to a subnet to route traffic from it via the NAT gateway:

   1. On the left-hand panel, select ![image](../../_assets/vpc/subnets.svg) **Subnets**.
   1. In the line with the desired subnet, click ![image](../../_assets/options.svg).
   1. In the menu that opens, select **Link route table**.
   1. In the window that opens, select the created table from the list.
   1. Click **Link**.

{% endlist %}

### Create a service account for the {#create-sa} cluster.

{% list tabs %}

- Management console

   1. Go to the `data-folder` folder.
   1. In the **Service accounts** tab, click **Create service account**.
   1. Enter the name of the [service account](../../iam/concepts/users/service-accounts.md), for example, `sa-for-data-proc`.
   1. Click **Add role** and assign the following [roles](../../iam/concepts/access-control/roles.md) to the service account:
      * `dataproc.agent` to create and use {{ dataproc-name }} clusters.
      * `vpc.user` to use the {{ dataproc-name }} cluster network.

   1. Click **Create**.

{% endlist %}

### Create an SSH key pair {#ssh}

To ensure a safe connection to the {{ dataproc-name }} cluster hosts, you'll need SSH keys. If you generated SSH keys previously, you can skip this step.

{% cut "How to generate an SSH key pair" %}

{% include [vm-ssh-prepare-key](../../_includes/vm-ssh-prepare-key.md) %}

{% note warning %}

Save the private key in a secure location: you won't be able to connect to the VM without it.

{% endnote %}

{% endcut %}

## Configure {{ ml-platform-name }} {#project}

To work with {{ dataproc-name }} clusters in {{ ml-platform-name }}, create and set up a project.

### Create a project {#create-project}

{% include [include](../../_includes/datasphere/ui-create-project.md) %}

### Edit the project settings {#change-settings}

1. Go to the **Settings** tab and click **![pencil](../../_assets/pencil.svg) Edit**.
1. Under **Advanced settings**, set up:
   * **Folder**: `data-folder`.
   * **Service account**: `sa-for-data-proc`.
   * **Subnet**: A subnet in the `{{ region-id }}-a` availability zone in the `data-folder` folder.

      {% include [subnet-create](../../_includes/subnet-create.md) %}

   * [Security groups](../../vpc/concepts/security-groups.md) if you use them in your organization.

1. Click **Save**.

## Create a {{ dataproc-name }} cluster {#cluster}

Before creating a cluster, make sure that your cloud has enough total SSD space (200 GB is allocated for a new cloud by default).

You can view your current resources under [Quotas]({{ link-console-quotas }}) in the management console.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.
   1. Click **Create resource** and select **{{ dataproc-name }} cluster** from the drop-down list.
   1. Name the cluster in the **Cluster name** field. The cluster name must be unique within the folder.
   1. In the **Version** field, select `2.0`.
   1. In the **Services** field, select: `LIVY`, `SPARK`, `YARN`, and `HDFS`.
   1. Enter the public part of your SSH key in the **Public key** field.
   1. In the **Service account** field, select `sa-for-data-proc`.
   1. In the **Availability** zone field, select `{{ region-id }}-a`.
   1. If necessary, set the properties of Hadoop and its components, for example:

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

   1. Select a network for the cluster.
   1. Enable the **UI Proxy** option to access the [web interfaces of {{ dataproc-name }} components](../../data-proc/concepts/interfaces.md).
   1. Configure subclusters: no more than one main subcluster with a **Master** host and subclusters for data storage or computing.

      {% note info %}

      To run computations on clusters, make sure you have at least one `Compute` or `Data` subcluster.

      {% endnote %}

      The roles of `Compute` and `Data` subcluster are different: you can deploy data storage components on `Data` subclusters, and data processing components on `Compute` subclusters. Storage on a `Compute` subcluster is only used to temporarily store processed files.
   1. For each subcluster, you can configure:
      * The number of hosts.
      * The [host class](../../data-proc/concepts/instance-types.md), which dictates the platform and computing resources available to the host.
      * Storage size and type.
      * The subnet of the network where the cluster is located.
   1. For `Compute` subclusters, you can specify the [autoscaling](../../data-proc/concepts/autoscaling.md) parameters.
   1. When you set up all the subclusters, click **Create cluster**.

{% endlist %}

{{ dataproc-name }} runs the create cluster operation. After the cluster status changes to **Running**, you can [connect](../../data-proc/operations/connect.md) to any active subcluster using the specified SSH key.

The {{ dataproc-name }} cluster that you created will be added to your {{ ml-platform-name }} project under **Resources** ⟶ **{{ dataproc-name }}** ⟶ **Available clusters**.

## Run your computations on the cluster {#run-code}

1. In the {{ ml-platform-name }} interface, open the project that you created the {{ dataproc-name }} cluster for.
1. Open our new **DataSphere Kernel** notebook.
1. In the cell, insert the code to compute. For example:

   ```
   #!spark --cluster <cluster name>
   import random

   def inside(p):
     x, y = random.random(), random.random()
     return x*x + y*y < 1

   NUM_SAMPLES = 1_000_000

   count = sc.parallelize(range(0, NUM_SAMPLES)) \
      .filter(inside).count()
   print("Pi is roughly %f" % (4.0 * count / NUM_SAMPLES))
   ```

   Where `#!spark --cluster <cluster name>` is a mandatory system command to run computations on a cluster.
1. Click ![Run](../../_assets/datasphere/jupyterlab/run.svg) to execute the cell.

Wait for the computation to start. While it is in progress, you'll see logs under the cell.

To learn more about running computations in the {{ dataproc-name }} clusters in {{ ml-platform-name }}, see [{#T}](../../datasphere/concepts/data-proc.md#session).

## Delete the resources you created {#clear-out}

{% note warning %}

Using the cluster deployed in {{ dataproc-name }}, you manage its lifecycle on your own. The cluster will run, and you will be [charged](../../data-proc/pricing.md) for it until you shut it down.

{% endnote %}

{% list tabs %}

- Management console

   To delete a cluster:
   1. In the [management console]({{ link-console-main }}), open the folder with the cluster that you want to delete.
   1. [Disable deletion protection](../../data-proc/operations/cluster-update.md) for the cluster if it is enabled.
   1. Select **{{ dataproc-name }}**.
   1. Click the ![image](../../_assets/options.svg) icon for the required cluster and select **Delete**.
   1. In the window that opens, click **Delete**.

   {{ dataproc-name }} runs the delete cluster operation.

{% endlist %}
