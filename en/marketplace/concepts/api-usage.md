# Billing of products based on publisher metrics

{{ marketplace-short-name }} provides an API to account for product consumption so that products can track consumption and invoice {{ yandex-cloud }} users through {{ billing-name }}. Integration with the API is required for any product that uses one or more pricing plans with custom metrics to account for consumption events.

Based on the metrics you set, an application (product) should register consumption events and send this data using the consumption metering API. You can send one or more consumption events per request.

For the specification of the service plan-based billing API, see [{#T}](../api-ref/index.md). An example of how to use the API is available in the [GitHub repository](https://github.com/yandex-cloud/python-sdk/tree/master/examples/marketplace/metering-api).

## Development and testing recommendations {#guidelines}

* To authenticate your app, use the [service account](../../iam/concepts/users/service-accounts.md) with the `marketplace.meteringAgent` role.
* To create a pricing plan for a product with custom metrics, submit a request in the {{ marketplace-short-name }} partner's account. Use the `skuId` assigned to the plan to send product consumption records.
* When a user is installing your application, it must verify that they have sufficient rights to use it and that sending of consumption events is possible. To do this, send the [write](../api-ref/ImageProductUsage/write.md) request with the `validateOnly: true` parameter.
* The application should take into account that an attempt to send consumption events may fail.
* Before you publish your product, we recommend testing its integration with the API using a demo product's ID and SKU: `product_id: {{ mp-test-product-id }}` and `sku_id: {{ mp-test-sku-id }}`.