# Сбор и экспорт метрик

#### Как добавить метрику RAM на виртуальной машине? {#add-metrics-ram}

Сервис {{ compute-full-name }} не может измерить потребление vRAM внутри гостевой операционной системы: для сервиса потребление памяти ВМ всегда одинаковое — то, которое выделено в момент ее запуска.

Вы можете самостоятельно настроить сбор пользовательских метрик [через API](../../monitoring/operations/metric/add.md), а для Linux-совместимых ОС — с помощью [агента для поставки системных метрик](../../monitoring/operations/unified-agent/linux_metrics.md). Агент позволяет собирать статистику использования большинства системных ресурсов: процессор, память, сеть, диск.

#### Как добавить метрику места на диске виртуальной машины? {#add-metrics-space}

{{ monitoring-name }} не имеет доступа к гостевым ОС, поэтому такой метрики нет.

Вы можете самостоятельно настроить сбор пользовательских метрик [](../../monitoring/operations/metric/add.md), а для Linux-совместимых ОС — с помощью [агента для поставки системных метрик](../../monitoring/operations/unified-agent/linux_metrics.md). Агент позволяет собирать статистику использования большинства системных ресурсов: процессор, память, сеть, диск.

#### Как собирать свои метрики из приложения? {#collect-1st-party}

[{{ unified-agent-full-name }}](../../monitoring/operations/unified-agent/pull_prometheus.md) поддерживает сбор метрик в формате {{ prometheus-name }} и конвертацию метрик в формат {{ monitoring-name }}. Таким образом, при помощи {{ unified-agent-short-name }} можно собирать метрики любых приложений, предоставляющих метрики в формате {{ prometheus-name }}.

Воспользуйтесь [клиентской библиотекой](https://prometheus.io/docs/instrumenting/clientlibs/) для языка программирования, на котором написано ваше приложение, и передавайте метрики в {{ monitoring-name }} в формате {{ prometheus-name }}.

{% list tabs %}

- Go

  [Клиентская библиотека Prometheus для Go](https://github.com/prometheus/client_golang).

- Python

  [Клиентская библиотека Prometheus для Python](https://github.com/prometheus/client_python).

- PHP

  [Клиентская библиотека Prometheus для PHP](https://github.com/promphp/prometheus_client_php).

- Java

  [Клиентская библиотека Prometheus для Java](https://github.com/prometheus/client_java).

- Node.js

  [Клиентская библиотека Prometheus для Node.js](https://github.com/siimon/prom-client).

- C++

  [Клиентская библиотека Prometheus для C++](https://github.com/jupp0r/prometheus-cpp).

{% endlist %}

Примеры приведены в следующих разделах документации:
* [{#T}](../../monitoring/operations/unified-agent/pull_prometheus.md).
* [{#T}](../../monitoring/operations/unified-agent/haproxy.md).


#### Можно ли поставлять в {{ monitoring-name }} метрики кластера {{ managed-k8s-full-name }}? {#collect-k8s}

Да, для этого используйте приложение [Metrics Provider](/marketplace/products/yc/metric-provider). Чтобы установить его, [воспользуйтесь инструкцией](../../managed-kubernetes/operations/applications/metrics-provider.md).


#### Как поставлять в {{ monitoring-name }} метрики сторонних приложений? {#collect-3rd-party}

Для поставки в {{ monitoring-name }} метрик сторонних приложений используется {{ unified-agent-short-name }}, в котором сконфигурирован вход `metrics_pull`. {{ unified-agent-short-name }} периодически опрашивает напрямую стороннее приложение, если оно поддерживает метрики в формате {{ prometheus-name }}, или специальное приложение-экспортер, реализующее интеграцию с {{ prometheus-name }}.

В разделе [{#T}](../../monitoring/operations/unified-agent/haproxy.md) приведен пример настройки поставки метрик HAProxy.

#### Как поставлять метрики с хостов вне {{ yandex-cloud }}? {#collect-external}

Настройте [авторизованные ключи сервисных аккаунтов](../../monitoring/operations/unified-agent/non-yc.md) для передачи метрик в {{ monitoring-name }} через {{ unified-agent-short-name }}.

Используйте эту методику и для отправки метрик с ВМ {{ yandex-cloud }} без привязанного сервисного аккаунта.

#### Как посмотреть список метрик? {#metrics-list}

Для этого откройте раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}** и выберите нужный сервис.

Чтобы получить полный список метрик, принадлежащих определенному облаку и каталогу, воспользуйтесь [инструкцией по запросу к API](../../monitoring/operations/metric/list.md).

#### Можно ли экспортировать метрики в формате {{ prometheus-name }}? {#export-prometheus}

Для экспорта метрик в формате {{ prometheus-name }} воспользуйтесь методом [prometheusMetrics](../../monitoring/api-ref/MetricsData/prometheusMetrics.md).

Пример настройки экспорта описан в [документации](../../monitoring/operations/metric/prometheusExport.md).