---
title: '{{ maf-name }}'
description: '{{ maf-name }} capabilities, settings, and limitations in {{ stackland-name }}.'
---

# {{ maf-name }}

*{{ maf-name }}* allows you to create {{ AF }} clusters within {{ stackland-name }} namespaces, upload DAG files, and execute scheduled tasks. The cluster and its settings are described in the `AirflowCluster` resource.

You can create multiple independent clusters within each namespace. To execute tasks, you use `KubernetesExecutor`: each task is run in a separate pod.

## Cluster composition {#architecture}

A cluster is comprised of the following {{ AF }} components:

* `scheduler`: Plans task execution.
* `apiServer`: Provides a web interface and a REST API.
* `triggerer`: Executes delayed tasks.
* `dagProcessor`: Uploads and parses DAG files.

You can specify the number of replicas and resources separately for each component. If parameters are not specified, platform-specific default values ​​are used. You cannot configure pod placement rules via `AirflowCluster`.

Supported {{ AF }} versions are listed in the `AirflowImageCatalog airflow` resource. The current release brings version `3.1.8`.

## Metadata database {#metadata-db}

A metadata database is created automatically for each {{ AF }} cluster. You do not have to set it up or enter credentials for connection. You cannot connect a custom database or modify the parameters of the service database.

When an {{ AF }} cluster is deleted, its metadata database also gets deleted.

### Storing history {#metadata-retention}

Historical metadata older than 90 days is automatically deleted once a week. DAG files and task logs in S3 are preserved. You cannot change the cleanup schedule or the metadata retention period.

## DAG file sources {#dags}

You can upload DAG files from a Git repository or S3-compatible storage. The source is selected in `spec.dags.source` and never changed again it after the cluster is created.

### Git {#git}

For a public HTTPS repository, it is enough to specify the URL and branch, tag, or commit in the `ref` field. For a private repository, create a Secret in the same namespace:

* For HTTPS, use the `username` and `password` keys.
* For SSH, use the `ssh-privatekey`.

SSH also requires a ConfigMap with the `known_hosts` key. The key names are fixed and are not specified in `AirflowCluster`.

Git repository updates are checked every 60 seconds. The interval is not adjustable.

### S3 {#s3}

There are two modes available for DAG files in S3:

* `stackland-storage`: Automatically creating an [{{ objstorage-name }}](storage.md) bucket or connecting an existing one.
* `s3`: Connecting an external S3-compatible storage using a specified endpoint and a Secret with access keys.

DAG files are synchronized every 60 seconds. Their local copy gets `1Gi` allocated for it. Components and tasks requiring DAG files from S3 are reside on a single node. Increasing the number of replicas does not ensure fault tolerance across multiple nodes in this mode.

## Task logs {#task-logs}

If the `spec.taskLogs` field is not specified, logs are stored locally in pods and are lost when the pods are recreated.

To store logs in S3, set a `stackland-storage` or `s3` type configuration in `spec.taskLogs`. You can add or remove a section after you create the cluster, but existing logs are not automatically migrated. After you enable remote storage, new logs are sent to S3, and the local copy is deleted.

You cannot change the type and immutable parameters of an already configured storage. To switch to a different bucket or endpoint, create a new `AirflowCluster`.

## Dependencies {#dependencies}

Additional Python and Debian packages for execution of DAG files are specified in `spec.dependencies.pip` and `spec.dependencies.deb`.

You can specify `spec.dependencies.repositories` for public or private package repositories. Without this field, the default repositories are used. After you modify packages, repository settings, or their Secrets, wait for the cluster update to complete before you run tasks with new dependencies. For more information, see [Additional dependencies](../../operations/airflow/edit-cluster.md#dependencies).

## Network access {#network-access}

Public HTTPS access to the web interface and API is enabled by default. The address of the ready-made web interface is available in `status.apiServerURL`.

If you install `spec.publicAccess: false`, the interface will be accessible only within the Kubernetes cluster. The domain and TLS certificate for public access are provided automatically and cannot be configured via `AirflowCluster`.

## Authentication {#authentication}

To access the web interface, use the username and password from the cluster Secret. The default username is `admin`. To learn how to get the data, see [Getting administrator credentials](../../operations/airflow/get-admin-credentials.md). Do not publish the Secret content or save it in the version control system.

Changing the `password` key in Secret automatically starts the re-configuration of the account. After the change, check that you can log in to the web interface using the new password. For the procedure and limitations, see [Password rotation](../../operations/airflow/get-admin-credentials.md#rotate-password).

## Deletion protection {#deletion-protection}

The `spec.deletionProtection` parameter prevents accidental deletion of `AirflowCluster`. If set to `true`, the `kubectl delete` command will be rejected. The protection is off by default (`false`); you can enable it when creating or [modifying cluster settings](../../operations/airflow/edit-cluster.md).

The protection is valid only for the `AirflowCluster` resource and does not block the separate deletion of its Secret and buckets. Disable protection before [deleting the cluster](../../operations/airflow/delete-cluster.md).

## Cluster health states {#statuses}

The main state is available in `status.phase`:

#|
|| **State** | **Description** ||
|| `Provisioning` | The cluster is being created or updated. ||
|| `Ready` | All required dependencies and components are ready. ||
|| `Paused` | The main components were stopped using `spec.pause: true`. ||
|| `Failed` | The last attempt to apply the configuration failed. ||
|| `Deleting` | The cluster and its associated data are being deleted. ||
|#

For troubleshooting, also check `status.conditions`, which indicates the stage, cause, and the error message.

## Limitations {#limits}

* Only {{ AF }} version 3.x from `AirflowImageCatalog airflow` is supported; the current release brings version `3.1.8`.
* The {{ stackland-name }} management console does not provide a separate form for `AirflowCluster`; configuring is done via `kubectl` and YAML manifests.
* The DAG source and the key parameters of the object storage do not change after creation.
* Connecting a custom metadata database and configuring pod placement via `AirflowCluster` are not supported.
* The local copy of the DAG files from S3 gets `1Gi` allocated for it; the components and tasks that use it reside on the same node.
* The existing administrator's new password may not be applied automatically after the Secret is changed. Test logging in with the new password; optionally, use [this access recovery guide](../../operations/airflow/troubleshooting.md#admin-password).
* Local task logs are not preserved when pods are recreated.
* Historical metadata older than 90 days is deleted during the weekly cleanup.
* The `Ready` state does not mean the Git repository or S3 storage is available. After you create the cluster, check that the DAG files have appeared in the web interface and the tasks are being executing.

## Instructions {#operations}

* [Activating {{ maf-name }}](../../operations/airflow/enable.md).
* [Creating an {{ AF }} cluster](../../operations/airflow/create-cluster.md).
* [Updating {{ AF }} cluster settings](../../operations/airflow/edit-cluster.md).
* [Getting {{ AF }} administrator credentials](../../operations/airflow/get-admin-credentials.md).
* [Opening the {{ AF }} web UI](../../operations/airflow/connect-ui.md).
* [Pausing or resuming an {{ AF }} cluster](../../operations/airflow/pause-resume.md).
* [Deleting an {{ AF }} cluster](../../operations/airflow/delete-cluster.md).
* [Troubleshooting {{ AF }}](../../operations/airflow/troubleshooting.md).
* [Disabling {{ maf-name }}](../../operations/airflow/disable.md).
