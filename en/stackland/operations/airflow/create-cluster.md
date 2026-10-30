---
title: Creating an {{ AF }} cluster
description: How to create an {{ AF }} cluster with a Git or S3 source of DAG files.
---

# Creating an {{ AF }} cluster

The [{{ AF }} cluster](../../concepts/components/airflow.md) is created by the `AirflowCluster` resource in the [project](../projects/create-project.md) namespace. Before creating the cluster, the installation administrator must [enable {{ maf-name }}](enable.md).

The metadata database is created automatically. No database connection configuration is required.

## Getting started {#before-you-begin}

Set up the following:

* [Project namespace](../projects/manage-namespaces.md#create-namespace).
* Git repository with DAG files or S3-compatible storage.
* S3-compatible storage if remote task logs are required.
* Secret containing credentials if a private Git repository or external S3 storage is used.

Create the Secret and ConfigMap referenced by the configuration in the same namespace as `AirflowCluster`.

The [{{ objstorage-name }}](../../concepts/components/storage.md) component must be enabled for automatically created buckets.

Check available {{ AF }} versions:

```bash
kubectl get airflowimagecatalog airflow \
  -o jsonpath='{range .spec.images[*]}{.version}{"\n"}{end}'
```

If the command does not output versions, check the resource structure: `kubectl get airflowimagecatalog airflow -o yaml`.

## Using the CLI {#create}

1. Create an `AirflowCluster` resource file, e.g., `airflow-cluster.yaml` and insert one of the following configurations:

    {% list tabs %}

    - Git and local logs

        This example uses a public Git repository and local task logs.

        {% include notitle [YAML-file](../../_includes/yamls/operations/airflow/create-cluster-external.md) %}

    - {{ objstorage-name }} for DAG and logs

        This example creates separate buckets for DAG files and task logs. DAG files are loaded from the `dags/` prefix in the bucket.

        {% include notitle [YAML-file](../../_includes/yamls/operations/airflow/create-cluster-managed.md) %}

    {% endlist %}

1. Specify the cluster name in `metadata.name` and the available version in `spec.version`. For the Git source, replace the repository URL and the `ref` value with your own.

    Both examples include public access to the web interface (`spec.publicAccess: true`) and [deletion protection](../../concepts/components/airflow.md#deletion-protection) (`spec.deletionProtection: true`). Change these parameters if necessary.

1. Apply the manifest:

    ```bash
    kubectl apply -f airflow-cluster.yaml -n <namespace>
    ```

    You can also specify the namespace in the manifest `metadata.namespace` and omit the `-n` parameter from the command.

1. Substitute the cluster name from `metadata.name` and wait for the `Ready` state:

    ```bash
    kubectl get airflowcluster <cluster_name> \
      -n <namespace> \
      -w
    ```

1. If the cluster remains in `Provisioning` for a long time or goes `Failed`, check the status conditions in `status.conditions`:

    ```bash
    kubectl describe airflowcluster <cluster_name> -n <namespace>
    ```

    Recommendations are provided in the [Troubleshooting](troubleshooting.md) section.

## Private Git repository {#private-git}

For HTTPS, create a Secret with fixed `username` and `password` keys:

```bash
kubectl create secret generic airflow-git-auth \
  -n <namespace> \
  --from-literal=username=<username> \
  --from-literal=password=<token_or_password>
```

Add a link to `spec.dags.git.authSecretRef` of the manifest:

```yaml
spec:
  dags:
    source: git
    git:
      repo: https://git.example.com/team/airflow-dags.git
      ref: main
      authSecretRef:
        name: airflow-git-auth
```

For SSH, the Secret must contain `ssh-privatekey`, and the ConfigMap must contain the `known_hosts` key:

```yaml
spec:
  dags:
    source: git
    git:
      repo: git@git.example.com:team/airflow-dags.git
      ref: main
      authSecretRef:
        name: airflow-git-ssh
      knownHostsConfigMapRef:
        name: airflow-git-known-hosts
```

The Git and S3 synchronization interval is 60 seconds and is not configurable.

## External S3 storage {#external-s3}

Create a Secret with access keys:

```bash
kubectl create secret generic airflow-s3-credentials \
  -n <namespace> \
  --from-literal=access-key-id=<key_ID> \
  --from-literal=secret-access-key=<secret_key>
```

For DAG files, specify the following in `spec`:

```yaml
spec:
  dags:
    source: s3
    s3:
      type: s3
      s3:
        bucket: airflow-dags
        region: ru-central1
        endpointUrl: https://storage.yandexcloud.net
        credentialsSecretRef:
          name: airflow-s3-credentials
          accessKeyIdPath: access-key-id
          secretAccessKeyPath: secret-access-key
        subPath: dags/
```

For remote logs, set the `taskLogs` field in `spec`:

```yaml
spec:
  taskLogs:
    type: s3
    s3:
      bucket: airflow-logs
      region: ru-central1
      endpointUrl: https://storage.yandexcloud.net
      credentialsSecretRef:
        name: airflow-s3-credentials
        accessKeyIdPath: access-key-id
        secretAccessKeyPath: secret-access-key
      subPath: logs/
```

## Next steps {#next-steps}

* [Get administrator credentials](get-admin-credentials.md).
* [Open the {{ AF }} web interface](connect-ui.md).
* [Modify the cluster settings](edit-cluster.md) if you need to configure resources or dependencies.
