---
title: Creating a service plan
description: Follow this guide to create a service plan.
---

# Creating a service plan

1. Log in to the [{{ marketplace-short-name }} partner dashboard]({{ link-cloud-partners }}).
1. Go to the product that you want to add a new [service plan](../concepts/tariff.md) for.
1. In the **{{ ui-key.yacloud_portal.marketplace_v2.product.tab_tariffs }}** tab, click **{{ ui-key.yacloud_portal.marketplace_v2.tariff.tariff-table_action_create }}**. If you do not see the **{{ ui-key.yacloud_portal.marketplace_v2.tariff.tariff-table_action_create }}** button, it means your application for the product has not been approved yet. You can find the details and deadlines under **{{ ui-key.yacloud_portal.marketplace_v2.common.menu_ticket }}**.
1. In the window that opens, enter the name of the service plan and select the pricing policy. Different policies are available for different types of products.

   {% include [types](../../_includes/marketplace/types-of-charge.md) %}

1. Enter the price for the selected unit of measurement.
1. Click **{{ ui-key.yacloud.common.create }}**.

## Create a custom service plan {#complex-tariff}

1. Log in to the [{{ marketplace-short-name }} partner dashboard]({{ link-cloud-partners }}).
1. Select the product you want to add a custom [service plan](../concepts/tariff.md) for.
1. In the **{{ ui-key.yacloud_portal.marketplace_v2.product.tab_tariffs }}** tab, click **{{ ui-key.yacloud_portal.marketplace_v2.tariff.tariff-table_action_create }}**. If you do not see the **{{ ui-key.yacloud_portal.marketplace_v2.tariff.tariff-table_action_create }}** button, it means your application for the product has not been approved yet. You can find the details and deadlines under **{{ ui-key.yacloud_portal.marketplace_v2.common.menu_ticket }}**.
1. Enter a service plan name.
1. Select `{{ ui-key.yacloud_components.marketplace.product-pricing-type_payg }}` ⟶ **Other pricing system**.
1. In the **Service plan description** field, describe the service plan to create:
    * Describe the plan you want to create and we will help set it up if possible.
    * Create a plan on your own: specify the metric for tracking product consumption by users and the unit price.

    For more information, see [{#T}](../concepts/api-usage.md).

1. Click **{{ ui-key.yacloud.common.create }}**.

The service plan will be submitted for verification and approval. Once the SKU is approved, you will receive an `skuId` for the new service plan. You can use the `skuId` in the API to work with [application usage records](../api-ref/quickstart.md).
