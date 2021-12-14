# Creating a new cloud

[When you register](../../../billing/quickstart/index.md#create_billing_account), the system automatically creates a [cloud](../../concepts/resources-hierarchy.md#cloud) for you named `cloud`. After you link a billing account, you can create an additional cloud.

To create an additional cloud:

  1. [On the billing console]({{ link-console-billing }}) make sure that the [billing account](../../../billing/concepts/billing-account.md) has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../../../billing/quickstart/index.md#create_billing_account) or ask your administrator to assign you the `billing.accounts.member` role for a payment account.
  1. Open the [management console]({{ link-console-main }}) homepage.
  1. Click ![image](../../../_assets/options.svg) next to your billing account.
  1. Select **Create cloud**.
  1. Enter the name of the cloud.
  1. Enter the organization you are going to link the cloud to. If you don't have an organization yet, one will be created automatically.
  1. Click **Create**. The `default` folder page in the new cloud opens.

{% note info %}

When you create a cloud, you are automatically given the [owner](../../concepts/resources-hierarchy.md#owner) role for this cloud.

{% endnote %}

#### See also {#see-also}

* [{#T}](update.md)
* [{#T}](set-access-bindings.md)
* [{#T}](switch-cloud.md)
* [{#T}](../folder/create.md)

