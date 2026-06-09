# Передача данных из эндпоинта-источника {{ GP }}


С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные из базы {{ GP }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных {{ GP }}](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](../../../troubleshooting/index.md) по их устранению.

## Сценарии передачи данных из {{ GP }} {#scenarios}

1. Миграция — перенос данных из одного хранилища в другое. Часто это перенос базы из устаревших локальных баз в управляемые облачные.

    * [Миграция кластера {{ GP }}](../../../tutorials/managed-greenplum.md).

1. Загрузка данных в витрины — процесс трансфера подготовленных данных в хранилища с целью последующей визуализации.

    * [Загрузка данных из {{ GP }} в витрину {{ CH }}](../../../tutorials/greenplum-to-clickhouse.md);
    * [Загрузка данных из {{ GP }}  в витрину {{ PG }}](../../../tutorials/greenplum-to-postgresql.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} читайте в разделе [Практические руководства](../../../tutorials/index.md).

## Подготовка базы данных {{ GP }} {#prepare}

{% note info %}

Данные, хранящиеся в `MATERIALIZED VIEW`, не переносятся. Для переноса данных из `MATERIALIZED VIEW` создайте обыкновенный `VIEW`, ссылающийся на переносимый `MATERIALIZED VIEW`.

{% endnote %}

{% list tabs %}

- {{ mgp-name }}

    
    1. Создайте пользователя, от имени которого трансфер подключится к источнику. Для этого выполните команду:
    
        ```pgsql
        CREATE ROLE <имя_пользователя> LOGIN ENCRYPTED PASSWORD '<пароль>';
        ```

    1. Настройте кластер-источник так, чтобы созданный пользователь мог подключаться ко всем [хостам-мастерам](../../../../managed-greenplum/concepts/index.md) кластера.
    
    1. Если предполагается использовать [параллельное копирование](../../../concepts/sharded.md), настройте кластер-источник так, чтобы созданный пользователь мог подключаться ко всем [хостам-сегментам](../../../../managed-greenplum/concepts/index.md) кластера в режиме прямого доступа (utility mode). Для этого убедитесь, что для кластера включена настройка "Доступ из {{ data-transfer-name }}".
    
    1. Выдайте созданному пользователю привилегию на выполнение операции `SELECT` над таблицами, которые переносит трансфер, и привилегию `USAGE` на схемы, в которых находятся эти таблицы.
    
       Привилегии должны быть выданы на таблицы целиком, доступ только к части столбцов таблицы не поддерживается.
    
       Таблицы, для которых не выданы необходимые привилегии, недоступны для {{ data-transfer-name }}. Эти таблицы обрабатываются так же, как если бы они отсутствовали.
    
       В этом примере привилегии выдаются на все таблицы в выбранной схеме:
    
        ```pgsql
        GRANT SELECT ON ALL TABLES IN SCHEMA <название_схемы> TO <имя_пользователя>;
        GRANT USAGE ON SCHEMA <название_схемы> TO <имя_пользователя>;
        ```

