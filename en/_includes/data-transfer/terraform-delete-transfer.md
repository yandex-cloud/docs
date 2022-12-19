To delete a transfer created using {{ TF }}:
1. Open the current {{ TF }} configuration file with an infrastructure plan.

   For more information about creating this file, see [{#T}](../../data-transfer/operations/transfer.md#create).
1. Delete the transfer description.
1. Make sure the settings are correct.

   {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

1. Type the word `yes`, then press **Enter**.

   {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-transfer }}).