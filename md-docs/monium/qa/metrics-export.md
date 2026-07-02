[Документация Yandex Cloud](../../index.md) > [Monium](../index.md) > Вопросы и ответы > Сбор и экспорт метрик

# Сбор и экспорт метрик

#### Как добавить метрику RAM на виртуальной машине? {#add-metrics-ram}

Сервис Yandex Compute Cloud не может измерить потребление vRAM внутри гостевой операционной системы: для сервиса потребление памяти ВМ всегда одинаковое — то, которое выделено в момент ее запуска.

Вы можете самостоятельно настроить сбор пользовательских метрик [через API](../../monitoring/operations/metric/add.md), а для Linux-совместимых ОС — с помощью [агента для поставки системных метрик](../../monitoring/operations/unified-agent/linux_metrics.md). Агент позволяет собирать статистику использования большинства системных ресурсов: процессор, память, сеть, диск.

#### Как добавить метрику места на диске виртуальной машины? {#add-metrics-space}

Monium Metrics не имеет доступа к гостевым ОС, поэтому такой метрики нет.

Вы можете самостоятельно настроить сбор пользовательских метрик [Запись пользовательских метрик через API](../../monitoring/operations/metric/add.md), а для Linux-совместимых ОС — с помощью [агента для поставки системных метрик](../../monitoring/operations/unified-agent/linux_metrics.md). Агент позволяет собирать статистику использования большинства системных ресурсов: процессор, память, сеть, диск.

#### Как собирать свои метрики из приложения? {#collect-1st-party}

[Unified Agent](../../monitoring/operations/unified-agent/pull_prometheus.md) поддерживает сбор метрик в формате Prometheus и конвертацию метрик в формат Monium Metrics. Таким образом, при помощи Unified Agent можно собирать метрики любых приложений, предоставляющих метрики в формате Prometheus.

Воспользуйтесь [клиентской библиотекой](https://prometheus.io/docs/instrumenting/clientlibs/) для языка программирования, на котором написано ваше приложение, и передавайте метрики в Monium Metrics в формате Prometheus.

{% list tabs group=programming_language %}

- Go {#go}

  [Клиентская библиотека Prometheus для Go](https://github.com/prometheus/client_golang).

- Python {#python}

  [Клиентская библиотека Prometheus для Python](https://github.com/prometheus/client_python).

- PHP {#php}

  [Клиентская библиотека Prometheus для PHP](https://github.com/promphp/prometheus_client_php).

- Java {#java}

  [Клиентская библиотека Prometheus для Java](https://github.com/prometheus/client_java).

- Node.js {#node}

  [Клиентская библиотека Prometheus для Node.js](https://github.com/siimon/prom-client).

- C++ {#cpp}

  [Клиентская библиотека Prometheus для C++](https://github.com/jupp0r/prometheus-cpp).

{% endlist %}

Примеры приведены в следующих разделах документации:
* [Поставка метрик пользовательских приложений](../../monitoring/operations/unified-agent/pull_prometheus.md).
* [Поставка метрик HAProxy и других сторонних приложений](../../monitoring/operations/unified-agent/haproxy.md).

#### Можно ли поставлять в Monium Metrics метрики кластера Yandex Managed Service for Kubernetes? {#collect-k8s}

Да, для этого используйте приложение [Metrics Provider](https://yandex.cloud/ru/marketplace/products/yc/metric-provider). Чтобы установить его, [воспользуйтесь инструкцией](../../managed-kubernetes/operations/applications/metrics-provider.md).

#### Как поставлять в Monium Metrics метрики сторонних приложений? {#collect-3rd-party}

Для поставки в Monium Metrics метрик сторонних приложений используется Unified Agent, в котором сконфигурирован вход `metrics_pull`. Unified Agent периодически опрашивает напрямую стороннее приложение, если оно поддерживает метрики в формате Prometheus, или специальное приложение-экспортер, реализующее интеграцию с Prometheus.

В разделе [Поставка метрик HAProxy и других сторонних приложений](../../monitoring/operations/unified-agent/haproxy.md) приведен пример настройки поставки метрик HAProxy.

#### Как поставлять метрики с хостов вне Yandex Cloud? {#collect-external}

Настройте [авторизованные ключи сервисных аккаунтов](../../monitoring/operations/unified-agent/non-yc.md) для передачи метрик в Monium Metrics через Unified Agent.

Используйте эту методику и для отправки метрик с ВМ Yandex Cloud без привязанного сервисного аккаунта.

#### Как посмотреть список метрик? {#metrics-list}

Для этого откройте раздел **Метрики** и выберите нужный сервис.

Чтобы получить полный список метрик, принадлежащих определенному облаку и каталогу, воспользуйтесь [инструкцией по запросу к API](../../monitoring/operations/metric/list.md).

#### Можно ли экспортировать метрики в формате Prometheus? {#export-prometheus}

Для экспорта метрик в формате Prometheus воспользуйтесь методом [prometheusMetrics](../../monitoring/api-ref/MetricsData/prometheusMetrics.md).

Пример настройки экспорта описан в [документации](../../monitoring/operations/metric/prometheusExport.md).