- {{ GP }}
    
    1. Если вы не планируете использовать для подключения к внешнему кластеру [сервис {{ interconnect-name }}](../../../../interconnect/concepts/index.md) или [VPN](../../../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом {{ data-transfer-name }}](../../../../overview/concepts/public-ips.md#virtual-private-cloud}).
       
       Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../../../concepts/network.md#source-external).
    
    1. Создайте пользователя, от имени которого трансфер подключится к источнику. Для этого выполните команду:
    
        ```pgsql
        CREATE ROLE <имя_пользователя> LOGIN ENCRYPTED PASSWORD '<пароль>';
        ```

    1. Настройте кластер-источник так, чтобы созданный пользователь мог подключаться ко всем [хостам-мастерам](../../../../managed-greenplum/concepts/index.md) кластера.
    
    1. Если предполагается использовать [параллельное копирование](../../../concepts/sharded.md), настройте кластер-источник так, чтобы созданный пользователь мог подключаться ко всем [хостам-сегментам](../../../../managed-greenplum/concepts/index.md) кластера в режиме прямого доступа (utility mode).
    
    1. Выдайте созданному пользователю привилегию на выполнение операции `SELECT` над таблицами, которые переносит трансфер, и привилегию `USAGE` на схемы, в которых находятся эти таблицы.
    
       Привилегии должны быть выданы на таблицы целиком, доступ только к части столбцов таблицы не поддерживается.
    
       Таблицы, для которых не выданы необходимые привилегии, недоступны для {{ data-transfer-name }}. Эти таблицы обрабатываются так же, как если бы они отсутствовали.
    
       В этом примере привилегии выдаются на все таблицы базы данных:
    
        ```pgsql
        GRANT SELECT ON ALL TABLES IN SCHEMA <название_схемы> TO <имя_пользователя>;
        GRANT USAGE ON SCHEMA <название_схемы> TO <имя_пользователя>;
        ```

{% endlist %}

{{ data-transfer-name }} взаимодействует с {{ GP }} по-разному в зависимости от настроек трансфера и содержимого кластера-источника. Подробная информация доступна в разделе [настройка эндпоинта-источника {{ GP }}](greenplum.md).

## Настройка эндпоинта-источника {{ GP }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mgp-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).


### Кластер {{ mgp-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.mgp.viewer }}`](../../../../managed-greenplum/security/index.md#mgp-viewer) или примитивная [роль `viewer`](../../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение к БД с указанием кластера в {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите вариант подключения к базе данных:
    
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}** — позволяет задать настройки подключения вручную.
    
        Выберите тип инсталляции **Кластер Managed Service for Greenplum** и задайте настройки:
    
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}** — выберите кластер, к которому необходимо подключиться.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}** — укажите имя базы данных в выбранном кластере.      
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}** — укажите пароль пользователя для доступа к базе данных.
    
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}** — позволяет подключиться к кластеру через [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):
    
        * Выберите каталог, в котором находится кластер {{ mgp-name }}.
        * Выберите тип инсталляции **Кластер управляемой БД** и задайте настройки:
    
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.mdb_cluster_id.title }}** — выберите кластер, к которому необходимо подключиться.      
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}** — выберите подключение в {{ connection-manager-name }} или создайте его.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}** — укажите имя базы данных в выбранном кластере.
    
        {% note warning %}
        
        Чтобы использовать подключение из {{ connection-manager-name }}, у пользователя должны быть [права доступа](../../../../metadata-hub/operations/connection-access.md) не ниже `connection-manager.user` к этому подключению.
        
        {% endnote %}
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.
    
      Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).

{% endlist %}


### Пользовательская инсталляция {#on-premise}

