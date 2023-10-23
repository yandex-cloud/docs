# Delta Lake в {{ dataproc-name }}

[Delta Lake](https://delta.io/) — это программное обеспечение с открытым исходным кодом, которое расширяет возможности платформы [{{ SPRK }}](https://spark.apache.org/):

* добавляет оптимизированный слой хранения данных в формате таблиц с поддержкой [ACID-транзакций](https://docs.delta.io/2.0.2/concurrency-control.html);
* дает возможность масштабируемой обработки метаданных;
* позволяет обновлять данные в аналитических таблицах, хранящихся в виде Parquet-файлов в системе HDFS или S3-совместимом хранилище;
* позволяет обрабатывать пакетные запросы и выполнять операции потоковой передачи данных.

Вы можете настроить работу Delta Lake в кластере {{ dataproc-name }}:

* [в однокластерном режиме](../operations/deltalake/one-cluster-mode.md) для версий {{ dataproc-name }} 2.0 и 2.1;
* [в мультикластером режиме](../operations/deltalake/multi-cluster-mode.md) для версий {{ dataproc-name }} 2.1 и выше.

Хотя однокластерный режим допускает работу с таблицами из разных кластеров и заданий {{ SPRK }}, одновременная запись из разных источников может привести к потере информации в таблице. Чтобы исключить такую ситуацию, необходима дополнительная настройка операций записи.

При работе в мультикластерном режиме за координацию доступа к таблицам Delta Lake из разных кластеров и заданий {{ SPRK }} отвечает вспомогательная база данных. В {{ yandex-cloud }} в качестве такой базы используется [{{ ydb-full-name }}](../../ydb/index.yaml).


{% include [deltalake-disclaimer](../../_includes/data-proc/deltalake-disclaimer.md) %}


Подробную информацию о Delta Lake см. в [документации Delta Lake](https://docs.delta.io/latest/index.html).

## Совместимость версий Delta Lake и {{ dataproc-name }} {#compatibility}

Версии Delta Lake и {{ dataproc-name }} совместимы, только если версия Delta Lake совместима с используемой в кластере версией {{ SPRK }}. В таблице ниже приведены совместимые версии и ссылки на файлы библиотек, которые понадобятся при настройке Delta Lake в кластере.

#|
|| **Версия {{ dataproc-name }}** | **Версия {{ SPRK }}** | **Версия Delta Lake**                                              | **Файлы JAR**                                                                                                         ||
|| 2.0.x                          | 3.0.3                   | [0.8.0](https://github.com/delta-io/delta/releases/tag/v0.8.0)     | [delta-core_2.12-0.8.0.jar](https://repo1.maven.org/maven2/io/delta/delta-core_2.12/0.8.0/delta-core_2.12-0.8.0.jar)  ||
|| 2.1.0 и 2.1.3                  | 3.2.1                   | [2.0.2](https://github.com/delta-io/delta/releases/tag/v2.0.2)     | [delta-core_2.12-2.0.2.jar](https://repo1.maven.org/maven2/io/delta/delta-core_2.12/2.0.2/delta-core_2.12-2.0.2.jar),
                                                                                                                                   [delta-storage-2.0.2.jar](https://repo1.maven.org/maven2/io/delta/delta-storage/2.0.2/delta-storage-2.0.2.jar)        ||
|| 2.1.4 и выше                   | 3.3.2                   | [2.3.0](https://github.com/delta-io/delta/releases/tag/v2.3.0)     | [delta-core_2.12-2.3.0.jar](https://repo1.maven.org/maven2/io/delta/delta-core_2.12/2.3.0/delta-core_2.12-2.3.0.jar),
                                                                                                                                   [delta-storage-2.3.0.jar](https://repo1.maven.org/maven2/io/delta/delta-storage/2.3.0/delta-storage-2.3.0.jar)        ||
|#

{% note info %}

Кластеры {{ dataproc-name }} версии 2.1.x находятся на [стадии Preview](../../overview/concepts/launch-stages.md) и предоставляются по запросу. Обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}

## Основные преимущества Delta Lake 2.x {#advantages}

Основные преимущества Delta Lake 2.x, по сравнению с версией 0.8.0:

* Поддержка [мультикластерного режима](https://docs.delta.io/2.0.2/delta-storage.html#multi-cluster-setup), который обеспечивает автоматическую координацию изменений данных в одной таблице из разных заданий {{ SPRK }} и кластеров {{ dataproc-name }}.
* Функция [идемпотентной записи данных](https://docs.delta.io/latest/delta-streaming.html#idempotent-table-writes-in-foreachbatch), которая позволяет решить задачу однократного применения изменений при потоковой обработке данных.
* Функция [Change Data Feed](https://docs.delta.io/2.0.2/delta-change-data-feed.html), которая обеспечивает отслеживание изменений данных в таблицах Delta Lake.
* Функция [Z-Ordering](https://docs.delta.io/2.0.2/optimizations-oss.html#z-ordering-multi-dimensional-clustering), которая реализует многомерную кластеризацию таблиц Delta Lake. Функция позволяет ускорить выполнение запросов с ограничениями на столбцы, которые используются для кластеризации.
* Поддержка [динамической перезаписи партиций](https://docs.delta.io/2.0.2/delta-batch.html#dynamic-partition-overwrites).
* [Оптимизация производительности запросов](https://docs.delta.io/2.0.2/optimizations-oss.html#compaction-bin-packing) за счет объединения небольших файлов в более крупные.
* Возможность [отката таблицы](https://docs.delta.io/2.0.2/delta-utility.html#restore-a-delta-table-to-an-earlier-state) к предыдущему состоянию.
