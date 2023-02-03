# Solomon REST API

В данном разделе описан программный интерфейс (API) взаимодействия с Solomon.

Solomon API позволяет осуществлять чтение и запись данных (метрик), а также управлять объектами конфигурации (или ресурсами в терминах REST API): кластерами, сервисами, шардами, алертами, дашбордами.

Адреса для подключения к API для каждого кластера Solomon перечислены в разделе [{#T}](../overview/clusters.md).

Работа с API осуществляется в соответствии с принципами REST, посредством HTTP-запросов. Используемые методы:
- **GET** — для получения информации о ресурсе или получения содержимого ресурса;
- **POST** — для создания нового ресурса;
- **PUT** — для изменения уже существующего ресурса;
- **DELETE** — для удаление ресурса.

## Аутентификация {#auth}

Для доступа к API необходимо пройти аутентификацию. На данный момент поддерживается аутентификация по OAuth-токенам, IAM-токенам Яндекс.Облака и TVM-тикетам. Подробнее механизмы аутентификации описаны в разделе [{#T}](./authentication.md).

## Описание API {#resources}

В Таблице 1 перечислены типы ресурсов поддерживаемые в Solomon REST API. Полная спецификация ресурсов и методов по работе с ними приведена в [Swagger](https://solomon.yandex-team.ru/swagger-ui/index.html). Примеры использования API приведены в разделе [{#T}](#examples).

<small>Таблица 1 — Типы ресурсов поддерживаемые в Solomon REST API.</small>

Ресурс|Опсиание
------|--------
[alerting](https://solomon.yandex-team.ru/swagger-ui/index.html#/alerting)| Набор методов для управления [алертами](../concepts/glossary.md#alert) и [каналами уведомлений](../concepts/glossary.md#channel).
[clusters](https://solomon.yandex-team.ru/swagger-ui/index.html#/clusters)| Набор методов для управления [кластерами](../concepts/glossary.md#cluster).
[dashboards](https://solomon.yandex-team.ru/swagger-ui/index.html#/dashboards)| Набор методов для управления [дашбордами](../concepts/glossary.md#dashboard).
[data](https://solomon.yandex-team.ru/swagger-ui/index.html#/data) | Метод для выгрузки данных (метрик) из Solomon.
[graphs](https://solomon.yandex-team.ru/swagger-ui/index.html#/graphs) | Набор методов для управления [графиками](../concepts/glossary.md#grapg).
[projects](https://solomon.yandex-team.ru/swagger-ui/index.html#/projects)| Набор методов для управления [проектами](../concepts/glossary.md#project).
[menu](https://solomon.yandex-team.ru/swagger-ui/index.html#/project%20menus) | Набор методов для управления [меню проекта](../concepts/glossary.md#project-menu).
[metrics](https://solomon.yandex-team.ru/swagger-ui/index.html#/metrics)| Набор методов для получения мета-информации о [метриках](../concepts/data-model.md): списка существующих метрик, множестве ключей и значений меток.
[metrics deletion](https://solomon.yandex-team.ru/swagger-ui/index.html#/metrics%20deletion)| Набор методов для управления операциями [удаления метрик](../concepts/deletion/operation.md): запуск, отмена, получение списка существующих операций, статуса запущенных операций.
[push](https://solomon.yandex-team.ru/swagger-ui/index.html#/push)| Метод для записи метрик в Solomon в push-режиме передачи метрик.
[services](https://solomon.yandex-team.ru/swagger-ui/index.html#/services)| Набор методов для управления [сервисами](../concepts/glossary.md#service).
[shards](https://solomon.yandex-team.ru/swagger-ui/index.html#/shards) | Набор методов для управления [шардами](../concepts/glossary.md#shard).

## Обработка ошибок {#error}

При возникновении ошибки Solomon API вернет HTTP-ответ со статусом >= 400. В теле ответа будет содержаться более подробное описание ошибки в следующем формате:

```json
    {
    "code": <number>,       // код ошибки
    "message": <string>,    // человекочитаемое описание ошибки
    <other fields>          // опциональные поля, специфичные для конкретного типа ошибок
    }
```

Пример сообщения об ошибке:

```json
{
   "code" : 401,
   "message" : "cannot authenticate by OAuth token, cause: expired_token",
   "redirectTo" : ""
}
```

{% note info %}

На данный момент нет фиксированного списка кодов ошибок, поэтому поле `code` зарезервировано для использования в следующих версиях Solomon и повторяет [код ответа HTTP](https://httpstatuses.com).

{% endnote %}

{% note tip %}

Рекомендуется логировать сообщения об ошибках при получении ответа с кодом HTTP >= 500, чтобы при [сообщении о проблеме](../problems/howtoreport.md) команде Solomon было проще разобраться с проблемой.

{% endnote %}

### Конфликты при обновлении объектов {#conflicts}

Для разрешения конфликтов при модифицирующих операциях используются номера версий объектов: в **PUT**-запросах нужно обязательно передавать номер версии объекта в поле `version`. Этот номер нужно предварительно получить через **GET** запрос к ресурсу. Объект будет модифицирован, только если между запросами **GET** и **PUT** никто не изменил объект. В противном случае API вернет код [409 Conflict](https://httpstatuses.com/409) и запросы **GET**, **PUT** нужно будет повторить с правильной версией.

## Примеры использования REST API {#examples}

### Получение списка алертов {#get-alert}

Чтобы получить список алертов определенного проекта через Solomon REST API, выполните следующую команду при помощи утилиты cURL, указав вместо `<project>` идентификатор вашего проекта в Solomon:

```bash
curl \
    -H "Content-Type: application/json" \
    -H "Authorization: OAuth ${SOLOMON_TOKEN}" \
    "https://solomon-prestable.yandex.net/api/v2/projects/<project>/alerts/"
```

Пример ответа на запрос:

```json
{
   "items" : [
      {
         "evaluationStats" : {
            "ok" : 1
         },
         "id" : "alerting-cluster-membership",
         "multiAlert" : false,
         "name" : "Alerting: Cluster membership",
         "notificationStats" : {},
         "projectId" : "solomon",
         "state" : "ACTIVE",
         "type" : "EXPRESSION"
      },
      {
         "evaluationStats" : {
            "ok" : 8
         },
         "id" : "alerting-health",
         "multiAlert" : true,
         "name" : "Alerting: Health",
         "notificationStats" : {},
         "projectId" : "solomon",
         "state" : "ACTIVE",
         "type" : "THRESHOLD"
      }
   ],
   "nextPageToken" : "10"
}
```

### Создание алерта {#post-alert}

Чтобы создать алерт через Solomon REST API, выполните следующую команду при помощи утилиты cURL, указав вместо `<project>` идентификатор вашего проекта в Solomon:

```bash
curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: OAuth ${SOLOMON_TOKEN}" \
    -d "@data.json" \
    "https://solomon-prestable.yandex.net/api/v2/projects/<project>/alerts/"
```

Содержимое файла **data.json**:

```json
{
    "id": "test-alerting-cluster-membership",
    "projectId": "solomon",
    "name": "[TEST] Alerting: Cluster membership",
    "channels": [
      {
        "id": "solomon-notifications",
        "config": {}
      }
    ],
    "type": {
      "expression": {
        "program": "let now = {project='solomon', cluster='production', service='alerting', host='cluster', sensor='health.cluster.membership'};\n\nlet prev = shift({project='solomon', cluster='production', service='alerting', host='cluster', sensor='health.cluster.membership'}, 1d);\n\nalarm_if(max(prev) > last(now));",
        "checkExpression": ""
      }
    },
    "annotations": {
      "details": "See https://solomon.yandex-team.ru/?cluster=production&project=solomon&dashboard=alerting-projects-assignment-summary-dashboard&b=not_var{{fromTime}}&e=not_var{{toTime}}"
    },
    "windowSecs": 300,
    "delaySecs": 60,
    "description": "https://wiki.yandex-team.ru/solomon/dev/runbooks#alerting-cluster-membership\n\nНет описания, что делать, если алерт сработал? Спроси создавшего этот алерт и заполни runbook самостоятельно!"
  }
```

### Удаление алерта {#delete-alert}

Чтобы удалить алерт через Solomon REST API, выполните следующую команду при помощи утилиты cURL, указав вместо `<project>` идентификатор вашего проекта в Solomon, а вместо `<alert_id>` — идентификатор удаляемого алерта:

```bash
curl -X DELETE \
    -H "Content-Type: application/json" \
    -H "Authorization: OAuth ${SOLOMON_TOKEN}" \
    "https://solomon-prestable.yandex.net/api/v2/projects/<project>/alerts/<alert_id>"
```