Подключение к БД с явным указанием сетевых адресов и портов.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите вариант подключения к базе данных:
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}** — позволяет задать настройки подключения вручную:
    
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.OnPremiseGreenplum.primary_host.title }}** — укажите IP-адрес или FQDN первичного хоста-мастера, к которому необходимо подключиться.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.OnPremiseGreenplum.primary_port.title }}** — укажите номер порта, который {{ data-transfer-name }} будет использовать для подключения к первичному хосту-мастеру.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.OnPremiseGreenplum.mirror_host.title }}** — укажите IP-адрес или FQDN резервного хоста-мастера, к которому необходимо подключиться (оставьте поле пустым, если в вашем кластере только один хост-мастер).
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.OnPremiseGreenplum.mirror_port.title }}** — укажите номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения к резервному хосту-мастеру (оставьте поле пустым, если в вашем кластере только один хост-мастер).
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.OnPremiseGreenplum.segments.title }}** — укажите данные для подключения к хостам-сегментам. Если их не указать, то адреса хостов-сегментов будут получены автоматически из служебной таблицы хоста-мастера.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.OnPremiseGreenplum.ca_certificate.title }}** — загрузите файл [сертификата](../../../../managed-greenplum/operations/connect/index.md#get-ssl-cert) или добавьте его содержимое в текстовом виде, если требуется шифрование передаваемых данных, например, для соответствия требованиям PCI DSS.
            
            
            {% note warning %}
            
            Если не добавить сертификат, трансфер может [завершиться ошибкой](../../../troubleshooting/index.md#failed-to-connect).
            
            {% endnote %}
          
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.OnPremiseGreenplum.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md). Трансфер будет использовать эту подсеть для доступа к базе данных.
    
            Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.
    
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}** — укажите имя базы данных.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}** — укажите пароль пользователя для доступа к базе данных.
    
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}** — позволяет подключиться к базе данных через [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):
    
          * Выберите каталог, в котором создано подключение {{ connection-manager-name }}.
          * Выберите тип инсталляции **Пользовательская инсталляция** и задайте настройки:
    
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}** — выберите подключение в {{ connection-manager-name }} или создайте его.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}** — укажите имя базы данных в пользовательской инсталляции.
            *  **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.OnPremiseGreenplum.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md). Трансфер будет использовать эту подсеть для доступа к базе данных.
    
                Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.
    
            {% note warning %}
            
            Чтобы использовать подключение из {{ connection-manager-name }}, у пользователя должны быть [права доступа](../../../../metadata-hub/operations/connection-access.md) не ниже `connection-manager.user` к этому подключению.
            
            {% endnote %}        
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.
    
      Это позволит применить к ВМ и БД в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и БД. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).

{% endlist %}

### Фильтр таблиц {#filter-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTableFilter.include_tables.title }}** — будут передаваться данные только из таблиц этого списка.

      Если таблица партиционирована, в этом поле можно указать как всю таблицу, так и отдельные ее партиции.

      Также убедитесь, что для включаемых в список таблиц [выданы необходимые привилегии](../../prepare.md#source-gp) пользователю, от имени которого будет осуществляться трансфер.

      Добавление новых таблиц при редактировании эндпоинта, использующегося в трансферах типа {{ dt-type-copy-repl }} или {{ dt-type-repl }} в статусе {{ dt-status-repl }}, не приведет к загрузке истории данных по этим таблицам. Чтобы добавить таблицу с ее историческими данными, используйте поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** в [настройках трансфера](../../transfer.md#update).

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTableFilter.exclude_tables.title }}** — данные таблиц из этого списка передаваться не будут.

      Если таблица партиционирована, то для исключения таблицы из этого списка необходимо перечислить все ее партиции.

      Списки включают имя [схемы]({{ gp.docs.broadcom }}/7/greenplum-database/admin_guide-ddl-ddl-schema.html) (описание содержания, структуры и ограничений целостности базы данных) и имя таблицы. Для обоих списков поддерживаются выражения вида:

      * `<имя_схемы>.<имя_таблицы>` — полное имя таблицы;
      * `<имя_схемы>.*` — все таблицы в указанной схеме;
      * `<имя_таблицы>` — таблица в схеме по умолчанию.

      Имена включенных и исключенных таблиц должны соответствовать правилам именования идентификаторов в {{ GP }}. Двойные кавычки внутри имени таблицы не поддерживаются. Внешние кавычки используются только как разделители и будут удалены при обработке путей.

{% endlist %}

### Расширенные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GpSourceAdvancedSettings.strong_consistency.title }}** — при включении {{ data-transfer-name }} выполнит дополнительные действия с источником для обеспечения [консистентности снапшота](#snapshot-consistency).

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GpSourceAdvancedSettings.service_schema.title }}** — схема, которая будет использоваться для размещения служебных объектов трансфера.

      Имя схемы должно соответствовать правилам именования идентификаторов в {{ GP }}. Двойные кавычки в имени схемы не поддерживаются.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GpSourceAdvancedSettings.disable_gpfdist.title }}** — отключает использование [утилиты](../../../../managed-greenplum/operations/gpfdist/connect.md) `gpfdist` для трансферов из {{ GP }} в {{ GP }}.

