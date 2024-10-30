---
title: '{{ IBRG }} в {{ dataproc-full-name }}'
description: Информация об {{ IBRG }}, а также таблица совместимости версий {{ IBRG }} и {{ dataproc-full-name }}.
---

# {{ IBRG }} в {{ dataproc-name }}

[{{ IBRG }}](https://iceberg.apache.org/) — [открытый табличный формат](https://iceberg.apache.org/spec/) для хранения и обработки больших массивов данных. Он расширяет возможности платформы [{{ SPRK }}](https://spark.apache.org/):

* Добавляет поддержку высокопроизводительных таблиц формата {{ IBRG }}, с которыми можно работать как с обычными SQL-таблицами.
* Предоставляет механизм [эволюции схемы данных](https://iceberg.apache.org/docs/latest/evolution/#schema-evolution) (schema evolution), при котором изменение схемы не имеет побочных эффектов.
* Обеспечивает [скрытое партиционирование данных](https://iceberg.apache.org/docs/latest/partitioning/) (hidden partitioning) без участия пользователя, предотвращая ошибки, связанные с ручным партиционированием.
* Позволяет выполнять ретроспективные запросы с помощью механизма [time travel](https://iceberg.apache.org/docs/latest/spark-queries/#time-travel). Например, можно выполнять воспроизводимые запросы, которые используют снимки таблиц, или сравнивать изменения.

    {% note info %}

    Для работы этого механизма требуется {{ SPRK }} версии 3.3.x и выше.

    {% endnote %}

* Позволяет откатывать таблицы до предыдущих версий (version rollback), чтобы быстро реагировать на проблемы.
* Обеспечивает [продвинутую фильтрацию](https://iceberg.apache.org/docs/latest/performance/#metadata-filtering) (advanced filtering) с использованием статистики, которая собирается на уровне колонок и партиций, а также метаданных таблицы. Это позволяет ускорить выполнение запросов в том числе и для очень больших таблиц: файлы с данными, которые не относятся к запросу, не будут обработаны.
* Обеспечивает самый строгий уровень изоляции транзакций — [serializable](https://iceberg.apache.org/docs/latest/reliability/). Все изменения в таблицах атомарны, и читатели видят только зафиксированные (committed) изменения.
* Поддерживает [конкурентную запись](https://iceberg.apache.org/docs/latest/reliability/#concurrent-write-operations) по оптимистичной стратегии — писатель попробует повторить операцию, если его изменения конфликтуют с изменениями, которые вносит другой писатель.

Вы можете [настроить {{ IBRG }} в кластере {{ dataproc-name }}](../operations/apache-iceberg.md) версии 2.0 и выше.


{% include [apache-iceberg-disclaimer](../../_includes/data-proc/apache-iceberg-disclaimer.md) %}


Подробную информацию об {{ IBRG }} см. в [официальной документации](https://iceberg.apache.org/docs/latest/).

## Совместимость версий {{ IBRG }} и образов {{ dataproc-name }} {#compatibility}

Версии {{ IBRG }} и образы {{ dataproc-name }} совместимы, только если версия {{ IBRG }} совместима с используемой в кластере версией {{ SPRK }}. В таблице ниже приведены совместимые версии и ссылки на файлы библиотек, которые понадобятся при настройке {{ IBRG }} в кластере.

#|
|| **Образ {{ dataproc-name }}** | **Версия {{ SPRK }}**   | **Версия {{ IBRG }}** | **Файлы JAR**     ||
|| 2.0.x                          | 3.0.3
| [1.0.0](https://github.com/apache/iceberg/releases/tag/apache-iceberg-1.0.0)
| [{{ dp-libs.iceberg.dp20.jar }}]({{ dp-libs.iceberg.dp20.repo }}) ||
|| 2.1.x (2.1.0–2.1.3)            | 3.2.1
| [1.4.3](https://github.com/apache/iceberg/releases/tag/apache-iceberg-1.4.3)
| [{{ dp-libs.iceberg.dp21.spark32.jar }}]({{ dp-libs.iceberg.dp21.spark32.repo }}) ||
|| 2.1.x (2.1.4 и выше)           | 3.3.2
| [1.5.2](https://github.com/apache/iceberg/releases/tag/apache-iceberg-1.5.2)
| [{{ dp-libs.iceberg.dp21.spark33.jar }}]({{ dp-libs.iceberg.dp21.spark33.repo }}) ||
|| 2.2.x                          | 3.5.0
| [1.5.2](https://github.com/apache/iceberg/releases/tag/apache-iceberg-1.5.2)
| [{{ dp-libs.iceberg.dp22.jar }}]({{ dp-libs.iceberg.dp22.repo }}) ||
|#


{% note info %}

Доступ к образу версии 2.2 предоставляется по запросу. Обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}

