---
title: Troubleshooting {{ AF }}
description: Diagnostics of statuses, dependencies, and connections for {{ AF }} clusters.
---

# Troubleshooting {{ AF }}

Start diagnostics from the `AirflowCluster` status and `status.conditions`.

## General diagnostics {#general}

1. Review the cluster state:

    ```bash
    kubectl get airflowcluster <cluster_name> \
      -n <namespace> \
      -o wide
    ```

1. Get the status conditions and cluster events:

    ```bash
    kubectl describe airflowcluster <cluster_name> \
      -n <namespace>
    ```

1. Get the cluster UID to search for its resources:

    ```bash
    kubectl get airflowcluster <cluster_name> \
      -n <namespace> \
      -o jsonpath='{.metadata.uid}'
    ```

1. Check {{ AF }} pods by providing the obtained UID below:

    ```bash
    kubectl get pods -n <namespace> \
      -l 'tier=airflow,airflow.stackland.yandex.cloud/owner-uid=<cluster_UID>'
    ```

## Cluster remains in provisioning {#provisioning}

Check the status conditions whose `status` field has the `False` value:

#|
|| **Status condition** | **What to check** ||
|| `ImageResolved` | A version from `spec.version` is present in `AirflowImageCatalog airflow`. ||
|| `DatabaseReady` | Readiness of an automatically created metadata database. In case of prolonged waiting, use the recommendations from the [Database errors](#database) section. ||
|| `DAGStorageReady` | Secret with Git and S3 credentials, `known_hosts` ConfigMap, bucket, and access resources. ||
|| `LogStorageReady` | `spec.taskLogs` settings, bucket, and S3 credentials. ||
|| `DependenciesReady` | The list of additional packages, their versions, repositories, and credentials. Recommendations are provided in the [Package installation errors](#dependencies) section. ||
|| `AuthSecretsReady` | Administrative secret, non-empty `username` and `password` keys, safekeeping of the original username. ||
|| `SecuritySecretsReady` | Configuring cluster protection settings. Contact the installation administrator in case you get an error. ||
|| `MigrationReady` | Metadata database update. If you get `MigrationFailed`, resend the error message to the installation administrator. ||
|| `InitialUserReady` | Configuring the {{ AF }} administrator account, including after changing the password secret. Contact the installation administrator in case you get an error. ||
|| `ComponentsReady` | Status of the {{ AF }} pods in the cluster namespace and messages about errors during their start. ||
|#

For an exact reason, see the `reason` and `message` fields of the relevant condition. Make sure that its `observedGeneration` matches the current `metadata.generation`.

If you were unable to fix the error by following the instructions below, send your installation administrator the cluster name, namespace, and the `reason` and `message` values.

## Git errors {#git}

For a private HTTPS repository, a secret must contain non-empty `username` and `password` keys. The following is required for SSH:

* `ssh-privatekey` in the secret from `authSecretRef`.
* `known_hosts` key in ConfigMap from `knownHostsConfigMapRef`.

Key names are fixed. Also, check the repository URL, existence of the branch, tag, or commit from `ref`, and the `subPath` path.

For errors during DAG file uploads, see the `git-sync` container log:

```bash
kubectl get pods -n <namespace> \
  -l 'tier=airflow,component=dag-processor,airflow.stackland.yandex.cloud/owner-uid=<cluster_UID>'
kubectl logs -n <namespace> <pod_name> -c git-sync
```

## Errors during DAG S3 synchronization

If DAG files from S3 do not appear in the web UI, check:

* Bucket name, endpoint, region, and `forcePathStyle` mode.
* Keys specified in `credentialsSecretRef` and access permissions for the bucket.
* CA certificate for the endpoint with a private certification authority.
* Existence of DAG files under a prefix from `subPath`.
* Network access to S3 from the namespace.

View the synchronization log:

```bash
kubectl get pods -n <namespace> \
  -l 'tier=airflow,component=dag-processor,airflow.stackland.yandex.cloud/owner-uid=<cluster_UID>'
kubectl logs -n <namespace> <pod_name> -c dag-sync
```

If pods remain `Pending`, review their events:

```bash
kubectl describe pod <pod_name> -n <namespace>
```

Keep in mind the [S3 source limitations](../../concepts/components/airflow.md#s3). If pods are not running due to a lack of resources or storage unavailability, send the events to your installation administrator.

## The password from the secret does not work {#admin-password}

Find the administrative secret [by cluster UID](get-admin-credentials.md#find-secret). If the `username` key has been changed, restore the original username: you cannot update the administrator name.

After [updating the `password` key](get-admin-credentials.md#rotate-password), wait until the secret is processed and check `status.conditions` for `InitialUserReady`. If an error occurs, send the `reason` and `message` values to your installation administrator.

If the cluster has switched back to `Ready` but you cannot log in with the new password, the existing user's password could remain unchanged. To restore access, manually set the password from the secret in {{ AF }}. To do this, you need permissions for running commands in pods (`pods/exec`). In case you do not have such permissions, contact your installation administrator.

1. If the cluster is paused, [resume it](pause-resume.md#resume). Find a running API server pod by providing the UID from the [Find secret](get-admin-credentials.md#find-secret) guide in the command below:

    ```bash
    kubectl get pods -n <namespace> \
      -l 'tier=airflow,component=api-server,airflow.stackland.yandex.cloud/owner-uid=<cluster_UID>'
    ```

1. Run the [password change command](https://airflow.apache.org/docs/apache-airflow-providers-fab/stable/cli-ref.html#reset-password) in the pod you found:

    ```bash
    kubectl exec -it <pod_name> \
      -n <namespace> \
      -c api-server -- \
      airflow users reset-password --username <username>
    ```

    Use the username from the `username` key of the administrative secret. In the interactive request, enter the password from the `password` key and confirm it.

1. Log out of the web UI, then log in anew with the password from the secret.

## Database errors {#database}

The metadata database is created and configured automatically. If `DatabaseReady=False` has persisted over a long period of time or {{ AF }} throws a database connection error, contact your installation administrator. Provide the cluster name, namespace, and error message.

## Package installation errors {#dependencies}

If `DependenciesReady=False`, start with `reason` and `message`:

* `SecretNotFound`, `InvalidSecret`, or `InvalidCABundle`: Check the secret from `spec.dependencies.repositories` (credentials, CA, and APT signature key). See the requirements in the [Package repositories](edit-cluster.md#package-repositories) section.
* `ImageBuildPending` or `ImageReplicationPending`: Dependencies are still being prepared for use. Wait until the update is complete. If the status remains unchanged for a long time, contact your installation administrator.
* `ImageBuildFailed`: Check the package names and versions, repository availability, and the compatibility of dependencies with the {{ AF }} version from `spec.version`.

Fix `spec.dependencies` or the secret you are using. If the reason is unclear based on `message`, forward this message to your installation administrator.

In case of `ImagePullBackOff` in pod events, you should also contact your installation administrator.

## Web UI is not published {#public-access}

Check `spec.publicAccess` and the cluster status. If `spec.publicAccess: false`, use [internal access](connect-ui.md#private-access) or [update the setting](edit-cluster.md#mutable-fields).

When `spec.publicAccess: true`, wait for the `Ready` status and get the address from `status.apiServerURL` using the [Open the web UI](connect-ui.md#public-access) guide. If the address does not appear or is unavailable, provide the cluster name, namespace, and error message to your installation administrator.

## Deletion is not completed {#deletion}

Cluster deletion includes deleting its data and automatically created buckets and may take time. If the `Deleting` status remains unchanged for a long time, provide the `kubectl describe airflowcluster <cluster_name> -n <namespace>` command output to your installation administrator.

Do not disable {{ maf-name }} until all clusters are deleted completely.
