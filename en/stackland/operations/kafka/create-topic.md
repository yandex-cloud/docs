# Creating a topic

If you have created a [cluster](create-cluster.md), you can create a topic in it.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Create a file of the `KafkaTopic` resource, e.g., using the `touch kafkatopic.yaml` command.
  1. Open the file and paste the configuration below into it:

      {% include notitle [YAML-file](../../_includes/yamls/operations/kafka/kafkatopic.md) %}

  1. Apply the manifest: `kubectl apply -f kafkatopic.yaml -n <project name>`. Optionally, you can specify the project name in the `metadata.namespace` resource property and skip it in the command.


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. In the left-hand menu, select **Kafka Clusters**.
  1. Select a cluster.
  1. Go to the **Topics** tab.
  1. Click **Create topic**.
  1. Enter the topic name and click **Create**.

{% endlist %}
