# Deleting a user

If you have an [{{ KF }}](../../concepts/components/kafka.md) user in your [project](../projects/create-project.md), you can delete it.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Find the name of the user in the list of project users: `kubectl get KafkaUserAccess -n <project name>`.
  1. Delete the user resource: `kubectl delete KafkaUserAccess <user name> -n <project name>`.


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. In the left-hand menu, select **Kafka Clusters**.
  1. Select a cluster.
  1. Select the **Users** tab.
  1. Select the user.
  1. Click **Delete**.
  1. Confirm the deletion.

{% endlist %}
