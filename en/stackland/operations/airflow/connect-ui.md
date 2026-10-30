---
title: Opening the {{ AF }} web UI
description: How to connect to the {{ AF }} cluster web UI.
---

# Opening the {{ AF }} web UI

You need [administrator credentials](get-admin-credentials.md) to log in. Public HTTPS access is enabled by default via `spec.publicAccess: true`.

## Public access {#public-access}

1. Wait for the `Ready` state and get the address:

    ```bash
    kubectl get airflowcluster <cluster_name> \
      -n <namespace> \
      -o jsonpath='{.status.apiServerURL}'
    ```

1. Open the HTTPS address in your browser.

1. Enter the username and password you obtained by following the [Getting administrator credentials](get-admin-credentials.md) guide.

If the `status.apiServerURL` field is empty, check the cluster state as described in [Troubleshooting](troubleshooting.md#public-access).

## Internal access {#private-access}

If `spec.publicAccess: false`, connect to the web UI via port forwarding:

1. Get the cluster UID:

    ```bash
    kubectl get airflowcluster <cluster_name> \
      -n <namespace> \
      -o jsonpath='{.metadata.uid}'
    ```

1. Find the cluster’s service by inserting the UID:

    ```bash
    kubectl get service \
      -n <namespace> \
      -l 'tier=airflow,component=api-server,airflow.stackland.yandex.cloud/owner-uid=<cluster_UID>'
    ```

1. Forward your local port to the service:

    ```bash
    kubectl port-forward \
      -n <namespace> \
      service/<service_name> 8080:8080
    ```

1. Open `http://127.0.0.1:8080` and log in with administrator credentials.

The command is active as long as the `kubectl port-forward` process is running.
