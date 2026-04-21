# Deleting a topic

If you have an [{{ KF }}](../../concepts/components/kafka.md) topic in your [project](../projects/create-project.md), you can delete it.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Find the name of the topic in the list of project topics: `kubectl get KafkaTopic -n <project name>`.
  1. Delete the topic resource: `kubectl delete KafkaTopic <topic name> -n <project name>`.


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. In the left-hand menu, select **Kafka Clusters**.
  1. Select a cluster.
  1. Select the **Topics** tab.
  1. Select a topic.
  1. Click **Delete**.
  1. Confirm the deletion.

{% endlist %}
