# Creating a PostgreSQL cluster

If you have a [project](../projects/create-project.md), you can create a [{{ PG }}](../../concepts/components/postgresql.md) cluster in it.

## Using the CLI {#cli}

1. If the project does not exist yet, create it: `kubectl create namespace <project name>`.
1. If the database needs a backup, get a storage ready depending on the S3 type:

    {% list tabs %}

    - External S3

        Create a secret with credentials for accessing an S3-compatible storage:

        1. Create a file, e.g., `touch s3-credentials.yaml`.
        1. Paste a configuration and substitute your `accessKey` and `secretKey`:

            {% include notitle [YAML-file create-bucket-for-cluster](../../_includes/yamls/operations/postgresql/create-secret-s3-credentials.md) %}

        1. Apply the manifest: `kubectl apply -f s3-credentials.yaml -n <project_name>`.

        In the cluster manifest, specify `spec.backup.storage.type: s3` and a link to this secret in `spec.backup.storage.s3.credentialsSecretRef.name`, e.g., `access-key-credentials`.

    - Stackland Storage (internal Stackland object storage)

        You need not create anything. In the cluster manifest, specify `spec.backup.storage.type: stackland-storage`; the operator will create a bucket and access key automatically. If required, you can refer to the existing resources via `spec.backup.storage.stacklandStorage.bucketRef` and `accessKeyRef`.

    {% endlist %}

1. Create the `PostgresqlCluster` resource file, e.g., using the `touch postgresqlcluster.yaml` command.
1. Open the file and paste the configuration below into it:

    {% list tabs %}

    - Minimum configuration

        {% include notitle [YAML-file](../../_includes/yamls/operations/postgresql/create-cluster-min.md) %}

        User data will be stored in a secret named `<cluster name>-superuser`.

    - Maximum configuration (backups to an external S3)

        Use it if you had created a secret with external S3 credentials at the previous step.

        {% note info %}

        To create a custom password for the superuser, create a secret with this password and specify the username as `postgres`.

        {% endnote %}

        {% include notitle [YAML-file](../../_includes/yamls/operations/postgresql/create-cluster-max.md) %}

        Substitute your backup schedule into `spec.backup.schedule`. Format: [CRON Expression Format](https://pkg.go.dev/github.com/robfig/cron#hdr-CRON_Expression_Format). In `spec.backup.storage.s3`, specify `endpointUrl`, `prefix`, `region`, and the name of the secret in `credentialsSecretRef.name`. Optionally, you can remove `schedule` to skip creating a schedule.

    - Maximum configuration (backups to Stackland Storage)

        This option is for backups to an internal object storage in Stackland Storage. Specify `spec.backup.storage.type: stackland-storage` in the manifest; the operator will create a bucket and access key automatically.

        {% note info %}

        To create a custom password for the superuser, create a secret with this password and specify the username as `postgres`.

        {% endnote %}

        {% include notitle [YAML-file](../../_includes/yamls/operations/postgresql/create-cluster-max-stackland-storage.md) %}

        Substitute your backup schedule into `spec.backup.schedule`. Format: [CRON Expression Format](https://pkg.go.dev/github.com/robfig/cron#hdr-CRON_Expression_Format).

    {% endlist %}

1. Apply the manifest: `kubectl apply -f postgresqlcluster.yaml -n <project name>`. Optionally, you can specify the project name in the `metadata.namespace` resource property and skip it in the command.

## Deletion protection {#deletion-protection}

To prohibit accidental cluster deletion, enable deletion protection by setting `spec.deletionProtection: true` in the manifest. As long as the protection is on, the deletion of the `PostgresqlCluster` resource via `kubectl delete` or the management console will be rejected. To delete the cluster, first deactivate the protection by setting `spec.deletionProtection: false` and applying the manifest. Then you can delete the cluster.

In the management console, the **Deletion protection** toggle is available when you create or edit a cluster.

{% note info %}

The database connection link is generated using this format: `jdbc:postgresql://<cluster name>.<project name>.svc.{{ cluster-domain }}:6432/<datatbase name>?user=postgres&password=<password>&ssl=true&sslmode=require`.

For your first connection, you can use `postgres` both as the database name and superuser name.

{% endnote %}

## Using the management console {#console}

1. If you have not opened a project yet, select one.
1. In the left menu, select **{{ PG }} Clusters**.
1. Click **Create**.
1. Fill out the fields as follows:

    * **Cluster name**: Only use lowercase letters, numbers, and hyphens.
    * **Number of instances**: Number of cluster replicas.
    * **{{ PG }} version**: Select from the list of available versions.
    * **Computing resources**, where **Limits** is the upper limit and **Requests** is the lower limit.
    * **Storage**, where **Disk type** is the storage class (`stackland-nvme`, `stackland-ssd`, `stackland-hdd`, `stackland-other`). Learn more about storage classes in [Disk subsystem](../../concepts/components/disk-storage.md#storage-classes).
    * **Database**: Section containing authentication credentials.
    * **Connection pooler**: Handles writes and reads; used for all data-modifying operations and critical transactions.
    * **Backups**: Settings for creating the database backup in an S3 bucket.
    * **Deletion protection**: Toggle. You cannot delete the cluster via the API or console until the protection is disabled.

1. Click **Create**.

This is it: the cluster has appeared in the **{{ PG }} Clusters** list. To copy the connection link:

1. Select the cluster from the list.
1. Click **Connect** and copy the link.

    {% note info %}

    The link is generated in following format: `jdbc:postgresql://<cluster name>.<project name>.svc.{{ cluster-domain }}:6432/<datatbase name>?user=postgres&password=<password>&ssl=true&sslmode=require`. Use the database password for connecting.

    For your first connection, you can use `postgres` both as the database name and superuser name.

    {% endnote %}
