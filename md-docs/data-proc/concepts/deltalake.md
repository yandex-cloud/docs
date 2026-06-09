# Delta Lake в Yandex Data Processing

[Delta Lake](https://delta.io/) — это программное обеспечение с открытым исходным кодом, которое расширяет возможности платформы [Apache Spark™](https://spark.apache.org/):

* добавляет оптимизированный слой хранения данных в формате таблиц с поддержкой [ACID-транзакций](https://docs.delta.io/2.0.2/concurrency-control.html);
* дает возможность масштабируемой обработки метаданных;
* позволяет обновлять данные в аналитических таблицах, хранящихся в виде Parquet-файлов в системе HDFS или S3-совместимом хранилище;
* позволяет обрабатывать пакетные запросы и выполнять операции потоковой передачи данных.

Вы можете настроить работу Delta Lake в кластере Yandex Data Processing:

* [в однокластерном режиме](../operations/deltalake/one-cluster-mode.md) для версий Yandex Data Processing 2.0 и 2.1;
* [в мультикластерном режиме](../operations/deltalake/multi-cluster-mode.md) для версий Yandex Data Processing 2.1 и выше.

Хотя однокластерный режим допускает работу с таблицами из разных кластеров и заданий Apache Spark™, одновременная запись из разных источников может привести к потере информации в таблице. Чтобы исключить такую ситуацию, необходима дополнительная настройка операций записи.

При работе в мультикластерном режиме за координацию доступа к таблицам Delta Lake из разных кластеров и заданий Apache Spark™ отвечает вспомогательная база данных. В Yandex Cloud в качестве такой базы используется [Yandex Managed Service for YDB](../../ydb/index.md).


{% note info %}

Delta Lake не является частью сервиса Yandex Data Processing и не сопровождается командой разработки и службой поддержки Yandex Cloud, а его использование не входит в [условия использования Yandex Data Processing](https://yandex.ru/legal/cloud_termsofuse/?lang=ru).

{% endnote %}

Подробная информация о Delta Lake в [документации Delta Lake](https://docs.delta.io/latest/index.html).


## Совместимость версий Delta Lake и Yandex Data Processing {#compatibility}

Версии Delta Lake и Yandex Data Processing совместимы, только если версия Delta Lake совместима с используемой в кластере версией Apache Spark™. В таблице ниже приведены совместимые версии и ссылки на файлы библиотек, которые понадобятся при настройке Delta Lake в кластере.

#|
|| **Версия Yandex Data Processing** | **Версия Apache Spark™** | **Версия Delta Lake**                                              | **Файлы JAR**                                                                                                         ||
|| 2.0.x                          | 3.0.3                   | [0.8.0](https://github.com/delta-io/delta/releases/tag/v0.8.0)     | [delta-core_2.12-0.8.0.jar](https://repo1.maven.org/maven2/io/delta/delta-core_2.12/0.8.0/delta-core_2.12-0.8.0.jar)  ||
|| 2.1.x                   | 3.3.2                   | [2.3.0](https://github.com/delta-io/delta/releases/tag/v2.3.0)     | [delta-core_2.12-2.3.0.jar](https://repo1.maven.org/maven2/io/delta/delta-core_2.12/2.3.0/delta-core_2.12-2.3.0.jar),
                                                                                                                                   [delta-storage-2.3.0.jar](https://repo1.maven.org/maven2/io/delta/delta-storage/2.3.0/delta-storage-2.3.0.jar)        ||
|#

{% note info %}

Кластеры Yandex Data Processing версии 2.2.x находятся на [стадии Preview](../../overview/concepts/launch-stages.md) и предоставляются по запросу. Обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.

{% endnote %}

## Основные преимущества Delta Lake 2.x {#advantages}

Основные преимущества Delta Lake 2.x, по сравнению с версией 0.8.0:

* Поддержка [мультикластерного режима](https://docs.delta.io/2.0.2/delta-storage.html#multi-cluster-setup), который обеспечивает автоматическую координацию изменений данных в одной таблице из разных заданий Apache Spark™ и кластеров Yandex Data Processing.
* Функция [идемпотентной записи данных](https://docs.delta.io/latest/delta-streaming.html#idempotent-table-writes-in-foreachbatch), которая позволяет решить задачу однократного применения изменений при потоковой обработке данных.
* Функция [Change Data Feed](https://docs.delta.io/2.0.2/delta-change-data-feed.html), которая обеспечивает отслеживание изменений данных в таблицах Delta Lake.
* Функция [Z-Ordering](https://docs.delta.io/2.0.2/optimizations-oss.html#z-ordering-multi-dimensional-clustering), которая реализует многомерную кластеризацию таблиц Delta Lake. Функция позволяет ускорить выполнение запросов с ограничениями на столбцы, которые используются для кластеризации.
* Поддержка [динамической перезаписи партиций](https://docs.delta.io/2.0.2/delta-batch.html#dynamic-partition-overwrites).
* [Оптимизация производительности запросов](https://docs.delta.io/2.0.2/optimizations-oss.html#compaction-bin-packing) за счет объединения небольших файлов в более крупные.
* Возможность [отката таблицы](https://docs.delta.io/2.0.2/delta-utility.html#restore-a-delta-table-to-an-earlier-state) к предыдущему состоянию.