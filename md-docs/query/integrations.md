[Документация Yandex Cloud](../index.md) > [Yandex Query](index.md) > Интеграции

# Интеграции

В данном разделе приведена основная информация про интеграции Yandex Query с различными сервисами Yandex Cloud и сторонними системами.

## Источники данных {#data_sources}

Yandex Query поддерживает работу с аналитическими и потоковыми источниками данных.

### Аналитические источники {#analytics_data_sources}

| Источник данных | Чтение  | Запись | Описание |
| --- | :---: | :---: | --- |
| [Object Storage](../storage/quickstart.md) | ![yes](../_assets/common/yes.svg) | ![yes](../_assets/common/yes.svg) | [Описание](sources-and-sinks/object-storage-binding.md) |
| [Yandex Managed Service for ClickHouse®](../managed-clickhouse/quickstart.md) | ![yes](../_assets/common/yes.svg) | ![no](../_assets/common/no.svg)  | [Описание](sources-and-sinks/clickhouse.md) |
| [Yandex MPP Analytics for PostgreSQL](../managed-greenplum/quickstart.md) | ![yes](../_assets/common/yes.svg) | ![no](../_assets/common/no.svg)  | [Описание](sources-and-sinks/greenplum.md) |
| [Yandex Managed Service for MySQL®](../managed-mysql/quickstart.md) | ![yes](../_assets/common/yes.svg) | ![no](../_assets/common/no.svg)  | [Описание](sources-and-sinks/mysql.md) |
| [Yandex Managed Service for PostgreSQL](../managed-postgresql/quickstart.md) | ![yes](../_assets/common/yes.svg) | ![no](../_assets/common/no.svg)  | [Описание](sources-and-sinks/postgresql.md) |
| [Yandex Managed Service for YDB](../ydb/quickstart.md) | ![yes](../_assets/common/yes.svg) | ![no](../_assets/common/no.svg)  | [Описание](sources-and-sinks/ydb.md) |


### Потоковые источники {#streaming_data_sources}

| Источник данных | Чтение  | Запись | Описание |
| --- | :---: | :---: | --- |
| [Yandex Data Streams](../data-streams/quickstart/index.md) | ![yes](../_assets/common/yes.svg) | ![yes](../_assets/common/yes.svg) | [Описание](sources-and-sinks/data-streams-binding.md) |
| [Monitoring](../monitoring/quickstart.md) | ![no](../_assets/common/no.svg) |  ![yes](../_assets/common/yes.svg) | [Описание](sources-and-sinks/monitoring.md) |
| [Yandex Cloud Logging](../logging/quickstart.md) | Через [Yandex Data Streams](../data-streams/quickstart/index.md) |  ![no](../_assets/common/no.svg) | [Описание](tutorials/cloud-logging.md)|
| [Yandex IoT Core](../iot-core/quickstart.md) | Через [Yandex Data Streams](../data-streams/quickstart/index.md) |  ![no](../_assets/common/no.svg) |  |
| [Yandex Audit Trails](../audit-trails/quickstart.md) | Через [Yandex Data Streams](../data-streams/quickstart/index.md) |  ![no](../_assets/common/no.svg) | [Описание](tutorials/audit-trails.md) |


## SDK {#sdk}

|  Библиотеки  | Язык программирования  | Уровень поддержки  | Репозиторий |
| --- | :---: | :---: |--- |
| database/sql | Go | [DML](#note) | [Репозиторий](https://github.com/ydb-platform/ydb-go-sdk/blob/master/SQL.md) |
| ydb-go-sdk | Go | [DML](#note) |[Репозиторий](https://github.com/ydb-platform/ydb-go-sdk) |
| JDBC | Java | [DML](#note) |[Репозиторий](https://github.com/ydb-platform/ydb-jdbc-driver) |
| ydb-java-sdk | Java | [DML](#note) |[Репозиторий](https://github.com/ydb-platform/ydb-java-sdk) |
| ydb-python-sdk | Python | [DML](#note) |[Репозиторий](https://github.com/ydb-platform/ydb-python-sdk) |
| ydb-php-sdk | PHP | [DML](#note) |[Репозиторий](https://github.com/ydb-platform/ydb-php-sdk) |
| ydb-cpp-sdk | C++ | [DML](#note) |[Репозиторий](https://github.com/ydb-platform/ydb-cpp-sdk) |
| ydb-dotnet-sdk | .Net |[DML](#note) | [Репозиторий](https://github.com/ydb-platform/ydb-dotnet-sdk) |
| ydb-rs-sdk | Rust | [DML](#note) |[Репозиторий](https://github.com/ydb-platform/ydb-rs-sdk) |

{% note info %}

* Yandex Query на данный момент поддерживает только **scripting-запросы**.
* Все поддерживаемые SDK используют общий подход к работе с Yandex Query и работают одинаково. Наиболее наглядным будет [пример](SDK/SDK.md) работы с Python SDK.

{% endnote %}


## GUI Clients {#gui}

|  Среда | Уровень поддержки  | Инструкция | Описание |
| --- | :---: | --- | --- |
| Yandex Query UI |  Полный |  | |
| [DBeaver](https://dbeaver.com)  |  [DML](#note) | [Инструкция](operations/ide.md) | C помощью [JDBC-драйвера](https://github.com/ydb-platform/ydb-jdbc-driver/releases)|
| JetBrains Database viewer |  [DML](#note) | [Инструкция](operations/ide.md)  | C помощью [JDBC-драйвера](https://github.com/ydb-platform/ydb-jdbc-driver/releases)|
| [DataGrip](https://www.jetbrains.com/ru-ru/datagrip/) |  [DML](#note) |  [Инструкция](operations/ide.md) | C помощью [JDBC-драйвера](https://github.com/ydb-platform/ydb-jdbc-driver/releases)|
| Другие JDBC-совместимые клиенты |  [DML](#note) |  [Инструкция](operations/ide.md) | C помощью [JDBC-драйвера](https://github.com/ydb-platform/ydb-jdbc-driver/releases)|

## Интерактивный анализ данных {#analytics}

|  Среда | Уровень поддержки  | Инструкция | Описание |
| --- | :---: | :---: | --- |
| Jupyter Notebooks |  [DML](#note) |  [Инструкция](tutorials/jupyter.md) | C помощью [yandex-query-magics](https://github.com/yandex-cloud/yandex-query-magics)|
| [DataSphere](../datasphere/quickstart.md) |  [DML](#note) |  [Инструкция](tutorials/jupyter.md) | C помощью [yandex-query-magics](https://github.com/yandex-cloud/yandex-query-magics)|


## Визуализация данных {#bi}

| Среда | Уровень поддержки  | Инструкция |
| --- | :---: | --- |
| [DataLens](../datalens/tutorials/index.md) | Полный | [Инструкция](tutorials/datalens.md) |


## Оркестрация {#scheduling}

| Среда | Уровень поддержки  | Инструкция |
| --- | :---: | --- |
| [Apache Airflow™](../managed-airflow/quickstart.md) | [DML](#note) | [Инструкция](tutorials/airflow-auto-tasks.md) |
| [Yandex Managed Service for Apache Airflow™](../managed-airflow/quickstart.md) | [DML](#note) | [Инструкция](tutorials/airflow-auto-tasks.md) |

## Примечание {#note}

* [DML](https://ru.wikipedia.org/wiki/Data_Manipulation_Language) — Data Manipulation Language. Позволяет считывать и записывать данные, но не позволяет управлять сущностями [привязок](concepts/glossary.md#binding) и [соединений](concepts/glossary.md#connection).