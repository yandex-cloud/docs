---
title: How to get the cost breakdown via API in {{ billing-name }}
description: Follow this guide to get the cost breakdown via the {{ billing-name }} public API.
---

# Getting the cost breakdown via API

{% note info %}

To work with the API, use the gRPC protocol. The REST API is currently not available.

{% endnote %}

{{ billing-name }} provides a public API for getting detailed information on expenses and resource consumption. You can use it to generate reports for any period, filter and group data by clouds, folders, services, products, resources, and labels, as well as automate data collection for integration into your own analytics and monitoring systems.

The minimum role required to get the cost breakdown via the API is `billing.accounts.viewer`. For more information, see the [role description](../security/index.md#billing-accounts-viewer).

Public {{ billing-name }} API endpoint: `https://billing.api.cloud.yandex.net`.

## ConsumptionCore {#consumption-core}

This is a service for getting usage and expense reports. It provides methods for obtaining breakdowns at different hierarchy levels.

To get the breakdown of costs and resource usage for a [billing account](../concepts/billing-account.md):

* For the billing account, use the [ConsumptionCore/GetBillingAccountUsageReport](../usage/api-ref/grpc/ConsumptionCore/getBillingAccountUsageReport.md) gRPC API call.
* For clouds, use the [ConsumptionCore/GetCloudUsageReport](../usage/api-ref/grpc/ConsumptionCore/getCloudUsageReport.md) gRPC API call.
* For folders, use the [ConsumptionCore/GetFolderUsageReport](../usage/api-ref/grpc/ConsumptionCore/getFolderUsageReport.md) gRPC API call.
* For services, use the [ConsumptionCore/GetServiceUsageReport](../usage/api-ref/grpc/ConsumptionCore/getServiceUsageReport.md) gRPC API call.
* For products (SKUs), use the [ConsumptionCore/GetSKUUsageReport](../usage/api-ref/grpc/ConsumptionCore/getSKUUsageReport.md) gRPC API call.
* For resources, use the [ConsumptionCore/GetResourceUsageReport](../usage/api-ref/grpc/ConsumptionCore/getResourceUsageReport.md) gRPC API call.
* For labels, use the [ConsumptionCore/GetLabelKeyUsageReport](../usage/api-ref/grpc/ConsumptionCore/getLabelKeyUsageReport.md) gRPC API call.

All `ConsumptionCore` methods return data as a three-level structure:

1. Overall results for the entire requested period, where:

   * `cost`: Cost of consumed resources before discounts.
   * `credits`: Applied discounts ([grants](../concepts/bonus-account.md), volume discounts, CVoS).
   * `expense`: Total cost after discounts.
1. Entity totals, i.e., the aggregate data for each entity of the requested type (cloud, folder, service, etc.).
1. Time series, i.e., the breakdown of data by `aggregation_period` (day, week, month, quarter, or year).

For more information, see the [ConsumptionCore](../usage/api-ref/grpc/ConsumptionCore/index.md) API reference.

## Metadata {#metadata}

With `Metadata`, you can obtain the lists of clouds, services, products (SKUs), labels, and resources, which you will later use to request breakdowns. `Metadata` methods return lists of available entities and their attributes.

Here is how you can get metadata on the following entities within a billing account:

* Available clouds, services, products (SKUs), label keys, and date ranges: [Metadata/GetUsage](../usage/api-ref/grpc/Metadata/getUsage.md) gRPC API call.
* Available label keys and values: [Metadata/GetLabel](../usage/api-ref/grpc/Metadata/getLabel.md) gRPC API call.
* Available folders for the specified clouds: [Metadata/GetCloud](../usage/api-ref/grpc/Metadata/getCloud.md) gRPC API call.
* Available resource IDs within a date range: [Metadata/GetResourceIDs](../usage/api-ref/grpc/Metadata/getResourceIDs.md) gRPC API call.

For more information, see the [Metadata](../usage/api-ref/grpc/Metadata/index.md) API reference.

## Use cases {#examples}

To use the examples, install [grpcurl](https://github.com/fullstorydev/grpcurl) and get your account credentials.

### Getting billing account usage details {#billing-account-report}

Here is a request example to get a report for a billing account for a given period:

  ```bash
  grpcurl -H "authorization: Bearer <IAM_token>" \
    -d '{
      "billing_account_id": "dn276oa9slgm********",
      "start_date": {
        "seconds": 1704067200
      },
      "end_date": {
        "seconds": 1706745599
      },
      "aggregation_period": "MONTH"
    }' \
    billing.api.cloud.yandex.net:443 \
    yandex.cloud.billing.usage_records.v1.ConsumptionCoreService/GetBillingAccountUsageReport
  ```

  Where:

  * `<IAM_token>`: IAM token used for authentication.
  * `billing_account_id`: [Billing account](../concepts/billing-account.md) ID.
  * `start_date`: Start of the period (inclusive).
  * `end_date`: End of the period (inclusive).
  * `aggregation_period`: Data aggregation period (`DAY`, `WEEK`, `MONTH`, `QUARTER`, `YEAR`).

  {% cut "Result" %}

  ```json
  {
    "currency": "RUB",
    "cost": {
      "value": "15000.50"
    },
    "credit_details": {
      "credit": {
        "value": "-1500.00"
      },
      "monetary_grant_credit": {
        "value": "-1000.00"
      },
      "volume_incentive_credit": {
        "value": "-500.00"
      },
      "cud_credit": {
        "value": "0.00"
      },
      "free_credit": {
        "value": "0.00"
      }
    },
    "expense": {
      "value": "13500.50"
    },
    "entities_data": [
      {
        "cost": {
          "value": "15000.50"
        },
        "credit_details": {
          "credit": {
            "value": "-1500.00"
          },
          "monetary_grant_credit": {
            "value": "-1000.00"
          },
          "volume_incentive_credit": {
            "value": "-500.00"
          },
          "cud_credit": {
            "value": "0.00"
          },
          "free_credit": {
            "value": "0.00"
          }
        },
        "expense": {
          "value": "13500.50"
        },
        "billing_account": {
          "id": "dn276oa9slgm********",
          "name": "My Billing Account"
        },
        "periodic": [
          {
            "cost": {
              "value": "15000.50"
            },
            "credit_details": {
              "credit": {
                "value": "-1500.00"
              },
              "monetary_grant_credit": {
                "value": "-1000.00"
              },
              "volume_incentive_credit": {
                "value": "-500.00"
              },
              "cud_credit": {
                "value": "0.00"
              },
              "free_credit": {
                "value": "0.00"
              }
            },
            "expense": {
              "value": "13500.50"
            },
            "timestamp": "2024-01-01T00:00:00Z"
          }
        ]
      }
    ]
  }
  ```

  {% endcut %}


### Getting cloud usage details {#cloud-report}

Here is a request example to get usage details for specific clouds, filtered by services:

  ```bash
  grpcurl -H "authorization: Bearer <IAM_token>" \
    -d '{
      "billing_account_id": "dn276oa9slgm********",
      "start_date": {
        "seconds": 1704067200
      },
      "end_date": {
        "seconds": 1706745599
      },
      "cloud_ids": ["b1gvlrnlw2e6********", "b1gia87mbaom********"],
      "service_ids": ["compute", "storage"],
      "aggregation_period": "MONTH"
    }' \
    billing.api.cloud.yandex.net:443 \
    yandex.cloud.billing.usage_records.v1.ConsumptionCoreService/GetCloudUsageReport
  ```

  Where:
  
  * `cloud_ids`: List of cloud IDs for filtering.
  * `service_ids`: List of service IDs for filtering.

  Additional filtering parameters:

  * `folder_ids`: List of folder IDs.
  * `sku_ids`: List of product (SKU) IDs.
  * `resource_ids`: List of resource IDs.
  * `labels`: Filtering by resource labels.

  {% cut "Result" %}

  ```json
  {
    "currency": "RUB",
    "cost": {
      "value": "8500.25"
    },
    "credit_details": {
      "credit": {
        "value": "-850.00"
      },
      "monetary_grant_credit": {
        "value": "-500.00"
      },
      "volume_incentive_credit": {
        "value": "-350.00"
      },
      "cud_credit": {
        "value": "0.00"
      },
      "free_credit": {
        "value": "0.00"
      }
    },
    "expense": {
      "value": "7650.25"
    },
    "entities_data": [
      {
        "cost": {
          "value": "5000.00"
        },
        "credit_details": {
          "credit": {
            "value": "-500.00"
          },
          "monetary_grant_credit": {
            "value": "-300.00"
          },
          "volume_incentive_credit": {
            "value": "-200.00"
          },
          "cud_credit": {
            "value": "0.00"
          },
          "free_credit": {
            "value": "0.00"
          }
        },
        "expense": {
          "value": "4500.00"
        },
        "cloud": {
          "id": "b1gvlrnlw2e6********",
          "name": "Production Cloud"
        },
        "periodic": [
          {
            "cost": {
              "value": "5000.00"
            },
            "credit_details": {
              "credit": {
                "value": "-500.00"
              },
              "monetary_grant_credit": {
                "value": "-300.00"
              },
              "volume_incentive_credit": {
                "value": "-200.00"
              },
              "cud_credit": {
                "value": "0.00"
              },
              "free_credit": {
                "value": "0.00"
              }
            },
            "expense": {
              "value": "4500.00"
            },
            "timestamp": "2024-01-01T00:00:00Z"
          }
        ]
      },
      {
        "cost": {
          "value": "3500.25"
        },
        "credit_details": {
          "credit": {
            "value": "-350.00"
          },
          "monetary_grant_credit": {
            "value": "-200.00"
          },
          "volume_incentive_credit": {
            "value": "-150.00"
          },
          "cud_credit": {
            "value": "0.00"
          },
          "free_credit": {
            "value": "0.00"
          }
        },
        "expense": {
          "value": "3150.25"
        },
        "cloud": {
          "id": "b1gia87mbaom********",
          "name": "Development Cloud"
        },
        "periodic": [
          {
            "cost": {
              "value": "3500.25"
            },
            "credit_details": {
              "credit": {
                "value": "-350.00"
              },
              "monetary_grant_credit": {
                "value": "-200.00"
              },
              "volume_incentive_credit": {
                "value": "-150.00"
              },
              "cud_credit": {
                "value": "0.00"
              },
              "free_credit": {
                "value": "0.00"
              }
            },
            "expense": {
              "value": "3150.25"
            },
            "timestamp": "2024-01-01T00:00:00Z"
          }
        ]
      }
    ]
  }
  ```

  {% endcut %}


### Getting metadata {#metadata-example}

Here is a request example to get metadata about available clouds, services, and products:

  ```bash
  grpcurl -H "authorization: Bearer <IAM_token>" \
    -d '{
      "billing_account_id": "dn276oa9slgm********",
      "start_date": {
        "seconds": 1704067200
      },
      "end_date": {
        "seconds": 1706745599
      }
    }' \
    billing.api.cloud.yandex.net:443 \
    yandex.cloud.billing.usage_records.v1.MetadataService/GetUsage
  ```

  {% cut "Result" %}

  ```json
  {
    "clouds": [
      {
        "id": "b1gvlrnlw2e6********",
        "name": "Production Cloud"
      },
      {
        "id": "b1gia87mbaom********",
        "name": "Development Cloud"
      }
    ],
    "services": [
      {
        "id": "compute",
        "name": "Compute Cloud"
      },
      {
        "id": "storage",
        "name": "Object Storage"
      },
      {
        "id": "vpc",
        "name": "Virtual Private Cloud"
      },
      {
        "id": "managed-kubernetes",
        "name": "Managed Service for Kubernetes"
      }
    ],
    "skus": [
      {
        "id": "sku-compute-vm-standard-v3",
        "name": "Compute VM Standard v3",
        "service_id": "compute"
      },
      {
        "id": "sku-storage-standard",
        "name": "Standard Storage",
        "service_id": "storage"
      },
      {
        "id": "sku-vpc-traffic",
        "name": "VPC Egress Traffic",
        "service_id": "vpc"
      }
    ],
    "label_keys": [
      {
        "key": "environment"
      },
      {
        "key": "project"
      },
      {
        "key": "team"
      }
    ],
    "date_range": {
      "start_date": "2024-01-01T00:00:00Z",
      "end_date": "2024-01-31T23:59:59Z"
    }
  }
  ```

  {% endcut %}

#### See also {#see-also}

* [{#T}](check-charges.md)
* [{#T}](get-folder-report.md)
* [{#T}](query-integration.md)