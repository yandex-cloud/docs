---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Deleting clusters {{ k8s }}

{% include [yc-cluster-list](../../../_includes/managed-kubernetes/cluster-list.md) %}

{% list tabs %}

- Management console

    To delete a [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster):
    1. Open **{{ managed-k8s-name }}** in the folder you want to delete the {{ k8s }} cluster from.
    1. Click the ![image](../../../_assets/vertical-ellipsis.svg) icon in the row of the {{ k8s }} cluster to be deleted.
    1. In the menu that opens, click **Delete**.
    1. In the window that opens, click **Delete**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    1. Delete the {{ k8s }} cluster:

        ```
        $ yc managed-kubernetes cluster delete test-k8s-cluster
        .....................done
        ```

    1. Make sure that the {{ k8s }} cluster was deleted:

        ```
        $ yc managed-kubernetes cluster list
        +----+------+------------+--------+--------+-------------------+-------------------+
        | ID | NAME | CREATED AT | HEALTH | STATUS | EXTERNAL ENDPOINT | INTERNAL ENDPOINT |
        +----+------+------------+--------+--------+-------------------+-------------------+
        +----+------+------------+--------+--------+-------------------+-------------------+
        ```

- API

  To delete a {{ k8s }} cluster, use the [delete](../../api-ref/Cluster/delete.md) method for the [Cluster](../../api-ref/Cluster/) resource.

{% endlist %}

