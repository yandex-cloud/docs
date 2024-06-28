# Интеграции

В данном разделе приведена основная информация про интеграции {{ yq-full-name }} с различными сервисами {{ yandex-cloud }} и сторонними системами.

## Источники данных {#data_sources}

{{ yq-full-name }} поддерживает работу с аналитическими и потоковыми источниками данных.

### Аналитические источники {#analytics_data_sources}

| Источник данных | Чтение  | Запись | Описание |
| --- | :---: | :---: | --- |
| [{{ objstorage-name }}](../storage/quickstart.md) | ![yes](../_assets/common/yes.svg) | ![yes](../_assets/common/yes.svg) | [Описание](./sources-and-sinks/object-storage-binding.md) |
| [{{ mpg-full-name }}](../managed-postgresql/quickstart.md) | ![yes](../_assets/common/yes.svg) | ![no](../_assets/common/no.svg)  | [Описание](./sources-and-sinks/postgresql.md) |
| [{{ mch-full-name }}](../managed-clickhouse/quickstart.md) | ![yes](../_assets/common/yes.svg) | ![no](../_assets/common/no.svg)  | [Описание](./sources-and-sinks/clickhouse.md) |
| [{{ ydb-full-name }}](../ydb/quickstart.md) | ![yes](../_assets/common/yes.svg) | ![no](../_assets/common/no.svg)  | [Описание](./sources-and-sinks/ydb.md) |


### Потоковые источники {#streaming_data_sources}

| Источник данных | Чтение  | Запись | Описание |
| --- | :---: | :---: | --- |
| [{{ yds-full-name }}](../data-streams/quickstart/index.md) | ![yes](../_assets/common/yes.svg) | ![yes](../_assets/common/yes.svg) | [Описание](./sources-and-sinks/data-streams-binding.md) |
| [{{ monitoring-name }}](../monitoring/quickstart.md) | ![no](../_assets/common/no.svg) |  ![yes](../_assets/common/yes.svg) | [Описание](./sources-and-sinks/monitoring.md) |
| [{{ cloud-logging-full-name }}](../logging/quickstart.md) | Через [{{ yds-full-name }}](../data-streams/quickstart/index.md) |  ![no](../_assets/common/no.svg) | [Описание](./tutorials/cloud-logging.md)|
| [{{ iot-full-name }}](../iot-core/quickstart.md) | Через [{{ yds-full-name }}](../data-streams/quickstart/index.md) |  ![no](../_assets/common/no.svg) |  |
| [{{ at-full-name }}](../audit-trails/quickstart.md) | Через [{{ yds-full-name }}](../data-streams/quickstart/index.md) |  ![no](../_assets/common/no.svg) | [Описание](./tutorials/audit-trails.md) |


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

* {{ yq-full-name }} на данный момент поддерживает только **scripting-запросы**.
* Все поддерживаемые SDK используют общий подход к работе с {{ yq-full-name }} и работают одинаково. Наиболее наглядным будет [пример](./SDK/SDK.md) работы с Python SDK.

{% endnote %}


## GUI Clients {#gui}

|  Среда | Уровень поддержки  | Инструкция | Описание |
| --- | :---: | --- | --- |
| Yandex Query UI |  Полный |  | |
| [DBeaver](https://dbeaver.com)  |  [DML](#note) | [Инструкция](./operations/ide.md) | C помощью [JDBC-драйвера](https://github.com/ydb-platform/ydb-jdbc-driver/releases)|
| JetBrains Database viewer |  [DML](#note) | [Инструкция](./operations/ide.md)  | C помощью [JDBC-драйвера](https://github.com/ydb-platform/ydb-jdbc-driver/releases)|
| [DataGrip](https://www.jetbrains.com/ru-ru/datagrip/) |  [DML](#note) |  [Инструкция](./operations/ide.md) | C помощью [JDBC-драйвера](https://github.com/ydb-platform/ydb-jdbc-driver/releases)|
| Другие JDBC-совместимые клиенты |  [DML](#note) |  [Инструкция](./operations/ide.md) | C помощью [JDBC-драйвера](https://github.com/ydb-platform/ydb-jdbc-driver/releases)|

## Интерактивный анализ данных {#analytics}

|  Среда | Уровень поддержки  | Инструкция | Описание |
| --- | :---: | :---: | --- |
| Jupyter Notebooks |  [DML](#note) |  [Инструкция](./tutorials/jupyter.md) | C помощью [yandex-query-magics](https://github.com/yandex-cloud/yandex-query-magics)|
| [{{ ml-platform-short-name }}](../datasphere/quickstart.md) |  [DML](#note) |  [Инструкция](./tutorials/jupyter.md) | C помощью [yandex-query-magics](https://github.com/yandex-cloud/yandex-query-magics)|


## Визуализация данных {#bi}

| Среда | Уровень поддержки  | Инструкция |
| --- | :---: | --- |
| [{{ datalens-name }}](../datalens/tutorials/index.md) | Полный | [Инструкция](./tutorials/datalens.md) |


## Оркестрация {#scheduling}

| Среда | Уровень поддержки  | Инструкция |
| --- | :---: | --- |
| [{{ AF }}](../managed-airflow/quickstart.md) | [DML](#note) | [Инструкция](./tutorials/airflow.md) |
| [{{ maf-full-name }}](../managed-airflow/quickstart.md) | [DML](#note) | [Инструкция](./tutorials/airflow.md) |

## Примечание {#note}

* [DML](https://ru.wikipedia.org/wiki/Data_Manipulation_Language) — Data Manipulation Language. Позволяет считывать и записывать данные, но не позволяет управлять сущностями [привязок](./concepts/glossary.md#binding) и [соединений](./concepts/glossary.md#connection).
