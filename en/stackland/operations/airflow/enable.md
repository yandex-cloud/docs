---
title: Enabling {{ maf-name }}
description: How to enable the {{ maf-name }} component and check that it is ready.
---

# Enabling {{ maf-name }}

By default, [{{ maf-name }}](../../concepts/components/airflow.md) is disabled. To create {{ AF }} clusters, the installation administrator must enable this component using the `ManagedAirflowConfig main` resource.

## Using the CLI {#enable}

1. Enable [{{ mpg-name }}](../../concepts/components/postgresql.md) and wait for the component to get ready:

    ```bash
    kubectl patch managedpostgresconfig main \
      --type=merge \
      -p '{"spec":{"enabled":true}}'
    kubectl get componentinstallation managed-postgres-main -w
    ```

    {{ mpg-name }} is a required component for storing {{ AF }} metadata and must remain enabled until all {{ AF }} clusters are deleted.

1. Make sure the resource exists:

    ```bash
    kubectl get managedairflowconfig main
    ```

1. Enable the component:

    ```bash
    kubectl patch managedairflowconfig main \
      --type=merge \
      -p '{"spec":{"enabled":true}}'
    ```

1. Wait for the installation to get ready:

    ```bash
    kubectl get componentinstallation managed-airflow-main -w
    ```

    The component is ready when `status.phase` takes the `Ready` value.

1. Check the {{ AF }} version catalog availability:

    ```bash
    kubectl get airflowimagecatalog airflow
    ```

## Next steps {#next-steps}

After you enable the component, [create an {{ AF }} cluster](create-cluster.md).
