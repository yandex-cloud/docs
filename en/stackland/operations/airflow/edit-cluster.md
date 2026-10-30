---
title: Updating {{ AF }} cluster settings
description: How to update resources, dependencies, and other parameters of an {{ AF }} cluster.
---

# Updating {{ AF }} cluster settings

To update [{{ AF }} cluster](../../concepts/components/airflow.md) settings, use the `AirflowCluster` resource.

## Using the CLI {#edit}

1. Export the current configuration:

    ```bash
    kubectl get airflowcluster <cluster_name> \
      -n <namespace> \
      -o yaml > airflow-cluster.yaml
    ```

1. Update the `spec` fields and remove the `status`, `metadata.resourceVersion`, `metadata.uid`, `metadata.creationTimestamp`, and `metadata.managedFields` system fields from the file.

1. Apply the configuration:

    ```bash
    kubectl apply -f airflow-cluster.yaml
    ```

1. Wait for the update to complete:

    ```bash
    kubectl get airflowcluster <cluster_name> \
      -n <namespace> \
      -w
    ```

    The `status.phase` field must become `Ready`, or `Paused` if the cluster is paused.

## What you can update {#mutable-fields}

Without re-creating the cluster, you can:

* Select a different supported version in `spec.version`.
* Change the number of replicas or change component resources.
* Modify [`spec.config`](#airflow-config) in line with applicable constraints.
* Enable or disable public access via `spec.publicAccess`.
* Update additional packages and their repositories in `spec.dependencies`.
* Update the Git repository `ref` and the secret with credentials.
* Enable or disable remote logs by adding or removing `spec.taskLogs`.
* [Pause or resume the cluster](pause-resume.md) via `spec.pause`.
* Enable or disable [deletion protection](../../concepts/components/airflow.md#deletion-protection) via `spec.deletionProtection`.

{% note warning %}

When adding or removing `spec.taskLogs`, existing logs are not migrated between the local disk and S3. The updated setup only applies to new log entries. Disabling remote logs does not delete the automatically created bucket and the objects already saved in it.

{% endnote %}

## What you cannot update {#immutable-fields}

After creation, you cannot update:

* DAG source type, Git repository URL, and `subPath`.
* Object storage type, bucket name, endpoint, `subPath`, and references to managed storage resources.

To update these parameters, create a new `AirflowCluster` and perform an individual data migration.

The metadata database is [created automatically](../../concepts/components/airflow.md#metadata-db). You cannot select a different database or update any parameters of the existing one.

## Component resources {#resources}

The examples below show fragments of `spec`. Add them into your current configuration, keeping the other parameters unchanged.

Example of updating the replica counts and resources:

```yaml
spec:
  components:
    scheduler:
      replicas: 2
      resources:
        requests:
          cpu: 500m
          memory: 1Gi
        limits:
          cpu: "2"
          memory: 4Gi
    dagProcessor:
      replicas: 2
```

If the `resources` field is set, specify all four values: `requests.cpu`, `requests.memory`, `limits.cpu`, and `limits.memory`.

`requests` sets the guaranteed resources for a single pod, and `limits`, the maximum resources. The `cpu` field defines the number of CPU cores, and `memory`, the amount of RAM.

`spec.components` supports `scheduler`, `apiServer`, `triggerer`, and `dagProcessor`. Each of them accepts both `replicas` and `resources`. Pod placement rules are not configurable.

## {{ AF }} parameters {#airflow-config}

The `spec.config` field defines settings for `airflow.cfg`, where the first level represents the section, and the second defines the parameter name. For example, to disable loading demo DAG files:

```yaml
spec:
  config:
    core:
      load_examples: "False"
```

All values must be single-line strings, including numbers and booleans. Use literal values without template expressions. Section and parameter names must start with a Latin letter, digit, or underscore and contain only Latin letters, digits, underscores, dots, and hyphens. The `DEFAULT` section is reserved.

The following parameters cannot be updated via `spec.config`. This restriction applies regardless of letter case:

#|
|| **Section** | **Parameters** ||
|| `api` | `base_url`, `secret_key` ||
|| `api_auth` | `jwt_secret` ||
|| `core` | `auth_manager`, `dags_folder`, `execution_api_server_url`, `executor`, `fernet_key` ||
|| `dag_processor` | `dag_bundle_config_list` ||
|| `database` | `sql_alchemy_conn` ||
|| `kubernetes_executor` | `multi_namespace_mode`, `namespace`, `pod_template_file`, `worker_container_repository`, `worker_container_tag` ||
|| `logging` | `delete_local_logs`, `remote_base_log_folder`, `remote_log_conn_id`, `remote_logging` ||
|| `metrics` | `statsd_host`, `statsd_on`, `statsd_port`, `statsd_prefix` ||
|| `scheduler` | `standalone_dag_processor` ||
|#

## Additional dependencies {#dependencies}

Here is an example of adding Python and Debian packages:

```yaml
spec:
  dependencies:
    pip:
      - name: apache-airflow-providers-amazon
    deb:
      - name: libpq5
```

For a Python package, you can specify `version` with a version constraint, e.g., `">=2.0,<3.0"`; for a Debian package, only `name` is specified. Installing packages does not change the {{ AF }} version specified in `spec.version`: incompatible dependencies cause an installation error.

After updating packages, repositories, or their associated secrets, wait for the cluster update to complete. The `DependenciesReady=True` condition for the current configuration confirms that the dependencies are ready. If package installation fails, refer to our [troubleshooting guide](troubleshooting.md#dependencies).

### Package repositories {#package-repositories}

If `repositories` is not set, the default pip and APT settings are used. For your own sources, set `spec.dependencies.repositories`:

```yaml
spec:
  dependencies:
    pip:
      - name: apache-airflow-providers-amazon
    deb:
      - name: libpq5
    repositories:
      pip:
        index:
          url: https://pypi.example.org/simple
          credentialsSecretRef:
            name: airflow-pypi-auth
          caSecretRef:
            name: airflow-repository-ca
            key: ca.crt
        extraIndexes:
          - url: https://pypi.org/simple
      deb:
        url: https://apt.example.org/debian
        suite: bookworm
        components: [main]
        credentialsSecretRef:
          name: airflow-apt-auth
        signingKeySecretRef:
          name: airflow-apt-key
          key: archive.asc
        caSecretRef:
          name: airflow-repository-ca
          key: ca.crt
```

Set up the specified secrets within the `AirflowCluster` namespace:

* `credentialsSecretRef`: Non-empty `username` and `password` keys. Use only printable ASCII characters without spaces. For a repository without authentication, the reference can be omitted.
* `caSecretRef`: Key with CA certificates in PEM format. Provide the reference if the repository uses a custom certificate authority.
* `signingKeySecretRef`: Secret record with the APT repository signing key. This reference is mandatory for `repositories.deb`.

Repository URLs must use HTTPS and must not contain credentials, query parameters, or fragments. The pip URL must end with `/simple`. One main and up to 16 additional pip indexes are supported; for indexes sharing the same host, use the same `credentialsSecretRef`. For APT, one repository is supported.

The `repositories.pip` section is valid only with a non-empty `pip` list, and `repositories.deb`, only with a non-empty `deb` list. In an installation without internet access, replace all addresses in the example, including `extraIndexes`, with those available within your network.
