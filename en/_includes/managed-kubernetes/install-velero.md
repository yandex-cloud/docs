Install the Velero application as follows:

{% list tabs %}

- Using {{ marketplace-short-name }}

    Install the Velero application by following [this guide](../../managed-kubernetes/operations/applications/velero-yc-csi.md). In the **Object Storage bucket name** field, specify the bucket you [created earlier](#before-you-begin).

    {% note warning %}

    If the name of the namespace where Velero is installed is not `velero`, additionally use the `--namespace <Velero namespace>` parameter for all subsequent commands.

    {% endnote %}

- Manually

    1. {% include [cli-install](../../_includes/cli-install.md) %}

        {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. [Create a service account](../../iam/operations/sa/create.md) for Velero to run.
    1. [Assign it the `storage.editor` role](../../iam/concepts/access-control/roles.md) to access [{{ objstorage-full-name }}](../../storage/).
    1. [Create a static access key](../../iam/operations/sa/create-access-key.md) for the service account in JSON format and save it to the `sa-key.json` file:

        ```bash
        yc iam access-key create \
           --service-account-name=<service account name> \
           --format=json > sa-key.json
        ```

    1. Create a file named `credentials` with the previously received static key data:

        ```ini
        [default]
          aws_access_key_id=<key ID>
          aws_secret_access_key=<key's secret part>
        ```

    1. Install the Velero server in the {{ managed-k8s-name }} cluster:

        ```bash
        kubectl label volumesnapshotclasses.snapshot.storage.k8s.io yc-csi-snapclass \
        velero.io/csi-volumesnapshot-class="true" && \
        velero install \
          --backup-location-config s3Url=https://{{ s3-storage-host }},region={{ region-id }} \
          --bucket <{{ objstorage-name }} bucket name> \
          --plugins velero/velero-plugin-for-aws:v1.3.0,velero/velero-plugin-for-csi:v0.2.0 \
          --provider aws \
          --secret-file ./credentials \
          --features=EnableCSI \
          --use-volume-snapshots=true \
          --snapshot-location-config region={{ region-id }} \
          --use-restic
        ```

        Where:
        * `--backup-location-config`: Backup storage parameters, i.e., the URL of {{ objstorage-name }} storage and region.
        * `--bucket`: Name of the backup storage bucket you [created earlier](#before-you-begin).
        * `--plugins`: Plugin images for AWS API compatibility.
        * `--provider`: Name of the object storage provider.
        * `--secret-file`: Full path to static access key data.
        * `--features`: List of enabled features.
        * `--snapshot-location-config`: Availability zone where disk snapshots will be located.
        * (Optional) `--use-restic`: Enables the restic plugin.

        Result:

        ```text
        CustomResourceDefinition/backups.velero.io: attempting to create resource
        CustomResourceDefinition/backups.velero.io: already exists, proceeding
        CustomResourceDefinition/backups.velero.io: created
        ...
        Velero is installed! ⛵ Use 'kubectl logs deployment/velero -n velero' to view the status.
        ```

    1. Make sure the Velero pod status has changed to `Running`:

        ```bash
        kubectl get pods --namespace velero
        ```

{% endlist %}