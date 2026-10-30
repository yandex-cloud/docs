---
title: Disabling {{ maf-name }}
description: How to safely disable {{ maf-name }}.
---

# Disabling {{ maf-name }}

[{{ maf-name }}](../../concepts/components/airflow.md) is disabled by the installation administrator. Prior to disabling, delete all the `AirflowCluster` resources and wait for their deletion to complete.

{% note warning %}

Do not disable the component until all `AirflowCluster` resources are completely deleted, even if they are in the `Deleting` state.

{% endnote %}

## Using the CLI {#disable}

1. Find all the clusters:

    ```bash
    kubectl get airflowcluster --all-namespaces
    ```

1. Delete each cluster by following the guide in [Deleting an {{ AF }} cluster](delete-cluster.md) and wait for the removal to complete.

1. Disable the component:

    ```bash
    kubectl patch managedairflowconfig main \
      --type=merge \
      -p '{"spec":{"enabled":false}}'
    ```

1. View the installation being deleted:

    ```bash
    kubectl get componentinstallation managed-airflow-main -w
    ```

After successful disabling, the `ComponentInstallation managed-airflow-main` resource will be deleted.
