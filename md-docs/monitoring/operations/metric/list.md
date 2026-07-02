[Документация Yandex Cloud](../../../index.md) > [Yandex Monitoring](../../index.md) > [Пошаговые инструкции](../index.md) > Работа с метриками > Получение списка метрик

# Получение списка метрик

Чтобы получить список метрик, принадлежащих определенному облаку и каталогу, воспользуйтесь методом [listMetrics](../../api-ref/MetricsMeta/listMetrics.md).

### Перед началом работы {#before-you-begin}

Чтобы воспользоваться примерами в этом разделе:

1. Убедитесь, что у вас установлена утилита [cURL](https://curl.haxx.se), используемая в примерах.
1. [Получите идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), на который у вас есть роль `monitoring.viewer` или выше.
1. Получите IAM-токен:
   * [Инструкция](../../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.
   * [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
   * [Инструкция](../../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.
   * [Инструкция](../../../iam/operations/iam-token/create-for-local.md) для локального аккаунта.

### Пример запроса {#sample-request}

Отправьте запрос и сохраните ответ в файл, например `output.json`:

```bash
export IAM_TOKEN=CggaATEVAgA...
curl \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --get 'https://monitoring.api.cloud.yandex.net/monitoring/v2/metrics/?folderId=b1gucmd4tma1********&pageSize=200' \
  --data-urlencode 'selectors={service="managed-clickhouse", resource_id="c9q5e2a9i24p********"}' > output.json
```

Пример ответа на запрос, который получает список метрик сервиса Managed Service for ClickHouse® для ресурса:

**output.json:**
```json
{
   "metrics" : [
      {
         "labels" : {
            "dc" : "rc1c",
            "host" : "rc1c-dqd0h0i0********.mdb.yandexcloud.net",
            "node" : "replica",
            "resource_id" : "c9q5e2a9i24p********",
            "resource_type" : "cluster",
            "service" : "managed-clickhouse",
            "shard" : "c9qdstaf9lfg********"
         },
         "name" : "net.packets_sent",
         "type" : "DGAUGE"
      },
      {
         "labels" : {
            "dc" : "rc1c",
            "host" : "rc1c-dqd0h0i0********.mdb.yandexcloud.net",
            "node" : "replica",
            "resource_id" : "c9q5e2a9i24p********",
            "resource_type" : "cluster",
            "service" : "managed-clickhouse",
            "shard" : "c9qdstaf9lfg********"
         },
         "name" : "disk.free_inodes",
         "type" : "DGAUGE"
      }
    ]
}
```

Где:

* `resource_id` – идентификатор ресурса.
* `metrics` – список метрик.

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._