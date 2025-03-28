Install the Velero application as follows:

{% list tabs group=instructions %}


- {{ marketplace-full-name }} {#marketplace}

    Install the Velero application by following [this guide](../../managed-kubernetes/operations/applications/velero-yc-csi.md). In the **Object Storage bucket name** field, specify the bucket you [created earlier](#before-you-begin).

    {% note warning %}

    If the name of the namespace where Velero is installed is not `velero`, use the additional `--namespace <Velero_application_namespace>` parameter for all the commands that follow.

    {% endnote %}


- Manually {#manual}

    1. {% include [cli-install](../../_includes/cli-install.md) %}

        {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. [Create a service account](../../iam/operations/sa/create.md) for Velero to run.
    1. [Assign](../../iam/concepts/access-control/roles.md) it the `storage.editor` role to access [{{ objstorage-full-name }}](../../storage/).
    1. [Create a static access key](../../iam/operations/authentication/manage-access-keys.md#create-access-key) for the service account in JSON format and save it to the `sa-key.json` file:

        ```bash
        yc iam access-key create \
           --service-account-name=<service_account_name> \
           --format=json > sa-key.json
        ```

    1. Create a file named `credentials` with the previously obtained static key data:

        ```ini
        [default]
        aws_access_key_id=<key_ID>
        aws_secret_access_key=<key_secret_part>
        ```

    1. Install the Velero server in the {{ managed-k8s-name }} cluster:

        ```bash
        kubectl label volumesnapshotclasses.snapshot.storage.k8s.io yc-csi-snapclass \
        velero.io/csi-volumesnapshot-class="true" && \
        velero install \
          --backup-location-config s3Url=https://{{ s3-storage-host }},region={{ region-id }} \
          --bucket <bucket_name> \
          --plugins velero/velero-plugin-for-aws:v1.5.2 \
          --provider aws \
          --secret-file <path_to_credentials_file> \
          --features=EnableCSI \
          --use-volume-snapshots=true \
          --snapshot-location-config region={{ region-id }} \
          --uploader-type=restic
        ```

        Where:
        * `--backup-location-config`: Backup storage parameters, i.e., the URL of {{ objstorage-name }} storage and region.
        * `--bucket`: Name of the [previously created](#before-you-begin) {{ objstorage-name }} bucket for backup storage.
        * `--plugins`: Plugin images for AWS API compatibility.
        * `--provider`: Name of the object storage provider.
        * `--secret-file`: Full path to the file with static access key data.
        * `--features`: List of enabled features.
        * `--snapshot-location-config`: Availability zone to host disk snapshots.
        * (Optional) `--uploader-type=restic`: Enables the restic plugin.

        Result:

        ```text
        CustomResourceDefinition/backups.velero.io: attempting to create resource
        CustomResourceDefinition/backups.velero.io: already exists, proceeding
        CustomResourceDefinition/backups.velero.io: created
        ...
        Velero is installed! ⛵ Use 'kubectl logs deployment/velero -n velero' to view the status.
        ```

    1. Make sure the Velero pod state has changed to `Running`:

        ```bash
        kubectl get pods --namespace velero
        ```

{% endlist %}