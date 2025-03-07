---
title: Как читать и визуализировать метрики при помощи Grafana
description: Следуя данной инструкции, вы сможете прочитать и визуализировать метрики при помощи Grafana.
---

# Чтение и визуализация метрик при помощи Grafana

{{ managed-prometheus-name }} поддерживает [{{ prometheus-name }} data source](https://grafana.com/docs/grafana/latest/datasources/prometheus/) и позволяет работать с дашбордами, которые созданы вами или сообществом, в {{ grafana-name }}.

## Подключить data source {#data-source}

1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хранятся данные.
1. [Создайте сервисный аккаунт](../../../../iam/operations/sa/create.md) с ролью `{{ roles-monitoring-viewer }}` на выбранный каталог.
1. [Создайте API-ключ](../../../../iam/operations/authentication/manage-api-keys.md#create-api-key) для сервисного аккаунта.
1. Откройте главную страницу вашей инсталляции {{ grafana-name }}.
1. В главном меню выберите **Configuration → Data Sources**.
1. Нажмите кнопку **Add data source**.
1. В разделе **Time series databases** выберите **Prometheus**.
1. В поле **Name** введите имя источника данных. 
1. В поле **URL**, в разделе **HTTP**, введите [эндпоинт, который получили ранее](../index.md#access).
1. В разделе **Custom HTTP headers** нажмите кнопку **Add Header** и добавьте заголовок для авторизации. В поле **Header** введите `Authorization`, в поле **Value** — `Bearer <API-ключ>`.
1. Нажмите кнопку **Save & test**. На экране должно появиться сообщение `The data source is working`.

## Примеры ошибок {#errors}

| Код ошибки | Описание | Текст ошибки |
|----|----|----|
| `404` | Эндпоинт не найден. Убедитесь, что в конфигурации указан правильный `url`. | ```not_found: workspace not found: monb1piptmdo********``` |
| `401` | Сервисный аккаунт не найден. Убедитесь, что в конфигурации указан правильный [API-ключ](../../../../iam/concepts/authorization/api-key.md). | ```auth: cannot authenticate by either token or api-key, cause: UNAUTHENTICATED: The token is invalid``` |
| `403` | Отсутствуют права на чтение. Убедитесь, что сервисный аккаунт имеет роль `{{ roles-monitoring-viewer }}` на выбранный каталог. | ```auth: PERMISSION_DENIED: Permission denied```|
| `429` | Превышена квота [Количество запросов в секунду на чтение через HTTP API](../index.md#limits). | ```execution: too many requests: monb1piptmdo********``` |
| `400` | Запрос вернул слишком много линий. Попробуйте уточнить запрос. | ```bad_data: Too many metrics are loaded by selectors {job=='grafana'}, expected not more than: 10000``` |

## Текущие ограничения {#restrictions}

В реализации {{ prometheus-name }} [HTTP API](https://prometheus.io/docs/prometheus/latest/querying/api/) поддерживаются только следующие эндпоинты:

* `/api/v1/query`
* `/api/v1/query_range`
* `/api/v1/labels`
* `/api/v1/<label_name>/values`
* `/api/v1/series`

При этом действуют следующие ограничения:
* Параметр `timeout` не поддерживается и игнорируется.
* Параметры `start` и `end` не поддерживаются и игнорируются для запросов `/api/v1/labels`, `/api/v1/<label_name>/values` и `/api/v1/series`.
* Максимальное число селекторов, которые можно передать в качестве параметра `match[]`, — 8.

{% include [maximum-time-lines](../../../../_includes/monitoring/maximum-time-lines.md) %}

* Параметр `--query.lookback-delta` равен `5m`.

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}
