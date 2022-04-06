# Управление {{ PG }}-расширениями

{{ mpg-short-name }} поддерживает многие стандартные расширения {{ PG }} и некоторые нестандартные. Полный список доступных расширений [приведен ниже](#postgresql).

{% note warning %}

В кластерах {{ mpg-short-name }} нельзя управлять расширениями {{ PG }} с помощью команд SQL.

{% endnote %}

## Подключение библиотек для расширений {#libraries-connection}

Некоторые расширения требуют подключения библиотек общего пользования (shared libraries). Чтобы подключить библиотеку, при [создании](cluster-create.md) или [изменении](update.md#change-postgresql-config) кластера укажите ее имя в [параметре Shared preload libraries](../concepts/settings-list#setting-shared-libraries).

{{ mpg-short-name }} поддерживает подключение библиотек:

* `auto_explain` — необходима для работы [расширения auto_explain]({{ pg-docs }}/auto-explain.html);
* `pg_hint_plan` — необходима для работы [расширения pg_hint_plan](https://pghintplan.osdn.jp/pg_hint_plan.html);
* `pg_qualstats` — необходима для работы [расширения pg_qualstats](https://github.com/powa-team/pg_qualstats);
* `timescaledb` — необходима для использования [расширения TimescaleDB](https://github.com/timescale/timescaledb).

## Получить список установленных расширений {#list-extensions}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
  1. Нажмите на имя нужного кластера и выберите блок **Базы данных**.
  1. В колонке **Расширения PostgreSQL** будет отображаться список расширений, подключенных к каждой базе данных.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список расширений для базы данных, выполните команду:

  ```bash
  {{ yc-mdb-pg }} database get <имя базы данных> \
     --cluster-name <имя кластера>
  ```

  Включенные расширения будут перечислены в списке `extensions`.

- API

  Получить список расширений для базы данных кластера можно с помощью метода [get](../api-ref/Database/get.md).

{% endlist %}

## Изменить список установленных расширений {#update-extensions}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Базы данных**.
  1. В строке с нужной базой данных нажмите значок ![options](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Настроить расширения PostgreSQL**.
  1. Выберите необходимые расширения и нажмите кнопку **Изменить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить расширения для базы данных, передайте их список в аргументе `--extensions` команды CLI. При этом расширения, не упомянутые в списке, будут выключены.

  ```bash
  {{ yc-mdb-pg }} database update <имя базы данных> \
     --cluster-name <имя кластера>
     --extensions <имя расширения>=<версия>,<имя расширения>=<версия>...
  ```

  {% note info %}

  Версия расширения не учитывается при обработке команды — в качестве версии можно передать любую непустую строку.

  {% endnote %}

- Terraform

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

     Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

  1. Добавьте к описанию кластера {{ mpg-name }} один или несколько блоков `extension` в секции `database`, соответствующей нужной базе данных (по одному блоку на каждое расширение):
  
      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя кластера>" {
        ...
        database {
          ...
          extension {
            name    = "<имя расширения>"
            version = "<версия расширения>"
          }
          ...
        }
        ...
      ```

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform-timeouts.md) %}

- API

  Передать новый список расширений для базы данных можно с помощью метода [update](../api-ref/Database/update.md).

{% endlist %}

## Поддерживаемые расширения {{ PG }} {#postgresql}

Полный список поддерживаемых расширений:

* [address_standardizer](https://postgis.net/docs/manual-3.1/postgis_installation.html#installing_pagc_address_standardizer) {#ext-address_standardizer}

    Содержит функции для нормализации почтовых адресов, переданных в виде строки.

* [address_standardizer_data_us](https://postgis.net/docs/manual-3.1/postgis_installation.html#make_install_postgis_extensions) {#ext-address_standardizer_data_us}

    Содержит правила нормализации почтовых адресов США и Канады для расширения [address_standardizer](#ext-address_standardizer).

* [amcheck]({{ pg-docs }}/amcheck.html) {#ext-amcheck}

    Содержит функции проверки логической согласованности реляционной структуры баз данных.

    Для использования расширения необходима [роль `mdb_admin`](../concepts/roles.md#mdb-admin).

* [autoinc]({{ pg-docs }}/contrib-spi.html#id-1.11.7.47.6) {#ext-autoinc}

    Содержит функцию `autoinc()`. Она возвращает следующее значение для последовательности, хранящейся в поле целочисленного типа. В отличие от встроенных типов, управляющих последовательностями, `autoinc()`:
	
    * блокирует попытки вставить в поле значение из запроса;
    * позволяет изменять значение в поле при обновлении записи.

* [bloom]({{ pg-docs }}/static/bloom.html) {#ext-bloom}

    Добавляет доступ к индексам баз данных на основе [фильтров Блума]({% if lang == "ru" %}https://ru.wikipedia.org/wiki/Фильтр_Блума{% endif %}{% if lang == "en" %}https://en.wikipedia.org/wiki/Bloom_filter{% endif %}). Эти вероятностные структуры данных требуют значительно меньше памяти, чем хеш-таблицы, но допускают ложноположительные срабатывания.

* [btree_gin]({{ pg-docs }}/static/btree-gin.html) {#ext-btree-gin}

    Содержит примеры классов оператора GIN (Generalized Inverted Index, обобщенный инвертированный индекс), используемого для обратного поиска.

* [btree_gist]({{ pg-docs }}/static/btree-gist.html) {#ext-btree-gist}

    Содержит классы оператора GiST (Generalized Search Tree, обобщенное дерево поиска). В отличие от индексов B-tree, GiST поддерживает операторы `<>` (<q>не равно</q>) и `<->` (<q>дистанция</q>), хотя и не обеспечивает уникальности возвращаемых значений.

* [citext]({{ pg-docs }}/static/citext.html) {#ext-citext}

    Содержит тип данных `citext`, используемый для регистронезависимой работы со строками.

* [clickhouse_fdw](https://github.com/adjust/clickhouse_fdw) {#ext-ch-fdw}

    Добавляет поддержку [Foreign Data Wrapper](https://wiki.postgresql.org/wiki/Foreign_data_wrappers) для доступа к базам данных {{ CH }}, поддерживает операции `SELECT FROM` и `INSERT INTO`.

* [cube]({{ pg-docs }}/static/cube.html) {#ext-cube}

    Содержит тип данных `cube`, используемый для представления многомерных кубов.

* [dblink]({{ pg-docs }}/static/dblink.html) {#ext-dblink}

    Добавляет поддержку подключения к другим базам данных {{ PG }} из текущей сессии.

    Для использования расширения необходима [роль `mdb_admin`](../concepts/roles.md#mdb-admin).

* [dict_int]({{ pg-docs }}/static/dict-int.html) {#ext-dict-int}

    Содержит пример дополнительного шаблона словаря для полнотекстового поиска. Использование шаблона позволяет избежать разрастания списка уникальных слов и увеличивает скорость поиска.

* [dict_xsyn]({{ pg-docs }}/static/dict-xsyn.html) {#ext-dict-xsyn}

    Содержит пример дополнительного шаблона словаря синонимов (Extended Synonym Dictionary) для полнотекстового поиска: при поиске слова будут найдены также все его синонимы.

* [earthdistance]({{ pg-docs }}/static/earthdistance.html) {#ext-earthdistance}

    Содержит модуль для вычисления расстояний между точками на поверхности Земли. Вычисление расстояния производится двумя способами:

    * через тип данных `cube` (требует включения расширения [cube](#ext-cube));
    * через встроенный тип данных `point`.

* [fuzzystrmatch]({{ pg-docs }}/fuzzystrmatch.html) {#ext-fuzzystrmatch}

    Содержит функции, используемые для определения сходства и различия строк.

* [hstore]({{ pg-docs }}/static/hstore.html) {#ext-hstore}

    Содержит тип `hstore`, позволяющий хранить пары <q>ключ:значение</q> в одном поле таблицы и эффективно работать с ними.

* [hypopg](https://hypopg.readthedocs.io/en/rel1_stable/) {#ext-hypopg}

    Содержит виртуальные индексы. Они позволяют с минимальными затратами ресурсов выяснить, будет ли {{ PG }} использовать реальные индексы при обработке [проблемных запросов](../tutorials/profiling.md#solving-inefficient-queries).

* [intarray]({{ pg-docs }}/static/intarray.html) {#ext-intarray}

    Содержит функции и операторы для работы с массивами целых чисел, в которых нет пустых (`NULL`) значений.

* [isn]({{ pg-docs }}/static/isn.html) {#ext-isn}

    Содержит типы данных для международных стандартов нумерации продукции EAN13, UPC, ISBN, ISMN и ISSN. Проверка и формирование номеров осуществляется по заданному списку префиксов.

* [jsquery](https://github.com/postgrespro/jsquery) {#ext-jsquery}

    Добавляет поддержку языка JsQuery, используемого для работы с данными типа `jsonb`. JsQuery позволяет организовать эффективный поиск во вложенных объектах и содержит дополнительные операторы сравнения с поддержкой индексов.

* [lo]({{ pg-docs }}/static/lo.html) {#ext-lo}

    Содержит тип данных `lo` и функцию `lo_manage()`. Они используются для управления большими бинарными объектами (Binary Large Object, BLOB) в соответствии с требованиями спецификаций драйверов JDBC и ODBC (стандартное поведение {{ PG }} им не соответствует).

* [ltree]({{ pg-docs }}/static/ltree.html) {#ext-ltree}

    Содержит тип данных `ltree` для представления меток данных, хранящихся в древовидной иерархической структуре.

* [moddatetime]({{ pg-docs }}/static/contrib-spi.html#id-1.11.7.47.8) {#ext-moddatetime}

    Содержит функцию `moddatetime()`, позволяющую отслеживать время последней модификации строки таблицы.

* [oracle_fdw](https://github.com/laurenz/oracle_fdw) {#ext-oracle_fdw}

    Добавляет поддержку [Foreign Data Wrapper](https://wiki.postgresql.org/wiki/Foreign_data_wrappers) для доступа к базам данных Oracle.

    Для использования расширения необходима [роль `mdb_admin`](../concepts/roles.md#mdb-admin).

* [orafce](https://github.com/orafce/orafce) {#ext-orafce}

    Добавляет функции и операторы, которые эмулируют набор функций и пакетов БД Oracle.

* [pg_buffercache]({{ pg-docs }}/pgbuffercache.html) {#ext-pg_buffercahce}

    Добавляет функции мониторинга общего буферного кеша.

    Для использования расширения необходима [роль `mdb_admin`](../concepts/roles.md#mdb-admin).

* [pg_hint_plan](http://pghintplan.osdn.jp/) {#ext-pg_hint_plan}

    Содержит функции для управления планировщиком {{ PG }}.

    Требует [подключения библиотеки общего пользования](#libraries-connection) `pg_hint_plan`.

* [pg_partman](https://github.com/pgpartman/pg_partman) {#ext-pg_partman}

    Добавляет расширенные возможности по партицированию таблиц, в том числе на основе времени или последовательности.

* [pg_qualstats](https://github.com/powa-team/pg_qualstats) {#ext-pg_qualstats}

    Добавляет возможность сбора статистики по предикатам в выражениях `WHERE` и предложениях `JOIN`.

    Требует [подключения библиотеки общего пользования](#libraries-connection) `pg_qualstats`.

* [pg_repack](http://reorg.github.io/pg_repack/) {#ext-pg_repack}

    Содержит функции для удаления раздувания (bloat) из таблиц и индексов. В отличие от `CLUSTER` и `VACUUM FULL`, не требует эксклюзивной блокировки таблиц.

    Для использования расширения необходима [роль `mdb_admin`](../concepts/roles.md#mdb-admin).

* [pg_stat_kcache](https://github.com/powa-team/pg_stat_kcache) {#ext-pg_stat_kcache}

    Добавляет возможность сбора статистики по операциям чтения и записи, выполненным на уровне файловой системы.

    Требует включения расширения [pg_stat_statements](#ext-pg_stat_statements).

    Для использования расширения необходима [роль `mdb_admin`](../concepts/roles.md#mdb-admin).

* [pg_stat_statements]({{ pg-docs }}/pgstatstatements.html) {#ext-pg_stat_statements}

    Добавляет возможности отслеживания планирования и сбора статистики выполнения всех SQL-запросов, запущенных в кластере.

* [pg_trgm]({{ pg-docs }}/static/pgtrgm.html) {#ext-pg_trgm}

    Содержит инструменты для быстрого поиска похожих строк на основе сопоставления триграмм.

* [pgcompacttable](https://github.com/dataegret/pgcompacttable) {#ext-pgcompacttable}

    Позволяет реорганизовать данные в таблицах, чтобы уменьшить занимаемый ими объем, без влияния на производительность кластера.

    Синтаксис использования:

    ```bash
    ./bin/pgcompacttable -h c-<идентификатор кластера>.rw.{{ dns-zone }} -p 6432 -U <имя пользователя> -W <пароль> -d <имя БД> -n <имя схемы> -t <имя таблицы>
    ```

    Требует включения расширения [pgstattuple](#ext-pgstattuple).

    Для использования расширения необходима [роль `mdb_admin`](../concepts/roles.md#mdb-admin).

* [pgcrypto]({{ pg-docs }}/static/pgcrypto.html) {#ext-pgcrypto}

    Содержит криптографические функции.

* [pgrouting](http://pgrouting.org/) {#ext-pgrouting}

    Содержит функции для геопространственной маршрутизации базы данных [PostGIS](https://www.postgis.net/).

* [pgrowlocks]({{ pg-docs }}/static/pgrowlocks.html) {#ext-pgrowlocks}

    Содержит функцию `pgrowlocks()`, которая возвращает сведения о блокировке строк в указанной таблице.

* [pgstattuple]({{ pg-docs }}/pgstattuple.html) {#ext-pgstattuple}

    Содержит функции для получения статистики на уровне кортежей.

    Для использования расширения необходима [роль `mdb_admin`](../concepts/roles.md#mdb-admin).

* [plv8](https://plv8.github.io/) {#ext-plv8}

    Добавляет поддержку процедурного языка основе Javascript и движка V8.

* [postgis](https://postgis.net/docs/) {#ext-postgis}

    Добавляет возможности хранения и обработки объектов геоинформационных систем (ГИС) в базах данных {{ PG }}.

* [postgis_tiger_geocoder](https://postgis.net/docs/postgis_installation.html#loading_extras_tiger_geocoder) {#ext-postgis_tiger_geocoder}

    Содержит функции для геокодирования на основе данных в формате [TIGER](https://wiki.openstreetmap.org/wiki/TIGER).

* [postgis_topology](https://postgis.net/docs/Topology.html) {#ext-postgis_topology}

    Содержит типы данных и функции расширения [postgis](#ext-postgis) для управления топологическими объектами.

* [postgres_fdw]({{ pg-docs }}/static/postgres-fdw.html) {#ext-postgres_fdw}

    Добавляет поддержку [Foreign Data Wrapper](https://wiki.postgresql.org/wiki/Foreign_data_wrappers) для доступа к внешним серверам {{ PG }}.

    Для использования расширения необходима [роль `mdb_admin`](../concepts/roles.md#mdb-admin).

* [rum](https://github.com/postgrespro/rum) {#ext-rum}

    Добавляет метод доступа для работы с индексами `RUM`.

* [seg]({{ pg-docs }}/static/seg.html) {#ext-seg}

    Содержит тип данных `seg` для представления отрезков линий или интервалов с плавающей запятой.

* [smlar](http://sigaev.ru/git/gitweb.cgi?p=smlar.git;a=blob;hb=HEAD;f=README) {#ext-smlar}

    Содержит набор функций для определения сходства массивов.

* [tablefunc](https://www.postgresql.org/docs/current/static/tablefunc.html) {#ext-tablefunc}

    Содержит набор функций, возвращающих таблицы (наборы строк).

* [timescaledb](https://github.com/timescale/timescaledb) {#ext-timescaledb}

    Добавляет возможности автоматического партицирования таблиц по времени и пространству (ключу партицирования), сохраняя при этом стандартный интерфейс {{ PG }} для работы с данными. Это позволяет масштабировать {{ PG }} для обработки временных рядов.

    Требует [подключения библиотеки общего пользования](#libraries-connection) `timescaledb`.

* [unaccent]({{ pg-docs }}/static/unaccent.html) {#ext-unaccent}

    Содержит словарь для поиска текста без учета диакритических знаков.

* [uuid-ossp]({{ pg-docs }}/static/uuid-ossp.html) {#ext-uuid-ossp}

    Содержит функции для генерации UUID по стандартным алгоритмам.

* [xml2]({{ pg-docs }}/static/xml2.html) {#ext-xml2}

    Добавляет поддержку запросов XPath и языка XSLT.
