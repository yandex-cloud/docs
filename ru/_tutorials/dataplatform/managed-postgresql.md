# Миграция кластера {{ PG }}

Чтобы перенести вашу базу данных в сервис {{ mpg-full-name }}, нужно непосредственно перенести данные, закрыть старую базу данных на запись и переключить нагрузку на кластер БД в {{ yandex-cloud }}.

{% note warning %}

Пользователи автоматически не переносятся в кластер {{ mpg-name }}. Их нужно [создать](../../managed-postgresql/operations/cluster-users.md#adduser) в новом кластере заново.

{% endnote %}

Миграция с помощью {{ data-transfer-name }} позволяет:

* обойтись без создания промежуточной [виртуальной машины](../../glossary/vm.md) или разрешения доступа к вашему кластеру-приемнику {{ mpg-name }} из интернета;
* минимизировать время недоступности базы данных при миграции;
* мигрировать со старых версий {{ PG }} на более новые.

Подробнее см. в разделе [{#T}](../../data-transfer/concepts/use-cases.md).

Чтобы использовать эти способы миграции, разрешите подключение к кластеру-источнику из интернета.

## Перенос данных {#data-transfer}

{% include notitle [MPG moving data with Data Transfer](datatransfer/managed-postgresql.md) %}


## Упрощенный перенос данных в новый кластер {#quick-transfer}

После создания кластера {{ mpg-name }} вы можете сразу перенести в него данные из другого кластера {{ mpg-name }} или пользовательской инсталляции базы данных.

При таком способе миграции:

  * Трансфер и эндпоинты создаются автоматически.
  * С источника на приемник однократно переносится снапшот данных.

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ mpg-name }}: использование хостов БД и дискового пространства (см. [тарифы {{ mpg-name }}](../../managed-postgresql/pricing.md)).
* Плата за использование публичных IP-адресов (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).
* Плата за трансфер: использование вычислительных ресурсов и количество переданных строк данных (см. [тарифы {{ data-transfer-name }}](../../data-transfer/pricing.md)).

### Перенесите данные {#transfer-data-quickly}

1. Откройте страницу **{{ ui-key.yacloud.mdb.cluster.overview.label_title }}** нового кластера {{ mpg-name }}.
1. В верхней части экрана нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.title_migration-alert-action }}**.
1. Задайте настройки источника:

    {% list tabs %}

    - Пользовательская инсталляция

      * **Подключение**:

          * **Выбрать существующее** — выберите, чтобы использовать существующее подключение.

            * **Идентификатор подключения** — выберите подключение [{{ connection-manager-full-name }}](../../metadata-hub/quickstart/connection-manager.md).
            
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — введите имя БД.
          
          * **Создать новое** — выберите, чтобы создать новое подключение.

            * **Хосты** — укажите IP-адрес или FQDN хоста-мастера. Если на хостах открыты разные порты для подключения, то вы можете задать несколько значений хостов в формате `хост:порт`, при этом значение поля **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.port.title }}** не будет учитываться.

            * **Имя пользователя** — введите имя пользователя для подключения к БД.

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}** — введите пароль для доступа к БД.

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — введите имя БД.

            * **TLS** — включите, чтобы использовать TLS-соединение.

              * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.ca_certificate.title }}** — добавьте содержимое файла сертификата.
      
    - Кластер {{ mpg-name }}

      * **Подключение**:

        * **Выбрать существующее** — выберите, чтобы использовать существующее подключение.

          * **Идентификатор кластера** — выберите кластер, к которому необходимо подключиться.

          * **Идентификатор подключения** — выберите подключение [{{ connection-manager-full-name }}](../../metadata-hub/quickstart/connection-manager.md).

          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — укажите имя БД в выбранном кластере.

        * **Создать новое** — выберите, чтобы создать новое подключение.

          * **Идентификатор кластера** — выберите кластер, к которому необходимо подключиться.

          * **Имя пользователя** — введите имя пользователя для подключения к БД кластера.

          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}** — введите пароль пользователя для доступа к БД кластера.

          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — укажите имя БД в выбранном кластере.

    {% endlist %}

   {% include [connection-manager-access](../../_includes/data-transfer/notes/connection-manager-access.md) %}

1. Задайте настройки приемника:

    * **Идентификатор подключения** — выберите подключение {{ connection-manager-name }}.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — укажите имя БД в кластере-приемнике.

1. (Опционально) Задайте дополнительные настройки:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTarget.cleanup_policy.title }}** — выберите способ очистки данных в базе-приемнике:

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}` — полное удаление таблиц, участвующих в трансфере (вариант по умолчанию).

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}` — удалить только данные из таблиц, участвующих в трансфере, но оставить схему.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTableFilter.include_tables.title }}** — будут передаваться данные только из таблиц этого списка.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTableFilter.exclude_tables.title }}** — данные таблиц из этого списка передаваться не будут.

      Списки включают имя [схемы]({{pg-docs}}/ddl-schemas.html) (описание содержания, структуры и ограничений целостности базы данных) и имя таблицы. Для обоих списков поддерживаются выражения вида:

      * `<имя_схемы>.<имя_таблицы>` — полное имя таблицы;
      * `<имя_схемы>.*` — все таблицы в указанной схеме.

      Имена таблиц должны соответствовать регулярному выражению:

      ```text
      ^"?[-_a-zA-Z0-9.]+"?\\."?[$-_a-zA-Z0-9.*]+"?$
      ```

      Двойные кавычки внутри имени таблицы не поддерживаются. Внешние кавычки используются только как разделители и будут удалены при обработке путей.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.object_transfer_settings.title }}** — выберите элементы схемы БД, которые будут перенесены в процессе активации или деактивации трансфера.

1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**, чтобы создать трансфер и эндпоинты.

1. [Активируйте](../../data-transfer/operations/transfer.md#activate) трансфер.

1. Дождитесь перехода трансфера в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.

1. Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

    * [Удалите кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md), если данные переносились из него.
    * [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
    * [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.
  

## Перенос таблиц с типами данных из расширений {{ PG }}

Сервис {{ data-transfer-name }} поддерживает копирование таблиц, содержащих столбцы с типами данных, определенных в расширениях {{ PG }}, а также копирование таблиц с производными типами (массивами таких типов и композитными типами с полями таких типов). Однако на данный момент есть ограничение — тип данных должен реализовывать __функции двоичного ввода и вывода__. То есть, для типа данных в системной таблице [pg_type](https://www.postgresql.org/docs/current/catalog-pg-type.html) значения в колонках `typsend` и `typreceive` должны быть отличны от нуля.

Например, для расширения [PostGIS](https://postgis.net/) перенос колонок с типами [`GEOMETRY`](https://postgis.net/docs/geometry.html), [`GEOMETRY_DUMP`](https://postgis.net/docs/geometry_dump.html) и [`GEOGRAPHY`](https://postgis.net/docs/geography.html) поддержан, а перенос типов [`BOX2D`](https://postgis.net/docs/box2d_type.html) и [`BOX3D`](https://postgis.net/docs/box3d_type.html) на данный момент не поддержан.

## См. также {#see-also}

Другие способы миграции описаны в [документации {{ mpg-full-name }}](../../managed-postgresql/tutorials/data-migration.md).
