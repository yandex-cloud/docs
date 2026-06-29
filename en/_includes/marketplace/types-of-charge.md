* _{{ ui-key.yacloud_components.marketplace.product-pricing-type_free }}_: The product license is provided free of charge.
* _{{ ui-key.yacloud_components.marketplace.product-pricing-type_payg }}_: Billing is per second based on VM usage parameters or application metrics defined by the product publisher. The following metrics are possible:
   * vCPU-hours: Every second of product usage is charged at the rate multiplied by the number of vCPUs of the `RUNNING` VM and divided by 3,600.
   * VM-hours: You are charged for product usage on `RUNNING` VMs. The per-second cost is calculated as the specified value divided by 3,600.
   * RAM-hours: You are charged for RAM usage by `RUNNING` VMs. The per-second cost is calculated as the specified value divided by 3,600.
   * Other pricing system: Billing is based on application metrics specified by the publisher. For more information, see [{#T}](../../marketplace/operations/create-tariff.md#complex-tariff).
* _Subscription_: Product subscription.
    To set up a subscription, create a subscription template. To do this, select either the `{{ ui-key.yacloud_components.marketplace.product-pricing-type_payg }}` or the `Subscription` service plan and click **Create subscription template** at the bottom of the page.
    If you create a subscription within the `{{ ui-key.yacloud_components.marketplace.product-pricing-type_payg }}` service plan, the user will automatically switch to this plan as soon as they unlink the subscription from a resource or as soon as the subscription expires.
    If you create a subscription within the `Subscription` service plan, you will need to set up integration with the [{{ license-manager }} API](../../marketplace/license-manager/api-ref/index.md). In this case, the product will only be available under the subscription and, when it expires, it will be disabled. You can learn more about subscriptions [here](../../marketplace/concepts/subscription.md).
