# Creating a trial period

1. Log in to the [{{ marketplace-short-name }} partner interface]({{ link-cloud-partners }}).
1. Select the product you want to add a custom [trial period](../concepts/trial-period.md) for.
1. Click **{{ ui-key.yacloud_portal.marketplace_v2.product.tab_tariffs }}** and select the plan.

   {% note warning %}

   You can only create a trial period for a plan with the `{{ ui-key.yacloud_components.marketplace.product-pricing-type_payg }}` pricing policy for the SKUs based on the VM consumption parameters.

   {% endnote %}

1. Click **{{ ui-key.yacloud_portal.marketplace_v2.tariff.action_create-trial-spec }}**.
1. Enter the duration of the trial period and click **{{ ui-key.yacloud.common.create }}**.