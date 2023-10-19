* _Free_: The product license is provided free of charge.
* _BYOL_: Lets you run software on the {{ yandex-cloud }} infrastructure using licenses purchased from third-party providers (sellers).
* _PAYG_: Billing is per second based on VM usage parameters or application metrics defined by the product publisher. The following metrics are possible:
   * Cores/hr: Every second of product use is charged at the rate multiplied by the number of VM cores with the `RUNNING` status and divided by 3600.
   * VM/hr: Charges are accrued for product usage on VMs with the `RUNNING` status. The per-second cost is calculated as the specified value divided by 3600.
   * RAM/hr: Charges are accrued for RAM usage by VMs with the `RUNNING` status. The per-second cost is calculated as the specified value divided by 3600.
   * Other pricing system: Billing is based on application metrics specified by the publisher. The per-second cost is calculated as the specified value divided by 3600. For more information, see [{#T}](../../marketplace/concepts/api-usage.md).
* _Subscription_: Product subscription.
   To set up a subscription, create a subscription template. To do this, select either the `PAYG` or the `Subscription` service plan and click **Create subscription template** at the bottom of the page.
   If you create a subscription within the `PAYG` service plan, when it expires, the user will automatically switch to this plan.
   If you create a subscription within the `Subscription` service plan, you will need to set up integration with the [License Manager API](../../marketplace/license-manager/api-ref/index.md). In this case, the product will only be available under the subscription and, when it expires, it will be disabled. You can learn more about subscriptions [here](../../marketplace/concepts/subscription.md).
