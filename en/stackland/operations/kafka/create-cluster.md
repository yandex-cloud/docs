# Creating a cluster {{ KF }}

If you have a [project](../projects/create-project.md), you can create an [{{ KF }}](../../concepts/components/kafka.md) cluster in it.

{% list tabs group=instructions %}

- CLI {#cli}

  1. If the project does not exist yet, create it: `kubectl create namespace <project name>`.
  1. Create the `KafkaCluster` resource file, e.g., using the `touch kafkacluster.yaml` command.
  1. Open the file and paste the configuration below into it:

      {% include notitle [YAML-file kafka cluster](../../_includes/yamls/operations/kafka/kafkacluster.md) %}

  1. Apply the manifest: `kubectl apply -f kafkacluster.yaml -n <project name>`. Optionally, you can specify the project name in the `metadata.namespace` resource property and skip it in the command.

  To connect to the cluster, follow the guide on [Connecting to an {{ KF }} cluster](connect-to-kafka.md).


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. In the left-hand menu, select **Kafka Clusters**.
  1. Click **Create**.
  1. Fill out the fields as follows:

      * **Cluster name**: Use only lowercase letters, numbers, and hyphens.
      * **Kafka version**: Select it from the list of available versions.
      * **Number of replicas** of the message processing service.
      * **Computing resources**, where **Limits** is the upper limit and **Requests** is the lower limit.
      * **Storage**, where **Disk type** is the storage class (`stackland-nvme`, `stackland-ssd`, `stackland-hdd`, `stackland-other`). Learn more about storage classes in [Disk subsystem](../../concepts/components/disk-storage.md#storage-classes). You can also enable **Automatic storage expansion**.
      * **Number of replicas** of the coordination service.
      * **Computing resources**, where **Limits** is the upper limit and **Requests** is the lower limit.
      * **Storage**, where **Disk type** is the storage class (`stackland-nvme`, `stackland-ssd`, `stackland-hdd`, `stackland-other`).

  1. Click **Create**.

  To connect to the cluster, follow the guide on [Connecting to an {{ KF }} cluster](connect-to-kafka.md).

{% endlist %}
