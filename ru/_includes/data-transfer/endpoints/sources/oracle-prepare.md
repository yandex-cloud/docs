{% note info %}

В некоторых версиях Oracle для системных объектов вместо префикса `V$` используются `V_$`. Например, `V_$DATABASE` вместо `V$DATABASE`.

Измените префиксы, если вы столкнулись с ошибкой вида `can only select from fixed tables/views` при выдаче прав на системные объекты.

{% endnote %}

{% list tabs %}

- Oracle
    
    * Чтобы подготовить источник к трансферу типа _{{ dt-type-copy }}_:
        
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
    
    * Чтобы подготовить источник к трансферу типа _{{ dt-type-repl }}_:
        
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