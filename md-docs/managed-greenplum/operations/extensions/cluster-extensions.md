[Документация Yandex Cloud](../../../index.md) > [Yandex MPP Analytics for PostgreSQL](../../index.md) > [Пошаговые инструкции](../index.md) > Расширения > Управление расширениями

# Управление расширениями в Yandex MPP Analytics for PostgreSQL

Yandex MPP Analytics for PostgreSQL поддерживает следующие расширения Greenplum® и PostgreSQL:

#|
|| **Расширение** | **Версия для Greenplum®** | **Версия для Apache Cloudberry™** ||
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
|| [diskquota](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-diskquota.html)
Позволяет ограничивать размер дискового пространства для схем и ролей в базе данных.
| 1.0 | 2.3 ||
|| [fuzzystrmatch](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-fuzzystrmatch.html)
Содержит функции для определения степени подобия и расстояния между двумя произвольными строками.
| 1.0 | 1.1 ||
|| [gp_distribution_policy](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-system_catalogs-gp_distribution_policy.html)
Содержит информацию о политике распределения данных таблиц по сегментам кластера.
| 1.0 | 1.0 ||
|| [gp_exttable_fdw](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/7/greenplum-database/admin_guide-external-map_ext_to_foreign.html)
Предоставляет оболочку внешних данных для работы с внешними таблицами.
| — | 1.0 ||
|| [gp_internal_tools](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/admin_guide-managing-monitor.html#creating-the-session_level_memory_consumption-view)
Содержит различные внутренние утилиты.
| 1.0.0 | 1.0.0 ||
|| [gp_relaccess_stats](https://github.com/open-gpdb/gp_relaccess_stats). Расширение от Yandex Cloud

Собирает статистику обращений к таблицам и представлениям. Подробнее читайте в разделе [Использование gp_relaccess_stats](gp_relaccess_stats.md).
| 1.1 | — ||
|| [gp_relsizes_stats](https://github.com/open-gpdb/gp_relsizes_stats). Расширение от Yandex Cloud

Собирает статистику о размере файлов и таблиц. Подробнее читайте в разделе [Использование gp_relsizes_stats](gp-relsizes-stats.md).
| 1.0 | — ||
|| [gp_toolkit](https://cloudberry.apache.org/docs/sys-catalogs/gp_toolkit)
Предоставляет набор административных представлений и функций.
| — | 1.6 ||
|| [gp_url_tools](https://github.com/open-gpdb/gp_url_tools). Расширение от Yandex Cloud

Содержит функции для работы с URL-адресами. Подробнее читайте в разделе [Использование gp_url_tools](gp-url-tools.md).
| 1.0 | — ||
|| [hstore](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-hstore.html)
Добавляет тип данных для хранения пар «ключ-значение» в одном поле.
| 1.3 | 1.8 ||
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
|| [orafce](https://github.com/orafce/orafce)
Добавляет функции и операторы, эмулирующие функции и пакеты Oracle.
| 3.7 | 4.9 ||
|| [pgcrypto](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-pgcrypto.html)
Добавляет функции шифрования данных. Подробнее читайте в разделе [Использование pgcrypto](pgcrypto.md).
| 1.1 | 1.3 ||
|| [pg_trgm](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-pg_trgm.html)
Добавляет функции и операторы для определения сходства текста, а также операторы индексации для поиска похожих строк.
| 1.1 | 1.6 ||
|| [plperl](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/analytics-pl_perl.html)
Включает поддержку процедурного языка PL/Perl.
| 1.0 | 1.0 ||
|| [plpgsql](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/analytics-pl_sql.html)
Включает поддержку процедурного языка PL/pgSQL.
| 1.0 | 1.0 ||
|| [postgres_fdw](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-postgres_fdw.html)
Добавляет оболочку для обращений к удаленным базам данных PostgreSQL.
| 1.0 | 1.1 ||
|| [pxf](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum-platform-extension-framework/6-11/gp-pxf/intro_pxf.html)
Позволяет работать с гетерогенными источниками данных.
| 2.0 | 2.1 ||
|| [pxf_fdw](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum-platform-extension-framework/6-11/gp-pxf/intro_pxf.html)
Добавляет оболочку внешних данных для доступа к гетерогенным источникам данных.
| — | 2.0 ||
|| [seg](https://www.postgresql.org/docs/current/seg.html)
Добавляет тип данных для представления отрезков или интервалов чисел с плавающей точкой.
| 1.0 | 1.4 ||
|| [tablefunc](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-modules-tablefunc.html)
Добавляет табличные функции, которые возвращают наборы строк.
| 1.0 | 1.0 ||
|| [tcn](https://www.postgresql.org/docs/current/tcn.html)
Добавляет триггерную функцию для уведомления подписчиков об изменениях в таблицах.
| 1.0 | 1.0 ||
|| [try_convert](https://github.com/open-gpdb/gpdb/tree/OPENGPDB_STABLE/contrib/try_convert). Расширение от Yandex Cloud

Добавляет функцию для преобразования данных из одного типа в другой. Подробнее читайте в разделе [Использование try_convert](try_convert.md).
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