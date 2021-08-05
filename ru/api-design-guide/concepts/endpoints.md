---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Эндпоинты API сервисов {{ yandex-cloud }}

У каждого из сервисов {{ yandex-cloud }} есть эндпоинт, к которому следует отправлять HTTP-запросы. Полный список эндпоинтов можно запросить с помощью вызова [endpoints](https://api.cloud.yandex.net/endpoints) к URL `https://api.cloud.yandex.net`.

## Пример {#example}

```
$ curl https://api.cloud.yandex.net/endpoints
{
 "endpoints": [
  {
   "id": "operation",
   "address": "operation.api.cloud.yandex.net:443"
  },
  {
   "id": "compute",
   "address": "compute.api.cloud.yandex.net:443"
  },
  {
   "id": "iam",
   "address": "iam.api.cloud.yandex.net:443"
  },
  {
   "id": "resourcemanager",
   "address": "resource-manager.api.cloud.yandex.net:443"
  },
  {
   "id": "resource-manager",
   "address": "resource-manager.api.cloud.yandex.net:443"
  },
  {
   "id": "mdb-clickhouse",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "managed-clickhouse",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "mdb-mongodb",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "managed-mongodb",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "mdb-postgresql",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "managed-postgresql",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "mdb-redis",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "managed-redis",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "mdb-mysql",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "managed-mysql",
   "address": "mdb.api.cloud.yandex.net:443"
  },
  {
   "id": "dataproc",
   "address": "dataproc.api.cloud.yandex.net:443"
  },
  {
   "id": "vpc",
   "address": "vpc.api.cloud.yandex.net:443"
  },
  {
   "id": "container-registry",
   "address": "container-registry.api.cloud.yandex.net:443"
  },
  {
   "id": "load-balancer",
   "address": "load-balancer.api.cloud.yandex.net:443"
  },
  {
   "id": "serverless-functions",
   "address": "serverless-functions.api.cloud.yandex.net:443"
  },
  {
   "id": "k8s",
   "address": "mks.api.cloud.yandex.net:443"
  },
  {
   "id": "managed-kubernetes",
   "address": "mks.api.cloud.yandex.net:443"
  },
  {
   "id": "logs",
   "address": "logs.api.cloud.yandex.net:443"
  },
  {
   "id": "ydb",
   "address": "ydb.api.cloud.yandex.net:443"
  },
  {
   "id": "iot-devices",
   "address": "iot-devices.api.cloud.yandex.net:443"
  },
  {
   "id": "dataproc-manager",
   "address": "dataproc-manager.api.cloud.yandex.net:443"
  },
  {
   "id": "endpoint",
   "address": "api.cloud.yandex.net:443"
  },
  {
   "id": "storage",
   "address": "storage.yandexcloud.net:443"
  },
  {
   "id": "serialssh",
   "address": "serialssh.cloud.yandex.net:9600"
  },
  {
   "id": "ai-translate",
   "address": "translate.api.cloud.yandex.net:443"
  },
  {
   "id": "ai-vision",
   "address": "vision.api.cloud.yandex.net:443"
  },
  {
   "id": "locator",
   "address": "locator.api.cloud.yandex.net:443"
  },
  {
   "id": "ai-stt",
   "address": "transcribe.api.cloud.yandex.net:443"
  },
  {
   "id": "ai-speechkit",
   "address": "transcribe.api.cloud.yandex.net:443"
  }
 ]
}
```