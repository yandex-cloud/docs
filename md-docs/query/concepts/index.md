[Документация Yandex Cloud](../../index.md) > [Yandex Query](../index.md) > Концепции > Обзор

# Обзор Yandex Query

Yandex Query – это сервис обработки данных, способный выполнять федеративные запросы к объектному хранилищу [Yandex Object Storage](../../storage/concepts/index.md), управляемым базам данных [Managed Service for ClickHouse®](https://yandex.cloud/ru/services/managed-clickhouse), [Yandex MPP Analytics for PostgreSQL](https://yandex.cloud/ru/services/managed-greenplum), [Managed Service for MySQL®](https://yandex.cloud/ru/services/managed-mysql), [Managed Service for PostgreSQL](https://yandex.cloud/ru/services/managed-postgresql) и [Managed Service for YDB](https://yandex.cloud/ru/services/ydb), а также потокам данных реального времени [Yandex Data Streams](../../data-streams/concepts/index.md). С помощью YQL, единого диалекта SQL, Yandex Query позволяет агрегировать результаты выполнения запросов [между этими системами](federated-processing.md).

Yandex Query является полностью управляемым облачным решением, это означает, что нет необходимости иметь запущенные сервера, на которых развернуто ПО. Все необходимые ресурсы для исполнения запросов выделяются в момент их запуска и освобождаются после завершения, а сами запросы начинают исполняться немедленно.

Yandex Query позволяет:

* Использовать один и тот же разработанный запрос для сценариев [аналитики данных](../../glossary/data-analytics.md), хранимых в Yandex Object Storage, и аналитики данных реального времени.
* Агрегировать результаты исполнения запросов между различными системами.
* Уменьшить расходы на разработку за счет общего языка – YQL и общих подходов.

Yandex Query объединяет возможности [виртуализации](../../glossary/virtualization.md) данных и систему потоковой аналитики реального времени. Такая архитектура системы называется [Unified Lambda](unified-processing.md).

![](../../_assets/query/unified-delta.png)

В модели Unified Lambda используется единый текст SQL-запроса для обработки потоковых данных и данных, хранимых в различных классах систем хранения.


## Поддержка хранилищ «сырых» данных

Большие объемы данных с редким доступом компании предпочитают хранить в объектных хранилищах класса Yandex Object Storage. Долгосрочное хранение данных с редкой обработкой в таких хранилищах является наиболее экономически выгодными. При этом данные в Yandex Object Storage хранятся в неструктурированном виде и эти данные необходимо обрабатывать простым и удобным для аналитиков способом.

## Потоковая обработка данных

Потоковая обработка основана на группирующих оконных функциях, которые получают потоки данных, группируют их по источникам и временным окнам, после чего выполняют расчеты, а результаты исполнения отправляют во внешние системы. Особенностью Yandex Query является единый текст SQL-запроса, который используется как для потоковой, так и для аналитической обработки.

## Интеграция с внешними системами

### Потоковая обработка

Потоковые запросы могут получать данные из следующих источников:

* Yandex Data Streams. Данными могут являться, например, логи работы приложений, поток изменений от базы данных [Debezium](../tutorials/debezium.md) или любая другая информация.

Результаты потоковой обработки экспортируются в:

* В Monitoring в виде метрик для построения графиков, дашбордов или алертинга.
* В Yandex Data Streams. С помощью Yandex Data Transfer данные из Yandex Data Streams могут быть отправлены в различные системы, в том числе в различные СУБД.

### Аналитическая обработка {#analytic}

Аналитические запросы Yandex Query могут получать данные из Yandex Object Storage в [форматах JSON, CSV/TSV, Parquet, сжатых различными алгоритмами](../sources-and-sinks/formats.md). Также аналитические запросы можно исполнять над управляемыми базами данных [Managed Service for ClickHouse®](https://yandex.cloud/ru/services/managed-clickhouse), [Yandex MPP Analytics for PostgreSQL](https://yandex.cloud/ru/services/managed-greenplum), [Managed Service for MySQL®](https://yandex.cloud/ru/services/managed-mysql), [Managed Service for PostgreSQL](https://yandex.cloud/ru/services/managed-postgresql) и [Managed Service for YDB](https://yandex.cloud/ru/services/ydb).

С помощью Yandex Query можно выполнять межсервисную аналитику данных, объединяя в одном запросе обращения ко всем поддерживаемым источникам данных.

Результаты исполнения запросов доступны для скачивания из интерфейса пользователя Yandex Query, но при необходимости результаты исполнения запросов можно в свою очередь сохранить в Yandex Object Storage.

### Yandex DataLens
С помощью Yandex Query можно выполнять визуализацию данных, хранящихся в Yandex Object Storage.

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._