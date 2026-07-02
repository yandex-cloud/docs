# Integrations

This section covers the basics of {{ yq-full-name }} integration with {{ yandex-cloud }} services and third-party systems.

## Data sources {#data_sources}

{{ yq-full-name }} supports both analytical and streaming data sources.

### Analytical sources {#analytics_data_sources}

| Data source | Read | Write | Description |
| --- | :---: | :---: | --- |
| [{{ objstorage-name }}](../storage/quickstart.md) | ![yes](../_assets/common/yes.svg) | ![yes](../_assets/common/yes.svg) | [Description](./sources-and-sinks/object-storage-binding.md) |
| [{{ mch-full-name }}](../managed-clickhouse/quickstart.md) | ![yes](../_assets/common/yes.svg) | ![no](../_assets/common/no.svg)  | [Description](./sources-and-sinks/clickhouse.md) |
| [{{ mgp-full-name }}](../managed-greenplum/quickstart.md) | ![yes](../_assets/common/yes.svg) | ![no](../_assets/common/no.svg)  | [Description](./sources-and-sinks/greenplum.md) |
| [{{ mmy-full-name }}](../managed-mysql/quickstart.md) | ![yes](../_assets/common/yes.svg) | ![no](../_assets/common/no.svg)  | [Description](./sources-and-sinks/mysql.md) |
| [{{ mpg-full-name }}](../managed-postgresql/quickstart.md) | ![yes](../_assets/common/yes.svg) | ![no](../_assets/common/no.svg)  | [Description](./sources-and-sinks/postgresql.md) |
| [{{ ydb-full-name }}](../ydb/quickstart.md) | ![yes](../_assets/common/yes.svg) | ![no](../_assets/common/no.svg)  | [Description](./sources-and-sinks/ydb.md) |


### Streaming sources {#streaming_data_sources}

| Data source | Read | Write | Description |
| --- | :---: | :---: | --- |
| [{{ yds-full-name }}](../data-streams/quickstart/index.md) | ![yes](../_assets/common/yes.svg) | ![yes](../_assets/common/yes.svg) | [Description](./sources-and-sinks/data-streams-binding.md) |
| [{{ monitoring-name }}](../monitoring/quickstart.md) | ![no](../_assets/common/no.svg) |  ![yes](../_assets/common/yes.svg) | [Description](./sources-and-sinks/monitoring.md) |
| [{{ cloud-logging-full-name }}](../logging/quickstart.md) | Via [{{ yds-full-name }}](../data-streams/quickstart/index.md) |  ![no](../_assets/common/no.svg) | [Description](./tutorials/cloud-logging.md)|
| [{{ iot-full-name }}](../iot-core/quickstart.md) | Via [{{ yds-full-name }}](../data-streams/quickstart/index.md) |  ![no](../_assets/common/no.svg) |  |
| [{{ at-full-name }}](../audit-trails/quickstart.md) | Via [{{ yds-full-name }}](../data-streams/quickstart/index.md) |  ![no](../_assets/common/no.svg) | [Description](./tutorials/audit-trails.md) |


## SDK {#sdk}

|  Libraries  | Programming language  | Support level  | Repository |
| --- | :---: | :---: |--- |
| database/sql | Go | [DML](#note) | [Repository](https://github.com/ydb-platform/ydb-go-sdk/blob/master/SQL.md) |
| ydb-go-sdk | Go | [DML](#note) |[Repository](https://github.com/ydb-platform/ydb-go-sdk) |
| JDBC | Java | [DML](#note) |[Repository](https://github.com/ydb-platform/ydb-jdbc-driver) |
| ydb-java-sdk | Java | [DML](#note) |[Repository](https://github.com/ydb-platform/ydb-java-sdk) |
| ydb-python-sdk | Python | [DML](#note) |[Repository](https://github.com/ydb-platform/ydb-python-sdk) |
| ydb-php-sdk | PHP | [DML](#note) |[Repository](https://github.com/ydb-platform/ydb-php-sdk) |
| ydb-cpp-sdk | C++ | [DML](#note) |[Repository](https://github.com/ydb-platform/ydb-cpp-sdk) |
| ydb-dotnet-sdk | .Net |[DML](#note) | [Repository](https://github.com/ydb-platform/ydb-dotnet-sdk) |
| ydb-rs-sdk | Rust | [DML](#note) |[Repository](https://github.com/ydb-platform/ydb-rs-sdk) |

{% note info %}

* {{ yq-full-name }} currently supports only **scripting requests**.
* All supported SDKs share a common approach to working with {{ yq-full-name }} and operate identically. This is best demonstrated by the following [example](./SDK/SDK.md) using the Python SDK.

{% endnote %}


## GUI Clients {#gui}

|  Environment | Support level  | Guide | Description |
| --- | :---: | --- | --- |
| Yandex Query UI |  Full |  | |
| [DBeaver](https://dbeaver.com)  |  [DML](#note) | [Guide](./operations/ide.md) | Via a [JDBC driver](https://github.com/ydb-platform/ydb-jdbc-driver/releases)|
| JetBrains Database viewer |  [DML](#note) | [Guide](./operations/ide.md)  | Via a [JDBC driver](https://github.com/ydb-platform/ydb-jdbc-driver/releases)|
| [DataGrip](https://www.jetbrains.com/ru-ru/datagrip/) |  [DML](#note) |  [Guide](./operations/ide.md) | Via a [JDBC driver](https://github.com/ydb-platform/ydb-jdbc-driver/releases)|
| Other JDBC-compatible clients |  [DML](#note) |  [Guide](./operations/ide.md) | Via a [JDBC driver](https://github.com/ydb-platform/ydb-jdbc-driver/releases)|

## Interactive data analysis {#analytics}

|  Environment | Support level  | Guide | Description |
| --- | :---: | :---: | --- |
| Jupyter Notebooks |  [DML](#note) |  [Guide](./tutorials/jupyter.md) | Via [yandex-query-magics](https://github.com/yandex-cloud/yandex-query-magics)|
| [{{ ml-platform-short-name }}](../datasphere/quickstart.md) |  [DML](#note) |  [Guide](./tutorials/jupyter.md) | Via [yandex-query-magics](https://github.com/yandex-cloud/yandex-query-magics)|


## Visualizing {#bi} data

| Environment | Support level  | Guide |
| --- | :---: | --- |
| [{{ datalens-name }}](../datalens/tutorials/index.md) | Full | [Guide](./tutorials/datalens.md) |


## Orchestration {#scheduling}

| Environment | Support level  | Guide |
| --- | :---: | --- |
| [{{ AF }}](../managed-airflow/quickstart.md) | [DML](#note) | [Guide](./tutorials/airflow-auto-tasks.md) |
| [{{ maf-full-name }}](../managed-airflow/quickstart.md) | [DML](#note) | [Guide](./tutorials/airflow-auto-tasks.md) |

## Note {#note}

* [DML](https://ru.wikipedia.org/wiki/Data_Manipulation_Language): Data Manipulation Language. It allows reading and writing data, but does not allow managing [bindings](./concepts/glossary.md#binding) or [connections](./concepts/glossary.md#connection).
