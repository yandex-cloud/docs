# Subscription

A subscription is a prepaid pricing model. Subscription:
* Becomes active at the moment of purchase. If the subscription period is specified in months or years, its cost is debited at the time of purchase and at the beginning of each following period of use: month or year. For example, if a monthly subscription is purchased on March 25, its cost will be debited on March 25 and April 1.
* Is valid only in one folder and for one product instance.
* Is not available to users during the [trial period](../../../billing/concepts/trial-period.md).

To use a subscription, a user must [link](../../operations/users/lock-subscription.md) it to a resource, app, or service.

To find products available by subscription, you can use the **Pricing type** → **Subscription** filter on the [{{ marketplace-short-name }}](/marketplace) website. You can find the terms and conditions for purchasing a subscription in the product card. To purchase a subscription, you need the `license-manager.user` [role](../../security/index.md). A purchased subscription is active even if it is not linked to a resource, app, or service.

The user can [move](../../operations/users/move-subscription.md) purchased subscriptions between folders to which they have permissions.

Subscription auto-renewal is automatically disabled if the user [billing account](../../../billing/concepts/billing-account.md) is blocked. After unblocking your billing account, you will need to purchase the subscription again.

## See also {#see-also}

* [{#T}](../../operations/users/buy-subscription.md)
* [{#T}](../../operations/users/cancel-subscription.md)
