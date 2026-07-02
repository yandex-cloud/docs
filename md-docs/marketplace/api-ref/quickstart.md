[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Marketplace](../index.md) > Партнерам > Справочник Metering API > Начало работы с API

# Как начать работать с Marketplace Metering API

В этом разделе вы научитесь отправлять [метрики потребления](../concepts/api-usage.md) вашего [продукта](../concepts/product.md) в Marketplace Metering API.


## Перед началом работы {#before-begin}

Чтобы начать работать c Marketplace Metering API:

1. Получите идентификаторы вашего продукта (`productId`) и SKU (`skuId`). Идентификаторы указаны на странице продукта в [кабинете партнера Marketplace](https://partners.yandex.cloud/).
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) сервисному аккаунту, от имени которого вы будете аутентифицироваться в Marketplace Metering API и отправлять метрики, роль `marketplace.meteringAgent` на ваш [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Подробнее в разделе [Управление доступом](../security/index.md).
1. [Получите](../../iam/concepts/authorization/iam-token.md) IAM-токен для того же сервисного аккаунта.

Чтобы воспользоваться примерами, установите:

* [cURL](https://curl.haxx.se)
* [gRPCurl](https://github.com/fullstorydev/grpcurl) (при использовании [gRPC API](../metering/api-ref/ImageProductUsage/index.md))
* [uuidgen](https://uuidgen.org/)


## Проверьте возможность отправки метрик {#dry-run}

Проверьте отправку метрик в Marketplace Metering API. Проверочный запрос отличается от реальной отправки метрик только параметром `validate_only` со значением `true`.

Для проверки выполните команду:

{% list tabs group=instructions %}

- REST API {#api}

  ```bash
  curl \
    --request POST \
    --url 'https://marketplace.api.cloud.yandex.net/marketplace/metering/v1/imageProductUsage/write' \
    --header 'Authorization: Bearer <IAM-токен>' \
    --header 'Content-Type: application/json' \
    --data '{
      "validate_only": true,
      "product_id": "<идентификатор_продукта>",
      "usage_records": [
        {
          "uuid": "<идентификатор_записи>",
          "sku_id": "<идентификатор_SKU>",
          "quantity": <количество_единиц>,
          "timestamp": "<временная_метка>"
        }
      ]
    }'
  ```

  Где:
  
  * `<IAM-токен>` — полученный перед началом работы IAM-токен.
  * `product_id` — идентификатор продукта.
  * `uuid` — уникальный идентификатор записи. Может быть сгенерирован с помощью [uuidgen](https://uuidgen.org/).
  * `sku_id` — идентификатор SKU.
  * `quantity` — количество потребленных единиц. Должно быть целое число больше `0`. Например, `1`.
  * `timestamp` — временная метка в формате [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601). Например, `2024-09-16T19:01:10.591128Z`.

- gRPC API {#grpc-api}

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer <IAM-токен>" \
    -d '{
      "validate_only": true,
      "product_id": "<идентификатор_продукта>",
      "usage_records": [
        {
          "uuid": "<идентификатор_записи>",
          "sku_id": "<идентификатор_SKU>",
          "quantity": <количество_единиц>,
          "timestamp": <временная_метка>
        }
      ]
    }' \
    marketplace.api.cloud.yandex.net:443 yandex.cloud.marketplace.metering.v1.ImageProductUsageService/Write
  ```

  Где:
  
  * `<IAM-токен>` — полученный перед началом работы IAM-токен.
  * `product_id` — идентификатор продукта.
  * `uuid` — уникальный идентификатор записи. Может быть сгенерирован с помощью [uuidgen](https://uuidgen.org/).
  * `sku_id` — идентификатор SKU.
  * `quantity` — количество потребленных единиц. Должно быть целое число больше `0`. Например, `1`.
  * `timestamp` — временная метка в формате [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601). Например, `2024-09-16T19:01:10.591128Z`.

{% endlist %}

## Отправьте метрику {#send-metric}

Чтобы отправить метрику, выполните команду:

{% list tabs group=instructions %}

- REST API {#api}

  ```bash
  curl \
    --request POST \
    --url 'https://marketplace.api.cloud.yandex.net/marketplace/metering/v1/imageProductUsage/write' \
    --header 'Authorization: Bearer <IAM-токен>' \
    --header 'Content-Type: application/json' \
    --data '{
      "product_id": "<идентификатор_продукта>",
      "usage_records": [
        {
          "uuid": "<идентификатор_записи>",
          "sku_id": "<идентификатор_SKU>",
          "quantity": <количество_единиц>,
          "timestamp": "<временная_метка>"
        }
      ]
    }'
  ```

  Где:
  
  * `<IAM-токен>` — полученный перед началом работы IAM-токен.
  * `product_id` — идентификатор продукта.
  * `uuid` — уникальный идентификатор записи. Может быть сгенерирован с помощью [uuidgen](https://uuidgen.org/).
  * `sku_id` — идентификатор SKU.
  * `quantity` — количество потребленных единиц. Должно быть целое число больше `0`. Например, `1`.
  * `timestamp` — временная метка в формате [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601). Например, `2024-09-16T19:01:10.591128Z`.

- gRPC API {#grpc-api}

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer <IAM-токен>" \
    -d '{
      "product_id": "<идентификатор_продукта>",
      "usage_records": [
        {
          "uuid": "<идентификатор_записи>",
          "sku_id": "<идентификатор_SKU>",
          "quantity": <количество_единиц>,
          "timestamp": "<временная_метка>"
        }
      ]
    }' \
    marketplace.api.cloud.yandex.net:443 yandex.cloud.marketplace.metering.v1.ImageProductUsageService/Write
  ```

  Где:
  
  * `<IAM-токен>` — полученный перед началом работы IAM-токен.
  * `product_id` — идентификатор продукта.
  * `uuid` — уникальный идентификатор записи. Может быть сгенерирован с помощью [uuidgen](https://uuidgen.org/).
  * `sku_id` — идентификатор SKU.
  * `quantity` — количество потребленных единиц. Должно быть целое число больше `0`. Например, `1`.
  * `timestamp` — временная метка в формате [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601). Например, `2024-09-16T19:01:10.591128Z`.

{% endlist %}

Результат:

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

Если метрика не была принята, отобразится список отклоненных записей. Например:

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

Где:

* `uuid` — уникальный идентификатор записи.
* `reason` — причина отклонения метрики. Возможные значения:

    * `DUPLICATE` — дубликат записи. Запись с таким идентификатором уже существует.
    * `EXPIRED` — просроченная запись. Нельзя отправлять метрики за потребление, которое произошло более часа назад.
    * `INVALID_TIMESTAMP` — неверная временная метка. Нельзя указывать будущее время.
    * `INVALID_SKU_ID` — неверный идентификатор SKU. SKU не найден.
    * `INVALID_PRODUCT_ID` — неверный идентификатор продукта. Продукт не найден.
    * `INVALID_QUANTITY` — неверное количество. Количество должно быть больше `0`.
    * `INVALID_ID` — неверный идентификатор записи. Идентификатор не является UUID.

Успешная проверка не гарантирует, что после реального запроса метрика будет принята. Например, если сервисный аккаунт потеряет права на отправку метрик, API вернет ошибку `403` и сообщение `Forbidden`. Это может произойти, если пользователь отозвал права доступа, либо платежный аккаунт перешел в [статус](../../billing/concepts/billing-account-statuses.md), в котором потребление невозможно. Чтобы избежать таких ошибок, делите работу на подзадачи и отправляйте метрики после каждой из них. Например, если приложение отправляет письма, то отправляйте метрику после каждого письма.

Вы можете группировать метрики в один запрос по разным SKU или за некоторое время. Это сократит количество запросов. Например, если приложение отправляет запросы с большим RPS, то отправляйте метрику раз в минуту с указанием количества успешных запросов в параметре `quantity`.