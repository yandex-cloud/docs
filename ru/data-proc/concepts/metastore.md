# Кластеры {{ metastore-full-name }}

{% include [Доступ по запросу](../../_includes/note-preview-by-request.md) %}

В сервисе {{ dataproc-name }} вы можете [создавать кластеры {{ metastore-full-name }}](../operations/metastore/cluster-create.md).

[{{ metastore-full-name }}](https://cwiki.apache.org/confluence/display/hive/design#Design-Metastore) — это сервер табличных метаданных, который:

* Предоставляет клиентским приложениям информацию о том, где брать данные для обработки и как их интерпретировать.
* Сохраняет метаданные таблиц между запусками вычислительных кластеров с коротким временем жизни.
* Делит пространство данных между одновременно работающими кластерами.
* Связывает разнородные ETL-системы и инструменты для работы с общими данными и упрощает их развертывание.
* Обеспечивает отказоустойчивость, масштабирование хранилища и резервное копирование метаданных.
* Упрощает отправку логов и метрик, процессы обновления и миграции.

Ряд продуктов Apache®, среди которых [Hive](https://hive.apache.org/), [Spark](https://spark.apache.org/) и [Impala](https://impala.apache.org/overview.html), поддерживает непосредственную работу с {{ metastore-name }}.

Подробнее о {{ metastore-full-name }} см. в [документации Apache®](https://cwiki.apache.org/confluence/display/hive/design#Design-Metastore).
