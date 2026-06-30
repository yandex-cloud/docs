To delete an endpoint created using {{ TF }}:
1. Open the current {{ TF }} configuration file with the infrastructure plan.

   For more on how to create such a file, see [{#T}](../../data-transfer/operations/endpoint/index.md#create).
1. Make sure that the endpoint being deleted is not bound to a transfer.
1. Delete the endpoint description.
1. Make sure the settings are correct.

   {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

1. Type `yes` and press **Enter**.

   {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

For more information, see [this {{ TF }} provider guide]({{ tf-provider-dt-endpoint }}).