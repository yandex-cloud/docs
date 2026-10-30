---
title: Getting {{ AF }} administrator credentials
description: How to get the username and password of an {{ AF }} cluster's administrator.
---

# Getting {{ AF }} administrator credentials

The administrator credentials are stored in a secret in the `AirflowCluster` namespace.

## Finding the secret {#search}

To find the secret with the credentials for the cluster in question:

1. Get the cluster UID:

    ```bash
    kubectl get airflowcluster <cluster_name> \
      -n <namespace> \
      -o jsonpath='{.metadata.uid}'
    ```

1. Find the secrets created for this UID:

    ```bash
    kubectl get secret -n <namespace> \
      -l 'airflow.stackland.yandex.cloud/owner-uid=<cluster_UID>'
    ```

1. Use the secret name with the `-admin` suffix instead of `<secret_name>` in the following commands.

## Getting a username {#get-username}

```bash
kubectl get secret <secret_name> \
  -n <namespace> \
  -o jsonpath='{.data.username}' | base64 --decode
```

The default username is `admin`.

## Getting a password {#get-password}

```bash
kubectl get secret <secret_name> \
  -n <namespace> \
  -o jsonpath='{.data.password}' | base64 --decode
```

{% note warning %}

The password gives administrative access to the {{ AF }} cluster. Save it in a secure location and do not provide it via logs, messages, or version control system.

{% endnote %}

## Rotating a password {#rotate-password}

To change the admin's password, edit the `password` key in its secret. The operator monitors changes in the secret and re-runs account configuration. You cannot edit the `username` key.

{% note warning %}

In the current distribution, a new password of an existing user may not apply automatically. The `Ready` state does not confirm the password change. You need to log in using the new value. If you failed to log in, follow [this guide on regaining access](troubleshooting.md#admin-password).

{% endnote %}

1. If the cluster is stopped, [restart it](pause-resume.md#resume).

1. Update only the `password` key in the [secret you found](#find-secret):

    ```bash
    kubectl patch secret <secret_name> \
      -n <namespace> \
      --type=merge \
      -p '{"stringData":{"password":"<new_password>"}}'
    ```

1. Wait until the change is processed and the cluster switches back to `Ready`:

    ```bash
    kubectl get airflowcluster <cluster_name> \
      -n <namespace> \
      -w
    ```

    If the cluster does not switch back to `Ready`, check `status.conditions` by running this command: `kubectl describe airflowcluster <cluster_name> -n <namespace>`. The `InitialUserReady` condition shows the account configuration result.

1. Log out of the web interface, then log in again with the new password.
