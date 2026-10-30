---
title: Deleting an {{ AF }} cluster
description: How to delete an {{ AF }} cluster and its associated data.
---

# Deleting an {{ AF }} cluster

Deleting an `AirflowCluster` deletes the [{{ AF }} cluster](../../concepts/components/airflow.md) and its metadata database. Any automatically created buckets, along with the DAG files and task logs stored inside them, are also deleted.

This deletion does not delete or clear any objects explicitly attached via `bucketRef` or `accessKeyRef`.

{% note alert %}

Before deletion, save the DAG files and logs you need. History and settings from the metadata database will be deleted along with the cluster. This operation is irreversible.

{% endnote %}

## Using the CLI {#delete}

1. Check for [deletion protection](../../concepts/components/airflow.md#deletion-protection):

    ```bash
    kubectl get airflowcluster <cluster_name> \
      -n <namespace> \
      -o jsonpath='{.spec.deletionProtection}'
    ```

1. If the protection is on, disable it:

    ```bash
    kubectl patch airflowcluster <cluster_name> \
      -n <namespace> \
      --type=merge \
      -p '{"spec":{"deletionProtection":false}}'
    ```

1. Delete the resource:

    ```bash
    kubectl delete airflowcluster <cluster_name> \
      -n <namespace>
    ```

1. Wait for the deletion to complete:

    ```bash
    kubectl get airflowcluster <cluster_name> \
      -n <namespace> \
      -w
    ```

During deletion, the `status.phase` becomes `Deleting`. Wait for the operation to complete. If your cluster remains in this state for too long, refer to [this troubleshooting guide](troubleshooting.md#deletion).
