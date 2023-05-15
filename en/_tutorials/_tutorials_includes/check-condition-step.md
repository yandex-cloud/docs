## Check the saved state {#check-condition}

Make sure that the state file is uploaded to {{ objstorage-name }}:

{% list tabs %}

- Management console

   1. Open the [management console] ({{ link-console-main }}) and select the folder with the bucket created.
   1. Select **{{ objstorage-name }}**.
   1. From the bucket list, select `terraform-ydb-tutorial` where you saved the {{ TF }} state.
   1. Make sure the state file is in the bucket.

{% endlist %}