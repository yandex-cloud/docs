# Управление расширениями {{ GP }}

{{ mgp-short-name }} поддерживает следующие расширения {{ GP }} и {{ PG }}:

#|
|| **Расширение** | **Версия** ||
|| [btree_gin]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-modules-btree_gin.html)
Добавляет возможность создавать индексы GIN для столбцов, подходящих для индексирования B-tree.
| 1.0 ||
|| [citext]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-citext.html)
Добавляет тип данных для сравнения строк без учета регистра.
| 1.0 ||
|| [dblink]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-dblink.html)
Включает поддержку подключений к другим базам данных {{ GP }} в рамках сессии.
| 1.1  ||
|| [dict_int]({{ pg.docs.org }}/current/dict-int.html)
Добавляет шаблон словаря для полнотекстового поиска целых чисел.
| 1.0 ||
|| [dict_xsyn]({{ pg.docs.org }}/current/dict-xsyn.html)
Добавляет шаблон словаря для полнотекстового поиска с расширенной обработкой синонимов.
| 1.0 ||
|| [diskquota]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-diskquota.html)
Позволяет ограничивать размер дискового пространства для схем и ролей в базе данных.
| 1.0 ||
|| [fuzzystrmatch]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-fuzzystrmatch.html)
Содержит функции для определения степени подобия и расстояния между двумя произвольными строками.
| 1.0 ||
|| [gp_array_agg]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-modules-gp_array_agg.html)
Добавляет параллельную реализацию агрегатной функции `array_agg` для {{ GP }}.
| 1.0.0 ||
|| [gp_internal_tools]({{ gp.docs.broadcom }}/7/greenplum-database/admin_guide-managing-monitor.html#creating-the-session_level_memory_consumption-view)
Содержит различные внутренние утилиты для {{ GP }}.
| 1.0.0 ||
|| [gp_legacy_string_agg]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-gp_legacy_string_agg.html)
Добавляет функцию `string_agg` с одним аргументом, которая присутствовала в {{ GP }} версии `5`.
| 1.0.0 ||
|| [gp_percentile_agg]({{ gp.docs.broadcom }}/6/greenplum-database/ref_guide-modules-gp_percentile_agg.html)
Добавляет агрегатную функцию для вычисления процентилей.
| 1.0.0 ||
|| [gp_relaccess_stats](https://github.com/open-gpdb/gp_relaccess_stats). Расширение от {{ yandex-cloud }}

Собирает статистику обращений к таблицам и представлениям. Подробнее см. в разделе [Использование gp_relaccess_stats](gp_relaccess_stats.md).
| 1.1 ||
|| [gp_relsizes_stats](https://github.com/open-gpdb/gp_relsizes_stats). Расширение от {{ yandex-cloud }}

Собирает статистику о размере файлов и таблиц. Подробнее см. в разделе [Использование gp_relsizes_stats](./gp-relsizes-stats.md).
| 1.0 ||
|| [gp_sparse_vector]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-gp_sparse_vector.html)
Добавляет разреженные векторы и связанные с ними функции.
| 1.0.1 ||
|| [gp_url_tools](https://github.com/open-gpdb/gp_url_tools). Расширение от {{ yandex-cloud }}

Содержит функции для работы с URL-адресами. Подробнее см. в разделе [Использование gp_url_tools](./gp-url-tools.md).
| 1.0 ||
|| [hstore]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-hstore.html)
Добавляет тип данных для хранения пар «ключ-значение» в одном поле.
| 1.3 ||
|| [intarray]({{ pg.docs.org }}/current/intarray.html)
Добавляет функции, операторы и поддержку индексов для одномерных массивов целых чисел.
| 1.0 ||
|| [isn]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-isn.html)
Добавляет тип данных для работы с международными стандартами идентификации продукции.
| 1.0 ||
|| [ltree]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-ltree.html)
Добавляет тип данных для представления меток данных в иерархической древовидной структуре.
| 1.0 ||
|| [orafce](https://github.com/orafce/orafce)
Добавляет функции и операторы, эмулирующие функции и пакеты Oracle.
| 3.7 ||
|| [pgaudit](https://github.com/open-gpdb/gpdb/tree/OPENGPDB_STABLE/gpcontrib/pgaudit). Расширение от {{ yandex-cloud }}

Добавляет возможность ведения журналов аудита сессий и объектов с использованием стандартной системы логирования {{ PG }}.
| 1.0.9 ||
|| [pgcrypto]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-pgcrypto.html)
Добавляет функции шифрования данных. Подробнее см. в разделе [Использование pgcrypto](./pgcrypto.md).
| 1.1 ||
|| [pg_trgm]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-pg_trgm.html)
Добавляет функции и операторы для определения сходства текста, а также операторы индексации для поиска похожих строк.
| 1.1 ||
|| [plperl]({{ gp.docs.broadcom }}/5/greenplum-database/ref_guide-extensions-pl_perl.html)
Включает поддержку процедурного языка PL/Perl.
| 1.0 ||
|| [plpgsql]({{ gp.docs.broadcom }}/5/greenplum-database/ref_guide-extensions-pl_sql.html)
Включает поддержку процедурного языка PL/pgSQL.
| 1.0 ||
|| [postgis]({{ gp.docs.broadcom }}/5/greenplum-database/ref_guide-extensions-postGIS.html)
Добавляет возможности хранения и обработки объектов геоинформационных систем (ГИС) в базах данных {{ PG }}.
| 2.1.5 ||
|| [postgres_fdw]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-postgres_fdw.html)
Добавляет оболочку для обращений к удаленным базам данных {{ PG }}.
| 1.0 ||
|| [pxf]({{ gp.docs.broadcom }}-platform-extension-framework/6-11/gp-pxf/intro_pxf.html)
Позволяет работать с гетерогенными источниками данных.
| 2.0 ||
|| [sslinfo]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-sslinfo.html)
Позволяет получать информацию о SSL-сертификате подключения.
| 1.0 ||
|| [tablefunc]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-tablefunc.html)
Добавляет табличные функции, которые возвращают наборы строк.
| 1.0 ||
|| [try_convert](https://github.com/open-gpdb/gp_relaccess_stats). Расширение от {{ yandex-cloud }}

Добавляет функцию для преобразования данных из одного типа в другой. Подробнее см. в разделе [Использование try_convert](try_convert.md).
| 1.0 ||
|| [tsearch2]({{ pg.docs.org }}/9.6/tsearch2.html)
Добавляет функции, совместимые с функциями полнотекстового поиска, которые присутствовали в {{ PG }} до версии `8.3`.
| 1.0 ||
|| [unaccent]({{ pg.docs.org }}/current/unaccent.html)
Добавляет словарь для полнотекстового поиска, удаляющий диакритические знаки.
| 1.0 ||
|| uuid-cb. Расширение от {{ yandex-cloud }}

Добавляет возможность генерации и валидации уникальных идентификаторов по требованиям Центробанка РФ. Подробнее см. в разделе [Использование uuid-cb](./uuid-cb.md).
| 1.0 ||
|| [{{ YZ }}](./yezzey.md). Расширение от {{ yandex-cloud }}

Позволяет перемещать [таблицы AO и AOCO](../../concepts/tables.md) из хранилища кластера в холодное хранилище и наоборот. Чтобы использовать это расширение, включите [гибридное хранилище](../../concepts/hybrid-storage.md) в кластере {{ GP }}.
| 1.8 ||
|| [xml2]({{ pg.docs.org }}/current/xml2.html)
Добавляет функции для выполнения запросов XPath и преобразований XSLT.
| 1.0 ||
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

Подробнее см. в [документации {{ GP }}]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-sql_commands-CREATE_EXTENSION.html).

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
