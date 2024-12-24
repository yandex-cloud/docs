{% note info %}

При трансфере из {{ PG }} в любой тип приемника объекты типа [large objects](https://www.postgresql.org/docs/current/largeobjects.html) не переносятся.

{% include [pg-types-limits](../../notes/pg-source-features.md) %}

Большие объекты в [системе хранения TOAST](https://www.postgresql.org/docs/12/storage-toast.html) и данные с [типом bytea](https://www.postgresql.org/docs/12/datatype-binary.html) переносятся без ограничений.

{% endnote %}

{% list tabs %}

- {{ mpg-name }}

    
    1. Настройте пользователя, от имени которого трансфер подключится к источнику:
        
        1. [Создайте пользователя](../../../../managed-postgresql/operations/cluster-users.md#adduser).
        
        1. Для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ [назначьте роль](../../../../managed-postgresql/operations/grant.md#grant-role) `mdb_replication` этому пользователю.
        
        1. [Подключитесь к базе данных](../../../../managed-postgresql/operations/connect.md), которую нужно мигрировать, от имени владельца базы и [настройте привилегии](../../../../managed-postgresql/operations/grant.md#grant-privilege):
            
            * `SELECT` над всеми таблицами базы данных, которые переносит трансфер;
            * `SELECT` над всеми последовательностями базы данных, которые переносит трансфер;
            * `USAGE` на схемы этих таблиц и последовательностей.
            * `ALL PRIVILEGES` (`CREATE` и `USAGE`) на задаваемую [параметром эндпоинта](../../../../data-transfer/operations/endpoint/source/postgresql.md#additional-settings) схему служебных таблиц `__consumer_keeper` и `__data_transfer_mole_finder`, если эндпоинт будет использоваться для типов трансфера _{{ dt-type-repl }}_ или _{{ dt-type-copy-repl }}_.

    1. Настройте [количество подключений пользователя](../../../../data-transfer/concepts/work-with-endpoints.md#postgresql-connection-limit) к базе данных.

    1. Если источник репликации — кластер, [включите](../../../../managed-postgresql/operations/extensions/cluster-extensions.md) для него расширение `pg_tm_aux`. Это позволит продолжить репликацию в случае смены хоста-мастера. В некоторых случаях при смене мастера в кластере трансфер может завершиться ошибкой. Подробнее см. в разделе [Решение проблем](../../../../data-transfer/troubleshooting/index.md#master-change).
    
    1. {% include [Таблицы без первичных ключей](../../primary-keys-postgresql.md) %}
    
    1. Выключите перенос внешних ключей на стадии создания эндпоинта-источника. Создайте их заново после окончания трансфера.
    
    1. Найдите и завершите слишком долгие DDL-запросы. Для этого сделайте выборку из системной таблицы {{ PG }} `pg_stat_activity`:
    
        ```sql
        SELECT NOW() - query_start AS duration, query, state
        FROM pg_stat_activity
        WHERE state != 'idle' ORDER BY 1 DESC;
        ```
    
       Будет возвращен список запросов, выполняющихся на сервере. Обратите внимание на запросы с высоким значением `duration`.
    
    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_). Подробнее см. в [описании дополнительных настроек эндпоинта для источника {{ PG }}](../../../../data-transfer/operations/endpoint/source/postgresql.md#additional-settings).
    
    1. Для параллельного чтения из таблицы установите ее первичный ключ в [режим serial](https://www.postgresql.org/docs/current/datatype-numeric.html#DATATYPE-SERIAL).
    
       После этого укажите количество воркеров и потоков в блоке **Среда выполнения** в [параметрах трансфера](../../../../data-transfer/operations/transfer.md#create).
    
    1. Настройте мониторинг WAL-лога. {#wal-setup-recommendation}

       Для трансферов типа _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ используется [логическая репликация]({{ pg-docs }}/logicaldecoding.html). Для этого сам трансфер создает слот репликации со значением `slot_name`, равным идентификатору трансфера, который можно получить, выбрав трансфер в списке ваших трансферов. WAL может расти по разным причинам: из-за долгой транзакции или из-за проблемы на трансфере. Поэтому рекомендуется настроить мониторинг WAL-лога на стороне источника.

        1. Для мониторинга размера использованного хранилища или диска [настройте алерт средствами мониторинга](../../../../managed-postgresql/operations/monitoring.md#monitoring-hosts) (см. описание `disk.used_bytes`).
        
        1. Задайте максимальный размер WAL при репликации в [настройке](../../../../managed-postgresql/concepts/settings-list.md#setting-max-slot-wal-keep-size) `Max slot wal keep size`. Редактирование данной настройки доступно начиная с 13 версии {{ PG }}. Если вы хотите экстренно запретить операции чтения трансферу, то [удалите слот репликации](../../../../managed-postgresql/operations/replication-slots.md#delete). 
        
           {% note warning %}
        
           При значении настройки `-1` (размер не ограничен) открытые логические слоты репликации, из которых не считывается информация, будут препятствовать удалению WAL-файлов. В результате WAL-файлы займут все дисковое пространство и вы потеряете возможность подключаться к кластеру.
        
           {% endnote %}
        
        1. [Настройте алерт](../../../../managed-postgresql/operations/monitoring.md) средствами {{ monitoring-full-name }} на метрику, которая используется для `Total size of WAL files`. Пороговые значения должны быть меньше, чем указаны для метрики `disk.used_bytes`, так как на диске, кроме данных, хранятся временные файлы, WAL-лог и другие типы данных. Текущий размер слота можно мониторить средствами БД через запрос, указав правильный `slot_name`, равный идентификатору трансфера:
        
            ```sql
            SELECT slot_name, pg_size_pretty(pg_current_wal_lsn() - restart_lsn), active_pid, catalog_xmin, restart_lsn, confirmed_flush_lsn
            FROM pg_replication_slots WHERE slot_name = '<идентификатор_трансфера>'
            ```

- {{ PG }}
    
    1. {% include notitle [White IP list](../../configure-white-ip.md) %}
    
    1. Создайте пользователя, от имени которого трансфер подключится к источнику:
        
        * Для типа трансфера _{{ dt-type-copy }}_ создайте пользователя командой:
        
            ```sql
            CREATE ROLE <имя_пользователя> LOGIN ENCRYPTED PASSWORD '<пароль>';
            ```
        
        * Для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ создайте пользователя с привилегией `REPLICATION` командой:
        
            ```sql
            CREATE ROLE <имя_пользователя> WITH REPLICATION LOGIN ENCRYPTED PASSWORD '<пароль>';
            ```
    
    1. Выдайте созданному пользователю привилегию на выполнение операции `SELECT` над всеми таблицами базы данных, которые переносит трансфер, и привилегию `USAGE` на схемы этих таблиц:
    
        ```sql
        GRANT SELECT ON ALL TABLES IN SCHEMA <название_схемы> TO <имя_пользователя>;
        GRANT USAGE ON SCHEMA <название_схемы> TO <имя_пользователя>;
        ```
    
    1. Выдайте созданному пользователю привилегии на задаваемую [параметром эндпоинта](../../../../data-transfer/operations/endpoint/source/postgresql.md#additional-settings) схему служебных таблиц `__consumer_keeper` и `__data_transfer_mole_finder`, если эндпоинт будет использоваться для типов трансфера _{{ dt-type-repl }}_ или _{{ dt-type-copy-repl }}_:
    
        ```sql
        GRANT ALL PRIVILEGES ON SCHEMA <имя_схемы> TO <имя_пользователя>;
        ```

    1. Настройте [количество подключений пользователя](../../../../data-transfer/concepts/work-with-endpoints.md#postgresql-connection-limit) к базе данных.

    1. Установите и включите расширение [wal2json](https://github.com/eulerto/wal2json).
    
       **Установка**
        
        * Linux
            
            1. Подключите [официальный репозиторий {{ PG }}](https://www.postgresql.org/download/) для вашего дистрибутива.
            1. Обновите список доступных пакетов и установите пакет `wal2json` для используемой версии {{ PG }}.
        
        * Windows 10, 11
            
            1. Если у вас не установлена Microsoft Visual Studio, загрузите и установите ее. Для сборки расширения wal2json достаточно редакции [Community Edition](https://visualstudio.microsoft.com/ru/vs/community/). При установке выберите компоненты:
                
                * MSBuild,
                * MSVC v141 x86/x64 build tools,
                * C++\CLI support for v141 build tools,
                * MSVC v141 — VS 2017 C++ x64\x86 build tools,
                * MSVC v141 — VS 2017 C++ x64\x86 Spectre-mitigated libs,
                * самая свежая версия Windows SDK для используемой версии ОС,
                * прочие зависимости, которые устанавливаются автоматически для выбранных компонентов.

               Запомните номер устанавливаемой версии Windows SDK — он понадобится при указании параметров сборки wal2json.
            
            1. Загрузите исходный код wal2json со [страницы проекта](https://github.com/eulerto/wal2json/releases).
            1. Распакуйте архив с исходным кодом в каталог `C:\wal2json\`.
            1. Перейдите в каталог `C:\wal2json`.
            1. В рамках одной сессии PowerShell внесите изменения в файл `wal2json.vcxproj`:
                
                * замените строки `C:\postgres\pg103` на путь к каталогу с установленной версией {{ PG }}, например:
                
                    ```powershell
                    (Get-Content .\wal2json.vcxproj).replace('C:\postgres\pg103', 'C:\PostgreSQL\14') | `
                     Set-Content .\wal2json.vcxproj
                    ```
                
                * замените параметр сборки `/MP` на `/MT`, например:
                
                    ```powershell
                    (Get-Content .\wal2json.vcxproj).replace('/MP', '/MT') | Set-Content .\wal2json.vcxproj
                    ```
                
                * укажите в параметре `<WindowsTargetPlatformVersion>` номер версии установленного компонента Windows SDK:
                
                    ```powershell
                    (Get-Content .\wal2json.vcxproj).replace('<WindowsTargetPlatformVersion>8.1', '<WindowsTargetPlatformVersion><установленная_версия_Windows_SDK>') | `
                     Set-Content .\wal2json.vcxproj
                    ```
                
                1. Укажите значение переменной окружения, необходимой для сборки wal2json, например, для Visual Studio Community Edition 2022:
                
                    ```powershell
                    $VCTargetsPath='C:\Program Files\Microsoft Visual Studio\2022\Comminuty\MSBuild\Microsoft\VC\v150'
                    ```
                
                1. Запустите сборку:
                
                    ```powershell
                    & 'C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe' /p:Configuration=Release /p:Platform=x64
                    ```
                
                1. Скопируйте файл `wal2json.dll` из каталога `build/release` в каталог `lib` установленной версии {{ PG }}.

       {% endlist %}

       **Настройка**
        
        1. В файле `postgresql.conf` измените значение параметра `wal_level` на `logical`:
        
            ```conf
            wal_level = logical
            ```
        
        1. Перезапустите PostgreSQL.
    
    1. Если источник репликации — кластер, установите и включите на его хостах расширение [pg_tm_aux](https://github.com/x4m/pg_tm_aux). Это позволит продолжить репликацию в случае смены хоста-мастера. В некоторых случаях при смене мастера в кластере трансфер может завершиться ошибкой. Подробнее см. в разделе [Решение проблем](../../../../data-transfer/troubleshooting/index.md#master-change).
    
    1. {% include [Таблицы без первичных ключей](../../primary-keys-postgresql.md) %}
    
    1. Выключите перенос внешних ключей на стадии создания эндпоинта-источника. Создайте их заново после окончания трансфера.
    
    1. Найдите и завершите слишком долгие DDL-запросы. Для этого сделайте выборку из системной таблицы {{ PG }} `pg_stat_activity`:
    
        ```sql
        SELECT NOW() - query_start AS duration, query, state
        FROM pg_stat_activity
        WHERE state != 'idle' ORDER BY 1 DESC;
        ```
    
       Будет возвращен список запросов, выполняющихся на сервере. Обратите внимание на запросы с высоким значением `duration`.
    
    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_). Подробнее см. в [описании дополнительных настроек эндпоинта для источника {{ PG }}](../../../../data-transfer/operations/endpoint/source/postgresql.md#additional-settings).
    
    1. Для параллельного чтения из таблицы установите ее первичный ключ в [режим serial](https://www.postgresql.org/docs/current/datatype-numeric.html#DATATYPE-SERIAL).
    
       После этого укажите количество [воркеров](../../../../data-transfer/concepts/index.md#worker) и потоков в блоке **Среда выполнения** в [параметрах трансфера](../../../../data-transfer/operations/transfer.md#create).
    
    1. Если на источнике настроена репликация через [Patroni](https://github.com/zalando/patroni), добавьте в его конфигурацию [блок ignore_slots](https://patroni.readthedocs.io/en/latest/SETTINGS.html?highlight=ignore_slots#dynamic-configuration-settings):
    
       ```yaml
       ignore_slots:
         - database: <база_данных>
           name: <слот_репликации>
           plugin: wal2json
           type: logical
       ```
    
       Где:
        
        * `database` — имя базы данных, для которой настроен трансфер.
        * `name` — имя слота репликации.

       Имя базы данных и имя слота репликации должны совпадать со значениями, указанными в [настройках эндпоинта для источника](../../../../data-transfer/operations/endpoint/source/postgresql.md). По умолчанию `имя слота репликации` совпадает с `ID трансфера`.

       В противном случае начало этапа репликации завершится ошибкой:
    
       ```
       Warn(Termination): unable to create new pg source: Replication slotID <имя_слота_репликации> does not exist.
       ```
    
    1. Настройте мониторинг WAL-лога. Для трансферов типа _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ используется [логическая репликация]({{ pg-docs }}/logicaldecoding.html). Для этого сам трансфер создает слот репликации со значением `slot_name`, равным идентификатору трансфера, который можно получить, выбрав трансфер в списке ваших трансферов. WAL может расти по разным причинам: из-за долгой транзакции или из-за проблемы на трансфере. Поэтому рекомендуется настроить мониторинг WAL-лога на стороне источника.
        
        1. Настройте алерты на основе [рекомендаций по использованию диска]({{ pg-docs }}/diskusage.html).
        
        1. [Установите максимальный размер WAL]({{ pg-docs }}/runtime-config-replication.html#GUC-MAX-SLOT-WAL-KEEP-SIZE). Эта возможность доступна, начиная с версии {{ PG }} 13.
        
        1. Текущий размер слота можно отслеживать средствами БД через запрос, указав правильный `slot_name`, равный идентификатору трансфера:
        
            ```sql
            SELECT slot_name, pg_size_pretty(pg_current_wal_lsn() - restart_lsn), active_pid, catalog_xmin, restart_lsn, confirmed_flush_lsn
            FROM pg_replication_slots WHERE slot_name = '<идентификатор_трансфера>'
            ```    

{% endlist %}

{% note info %}

Об особенностях переноса данных из {{ PG }} в {{ CH }} трансферами типа _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ см. в разделе [Асинхронная репликация данных из {{ PG }} в {{ CH }}](../../../../data-transfer/tutorials/rdbms-to-clickhouse.md).

{% endnote %}