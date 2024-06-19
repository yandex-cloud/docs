# Apache Iceberg в {{ dataproc-name }}

Apache Iceberg - открытый формат табличного хранения, созданный для аналитической обработки больших данных. Этот формат добавляет таким вычислительным движкам как {{ SPRK }}, Trino, PrestoDB, Link, Hive и Impala возможность работы с таблицами языком SQL запросов.

## Основные возможности

* [Schema evolution](https://iceberg.apache.org/docs/nightly/evolution/#schema-evolution) - поддержка изменений схемы данных, включая переименование объектов, без сайд-эффектов.

* Скрытое секционирование ([Hidden partitioning](https://iceberg.apache.org/docs/nightly/partitioning/)) - защищает от ошибок при проектирования способов размещения данных, ведущих к выдаче некорректных результатов или сильному замедлению работы выборок.

* Ретроспективные запросы ([Time travel](https://iceberg.apache.org/docs/nightly/spark-queries/#time-travel). Spark 3.3 и выше) - позволяет повторять запросы, которые будут использовать одинаковые снимки данных, или наоборот - сравнивать изменения.

* Возможность отката версий (Version rollback) позволяет быстро возвращать данные к предыдущему “хорошему” состоянию.

## Надежность и производительность

Iceberg создан для работы с очень большими таблицами. Он используется с таблицами, которые содержат десятки петабайт данных.

* Эффективная фильтрация ([Advanced filtering](https://iceberg.apache.org/docs/nightly/performance/#data-filtering)) - сканирование файлов данных ограничено секциями и column-level статистикой, хранящейся в metadata.

* [Serializable isolation](https://iceberg.apache.org/docs/nightly/reliability/) -- изменения таблиц атомарны. Читатель никогда не увидит незафиксированные (uncommitted) изменения.

* Поддержка конкурентной записи ([Multiple concurrent writers](https://iceberg.apache.org/docs/nightly/reliability/#concurrent-write-operations)) -  писатели используют оптимистическую блокировку и повторы, что позволяет пересекающимся изменениям успешно завершаться, несмотря на конфликты.

{% include [deltalake-disclaimer](../../../_includes/data-proc/deltalake-disclaimer.md) %}

Подробную информацию о Apache Iceberg см. в [документации Apache Iceberg](https://iceberg.apache.org/docs/nightly/).

Вы можете [настроить Apache Iceberg  с кластером {{ dataproc-name }}]( ../operations/iceberg.md) для работы с версиями  2.0  и выше.

## **Совместимость версий Apache Iceberg и {{ dataproc-name }}** {#compatibility}

Версии Apache Iceberg и {{ dataproc-name }} совместимы, только если версия Apache Iceberg совместима с используемой в кластере версией {{ SPRK }}. В таблице ниже приведены совместимые версии и ссылки на файлы библиотек, которые понадобятся при настройке Apache Iceberg в кластере.

#|
||

**Версия {{ dataproc-name }}**

|

**Версия {{ SPRK }}™**

|

**Версия Apache Iceberg**

|

**Файлы JAR**

||
||

2\.0.x

|

3\.0.3

|

[1.0.0](https://web.archive.org/web/20221208090306/https://iceberg.apache.org/docs/1.0.0/)

|

[iceberg-spark-runtime-3.0_2.12-1.0.0.jar](https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-3.0_2.12/1.0.0/iceberg-spark-runtime-3.0_2.12-1.0.0.jar)

||
||

2\.1.x

|

3\.3.2

|

[1.5.2](https://iceberg.apache.org/docs/1.5.2/)

|

[iceberg-spark-runtime-3.3_2.12-1.5.2.jar](https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-3.3_2.12/1.5.2/iceberg-spark-runtime-3.3_2.12-1.5.2.jar)

||
||

2\.2.x

|

3\.5.0

|

[1.5.2](https://iceberg.apache.org/docs/1.5.2/)

|

[iceberg-spark-runtime-3.5_2.12-1.5.2.jar](https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-3.5_2.12/1.5.2/iceberg-spark-runtime-3.5_2.12-1.5.2.jar)

||
|#

{% note info "Примечание" %}

Кластеры {{ dataproc-name }} версии 2.2.x находятся на [стадии Preview](../../overview/concepts/launch-stages.md) и предоставляются по запросу. Обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}
