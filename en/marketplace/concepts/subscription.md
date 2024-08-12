# Subscription

Subscriptions are prepaid pricing models. A subscription is valid for only one product instance. For a single product, you can create multiple subscriptions with different costs for different periods. There are two ways of creating a subscription: with and without integration with the [{{ license-manager }} API](../license-manager/api-ref/index.md).

|   | **Without integration** | **With integration** |
|---|----------------|---------------|
| **Additional settings** | Not required | You need to set up [integration with the {{ license-manager }} API](../operations/license-manager-integration.md) yourself and revise the code of your application to check the status of subscriptions, their types, and implement the relevant business logic. |
| **Supported services** | {{ compute-name }} | {{ compute-name }}, {{ managed-k8s-name }}, SaaS; support for other services to be added later. |
| **Pricing plan requirements** | `{{ ui-key.yacloud_components.marketplace.product-pricing-type_payg }}` + `Subscription` combined plan | `Subscription` only |
| **Subscription options** | Only for a specified period, e.g., a month, a year. | In addition to periodic subscriptions, we offer custom subscriptions, e.g., for a number of users per month, etc. |
| **Features** | <li>If the subscription expires, the user automatically switches to the `{{ ui-key.yacloud_components.marketplace.product-pricing-type_payg }}` plan.</li><li>The user can switch from a subscription to the `{{ ui-key.yacloud_components.marketplace.product-pricing-type_payg }}` plan any time.</li><li>Users can choose not to subscribe and use products only under the `{{ ui-key.yacloud_components.marketplace.product-pricing-type_payg }}` plan instead.</li> | <li>If the subscription expires, the product will cease to operate.</li><li>It is up to the partner to monitor consumption and user restrictions if limits are exceeded.</li><li>When starting a product, the user must link a [service account](../../iam/concepts/users/service-accounts.md) with the `{{ roles-license-manager-user }}` and `{{ roles-license-manager-subscription-agent }}` roles, otherwise the product will not work.</li> |

The subscription starts as soon as it is purchased. If you change the subscription plan, the user will continue using their active subscription and will later purchase a new one based on the new plan. Subscription can be purchased by users with the `{{ roles-license-manager-user }}` [role](../../iam/concepts/access-control/roles.md) for a folder.

{% note info %}

Subscriptions cannot be combined with the PAYG plan, where the user pays for the application metrics set by the publisher.

{% endnote %}
