# Чтение и визуализация метрик при помощи Grafana

{% include [note-preview](../../../../_includes/monitoring/prometheus-preview.md) %}

{{ managed-prometheus-name }} поддерживает [{{ prometheus-name }} data source](https://grafana.com/docs/grafana/latest/datasources/prometheus/) и позволяет работать с дашбордами, которые созданы вами или сообществом, в {{ grafana-name }}.

## Подключить data source {#data-source}

1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хранятся данные.
1. [Создайте сервисный аккаунт](../../../../iam/operations/sa/create.md) с ролью `{{ roles-monitoring-viewer }}` на выбранный каталог.
1. [Создайте API-ключ](../../../../iam/operations/api-key/create.md) для сервисного аккаунта.
1. Откройте главную страницу вашей инсталляции {{ grafana-name }}.
1. В главном меню выберите **Configuration → Data Sources**.
1. Нажмите кнопку **Add data source**.
1. В разделе **Time series databases** выберите **Prometheus**.
1. В поле **Name** введите имя источника данных. 
1. В поле **URL**, в разделе **HTTP**, введите [эндпоинт, который получили ранее](../index.md#access).
1. В разделе **Custom HTTP headers** нажмите кнопку **Add Header** и добавьте заголовок для авторизации. В поле **Header** введите `Authorization`, в поле **Value** — `Bearer <Api-Key>`.
1. Нажмите кнопку **Save & test**. На экране должно появиться сообщение `The data source is working`.

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
* Максимальное количество временных рядов, по которым можно получить метаданные при помощи запроса `/api/v1/series`, — 10000.
* Максимально число временных рядов, которые можно прочитать в рамках одного запроса `/api/v1/query` или `/api/v1/query_range`, — 10000.
* Параметр `--query.lookback-delta` равен `5m`.

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}
