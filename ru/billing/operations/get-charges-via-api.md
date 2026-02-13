---
title: Как получить детализацию расходов через API в {{ billing-name }}
description: Следуя данной инструкции, вы сможете получить детализацию расходов через публичный API {{ billing-name }}.
---

# Получить детализацию расходов через API

{% note info %}

Для работы с API используйте протокол gRPC. Версия REST API в настоящее время не предоставляется.

{% endnote %}

{{ billing-name }} предоставляет публичный API для получения детализации расходов и потребления ресурсов. С его помощью можно получать отчеты за любой период, фильтровать и группировать данные по облакам, каталогам, сервисам, продуктам, ресурсам и меткам, а также автоматизировать сбор данных для интеграции в собственные системы аналитики и мониторинга.

Минимально необходимая роль для получения детализации расходов через API — `billing.accounts.viewer`. См. [описание роли](../security/index.md#billing-accounts-viewer).

Эндпоинт публичного API {{ billing-name }} — `https://billing.api.cloud.yandex.net`.

## Сервис ConsumptionCore {#consumption-core}

Сервис для получения отчетов о потреблении и расходах. Предоставляет методы для получения детализации по различным уровням иерархии.

Чтобы получить детализацию расходов и потребления ресурсов в рамках [платежного аккаунта](../concepts/billing-account.md):

* По платежному аккаунту воспользуйтесь вызовом gRPC API [ConsumptionCore/GetBillingAccountUsageReport](../usage/api-ref/grpc/ConsumptionCore/getBillingAccountUsageReport.md).
* По облакам воспользуйтесь вызовом gRPC API [ConsumptionCore/GetCloudUsageReport](../usage/api-ref/grpc/ConsumptionCore/getCloudUsageReport.md).
* По каталогам воспользуйтесь вызовом gRPC API [ConsumptionCore/GetFolderUsageReport](../usage/api-ref/grpc/ConsumptionCore/getFolderUsageReport.md).
* По сервисам воспользуйтесь вызовом gRPC API [ConsumptionCore/GetServiceUsageReport](../usage/api-ref/grpc/ConsumptionCore/getServiceUsageReport.md).
* По продуктам (SKU) воспользуйтесь вызовом gRPC API [ConsumptionCore/GetSKUUsageReport](../usage/api-ref/grpc/ConsumptionCore/getSKUUsageReport.md).
* По ресурсам воспользуйтесь вызовом gRPC API [ConsumptionCore/GetResourceUsageReport](../usage/api-ref/grpc/ConsumptionCore/getResourceUsageReport.md).
* По меткам воспользуйтесь вызовом gRPC API [ConsumptionCore/GetLabelKeyUsageReport](../usage/api-ref/grpc/ConsumptionCore/getLabelKeyUsageReport.md).

Все методы сервиса `ConsumptionCore` возвращают данные в трехуровневой структуре:

1. Общие итоги за весь запрошенный период, где:

   * `cost` — стоимость потребленных ресурсов без учета скидок.
   * `credits` — примененные скидки ([гранты](../concepts/bonus-account.md), скидки за объем, резервированное потребление).
   * `expense` — итоговая стоимость с учетом скидок.
1. Итоги по сущностям — агрегированные данные для каждой сущности запрошенного типа (облако, каталог, сервис и т. д.).
1. Временные ряды — разбивка данных по периодам в соответствии с параметром `aggregation_period` (день, неделя, месяц, квартал, год).

Подробнее см. в справочнике API [ConsumptionCore](../usage/api-ref/grpc/ConsumptionCore/index.md).

## Сервис Metadata {#metadata}

Сервис позволяет получить списки облаков, сервисов, продуктов (SKU), меток и ресурсов для последующего использования в запросах детализации. Методы сервиса `Metadata` возвращают списки доступных сущностей и их атрибутов.

Чтобы получить в рамках платежного аккаунта метаданные о:

* Доступных облаках, сервисах, продуктах (SKU), ключах меток и диапазонах дат воспользуйтесь вызовом gRPC API [Metadata/GetUsage](../usage/api-ref/grpc/Metadata/getUsage.md).
* Доступных ключах и значениях меток воспользуйтесь вызовом gRPC API [Metadata/GetLabel](../usage/api-ref/grpc/Metadata/getLabel.md).
* Доступных каталогах для указанных облаков воспользуйтесь вызовом gRPC API [Metadata/GetCloud](../usage/api-ref/grpc/Metadata/getCloud.md).
* Всех доступных идентификаторах ресурсов в диапазоне дат воспользуйтесь вызовом gRPC API [Metadata/GetResourceIDs](../usage/api-ref/grpc/Metadata/getResourceIDs.md).

Подробнее см. в справочнике API [Metadata](../usage/api-ref/grpc/Metadata/index.md).

## Примеры использования {#examples}

Чтобы воспользоваться примерами, установите утилиту [grpcurl](https://github.com/fullstorydev/grpcurl) и получите данные вашего аккаунта для аутентификации.

### Получение детализации по платежному аккаунту {#billing-account-report}

Пример запроса для получения отчета по платежному аккаунту за указанный период:

  ```bash
  grpcurl -H "authorization: Bearer <IAM-токен>" \
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

  Где:

  * `<IAM-токен>` — IAM-токен для аутентификации.
  * `billing_account_id` — идентификатор [платежного аккаунта](../concepts/billing-account.md).
  * `start_date` — начало периода (включительно).
  * `end_date` — конец периода (включительно).
  * `aggregation_period` — период агрегации данных (`DAY`, `WEEK`, `MONTH`, `QUARTER`, `YEAR`).

  {% cut "Результат" %}

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


### Получение детализации по облакам {#cloud-report}

Пример запроса для получения детализации по конкретным облакам с фильтрацией по сервисам:

  ```bash
  grpcurl -H "authorization: Bearer <IAM-токен>" \
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

  Где:
  
  * `cloud_ids` — список идентификаторов облаков для фильтрации.
  * `service_ids` — список идентификаторов сервисов для фильтрации.

  Дополнительные параметры фильтрации:

  * `folder_ids` — список идентификаторов каталогов.
  * `sku_ids` — список идентификаторов продуктов (SKU).
  * `resource_ids` — список идентификаторов ресурсов.
  * `labels` — фильтрация по меткам ресурсов.

  {% cut "Результат" %}

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


### Получение метаданных {#metadata-example}

Пример запроса для получения метаданных о доступных облаках, сервисах и продуктах:

  ```bash
  grpcurl -H "authorization: Bearer <IAM-токен>" \
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

  {% cut "Результат" %}

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

#### См. также {#see-also}

* [{#T}](check-charges.md)
* [{#T}](get-folder-report.md)
* [{#T}](query-integration.md)