[Документация Yandex Cloud](../../index.md) > [Yandex Monitoring](../index.md) > Концепции > Обзор сервиса

# Обзор Monitoring

Сервис Monitoring позволяет собирать и хранить метрики, а также отображать их в виде графиков на дашбордах.

Monitoring автоматически собирает данные о состоянии ваших ресурсов в Yandex Cloud и отображает их на сервисных дашбордах. Для загрузки пользовательских метрик доступен API.

С помощью Monitoring вы можете:
* Отслеживать состояние ваших сервисов в Yandex Cloud на сервисных дашбордах. Это позволяет контролировать текущую нагрузку на ресурсы и планировать увеличение [квот](https://console.yandex.cloud/cloud?section=quotas).
* Загружать собственные метрики, используя API. Вы можете собрать на одном дашборде метрики вашего приложения и метрики используемых им ресурсов Yandex Cloud.
* Выгружать метрики ваших ресурсов и пользовательские метрики с помощью API.
* Создавать собственные дашборды и графики, чтобы визуализировать метрики наиболее удобным для вас способом.
* Настраивать уведомления (алерты) об изменении метрик. Уведомления можно направлять получателям по различным каналам связи.
* Для критичных изменений метрик можно настраивать последовательность уведомлений — политику эскалаций.

## Принцип работы {#how-it-works}

Monitoring собирает и хранит метрики в виде [временных рядов](https://ru.wikipedia.org/wiki/Временной_ряд). Для идентификации и описания характеристик временных рядов используются метки. Они указывают на принадлежность метрики сервису, описывают смысловое значение метрик и т. д. Подробнее в разделе [Модель данных в Monitoring](data-model.md).

Monitoring отображает метрики на графиках. Множество связанных между собой графиков можно собрать на дашбордах. Подробнее в разделе [Визуализация](visualization/index.md).

## Поставка метрик кластера Yandex Managed Service for Kubernetes {#metrics-provider}

Monitoring позволяет выгружать метрики объектов [кластера Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). Провайдер преобразует запрос на получение внешних метрик от объекта в кластере Managed Service for Kubernetes в нужный Monitoring формат, а также выполняет обратное преобразование — от Monitoring до объекта кластера.

Метрики кластеров можно получить с помощью следующих инструментов:

* [консоль управления](https://console.yandex.cloud);
* [интерфейс Monitoring](https://monitoring.yandex.cloud);
* [API Monitoring](../api-ref/authentication.md);
* приложение [Metrics Provider](https://yandex.cloud/ru/marketplace/products/yc/metric-provider);
* приложение [Prometheus Operator](https://yandex.cloud/ru/marketplace/products/yc/prometheus-operator).

Подробнее читайте в разделе [Мониторинг состояния кластера Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-get-stats.md).

Описание метрик приводится в [Справочнике](../metrics-ref/index.md#managed-kubernetes).