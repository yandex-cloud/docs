## Check the saved state {#check-condition}

Make sure the state file is uploaded to [{{ objstorage-full-name }}](../../storage/):

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [management console]({{ link-console-main }}) and select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [bucket](../../storage/concepts/bucket.md) you created.
   1. Select **{{ objstorage-name }}**.
   1. In the bucket list, select the bucket you saved the {{ TF }} state to.
   1. Make sure the state file is in the bucket.

{% endlist %}