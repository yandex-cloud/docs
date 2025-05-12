# Управление расширениями {{ GP }}

{{ mgp-short-name }} поддерживает некоторые расширения {{ GP }}. См. [полный список доступных расширений и их версий](#greenplum).

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

## Поддерживаемые расширения {{ GP }} {#greenplum}

#|
|| **Расширение** | **Версия** ||
|| [citext]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-citext.html)
Добавляет тип данных для сравнения строк без учета регистра.
| 1.0 ||
|| [dblink]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-dblink.html)
Включает поддержку подключений к другим базам данных {{ GP }} в рамках сессии.
| 1.1  ||
|| [diskquota]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-diskquota.html)
Позволяет ограничивать размер дискового пространства для схем и ролей в базе данных.
| 1.0 ||
|| [fuzzystrmatch]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-fuzzystrmatch.html)
Содержит функции для определения степени подобия и расстояния между двумя произвольными строками.
| 1.0 ||
|| [gp_internal_tools]({{ gp.docs.broadcom }}/7/greenplum-database/admin_guide-managing-monitor.html#creating-the-session_level_memory_consumption-view)
Содержит различные внутренние утилиты для {{ GP }}.
| 1.0.0 ||
|| [gp_url_tools](https://github.com/open-gpdb/gp_url_tools)
Содержит функции для работы с URL-адресами. Подробнее см. в разделе [Использование gp_url_tools](./gp-url-tools.md).
| 1.0 ||
|| [hstore]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-hstore.html)
Добавляет тип данных для хранения пар <q>ключ-значение</q> в одном поле.
| 1.3 ||
|| [pgcrypto]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-modules-pgcrypto.html)
Добавляет функции шифрования данных. Подробнее см. в разделе [Использование pgcrypto](./pgcrypto.md).
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
|| uuid-cb
Добавляет возможность генерации и валидации уникальных идентификаторов по требованиям Центробанка РФ. Подробнее см. в разделе [Использование uuid-cb](./uuid-cb.md).
| 1.0 ||
|| [{{ YZ }}](./yezzey.md). Расширение от {{ yandex-cloud }}

Позволят перемещать [таблицы AO и AOCO](../../concepts/tables.md) из хранилища кластера в холодное хранилище и наоборот. Чтобы использовать это расширение, включите [гибридное хранилище](../../concepts/hybrid-storage.md) в кластере {{ mgp-name }}.
| 1.8 ||
|#

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
