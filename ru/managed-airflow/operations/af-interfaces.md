---
title: "Работа с интерфейсами {{ AF }}"
description: "Для работы с {{ AF }} можно использовать веб-интерфейс или {{ AF }} REST API"
keywords:
  - работа с интерфейсами {{ AF }}
  - {{ AF }}
  - Airflow
---

# Работа с интерфейсами {{ AF }}

Для работы с {{ maf-name }} можно использовать [веб-интерфейс](#web-gui) или [API {{ AF }}](#rest-api).

## Работа с веб-интерфейсом {#web-gui}

{% include [web interface](../../_includes/mdb/maf/web-interface.md) %}

## Работа с API {{ AF }} {#rest-api}

Запросы к [API {{ AF }}](https://airflow.apache.org/docs/apache-airflow/stable/stable-rest-api-ref.html) можно выполнять с виртуальных машин (ВМ), расположенных в облачной сети кластера {{ maf-name }}.

1. В облачной сети, в которой расположен кластер {{ maf-name }}, создайте ВМ на основе [Linux](../../compute/quickstart/quick-create-linux.md).
1. [Настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для подключения к ВМ.
1. Выполните запрос к API, например, с помощью cURL. В параметрах авторизации укажите имя пользователя и пароль.

Пример запроса:

```bash
curl -X GET \
    'http://c-<идентификатор кластера>.rw.mdb.yandexcloud.net/api/v1/dags' \
    --user 'admin:<пароль пользователя admin>' \
    --header 'Content-Type: application/json'
```

Запрос возвращает список DAG-файлов. Пример ответа см. в [документации API {{ AF }}](https://airflow.apache.org/docs/apache-airflow/stable/stable-rest-api-ref.html#operation/get_dags).
