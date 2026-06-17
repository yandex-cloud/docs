# Управление расширениями в Yandex MPP Analytics for PostgreSQL

Yandex MPP Analytics for PostgreSQL поддерживает следующие расширения Greenplum® и PostgreSQL:

#|
|| **Расширение** | **Версия для Greenplum®** | **Версия для Apache Cloudberry™** ||
|| [autoinc](https://www.postgresql.org/docs/current/contrib-spi.html#CONTRIB-SPI-AUTOINC)
Добавляет триггерную функцию для записи в целочисленное поле очередного значения из последовательности.
| 1.0 | 1.0 ||
|| [amcheck](https://www.postgresql.org/docs/current/amcheck.html)
Содержит функции для проверки логической целостности структуры индексов.
| 1.0 | 1.3 ||
|| [bloom](https://www.postgresql.org/docs/14/bloom.html)
Предоставляет метод доступа к индексам на основе фильтров Блума.
| — | 1.0 ||
|| [bool_plperl](https://www.postgresql.org/docs/14/plperl-funcs.html)
Предоставляет трансформацию для типа `bool` для процедурного языка PL/Perl.
| — | 1.0 ||
|| [btree_gist](https://www.postgresql.org/docs/14/btree-gist.html)
Предоставляет классы операторов GiST с поведением, аналогичным B-tree.
| — | 1.6 ||
|| [btree_gin](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-btree_gin.html)
Добавляет возможность создавать индексы GIN для столбцов, подходящих для индексирования B-tree.
| 1.0 | 1.3 ||
|| [citext](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-citext.html)
Добавляет тип данных для сравнения строк без учета регистра.
| 1.0 | 1.6 ||
|| [dblink](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-dblink.html)
Включает поддержку подключений к другим базам данных Greenplum® в рамках сессии.
| 1.1  | 1.2 ||
|| [dict_int](https://www.postgresql.org/docs/current/dict-int.html)
Добавляет шаблон словаря для полнотекстового поиска целых чисел.
| 1.0 | 1.0 ||
|| [dict_xsyn](https://www.postgresql.org/docs/current/dict-xsyn.html)
Добавляет шаблон словаря для полнотекстового поиска с расширенной обработкой синонимов.
| 1.0 | 1.0 ||
|| [diskquota](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-diskquota.html)
Позволяет ограничивать размер дискового пространства для схем и ролей в базе данных.
| 1.0 | 2.3 ||
|| [fuzzystrmatch](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-fuzzystrmatch.html)
Содержит функции для определения степени подобия и расстояния между двумя произвольными строками.
| 1.0 | 1.1 ||
|| [gp_array_agg](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-gp_array_agg.html)
Добавляет параллельную реализацию агрегатной функции `array_agg`.
| 1.0.0 | — ||
|| [gp_distribution_policy](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-system_catalogs-gp_distribution_policy.html)
Содержит информацию о политике распределения данных таблиц по сегментам кластера.
| 1.0 | 1.0 ||
|| [gp_debug_numsegments](https://github.com/apache/cloudberry/tree/main/gpcontrib/gp_debug_numsegments)
Предоставляет функции для получения и задания числа сегментов по умолчанию при создании таблиц.
| — | 1.0 ||
|| [gp_exttable_fdw](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/7/greenplum-database/admin_guide-external-map_ext_to_foreign.html)
Предоставляет оболочку внешних данных для работы с внешними таблицами.
| — | 1.0 ||
|| [gp_inject_fault](https://github.com/apache/cloudberry/tree/main/gpcontrib/gp_inject_fault)
Предоставляет интерфейс для внедрения предопределенных точек отказа в работающий кластер.
| — | 1.0 ||
|| [gp_internal_tools](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/admin_guide-managing-monitor.html#creating-the-session_level_memory_consumption-view)
Содержит различные внутренние утилиты.
| 1.0.0 | 1.0.0 ||
|| [gp_percentile_agg](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-gp_percentile_agg.html)
Добавляет агрегатную функцию для вычисления процентилей.
| 1.0.0 | — ||
|| [gp_relaccess_stats](https://github.com/open-gpdb/gp_relaccess_stats). Расширение от Yandex Cloud

Собирает статистику обращений к таблицам и представлениям. Подробнее читайте в разделе [Использование gp_relaccess_stats](gp_relaccess_stats.md).
| 1.1 | — ||
|| [gp_relsizes_stats](https://github.com/open-gpdb/gp_relsizes_stats). Расширение от Yandex Cloud

Собирает статистику о размере файлов и таблиц. Подробнее читайте в разделе [Использование gp_relsizes_stats](gp-relsizes-stats.md).
| 1.0 | — ||
|| [gp_sparse_vector](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-gp_sparse_vector.html)
Добавляет разреженные векторы и связанные с ними функции.
| 1.0.1 | 1.0.1 ||
|| [gp_stats_collector](https://github.com/apache/cloudberry/blob/main/gpcontrib/gp_stats_collector)
Предоставляет средства для сбора метрик выполнения запросов и передачи их внешнему агенту.
| 1.1 | 1.1 ||
|| [gp_toolkit](https://cloudberry.apache.org/docs/sys-catalogs/gp_toolkit)
Предоставляет набор административных представлений и функций.
| — | 1.6 ||
|| [gp_url_tools](https://github.com/open-gpdb/gp_url_tools). Расширение от Yandex Cloud

Содержит функции для работы с URL-адресами. Подробнее читайте в разделе [Использование gp_url_tools](gp-url-tools.md).
| 1.0 | — ||
|| [hstore](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-hstore.html)
Добавляет тип данных для хранения пар «ключ-значение» в одном поле.
| 1.3 | 1.8 ||
|| [hstore_plperl](https://www.postgresql.org/docs/14/hstore.html#id-1.11.7.25.11)
Предоставляет трансформацию для типа `hstore` для процедурного языка PL/Perl.
| — | 1.0 ||
|| [insert_username](https://www.postgresql.org/docs/current/contrib-spi.html#CONTRIB-SPI-INSERT-USERNAME)
Добавляет триггерную функцию для записи имени текущего пользователя в текстовое поле.
| 1.0 | 1.0 ||
|| [intagg](https://www.postgresql.org/docs/14/intagg.html). Расширение устарело.
Добавляет агрегатор целых чисел и перечислитель.
| — | 1.1 ||
|| [intarray](https://www.postgresql.org/docs/current/intarray.html)
Добавляет функции, операторы и поддержку индексов для одномерных массивов целых чисел.
| 1.0 | 1.5 ||
|| [isn](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-isn.html)
Добавляет тип данных для работы с международными стандартами идентификации продукции.
| 1.0 | 1.2 ||
|| [jsonb_plperl](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/7/greenplum-database/admin_guide-query-topics-json-data.html#topic_transforms)
Предоставляет трансформацию для типа `jsonb` для процедурного языка PL/Perl.
| — | 1.0 ||
|| [logerrors](https://github.com/munakoiso/logerrors)
Добавляет функцию для сбора статистики о сообщениях в журнале.
| 2.1 | 2.1 ||
|| [ltree](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-ltree.html)
Добавляет тип данных для представления меток данных в иерархической древовидной структуре.
| 1.0 | 1.2 ||
|| [moddatetime](https://www.postgresql.org/docs/current/contrib-spi.html#CONTRIB-SPI-MODDATETIME)
Добавляет триггерную функцию для записи текущего времени в поле `timestamp`.
| 1.0 | 1.0 ||
|| [old_snapshot](https://www.postgresql.org/docs/14/oldsnapshot.html)
Позволяет анализировать состояние `old_snapshot_threshold`.
| — | 1.0 ||
|| [orafce](https://github.com/orafce/orafce)
Добавляет функции и операторы, эмулирующие функции и пакеты Oracle.
| 3.7 | 4.9 ||
|| [pageinspect](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-pageinspect.html)
Предоставляет функции для низкоуровневого анализа содержимого страниц базы данных.
| 1.8 | 1.9 ||
|| [pgaudit](https://github.com/open-gpdb/gpdb/tree/OPENGPDB_STABLE/gpcontrib/pgaudit). Расширение от Yandex Cloud

Добавляет возможность ведения журналов аудита сессий и объектов с использованием стандартной системы логирования PostgreSQL.
| 1.0.9 | — ||
|| [pgcrypto](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-pgcrypto.html)
Добавляет функции шифрования данных. Подробнее читайте в разделе [Использование pgcrypto](pgcrypto.md).
| 1.1 | 1.3 ||
|| [pgrowlocks](https://www.postgresql.org/docs/current/pgrowlocks.html)
Предоставляет функцию для просмотра информации о блокировке строк таблицы.
| 1.1 | 1.2 ||
|| [pgstattuple](https://www.postgresql.org/docs/current/pgstattuple.html)
Предоставляет функции для получения статистики на уровне кортежей.
| 1.2 | 1.5 ||
|| [pg_buffercache](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/7/greenplum-database/ref_guide-modules-pg_buffercache.html)
Предоставляет средства для анализа содержимого общего буферного кеша в реальном времени.
| 1.1 | 1.4.1 ||
|| [pg_freespacemap](https://www.postgresql.org/docs/current/pgfreespacemap.html)
Предоставляет средства для анализа карты свободного пространства (FSM).
| 1.0 | 1.2 ||
|| [pg_hint_plan](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/7/greenplum-database/ref_guide-modules-pg_hint_plan.html)
Позволяет управлять планами выполнения запросов с помощью подсказок в комментариях SQL.
| — | 1.3.9 ||
|| [pg_prewarm](https://www.postgresql.org/docs/current/pgprewarm.html)
Предоставляет способ загрузки данных отношения в кеш операционной системы или буферный кеш PostgreSQL.
| 1.0 | 1.2 ||
|| [pg_stat_statements](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/7/greenplum-database/ref_guide-modules-pg_stat_statements.html)
Предоставляет средства для отслеживания статистики планирования и выполнения операторов SQL.
| 1.2 | 1.9 ||
|| [pg_surgery](https://www.postgresql.org/docs/14/pgsurgery.html)
Предоставляет функции для исправления поврежденного отношения.
| — | 1.0 ||
|| [pg_trgm](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-pg_trgm.html)
Добавляет функции и операторы для определения сходства текста, а также операторы индексации для поиска похожих строк.
| 1.1 | 1.6 ||
|| [pg_visibility](https://www.postgresql.org/docs/14/pgvisibility.html)
Предоставляет средства для анализа карты видимости и информации о видимости страниц отношения.
| — | 1.2 ||
|| [plperl](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/analytics-pl_perl.html)
Включает поддержку процедурного языка PL/Perl.
| 1.0 | 1.0 ||
|| [plpgsql](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/analytics-pl_sql.html)
Включает поддержку процедурного языка PL/pgSQL.
| 1.0 | 1.0 ||
|| [postgis](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/analytics-postGIS.html)
Добавляет возможности хранения и обработки объектов геоинформационных систем (ГИС) в базах данных PostgreSQL.
| 2.1.5 | — ||
|| [postgres_fdw](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-postgres_fdw.html)
Добавляет оболочку для обращений к удаленным базам данных PostgreSQL.
| 1.0 | 1.1 ||
|| [pxf](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum-platform-extension-framework/6-11/gp-pxf/intro_pxf.html)
Позволяет работать с гетерогенными источниками данных.
| 2.0 | 2.1 ||
|| [pxf_fdw](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum-platform-extension-framework/6-11/gp-pxf/intro_pxf.html)
Добавляет оболочку внешних данных для доступа к гетерогенным источникам данных.
| — | 2.0 ||
|| [refint](https://www.postgresql.org/docs/current/contrib-spi.html#CONTRIB-SPI-REFINT)
Добавляет триггерные функции для реализации ссылочной целостности.
| 1.0 | 1.0 ||
|| [seg](https://www.postgresql.org/docs/current/seg.html)
Добавляет тип данных для представления отрезков или интервалов чисел с плавающей точкой.
| 1.0 | 1.4 ||
|| [sslinfo](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-sslinfo.html)
Позволяет получать информацию о SSL-сертификате подключения.
| 1.0 | 1.2 ||
|| [tablefunc](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-tablefunc.html)
Добавляет табличные функции, которые возвращают наборы строк.
| 1.0 | 1.0 ||
|| [tcn](https://www.postgresql.org/docs/current/tcn.html)
Добавляет триггерную функцию для уведомления подписчиков об изменениях в таблицах.
| 1.0 | 1.0 ||
|| [try_convert](https://github.com/open-gpdb/gpdb/tree/OPENGPDB_STABLE/contrib/try_convert). Расширение от Yandex Cloud

Добавляет функцию для преобразования данных из одного типа в другой. Подробнее читайте в разделе [Использование try_convert](try_convert.md).
| 1.0 | — ||
|| [tsearch2](https://www.postgresql.org/docs/9.6/tsearch2.html)
Добавляет функции, совместимые с функциями полнотекстового поиска, которые присутствовали в PostgreSQL до версии `8.3`.
| 1.0 | — ||
|| [tsm_system_rows](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/7/greenplum-database/ref_guide-modules-tsm_system_rows.html)
Предоставляет метод табличной выборки `SYSTEM_ROWS`.
| — | 1.0 ||
|| [tsm_system_time](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/7/greenplum-database/ref_guide-modules-tsm_system_time.html)
Предоставляет метод табличной выборки `SYSTEM_TIME`.
| — | 1.0 ||
|| [unaccent](https://www.postgresql.org/docs/current/unaccent.html)
Добавляет словарь для полнотекстового поиска, удаляющий диакритические знаки.
| 1.0 | 1.1 ||
|| uuid-cb. Расширение от Yandex Cloud

Добавляет возможность генерации и валидации уникальных идентификаторов по требованиям Центробанка РФ. Подробнее читайте в разделе [Использование uuid-cb](uuid-cb.md).
| 1.0 | — ||
|| [uuid-ossp](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/7/greenplum-database/ref_guide-modules-uuid-ossp.html)
Предоставляет функции для генерации универсальных уникальных идентификаторов (UUID).
| — | 1.1 ||
|| [yezzey](yezzey.md). Расширение от Yandex Cloud

Позволяет перемещать [таблицы AO и AOCO](../../concepts/tables.md) из хранилища кластера в холодное хранилище и наоборот. Чтобы использовать это расширение, включите [гибридное хранилище](../../concepts/hybrid-storage.md) в кластере Yandex MPP Analytics for PostgreSQL.
| 1.8 | 1.8.8 ||
|| [xml2](https://www.postgresql.org/docs/current/xml2.html)
Добавляет функции для выполнения запросов XPath и преобразований XSLT.
| 1.0 | 1.1 ||
|#

## Получить список расширений, доступных для установки {#available-extensions}

Подключитесь к выбранной базе данных и выполните команду:

```sql
SELECT * FROM pg_available_extensions();
```

Будет выведен список расширений БД доступных для установки:

```text
name                    | default_version | comment                            
------------------------+-----------------+------------------------------
 diskquota              | 1.0             | Disk Quota Main Program
...
```

## Получить список установленных расширений {#list-extensions}

Подключитесь к выбранной базе данных и выполните команду:

```sql
SELECT extname FROM pg_extension;
```

Будет выведен список расширений, установленных в БД:

```text
      extname
-------------------
 plpgsql
...
```

## Изменить список установленных расширений {#update-extensions}

Подключитесь к выбранной базе данных и выполните команду:

```sql
CREATE EXTENSION <имя_расширения>;
```

Подробнее читайте в [документации Greenplum®](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/7/greenplum-database/ref_guide-sql_commands-CREATE_EXTENSION.html).

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._

_Apache® и Apache Cloudberry™ являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._