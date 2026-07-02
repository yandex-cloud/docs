[Документация Yandex Cloud](../../../../index.md) > [Yandex Data Transfer](../../../index.md) > [Пошаговые инструкции](../../index.md) > [Настройка эндпоинтов](../index.md) > Oracle > Источник

# Передача данных из эндпоинта-источника Oracle

С помощью сервиса Yandex Data Transfer вы можете переносить данные из базы Oracle и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных Oracle](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в Yandex Data Transfer.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Cоздайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](../../../troubleshooting/index.md) по их устранению.

## Сценарии передачи данных из Oracle {#scenarios}

1. Миграция — перенос данных из одного хранилища в другое. Часто это перенос базы из устаревших локальных баз в управляемые облачные.

1. Загрузка данных в витрины — процесс трансфера подготовленных данных в хранилища с целью последующей визуализации.

Подробное описание возможных сценариев передачи данных в Yandex Data Transfer читайте в разделе [Практические руководства](../../../tutorials/index.md).

## Подготовка базы данных источника {#prepare}

{% note info %}

В некоторых версиях Oracle для системных объектов вместо префикса `V$` используются `V_$`. Например, `V_$DATABASE` вместо `V$DATABASE`.

Измените префиксы, если вы столкнулись с ошибкой вида `can only select from fixed tables/views` при выдаче прав на системные объекты.

{% endnote %}

{% list tabs %}

