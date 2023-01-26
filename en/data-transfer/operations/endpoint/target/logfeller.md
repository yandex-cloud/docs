# Configuring a Logfeller target endpoint

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, configure access to Logfeller.

## Settings {#settings}

{% list tabs %}

- Management console

   * **Log name**: Finished tables will be published in YT at `//logs/log_name`. You can use `/` in the log name to create a hierarchy of directories. For example, if you specify the log name `myservice/access-log`, data will be located at `//logs/myservice/access-log`.

   * **YT cluster**: Select the YT cluster to store tables.

   * **YT account**: Select the YT account to store tables. Only logs must be stored in this account.

   * **YT operations settings**:

      * **Pool**: The pool where operations in YT will be run to process the log data.

      * **Specification**: [Specifications of YT operations in JSON format](https://yt.yandex-team.ru/docs/description/mr/operations_options#obshie-opcii-dlya-vseh-tipov-operacij). Enables you to redefine the settings.

   * **Daily tables**, **Hourly tables**, **Half-hourly tables**, and **Ultrafast tables**: Log tables for specific time intervals.

      * **Table life time**: Defines how long logs are retained in the table. To set a time interval, specify a value and a time letter, for example, `12h`, `7d`, or `365d`.

      * **Build delay**: Configures the delayed build of the tables. This can be useful if raw data is uploaded to Logbroker with a persistent delay. To set a time interval, specify a value and a time letter, for example, `12h`, `7d`, or `365d`.

      * **Build options**:

         * **Build options**: Data sorting by columns. You can only specify columns that are in the table schema. Data will be sorted in the specified order.

         * **Compression codec**: Select a [compression codecs](https://yt.yandex-team.ru/docs/description/common/compression#compression_codecs).

         * **Erasure codec**: Select an [erasure algorithms](https://yt.yandex-team.ru/docs/description/common/replication#erasure).

         * **YT operation settings**: Enables you to redefine or supplement the **Pool** and **Specification** settings specified above at the general log settings level.

      * **Rebuild options**:

         * **Number of days to wait**: If the source sends data older than the specified period, it will be ignored and not included in the published table.

         * **Rebuild frequency**: To set a time interval, specify a value and a time letter, for example, `12h`, `7d`, or `365d`. By default, the process is launched every three hours. If a sensitive completeness threshold (100%) is set and the source regularly sends history data, it is better to launch the process twice a day (12h) or once a day (24h) to reduce the use of computing resources.

         * **Completeness threshold**: The threshold for <q>late</q> data. It is set as a percentage between `0.00` and `100.00`. If you specify 100%, any late string will exceed the threshold. If you specify 99.8%, the number of late strings greater than 0.2% will exceed the threshold. If the specified threshold is exceeded, data will be rebuilt in the published table and a new table change event will be sent to Reactor.

         * **YT operations settings**: Enables you to redefine or supplement the **Pool** and **Specification** settings entered above at the general log settings level.

      * **Archive options**:

         * **Enabled**: Archiving activation.

         * **Archivation delay**: To set a time interval, specify a value and a time letter, for example, `12h`, `7d`, or `365d`. Tables are initially written with codecs. After archiving, reading tables will become more difficult. Activate a delayed archiving start if fast access to data is critical.

         * **Compression codec**: Select a [compression codecs](https://yt.yandex-team.ru/docs/description/common/compression#compression_codecs).

         * **Erasure codec**: Select an [erasure algorithms](https://yt.yandex-team.ru/docs/description/common/replication#erasure).

         * **YT operation settings**: Enables you to redefine or supplement the **Pool** and **Specification** settings specified above at the general log settings level.

   * **Advanced settings**:

      * **Sensitive data**: Defines what to do with sensitive data. Select one of the suggested strategies.

      * **Name of private queue in Nirvactore**: By default, logs are run from the common queue (the name must be left blank). If the number of logs exceeds 30 and there is a dedicated resource pool, we recommend using a separate queue.

{% endlist %}
