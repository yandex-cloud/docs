# Apache Iceberg™ в Yandex Data Processing

[Apache Iceberg™](https://iceberg.apache.org/) — [открытый табличный формат](https://iceberg.apache.org/spec/) для хранения и обработки больших массивов данных. Он расширяет возможности платформы [Apache Spark™](https://spark.apache.org/):

* Добавляет поддержку высокопроизводительных таблиц формата Apache Iceberg™, с которыми можно работать как с обычными SQL-таблицами.
* Предоставляет механизм [эволюции схемы данных](https://iceberg.apache.org/docs/latest/evolution/#schema-evolution) (schema evolution), при котором изменение схемы не имеет побочных эффектов.
* Обеспечивает [скрытое партиционирование данных](https://iceberg.apache.org/docs/latest/partitioning/) (hidden partitioning) без участия пользователя, предотвращая ошибки, связанные с ручным партиционированием.
* Позволяет выполнять ретроспективные запросы с помощью механизма [time travel](https://iceberg.apache.org/docs/latest/spark-queries/#time-travel). Например, можно выполнять воспроизводимые запросы, которые используют снимки таблиц, или сравнивать изменения.

    {% note info %}

    Для работы этого механизма требуется Apache Spark™ версии 3.3.x и выше.

    {% endnote %}

* Позволяет откатывать таблицы до предыдущих версий (version rollback), чтобы быстро реагировать на проблемы.
* Обеспечивает [продвинутую фильтрацию](https://iceberg.apache.org/docs/latest/performance/#metadata-filtering) (advanced filtering) с использованием статистики, которая собирается на уровне колонок и партиций, а также метаданных таблицы. Это позволяет ускорить выполнение запросов в том числе и для очень больших таблиц: файлы с данными, которые не относятся к запросу, не будут обработаны.
* Обеспечивает самый строгий уровень изоляции транзакций — [serializable](https://iceberg.apache.org/docs/latest/reliability/). Все изменения в таблицах атомарны, и читатели видят только зафиксированные (committed) изменения.
* Поддерживает [конкурентную запись](https://iceberg.apache.org/docs/latest/reliability/#concurrent-write-operations) по оптимистичной стратегии — писатель попробует повторить операцию, если его изменения конфликтуют с изменениями, которые вносит другой писатель.

Вы можете [настроить Apache Iceberg™ в кластере Yandex Data Processing](../operations/apache-iceberg.md) версии 2.0 и выше.


{% note info %}

Apache Iceberg™ не является частью сервиса Yandex Data Processing и не сопровождается командой разработки и службой поддержки Yandex Cloud, а его использование не входит в [условия использования Yandex Data Processing](https://yandex.ru/legal/cloud_termsofuse/?lang=ru).

{% endnote %}


Подробную информацию об Apache Iceberg™ см. в [официальной документации](https://iceberg.apache.org/docs/latest/).

## Совместимость версий Apache Iceberg™ и образов Yandex Data Processing {#compatibility}

Версии Apache Iceberg™ и образы Yandex Data Processing совместимы, только если версия Apache Iceberg™ совместима с используемой в кластере версией Apache Spark™. В таблице ниже приведены совместимые версии и ссылки на файлы библиотек, которые понадобятся при настройке Apache Iceberg™ в кластере.

#|
|| **Образ Yandex Data Processing** | **Версия Apache Spark™**   | **Версия Apache Iceberg™** | **Файлы JAR**     ||
|| 2.0.x                          | 3.0.3
| [1.0.0](https://github.com/apache/iceberg/releases/tag/apache-iceberg-1.0.0)
| [iceberg-spark-runtime-3.0_2.12-1.0.0.jar](https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-3.0_2.12/1.0.0/iceberg-spark-runtime-3.0_2.12-1.0.0.jar) ||
|| 2.1.x                | 3.3.2
| [1.5.2](https://github.com/apache/iceberg/releases/tag/apache-iceberg-1.5.2)
| [iceberg-spark-runtime-3.3_2.12-1.5.2.jar](https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-3.3_2.12/1.5.2/iceberg-spark-runtime-3.3_2.12-1.5.2.jar) ||
|| 2.2.x                          | 3.5.0
| [1.5.2](https://github.com/apache/iceberg/releases/tag/apache-iceberg-1.5.2)
| [iceberg-spark-runtime-3.5_2.12-1.5.2.jar](https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-3.5_2.12/1.5.2/iceberg-spark-runtime-3.5_2.12-1.5.2.jar) ||
|#


{% note info %}

Доступ к образу версии 2.2 предоставляется по запросу. Обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.

{% endnote %}