- Oracle
    
    * Чтобы подготовить источник к трансферу типа _**Копирование**_:
        
        1. Создайте пользователя, от имени которого трансфер подключится к источнику:
        
            ```sql
            CREATE USER <имя_пользователя> IDENTIFIED BY <пароль>;
            GRANT CREATE SESSION TO <имя_пользователя>;
            ```
        
        1. Выдайте права созданному пользователю:
        
           ```sql
           GRANT SELECT ON V$DATABASE TO <имя_пользователя>;
           GRANT SELECT ON DBA_EXTENTS TO <имя_пользователя>;
           GRANT SELECT ON DBA_OBJECTS TO <имя_пользователя>;
           GRANT FLASHBACK ANY TABLE TO <имя_пользователя>;
           ```
        
           При необходимости, право `FLASHBACK` можно выдать не на все таблицы (`ANY TABLE`), а только на те, которые нужно скопировать.
        
        1. Выдайте пользователю [права на чтение таблиц](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/GRANT.html), которые нужно скопировать.
    
    * Чтобы подготовить источник к трансферу типа _**Репликация**_:
        
        1. Создайте пользователя, от имени которого трансфер подключится к источнику:
        
           ```sql
           CREATE USER <имя_пользователя> IDENTIFIED BY <пароль>;
           ALTER USER <имя_пользователя> DEFAULT tablespace USERS TEMPORARY tablespace TEMP;
           ALTER USER <имя_пользователя> quote unlimited on USERS;

           GRANT 
               CREATE SESSION,
               execute_catalog_role,
               SELECT ANY TRANSACTION,
               SELECT ANY DISCTIONARY,
               CREATE PROCEDURE,
               LOGMINING 
           TO <имя_пользователя>;
           ```
        
        1. Выдайте права созданному пользователю:
        
            ```sql
            GRANT SELECT ON V$DATABASE TO <имя_пользователя>;
            GRANT SELECT ON V$LOG TO <имя_пользователя>;
            GRANT SELECT ON V$LOGFILE TO <имя_пользователя>;
            GRANT SELECT ON V$ARCHIVED_LOG TO <имя_пользователя>;

            GRANT SELECT ON dba_objects TO <имя_пользователя>;
            GRANT SELECT ON dba_extents TO <имя_пользователя>;

            GRANT EXECUTE ON SYS.DBMS_LOGMNR TO <имя_пользователя>;
            GRANT SELECT ON SYSTEM.LOGMNR_COL$ TO <имя_пользователя>;
            GRANT SELECT ON SYSTEM.LOGMNR_OBJ$ TO <имя_пользователя>;
            GRANT SELECT ON SYSTEM.LOGMNR_USER$ TO <имя_пользователя>;
            GRANT SELECT ON SYSTEM.LOGMNR_UID$ TO <имя_пользователя>;
            ```
        
        1. Выдайте пользователю [права на чтение таблиц](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/GRANT.html), которые нужно реплицировать.
        1. Включите [Minimal Supplemental Logging](https://docs.oracle.com/database/121/SUTIL/GUID-D2DDD67C-E1CC-45A6-A2A7-198E4C142FA3.htm#SUTIL1583) с первичными ключами, для этого выполните:
        
            ```sql
            ALTER DATABASE ADD SUPPLEMENTAL LOG DATA (PRIMARY KEY) COLUMNS;
            ```
    
    * Если вы работаете в [CDB-среде](https://docs.oracle.com/database/121/CNCPT/cdbovrvw.htm#CNCPT89234), выполните следующие настройки:
        
        1. Создайте [пользователя](https://docs.oracle.com/en/database/oracle/oracle-database/19/multi/overview-of-managing-a-multitenant-environment.html#GUID-7D303718-2D59-495F-90FB-E51A377B1AD2) `Common User`:
        
            ```sql
            CREATE USER C##<имя_пользователя> IDENTIFIED BY <пароль> CONTAINER=all;
            ALTER USER C##<имя_пользователя> DEFAULT TABLESPACE USERS temporary tablespace TEMP CONTAINER=all;
            ALTER USER C##<имя_пользователя> quota unlimited on USERS CONTAINER=all;
            ALTER USER C##<имя_пользователя> SET container_data = (cdb$root, <имя_вашей_PCB>) CONTAINER=current;

            GRANT 
                CREATE SESSION,
                execute_catalog_role,
                SELECT ANY TRANSACTION,
                SELECT ANY DICTIONALY,
                CREATE PROCEDURE,
                LOGMINING,
                SET CONTAINER
            TO C##<имя_пользователя> CONTAINER=ALL;
            ```
        
           При необходимости, можно указать только контейнер `cdb$root` и контейнер с таблицами, которые нужно перенести.
        
        1. Чтобы пользователь мог переключаться на контейнер `cdb$root`, выдайте ему права `ALTER SESSION`:
        
            ```sql
            GRANT ALTER SESSION TO C##<имя_пользователя>;
            ```
        
        1. Выдайте права созданному пользователю:
        
            ```sql
            GRANT SELECT ON V$DATABASE TO C##<имя_пользователя> CONTAINER=ALL;
            GRANT SELECT ON V$LOG TO C##<имя_пользователя> CONTAINER=ALL;
            GRANT SELECT ON V$LOGFILE TO C##<имя_пользователя> CONTAINER=ALL;
            GRANT SELECT ON V$ARCHIVED_LOG TO C##<имя_пользователя> CONTAINER=ALL;

            GRANT SELECT ON dba_objects TO C##<имя_пользователя> CONTAINER=ALL;
            GRANT SELECT ON dba_extents TO C##<имя_пользователя> CONTAINER=ALL;

            GRANT EXECUTE ON SYS.DBMS_LOGMNR TO C##<имя_пользователя> CONTAINER=ALL;
            GRANT SELECT ON SYSTEM.LOGMNR_COL$ TO C##<имя_пользователя> CONTAINER=ALL;
            GRANT SELECT ON SYSTEM.LOGMNR_OBJ$ TO C##<имя_пользователя> CONTAINER=ALL;
            GRANT SELECT ON SYSTEM.LOGMNR_USER$ TO C##<имя_пользователя> CONTAINER=ALL;
            GRANT SELECT ON SYSTEM.LOGMNR_UID$ TO C##<имя_пользователя> CONTAINER=ALL;
            ```

{% endlist %}

## Настройка эндпоинта-источника Oracle {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта задайте настройки подключения к кластеру Oracle.

Настройки приведены для пользовательской инсталляции, когда все поля заполняются вручную.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **Тип подключения** — выберите [тип подключения](https://docs.oracle.com/cd/E11882_01/network.112/e41945/concepts.htm#NETAG002) к кластеру Oracle.
    
    * Для подключения типа **Инстанс**:
    
        * **Хост** — укажите IP-адрес или FQDN хоста, к которому необходимо подключиться.
        * **Порт** — укажите номер порта, который сервис Data Transfer будет использовать для подключения.
        
        * **Тип** — укажите [Oracle SID](https://docs.oracle.com/en/database/oracle/oracle-database/21/cncpt/oracle-database-instance.html#GUID-8BB8140D-63ED-454E-AAC3-1964F80D102D) или [Service Name](https://docs.oracle.com/en/database/oracle/oracle-database/21/cncpt/application-and-networking-architecture.html#GUID-C931A159-E1FE-4DB3-A811-510C42516683) в соответствующем поле ниже.
    
    * Для подключения типа **Строка подключения TNS** укажите строку подключения к Oracle RDBMS в соответствующем поле ниже.
    
    * **Пользователь** — укажите имя пользователя, под которым сервис Data Transfer будет подключаться к базе данных.
    
    * **Пароль** — укажите пароль пользователя для доступа к базе данных.
    
    * **PDB-контейнер** — укажите имя [PDB контейнера](https://docs.oracle.com/en/database/oracle/oracle-database/21/cncpt/CDBs-and-PDBs.html#GUID-49C0C90D-5A72-4131-8C3D-B07341C75CB2), к которому нужно подключиться. Если вы не работаете в [CDB-среде](https://docs.oracle.com/database/121/CNCPT/cdbovrvw.htm#CNCPT89234), оставьте это поле пустым.
    * **Список включённых таблиц** — будут передаваться данные только из таблиц этого списка. Задается с помощью регулярных выражений.
    * **Список исключённых таблиц** — данные таблиц из этого списка передаваться не будут. Задается с помощью регулярных выражений.
    
      Списки включают имя [схемы](https://docs.oracle.com/en/database/oracle/oracle-database/19/admqs/managing-schema-objects.html) (описание содержания, структуры и ограничений целостности базы данных) и имя таблицы. Для обоих списков поддерживаются выражения вида:
    
        * `<имя_схемы>.<имя_таблицы>` — полное имя таблицы;
        * `<имя_схемы>.*` — все таблицы в указанной схеме;
        * `<имя_таблицы>` — таблица в схеме по умолчанию.
    
        Имена включенных и исключенных таблиц должны соответствовать правилам именования идентификаторов в Oracle. Подробнее читайте в [документации Oracle](https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/Database-Object-Names-and-Qualifiers.html). Двойные кавычки внутри имени таблицы не поддерживаются. Экранирование внешних двойных кавычек не требуется.
    
    * **Преобразовывать тип "NUMBER" в "Int64"** — включите эту настройку для преобразования типа `NUMBER` (без параметров) в `INT64`. [Параметризованные типы `NUMBER (precision, scale)`](https://docs.oracle.com/cd/B28359_01/server.111/b28318/datatype.htm#CNCPT1832) автоматически преобразуются в целочисленные типы, где это возможно.

{% endlist %}

## Настройка приемника данных {#supported-targets}

Настройте один из поддерживаемых приемников данных:

* [PostgreSQL](../target/postgresql.md);
* [ClickHouse®](../target/clickhouse.md);
* [Greenplum®](../target/greenplum.md);
* [YTsaurus](yt.md).

Полный список поддерживаемых источников и приемников в Yandex Data Transfer читайте в разделе [Доступные трансферы](../../../transfer-matrix.md).

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).