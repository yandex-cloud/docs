## Check the saved state {#check-condition}

Make sure that the state file is uploaded to {{ objstorage-name }}:

{% list tabs %}

- Management console

   1. Open the [management console]({{ link-console-main }}) and select the folder with the bucket created.
   1. Select **{{ objstorage-name }}**.
   1. In the bucket list, select the bucket you saved the {{ TF }} state to.
   1. Make sure the state file is in the bucket.

{% endlist %}