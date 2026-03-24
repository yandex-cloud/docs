## Check the saved state {#check-condition}

Make sure the state file is uploaded to [{{ objstorage-full-name }}](../../storage/):

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [management console]({{ link-console-main }}) and select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the new [bucket](../../storage/concepts/bucket.md).
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. In the bucket list, select the bucket you saved the {{ TF }} state to.
  1. Make sure the state file is in the bucket.

{% endlist %}