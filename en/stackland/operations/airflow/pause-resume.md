---
title: Pausing or resuming an {{ AF }} cluster
description: How to suspend and resume an {{ AF }} cluster's components.
---

# Pausing or resuming an {{ AF }} cluster

Pausing stops the main {{ AF }} components. The cluster configuration, metadata database, buckets, and credentials are saved.

A weekly [cleanup of metadata older than 90 days](../../concepts/components/airflow.md#metadata-retention) continues during suspension.

{% note warning %}

Pausing terminates the active pods of the main components. Do not use it when running critical tasks.

{% endnote %}

## Pausing a cluster {#pause}

1. Install `spec.pause: true`:

    ```bash
    kubectl patch airflowcluster <cluster_name> \
      -n <namespace> \
      --type=merge \
      -p '{"spec":{"pause":true}}'
    ```

1. Wait for the `Paused` status:

    ```bash
    kubectl get airflowcluster <cluster_name> \
      -n <namespace> \
      -w
    ```

## Resuming a cluster {#resume}

1. Install `spec.pause: false`:

    ```bash
    kubectl patch airflowcluster <cluster_name> \
      -n <namespace> \
      --type=merge \
      -p '{"spec":{"pause":false}}'
    ```

1. Wait for the `Ready` status:

    ```bash
    kubectl get airflowcluster <cluster_name> \
      -n <namespace> \
      -w
    ```

After resuming, the scheduler resumes processing DAG files. Check the schedules and task statuses in the web UI.
