# Creating {{ dataproc-name }} clusters

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.

  1. Click **Create resource** and select **{{ dataproc-name }} cluster** from the drop-down list.

  1. Enter the cluster name in the **Cluster name** field. The cluster name must be unique within the folder.

  1. Select a relevant [image version](../concepts/environment.md) and the components you want to use in the cluster.

     {% note info %}

     Note that some components require other components to work. For example, to use Spark, you need YARN.

     {% endnote %}

  1. Enter the public part of your SSH key in the **Public key** field. For information about how to generate and use SSH keys, see the [{{ compute-full-name }} documentation](../../compute/operations/vm-connect/ssh.md).

  1. Select or create a [service account](../../iam/concepts/users/service-accounts.md) that you want to grant access to the cluster.

  1. Select the availability zone for the cluster.

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
     * [MapReduce](https://hadoop.apache.org/docs/current/hadoop-mapreduce-client/hadoop-mapreduce-client-core/mapred-default.xml)
     * [Spark](https://spark.apache.org/docs/2.2.3/configuration.html#available-properties)
     * [Flume 1.8.0](https://flume.apache.org/releases/content/1.8.0/FlumeUserGuide.html#flume-properties)
     * [HBASE](https://hbase.apache.org/book.html#hbase_default_configurations)
     * [HIVE](https://cwiki.apache.org/confluence/display/Hive/Configuration+Properties)
     * [SQOOP](https://sqoop.apache.org/docs/1.4.6/SqoopUserGuide.html#_additional_import_configuration_properties)
     * [Tez 0.9.1](https://tez.apache.org/releases/0.9.1/tez-api-javadocs/configs/TezConfiguration.html)
     * [Zeppelin 0.7.3](https://zeppelin.apache.org/docs/0.7.3/install/configuration.html)
     * [ZooKeeper 3.4.6](http://zookeeper.apache.org/doc/r3.4.6/zookeeperAdmin#sc_configuration)

  1. Select or create a network for the cluster.

  1. Enable the **UI Proxy** option to access the [web interfaces of the components](../concepts/ui-proxy.md) {{ dataproc-name }}.

  1. Configure subclusters: no more than one main subcluster with a **Master** host and subclusters for data storage or computing.

     The roles of the `Compute` and `Data` subclusters are different: you can deploy data storage components on `Data` and data processing components on `Compute` subclusters. Storage on a `Compute` subcluster is only used to temporarily store processed files.

  1. For each subcluster, you can configure:
     * The number of hosts.
     * [The host class](../concepts/instance-types.md) is the platform and computing resources available to the host.
     * Storage size and type.
     * The subnet of the network where the cluster is located.

  1. For `Compute` subclusters, you can specify the [auto scaling](../concepts/autoscaling.md) parameters.

  1. After you configure all the subclusters you need, click **Create cluster**.

{% endlist %}

{{ dataproc-name }} runs the create cluster operation. After the cluster status changes to **Running**, you can [connect](connect.md) to any active subcluster using the specified SSH key.
