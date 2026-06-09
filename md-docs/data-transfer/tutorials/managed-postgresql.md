# Миграция кластера {{ PG }}

Чтобы перенести вашу базу данных в сервис {{ mpg-full-name }}, нужно непосредственно перенести данные, закрыть старую базу данных на запись и переключить нагрузку на кластер БД в {{ yandex-cloud }}.

{% note warning %}

Пользователи автоматически не переносятся в кластер {{ mpg-name }}. Их нужно [создать](../../managed-postgresql/operations/cluster-users.md#adduser) в новом кластере заново.

{% endnote %}

Миграция с помощью {{ data-transfer-name }} позволяет:

* обойтись без создания промежуточной [виртуальной машины](../../glossary/vm.md) или разрешения доступа к вашему кластеру-приемнику {{ mpg-name }} из интернета;
* минимизировать время недоступности базы данных при миграции;
* мигрировать со старых версий {{ PG }} на более новые.

Подробнее см. в разделе [{#T}](../concepts/use-cases.md).

Чтобы использовать эти способы миграции, разрешите подключение к кластеру-источнику из интернета.

## Перенос данных {#data-transfer}

# Миграция данных с использованием сервиса {{ data-transfer-full-name }} {#data-transfer}



### Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mpg-name }}: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы {{ mpg-name }}](../../managed-postgresql/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных (см. [тарифы {{ data-transfer-name }}](../pricing.md)).


### Перенесите данные {#transfer-data}

1. [Подготовьте кластер-источник](../operations/prepare.md#source-pg).
1. Подготовьте инфраструктуру:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте кластер-приемник {{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md) любой подходящей конфигурации. Включите те же [расширения {{ PG }}](../../managed-postgresql/operations/extensions/cluster-extensions.md), что и в кластере-источнике.
        1. [Подготовьте кластер-приемник](../operations/prepare.md#target-pg).
        1. [Создайте эндпоинт для источника](../operations/endpoint/index.md#create) со следующими параметрами:

             * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `PostgreSQL`.
             * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.connection.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.on_premise.title }}`.

           Укажите параметры подключения к кластеру-источнику.

        1. [Создайте эндпоинт для приемника](../operations/endpoint/index.md#create) со следующими параметрами:

             * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ PG }}`.
             * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTarget.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTarget.connection.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.

           Укажите идентификатор кластера-приемника.

        1. [Создайте трансфер](../operations/transfer.md#create) типа _{{ dt-type-copy-repl }}_, использующий созданные эндпоинты.
        1. [Активируйте трансфер](../operations/transfer.md#activate).

            {% note warning %}

            Избегайте любых изменений в схеме данных в кластере-источнике и кластере-приемнике во время работы трансфера. Подробнее см. в разделе [{#T}](../operations/db-actions.md).

            {% endnote %}

    - {{ TF }} {#tf}

        1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
        1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
        1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
        1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

        1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-pgsql-mpg.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-on-premise-postgresql-to-cloud/blob/main/data-transfer-pgsql-mpg.tf).

            В этом файле описаны:

            * [сеть](../../vpc/concepts/network.md#network);
            * [подсеть](../../vpc/concepts/network.md#subnet);
            * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру;
            * кластер-приемник {{ mpg-name }};
            * эндпоинт для источника;
            * эндпоинт для приемника;
            * трансфер.

        1. Укажите в файле `data-transfer-pgsql-mpg.tf`:

            * [параметры эндпоинта-источника](../operations/endpoint/source/postgresql.md#on-premise);
            * `pg-extensions` – список [расширений {{ PG }}](../../managed-postgresql/operations/extensions/cluster-extensions.md) в кластере-источнике;
            * параметры кластера-приемника, которые используются и как [параметры эндпоинта-приемника](../operations/endpoint/target/postgresql.md#managed-service):

                * `target_pgsql_version` — версия {{ PG }}, она должна быть не ниже, чем в кластере-источнике;
                * `target_user` и `target_password` — имя и пароль пользователя-владельца базы данных.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            1. Выполните команду для просмотра планируемых изменений:
            
               ```bash
               terraform plan
               ```
            
               Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
            
            1. Если вас устраивают планируемые изменения, внесите их:
               1. Выполните команду:
            
                  ```bash
                  terraform apply
                  ```
            
               1. Подтвердите изменение ресурсов.
               1. Дождитесь завершения операции.

            В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

            Трансфер активируется автоматически после создания.

    {% endlist %}

1. Дождитесь перехода трансфера в статус {{ dt-status-repl }}.
1. Снимите пишущую нагрузку с кластера-источника.
1. На странице [мониторинга трансфера](../operations/monitoring.md) дождитесь снижения до нуля характеристики **Maximum data transfer delay**. Это значит, что на кластер-приемник перенесены все изменения, произошедшие в кластере-источнике после завершения копирования данных.
1. Переключите нагрузку на кластер-приемник.
1. [Деактивируйте](../operations/transfer.md#deactivate) трансфер и дождитесь его перехода в статус {{ dt-status-stopped }}.

    Подробнее о статусах трансфера см. в разделе [Жизненный цикл трансфера](../concepts/transfer-lifecycle.md#statuses).


1. Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

    {% list tabs group=instructions %}

    - Ресурсы созданы вручную {#manual}

        1. [Удалите кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).
        1. [Удалите остановленный трансфер](../operations/transfer.md#delete).
        1. [Удалите эндпоинты](../operations/endpoint/index.md#delete) для источника и приемника.

    - Ресурсы созданы с помощью {{ TF }} {#tf}

        1. В терминале перейдите в директорию с планом инфраструктуры.
        
            {% note warning %}
        
            Убедитесь, что в директории нет {{ TF }}-манифестов с ресурсами, которые вы хотите сохранить. {{ TF }} удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
        
            {% endnote %}
        
        1. Удалите ресурсы:
        
            1. Выполните команду:
        
                ```bash
                terraform destroy
                ```
        
            1. Подтвердите удаление ресурсов и дождитесь завершения операции.
        
            Все ресурсы, которые были описаны в {{ TF }}-манифестах, будут удалены.

    {% endlist %}


## Упрощенный перенос данных в новый кластер {#quick-transfer}

После создания кластера {{ mpg-name }} вы можете сразу перенести в него данные из другого кластера {{ mpg-name }} или пользовательской инсталляции базы данных.

При таком способе миграции:

* Трансфер и эндпоинты создаются автоматически.
* С источника на приемник однократно переносится снапшот данных.

### Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mpg-name }}: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы {{ mpg-name }}](../../managed-postgresql/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных (см. [тарифы {{ data-transfer-name }}](../pricing.md)).

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

   {% note warning %}
   
   Чтобы использовать подключение из {{ connection-manager-name }}, у пользователя должны быть [права доступа](../../metadata-hub/operations/connection-access.md) не ниже `connection-manager.user` к этому подключению.
   
   {% endnote %}

1. Задайте настройки приемника:

    * **Идентификатор подключения** — выберите подключение {{ connection-manager-name }}.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — укажите имя БД в кластере-приемнике.

1. (Опционально) Задайте дополнительные настройки:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTarget.cleanup_policy.title }}** — выберите способ очистки данных в базе-приемнике:

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}` — полное удаление таблиц, участвующих в трансфере (вариант по умолчанию).

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}` — удалить только данные из таблиц, участвующих в трансфере, но оставить схему.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTableFilter.include_tables.title }}** — будут передаваться данные только из таблиц этого списка.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTableFilter.exclude_tables.title }}** — данные таблиц из этого списка передаваться не будут.

      Списки включают имя [схемы]({{ pg-docs }}/ddl-schemas.html) (описание содержания, структуры и ограничений целостности базы данных) и имя таблицы. Для обоих списков поддерживаются выражения вида:

      * `<имя_схемы>.<имя_таблицы>` — полное имя таблицы;
      * `<имя_схемы>.*` — все таблицы в указанной схеме.

      Имена таблиц должны соответствовать регулярному выражению:

      ```text
      ^"?[-_a-zA-Z0-9.]+"?\\."?[$-_a-zA-Z0-9.*]+"?$
      ```

      Двойные кавычки внутри имени таблицы не поддерживаются. Внешние кавычки используются только как разделители и будут удалены при обработке путей.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.object_transfer_settings.title }}** — выберите элементы схемы БД, которые будут перенесены в процессе активации или деактивации трансфера.

1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**, чтобы создать трансфер и эндпоинты.

1. [Активируйте](../operations/transfer.md#activate) трансфер.

1. Дождитесь перехода трансфера в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.

1. Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

    1. [Удалите кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md), если данные переносились из него.
    1. [Удалите трансфер](../operations/transfer.md#delete).
    1. [Удалите эндпоинты](../operations/endpoint/index.md#delete) для источника и приемника.
  

## Перенос таблиц с типами данных из расширений {{ PG }}

Сервис {{ data-transfer-name }} поддерживает копирование таблиц, содержащих столбцы с типами данных, определенных в расширениях {{ PG }}, а также копирование таблиц с производными типами (массивами таких типов и композитными типами с полями таких типов). Однако на данный момент есть ограничение — тип данных должен реализовывать __функции двоичного ввода и вывода__. То есть, для типа данных в системной таблице [pg_type](https://www.postgresql.org/docs/current/catalog-pg-type.html) значения в колонках `typsend` и `typreceive` должны быть отличны от нуля.

Например, для расширения [PostGIS](https://postgis.net/) перенос колонок с типами [`GEOMETRY`](https://postgis.net/docs/geometry.html), [`GEOMETRY_DUMP`](https://postgis.net/docs/geometry_dump.html) и [`GEOGRAPHY`](https://postgis.net/docs/geography.html) поддержан, а перенос типов [`BOX2D`](https://postgis.net/docs/box2d_type.html) и [`BOX3D`](https://postgis.net/docs/box3d_type.html) на данный момент не поддержан.

## См. также {#see-also}

Другие способы миграции описаны в [документации {{ mpg-full-name }}](../../managed-postgresql/tutorials/data-migration.md).