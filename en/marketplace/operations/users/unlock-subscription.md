---
title: How to unlink a subscription purchased on {{ marketplace-full-name }}
---

# Unlinking a subscription

If you unlink a subscription, the product will stop working until you link another active subscription to the resource, app, or service. The subscription remains active until the end of the paid period, regardless of whether it is linked.

If a product for {{ compute-name }} is available on both a subscription and `Pay as you go` basis, when you unlink the subscription from the virtual machine, the product installed on it will be charged at the `Pay as you go` rate. You can see the available pricing types in the product card.

To unlink a subscription:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where the [subscription](../../concepts/users/subscription.md) is located.
   1. Go to the **{{ ui-key.yacloud.marketplace-v2.label_licenses }}** tab.
   1. In the line with the appropriate subscription, click ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.marketplace-v2.action_detach-subscription }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.common.continue }}**.

{% endlist %}
