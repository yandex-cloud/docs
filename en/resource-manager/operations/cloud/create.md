# Creating a new cloud

[When you register](../../../billing/quickstart/index.md#create_billing_account), the system automatically creates a [cloud](../../concepts/resources-hierarchy.md#cloud) for you named `cloud`. After you link a billing account, you can create an additional cloud.

{% note important %}

You currently can't create an additional cloud if you were already invited to the cloud and have no billing account.

{% endnote %}

To create an additional cloud:

  1. [On the billing page]({{ link-console-billing }}) make sure that the [billing account](../../../billing/concepts/billing-account.md) has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a payment account, [create one](../../../billing/quickstart/index.md#create_billing_account).
  1. Open the [management console]({{ link-console-main }}) homepage.
  1. Click ![image](../../../_assets/options.svg) next to your billing account.
  1. Select **Create cloud**.
  1. Enter a name for the cloud and click **Create**. The `default` folder page in the new cloud opens.

{% note info %}

When you create a cloud, you are automatically given the [owner](../../concepts/resources-hierarchy.md#owner) role for this cloud.

{% endnote %}

