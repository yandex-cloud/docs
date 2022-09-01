# Setting up a project for computing on Apache Spark™ clusters

To start computing on Apache Spark™ clusters, prepare a {{ ml-platform-name }} project. To run computations, create a new {{ dataproc-name }} cluster or use an existing one.

{% include [need-updates](../../_includes/datasphere/migration/need-updates.md) %}

## Set up a project to work with the {{ dataproc-name }} cluster {#settings}

To set up your project:
1. {% include [include](../../_includes/datasphere/first-step.md) %}
1. Click ![image](../../_assets/options.svg) in the line of the project to be configured.
1. In the menu that opens, click **Edit**.
1. In the window that opens, click **Additional settings**.
1. In the **Service account** field, select a service account with the appropriate [roles](../concepts/data-proc.md#roles).
1. In the **Subnet** field, specify the subnet where new {{ dataproc-name }} clusters will be created or existing ones will be used.

{% include [subnet-create](../../_includes/subnet-create.md) %}

## Create a {{ dataproc-name }} cluster {#create}

Before creating a cluster, make sure that your cloud has enough total SSD space (200 GB is allocated to a new cloud by default).

You can calculate the total SSD space required for different configurations using the formula:

```
<number of {{ dataproc-name }} hosts> * 256 + 128
```

| Cluster type | Number of hosts | SSD size |
|--------------|:-----------------:|------------------|
| XS | 1 | 384 GB |
| S | 4 | 1152 GB |
| M | 8 | 2176 GB |
| L | 16 | 4224 GB |
| XL | 32 | 8320 GB |

You can view your current resources under [Quotas]({{ link-console-quotas }}) in the management console.

### Create a cluster through the notebook interface in {{ ml-platform-name }} {#notebook}

{{ ml-platform-name }} monitors the lifetime of the cluster you created and automatically deletes it if it was idle for two hours.

To create a cluster using the notebook interface:
1. {% include [include](../../_includes/datasphere/first-step.md) %}
1. Select the project to create a {{ dataproc-name }} cluster for.
1. In the top panel, click **File** and select **Data Proc Clusters**.
1. In the **Create new cluster** section of the window that opens:
   1. In the **Name** field, enter a name for the {{ dataproc-name }} cluster.
   1. In the **Size** list, select the {{ dataproc-name }} cluster configuration.
1. Click **Create**.

Information about the status of the created cluster will be displayed in the same window.

#### {{ dataproc-name }} cluster statuses {#status}

Once created, a cluster can have the following statuses:
* `STARTING`: The cluster is being created.
* `UP`: The cluster is created and ready to run calculations.
* `DOWN`: Problems creating the cluster.

### Create a cluster in {{ dataproc-name }} {#console}

You can manage the life cycle of a cluster that you created manually. To ensure proper integration, you need to create a cluster with the following parameters:
* **Version**: 1.3 and higher.
* **Enabled services**: `LIVY`, `SPARK`, `YARN`, and `HDFS`.
   {% if product == "yandex-cloud" %}
* **Cluster availability zone**: `{{ region-id }}-a`.
   {% endif %}

{% cut "How to create a {{ dataproc-name }} cluster " %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.
   1. Click **Create resource** and select **{{ dataproc-name }} cluster** from the drop-down list.
   1. Name the cluster in the **Cluster name** field. The cluster name must be unique within the folder.
   1. In the **Version** field, select `1.3`.
   1. In the **Services** field, select: `LIVY`, `SPARK`, `YARN`, and `HDFS`.
   1. Enter the public part of your SSH key in the **Public key** field. For information about how to generate and use SSH keys, see the [{{ compute-full-name }} documentation](../../compute/operations/vm-connect/ssh.md).
   1. Select or create a [service account](../../iam/concepts/users/service-accounts.md) to be granted cluster access.
   1. In the **Availability** zone field, select `{{ region-id }}-a`.
   1. If necessary, set the properties of Hadoop and its components, for example:

      ```
      hdfs:dfs.replication : 2
      hdfs:dfs.blocksize : 1073741824
      spark:spark.driver.cores : 1
      ```

      The available properties are listed in the official documentation for the components:

      * [Hadoop](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/core-default.xml)
      * [HDFS](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml)
      * [YARN](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-common/yarn-default.xml)
      * [mapreduce](https://hadoop.apache.org/docs/current/hadoop-mapreduce-client/hadoop-mapreduce-client-core/mapred-default.xml)
      * [Spark](https://spark.apache.org/docs/2.2.3/configuration.html#available-properties)
      * [Flume 1.8.0](https://flume.apache.org/releases/content/1.8.0/FlumeUserGuide.html#flume-properties)
      * [HBASE](https://hbase.apache.org/book.html#hbase_default_configurations)
      * [HIVE](https://cwiki.apache.org/confluence/display/Hive/Configuration+Properties)
      * [SQOOP](https://sqoop.apache.org/docs/1.4.6/SqoopUserGuide.html#_additional_import_configuration_properties)
      * [Tez 0.9.1](https://tez.apache.org/releases/0.9.1/tez-api-javadocs/configs/TezConfiguration.html)
      * [Zeppelin 0.7.3](https://zeppelin.apache.org/docs/0.7.3/install/configuration.html)
      * [ZooKeeper 3.4.6](http://zookeeper.apache.org/doc/r3.4.6/zookeeperAdmin#sc_configuration)
   1. Select or create a network for the cluster.
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
   1. Once you have configured all of the subclusters you need, click **Create cluster**.

{% endlist %}

{{ dataproc-name }} runs the create cluster operation. After the cluster status changes to **Running**, you can [connect](../../data-proc/operations/connect.md) to any active subcluster using the specified SSH key.

{% endcut %}

Once the cluster is created, add it to the project settings:
1. {% include [include](../../_includes/datasphere/first-step.md) %}
1. Click ![image](../../_assets/options.svg) in the line of the project to be configured.
1. In the menu that opens, click **Edit**.
1. In the window that opens, click **Additional settings**.
1. In the **{{ dataproc-name }} cluster** field, specify the cluster you just created.

## Run a computing operation on a {{ dataproc-name }} cluster {#run-code}

To run computations on a cluster created from the notebook interface:
1. Open the project that you created the Data Proc cluster for.
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

   Where `#!spark --cluster <cluster name>` is a mandatory system command to run computations on a cluster. You can view the cluster name in the **Data Proc Clusters** window in the **File** menu.
1. Click ![image](../../_assets/datasphere/jupyterlab/run.svg) to start the calculation.

Wait for the computation to start. While it is in progress, you'll see logs under the cell.

## Delete a {{ dataproc-name }} cluster {#delete}

If you created a cluster using the notebook interface in {{ ml-platform-name }}, it will be automatically deleted after two hours of idle time. You can also delete it manually through the notebook interface.

A cluster that you created yourself must be deleted in {{ dataproc-name }}.

### Delete a cluster through the notebook interface in {{ ml-platform-name }} {#delete-notebook}

To delete a cluster using the notebook interface:
1. {% include [include](../../_includes/datasphere/first-step.md) %}
1. Select the project to delete the {{ dataproc-name }} cluster from.
1. In the top panel, click **File** and select **Data Proc Clusters**.
1. In the window that opens, click **Destroy** in the cluster line.

### Delete a cluster in {{ dataproc-name }} {#delete-console}

{% list tabs %}

- Management console

   To delete a cluster:
   1. In the [management console]({{ link-console-main }}), open the folder with the cluster that you want to delete.
   1. Select **{{ dataproc-name }}**.
   1. Click the ![image](../../_assets/options.svg) icon for the required cluster and select **Delete**.
   1. Confirm cluster deletion.

   {{ dataproc-name }} runs the delete cluster operation.

{% endlist %}
