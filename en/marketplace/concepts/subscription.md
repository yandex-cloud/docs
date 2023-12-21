# Subscription

Subscriptions are prepaid pricing models. A subscription is valid for only one product instance. For a single product, you can create multiple subscriptions with different costs for different periods. There are two ways of creating a subscription: with and without integration with the [{{ license-manager }} API](../license-manager/api-ref/index.md).

|   | **Without integration** | **With integration** |
|---|----------------|---------------|
| **Additional settings** | Not required | You need to set up integration with the {{ license-manager }} API and revise the code of your application to check the status of subscriptions, their types, and implement their business logic. |
| **Supported services** | {{ compute-name }} | {{ compute-name }}; support for other services is to be announced |
| **Pricing plan requirements** | `{{ ui-key.yacloud_components.marketplace.product-pricing-type_payg }}` + `Subscription` combined plan | `Subscription` only |
| **Subscription options** | Only for a specified period, e.g., a month, a year | In addition to periodic subscriptions, we offer custom subscriptions, e.g., a subscription for a number of users per month, etc. |
| **Features** | <li>If the subscription expires, the user automatically switches to the `{{ ui-key.yacloud_components.marketplace.product-pricing-type_payg }}` plan.</li><li>The user can switch from a subscription-based to the `{{ ui-key.yacloud_components.marketplace.product-pricing-type_payg }}` plan any time.</li> | <li>If the subscription expires, the product stops working.</li><li>The partner independently controls usage and sets restrictions for users in case of exceeding limits.</li> |

The subscription starts from the moment of its purchase. If you change a subscription plan, the user will continue to use their active subscription, and will purchase a new subscription at the updated price.

{% note info %}

Subscriptions cannot be combined with the PAYG plan, where the user pays for the application metrics set by the publisher.

{% endnote %}
