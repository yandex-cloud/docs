# Deleting a cluster {{ KF }}

If you have an [{{ KF }}](../../concepts/components/kafka.md) cluster in your [project](../projects/create-project.md), you can delete it.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Find the name of the required cluster in the list of project clusters: `kubectl get KafkaCluster -n <project name>`.
  1. Delete the cluster resource: `kubectl delete KafkaCluster <cluster name> -n <project name>`.


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. In the left-hand menu, select **Kafka Clusters**.
  1. Select a cluster.
  1. Click **Delete**.
  1. Confirm the deletion.

{% endlist %}
