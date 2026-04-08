# Deleting a PostgreSQL cluster

If you have a [{{ PG }}](../../concepts/components/postgresql.md) cluster in your [project](../projects/create-project.md), you can delete it.

{% note warning %}

If the **deletion protection** is on (`spec.deletionProtection: true`), you cannot delete the cluster. First, deactivate the protection by setting `spec.deletionProtection: false` in the manifest and applying the changes (`kubectl apply`). Alternatively, deactivate it on the cluster editing page in the management console. Then you can delete the cluster.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Find the name of the required cluster in the list of project clusters: `kubectl get PostgresqlCluster -n <project name>`.
  1. Delete the cluster resource: `kubectl delete PostgresqlCluster <cluster name> -n <project name>`.


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. In the left-hand menu, select **{{ PG }} Clusters**.
  1. Select a cluster.
  1. Click **Delete**.
  1. Confirm the deletion.

{% endlist %}

This is it. You have successfully deleted the cluster.
