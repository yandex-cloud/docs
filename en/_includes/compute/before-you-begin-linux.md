To get started in {{ yandex-cloud }}:

1. Log in to [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.
{% if product == "yandex-cloud" %}
1. [On the billing page]({{ link-console-billing }}) make sure that you enabled a [billing account](../../billing/concepts/billing-account.md) and that it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../../billing/quickstart/index.md#create_billing_account).
{% endif %}
1. If you don't have a folder, [create one](../../resource-manager/operations/folder/create.md).
1. If you don't have an SSH key pair yet, [create one](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).