{% endlist %}

### Особенности работы с источником Greenplum {#advanced}

{{ data-transfer-name }} поддерживает только {{ GP }} версий 6.28 и выше. {{ GP }} других версий не поддерживается.

Сервис выполняет операции с кластером {{ GP }} в транзакциях с [уровнем изоляции]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-sql_commands-SET_TRANSACTION.html) `READ COMMITTED`.

{{ data-transfer-name }} поддерживает работу с включенным [параллельным копированием](../../../concepts/sharded.md) для источника {{ GP }}.

Во время работы с включенным параллельным копированием {{ data-transfer-name }} удерживает открытую транзакцию на хосте-мастере {{ GP }}. При прерывании этой транзакции трансфер завершится с ошибкой.

При отключенном параллельном копировании трансфер переносит данные объектов {{ GP }} `TABLE`, `VIEW`, `FOREIGN TABLE`, и `EXTERNAL TABLE`. Данные из этих объектов трактуются как данные из обыкновенных таблиц и обрабатываются приемником соответственно. При включенном параллельном копировании трансфер переносит только таблицы (объекты `TABLE`), причем таблицы с [политикой распределения]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-sql_commands-CREATE_TABLE.html) `DISTRIBUTED REPLICATED` не переносятся.

Если в трансфере из {{ GP }} в {{ GP }} не используется прямое чтение с сегментов, количество потоков не может превышать минимальное число сегментов в участвующих кластерах.

Проверить количество сегментов можно через [консоль управления]({{ link-console-main }}) или выполнив SQL-запрос:

```pgsql
SELECT COUNT(*) FROM gp_segment_configuration WHERE role='p' AND content >= 0;
```

Количество участвующих в переносе воркеров ограничено заданным числом потоков. Каждый воркер переносит таблицы последовательно, при этом каждая таблица переносится только одним воркером.

### Консистентность снапшота {#snapshot-consistency}

При запуске трансфера с отключенным параллельным копированием (по умолчанию) сервис выполняет копирование, взаимодействуя только с [хостом-мастером](../../../../managed-greenplum/concepts/index.md) кластера {{ GP }}. Доступ к копируемым таблицам осуществляется в [режиме блокировки]({{ gp.docs.broadcom }}/7/greenplum-database/ref_guide-sql_commands-LOCK.html) `ACCESS SHARE`. Консистентность снапшота обеспечивается средствами {{ GP }}.

При запуске трансфера с включенным параллельным копированием сервис выполняет копирование, взаимодействуя как с хостом-мастером, так и в режиме прямого доступа (utility mode) с [хостами-сегментами](../../../../managed-greenplum/concepts/index.md) кластера {{ GP }}. Доступ к копируемым таблицам осуществляется с блокировкой таблицы в режиме `ACCESS SHARE` или `SHARE`, зависящем от настройки "Обеспечивать строгую консистентность снапшота".

Трансферу с включенным параллельным копированием для обеспечения консистентности снапшота требуется обеспечить неизменность данных в переносимых таблицах. При блокировке в режиме `ACCESS SHARE` (по умолчанию) неизменность данных не обеспечивается сервисом и должна быть обеспечена извне. При блокировке в режиме `SHARE` неизменность данных в исходных таблицах обеспечивается механизмами {{ GP }}.

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._


## Настройка приемника данных {#supported-targets}

Настройте один из поддерживаемых приемников данных:

* [{{ PG }}](../target/postgresql.md);
* [{{ CH }}](../target/clickhouse.md);
* [{{ GP }}](../target/greenplum.md);
* [{{ ytsaurus-name }}](yt.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} читайте в разделе [Доступные трансферы](../../../transfer-matrix.md).

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).