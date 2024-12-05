---
title: Getting started with {{ marketplace-short-name }} Metering API
description: You will learn how to send consumption metrics for your product in {{ marketplace-short-name }} Metering API.
---

# How to get started with {{ marketplace-short-name }} Metering API

In this section, you will learn how to send [consumption metrics](../concepts/api-usage.md) for your [product](../concepts/product.md) in {{ marketplace-short-name }} Metering API.


## Getting started {#before-begin}

To get started with {{ marketplace-short-name }} Metering API:

1. Get your product's IDs (`productId`) and SKU (`skuId`). You can find the IDs on the product page in the [{{ marketplace-short-name }} partner dashboard]({{ link-cloud-partners }}).
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) the `marketplace.meteringAgent` role for your [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to the service account you will use to authenticate with {{ marketplace-short-name }} Metering API and submit metrics. To learn more, see [Access management](../security/index.md).
1. [Get](../../iam/concepts/authorization/iam-token) an IAM token for the same service account.

To use the examples, install the following:

* [cURL](https://curl.haxx.se)
* [gRPCurl](https://github.com/fullstorydev/grpcurl) (when using [gRPC API](../api-ref/ImageProductUsage/index))
* [uuidgen](https://uuidgen.org/)


## Test metric submission {#dry-run}

Test submitting metrics to {{ marketplace-short-name }} Metering API. A test metric submission request is the same as a real one except for the `validate_only` parameter set to `true`.

Test by running this command:

{% list tabs group=instructions %}

- REST API {#api}

  ```bash
  curl \
    --request POST \
    --url 'https://marketplace.{{ api-host }}/marketplace/metering/v1/imageProductUsage/write' \
    --header 'Authorization: Bearer <IAM_token>' \
    --header 'Content-Type: application/json' \
    --data '{
      "validate_only": true,
      "product_id": "<product_ID>",
      "usage_records": [
        {
          "uuid": "<record_ID>",
          "sku_id": "<SKU_ID>",
          "quantity": <number_of_units>,
          "timestamp": "<timestamp>"
        }
      ]
    }'
  ```

  {% include [post-metering-legend](../../_includes/marketplace/post-metering-legend.md) %}

- gRPC API {#grpc-api}

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer <IAM_token>" \
    -d '{
      "validate_only": true,
      "product_id": "<product_ID>",
      "usage_records": [
        {
          "uuid": "<record_ID>",
          "sku_id": "<SKU_ID>",
          "quantity": <number_of_units>,
          "timestamp": <timestamp>
        }
      ]
    }' \
    marketplace.{{ api-host }}:443 yandex.cloud.marketplace.metering.v1.ImageProductUsageService/Write
  ```

  {% include [post-metering-legend](../../_includes/marketplace/post-metering-legend.md) %}

{% endlist %}

## Submit a metric {#send-metric}

To submit a metric, run this command:

{% list tabs group=instructions %}

- REST API {#api}

  ```bash
  curl \
    --request POST \
    --url 'https://marketplace.{{ api-host }}/marketplace/metering/v1/imageProductUsage/write' \
    --header 'Authorization: Bearer <IAM_token>' \
    --header 'Content-Type: application/json' \
    --data '{
      "product_id": "<product_ID>",
      "usage_records": [
        {
          "uuid": "<record_ID>",
          "sku_id": "<SKU_ID>",
          "quantity": <number_of_units>,
          "timestamp": "<timestamp>"
        }
      ]
    }'
  ```

  {% include [post-metering-legend](../../_includes/marketplace/post-metering-legend.md) %}

- gRPC API {#grpc-api}

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer <IAM_token>" \
    -d '{
      "product_id": "<product_ID>",
      "usage_records": [
        {
          "uuid": "<record_ID>",
          "sku_id": "<SKU_ID>",
          "quantity": <number_of_units>,
          "timestamp": "<timestamp>"
        }
      ]
    }' \
    marketplace.{{ api-host }}:443 yandex.cloud.marketplace.metering.v1.ImageProductUsageService/Write
  ```

  {% include [post-metering-legend](../../_includes/marketplace/post-metering-legend.md) %}

{% endlist %}

Result:

```json
{
  "accepted": [
    {
      "uuid": "uu1dc02f-6785-47fc-945a-7b4d********",
      "sku_id": "dn21df4qvqhb********",
      "quantity": 1,
      "timestamp": "2024-09-16T19:01:10.591128Z"
    }
  ],
  "rejected": []
}
```

If the metric is rejected, a list of rejected records will be displayed. For example:

```json
{
  "accepted": [],
  "rejected": [
    {
      "uuid": "uu1dc02f-6785-47fc-945a-7b4d********",
      "reason": "INVALID_ID"
    }
  ]
}
```

Where:

* `uuid`: Unique record ID.
* `reason`: Reason for rejecting the metric. The possible values are:

    * `DUPLICATE`: Record duplicate. A record with this ID already exists.
    * `EXPIRED`: Expired record. You cannot submit metrics for consumption events older than one hour.
    * `INVALID_TIMESTAMP`: Invalid timestamp. Future timestamps are not supported.
    * `INVALID_SKU_ID`: Invalid SKU ID. The SKU is not found.
    * `INVALID_PRODUCT_ID`: Invalid product ID. The product is not found.
    * `INVALID_QUANTITY` : Invalid quantity. The quantity must be greater than `0`.
    * `INVALID_ID`: Invalid record ID. The ID is not recognized as a UUID.

A successful test does not guarantee the metric will be accepted following an actual request. For example, if the service account loses its permission to submit metrics, the API will return the `403` `Forbidden` error. This can happen if the user revokes access permissions or the billing account enters a [state](../../billing/concepts/billing-account-statuses) in which consumption is not possible. To avoid such errors, break you jobs down into smaller sub-issues and submit metrics after each one. For example, for an email app, send a metric per email sent.

You can group metrics into a single request by different SKUs or over a certain time period. This will reduce the number of requests. For example, if your app’s RPS is high, submit metrics once per minute with the number of successful requests specified in the `quantity` parameter.