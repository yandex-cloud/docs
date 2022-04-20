# Creating a service plan

1. Log in to the [{{ marketplace-short-name }} partner interface]({{ link-cloud-partners }}).
1. Go to the product that you want to add a new [service plan](../concepts/tariff.md) for.
1. On the **Pricing** tab, click **Create service plan**. If you don't see the **Create service plan** button, it means your application for the product has not been approved yet. You can find the details and deadlines under **Application ticket**.
1. In the window that opens, enter the name of the service plan and select the pricing policy. Different policies are available for different types of products.

   {% include [types](../../_includes/marketplace/types-of-charge.md) %}

1. Enter the price for the selected unit of measurement.
1. Click **Create**.

## Create a custom service plan {#complex-tariff}

1. Log in to the [{{ marketplace-short-name }} partner interface]({{ link-cloud-partners }}).
1. Select the product you wish to add a custom [service plan](../concepts/tariff.md) for.
1. On the **Pricing** tab, click **Create service plan**. If you don't see the **Create service plan** button, it means your application for the product has not been approved yet. You can find the details and deadlines under **Application ticket**.
1. Enter a service plan name.
1. Select `PAYG` ⟶ **Other pricing system**.
1. In the **Service plan description** field, describe the service plan you are about to create:
   * Specify the metric to be used to track product consumption by users. For details, see [{#T}](../concepts/api-usage.md).
   * Specify the unit price.
1. Click **Create**.

The service plan will be submitted for verification and approval. Once the SKU is approved, you will receive an `skuId` representing the service plan just created. You can use the `skuId` in the API to process [application usage records](../api-ref/).
