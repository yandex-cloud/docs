# Передача данных из эндпоинта-источника {{ PG }}

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные из базы {{ PG }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных {{ PG }}](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. [Выполняйте необходимые действия по работе с базой](#db-actions) и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных из {{ PG }} {#scenarios}

1. Миграция — перенос данных из одного хранилища в другое. Часто это перенос базы из устаревших локальных баз в управляемые облачные.

    * [Миграция кластера {{ PG }}](../../../tutorials/managed-postgresql.md);
    * [Миграция из AWS RDS for {{ PG }}](../../../tutorials/rds-to-mpg.md);
    * [Миграция со сменой хранилища: {{ PG }} в {{ ydb-short-name }}](../../../tutorials/mpg-to-ydb.md);
    * [Миграция со сменой хранилища: {{ PG }} в {{ MY }}](../../../tutorials/mpg-to-mmy.md);
    * [Миграция со сменой хранилища: {{ PG }} в {{ OS }}](../../../tutorials/postgresql-to-opensearch.md).

1. Захват изменений данных — это процесс отслеживания изменений в базе данных и поставка этих изменений потребителям. Применяется для приложений, которые чувствительны к изменению данных в реальном времени.

    * [Захват изменений из {{ PG }} и поставка в {{ DS }}](../../../tutorials/mpg-to-yds.md);
    * [Захват изменений из {{ PG }} и поставка в {{ KF }}](../../../tutorials/cdc-mpg.md).

1. Загрузка данных в витрины — процесс трансфера подготовленных данных в хранилища с целью последующей визуализации.

    * [Загрузка данных из {{ PG }} в витрину {{ CH }}](../../../tutorials/rdbms-to-clickhouse.md).

1. Загрузка данных в масштабируемое хранилище {{ objstorage-name }} позволяет удешевить хранение и облегчает обмен данных с контрагентами.

    * [Загрузка данных {{ PG }} в масштабируемое хранилище {{ objstorage-name }}](../../../tutorials/mpg-to-objstorage.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} читайте в разделе [Практические руководства](../../../tutorials/index.md).

## Подготовка базы данных источника {#prepare}

{% note info %}

При трансфере из {{ PG }} в любой тип приемника объекты типа [large objects](https://www.postgresql.org/docs/current/largeobjects.html) не переносятся.

При переносе данных с типом `TIMESTAMP WITHOUT TIME ZONE` применяется часовой пояс, указанный в параметре `timezone` базы данных источника {{ PG }}.

{% cut "Пример" %}

В колонке с типом данных `TIMESTAMP WITHOUT TIME ZONE` записано значение `1970-01-01 00:00:00`. То, как при трансфере будет перенесено значение, зависит от параметра `timezone` в БД:

* Если значение параметра равно `Etc/UTC`, то время переносится как `1970-01-01 00:00:00+00`.
* Если значение параметра равно `Europe/Moscow`, то время переносится как `1970-01-01 00:00:00+03`.

{% endcut %}

Данные, хранящиеся в `MATERIALIZED VIEW`, не переносятся. Для переноса данных из `MATERIALIZED VIEW` создайте обыкновенный `VIEW`, ссылающийся на переносимый `MATERIALIZED VIEW`.

Если определение переносимого `VIEW` содержит вызов `VOLATILE` [функции]({{ pg.docs.org }}/current/xfunc-volatility.html), то трансфер читает данные из такого `VIEW` с уровнем изоляции `READ UNCOMMITTED`. Консистентность между данными в этом `VIEW` и данными других переносимых объектов не гарантируется. Чтение из `MATERIALIZED VIEW` в определении `VIEW` равносильно вызову `VOLATILE` функции.

Большие объекты в [системе хранения TOAST](https://www.postgresql.org/docs/12/storage-toast.html) и данные с [типом bytea](https://www.postgresql.org/docs/12/datatype-binary.html) переносятся без ограничений.

{% endnote %}

{% list tabs %}

- {{ mpg-name }}

    
    1. Настройте пользователя, от имени которого трансфер подключится к источнику:
        
        1. [Создайте пользователя](../../../../managed-postgresql/operations/cluster-users.md#adduser).
        
        1. Для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ [назначьте роль](../../../../managed-postgresql/operations/grant.md#grant-role) `mdb_replication` этому пользователю.
        
        1. [Подключитесь к базе данных](../../../../managed-postgresql/operations/connect/index.md), которую нужно мигрировать, от имени владельца базы и [настройте привилегии](../../../../managed-postgresql/operations/grant.md#grant-privilege):

            * Выдайте привилегию на выполнение операции `SELECT` над всеми таблицами базы данных, которые переносит трансфер:

              ```sql
              GRANT SELECT ON ALL TABLES IN SCHEMA <название_схемы> TO <имя_владельца_БД>;
              ```

            * Выдайте привилегию на выполнение операции `SELECT` над всеми последовательностями базы данных, которые переносит трансфер:

              ```sql
              GRANT SELECT ON ALL SEQUENCES IN SCHEMA <название_схемы> TO <имя_владельца_БД>;
              ```

            * Выдайте привилегию `USAGE` на схемы, где хранятся эти таблицы и последовательности:

              ```sql
              GRANT USAGE ON SCHEMA <название_схемы> TO <имя_владельца_БД>;
              ```

            * Выдайте привилегию `ALL PRIVILEGES` (`CREATE` и `USAGE`) на задаваемую [параметром эндпоинта](postgresql.md#additional-settings) схему для хранения служебных таблиц `__consumer_keeper` и `__data_transfer_mole_finder`, если эндпоинт будет использоваться для типов трансфера _{{ dt-type-repl }}_ или _{{ dt-type-copy-repl }}_:

              ```sql
              GRANT ALL PRIVILEGES ON SCHEMA <название_схемы> TO <имя_владельца_БД>;
              ```

    1. Настройте [количество подключений пользователя](../../../concepts/work-with-endpoints.md#postgresql-connection-limit) к базе данных.

    1. Если источник репликации — кластер, выполните настройки:

        * [Включите](../../../../managed-postgresql/operations/extensions/cluster-extensions.md) для него расширение `pg_tm_aux`. Это позволит продолжить репликацию в случае смены хоста-мастера. В некоторых случаях при смене мастера в кластере трансфер может завершиться ошибкой. Подробнее читайте в разделе [Решение проблем](../../../troubleshooting/index.md#master-change).

        * Укажите в кластере значение [настройки](../../../../managed-postgresql/concepts/settings-list.md#setting-wal-keep-size) `Wal keep size`. В случае смены хоста-мастера хранимой в [WAL](https://www.postgresql.org/docs/current/wal-intro.html) на новом мастере истории должно хватать для продолжения репликации с того же места. Если истории недостаточно, трансфер может завершиться [ошибкой](postgresql.md#no-wal-story). В качестве минимального значения настройки `Wal keep size` рекомендуется взять среднее значение из графика **Source buffer size** в [мониторинге {{ data-transfer-name }}](../../monitoring.md). Если на диске достаточно свободных ресурсов, укажите значение настройки с запасом.

    1. Для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ таблицы без первичных ключей не переносятся. Чтобы сохранить работоспособность трансфера при переносе базы с такими таблицами:
       
       * Не переносите таблицы без первичных ключей. Для этого добавьте их в список исключенных таблиц в [настройках эндпоинта для источника](postgresql.md#additional-settings.md).
       * Добавьте идентификатор реплики на таблицах без `primary key`:
           * Для таблиц с индексом установите `REPLICA IDENTITY` по `unique key`:
       
               ```sql
               ALTER TABLE MY_TBL REPLICA IDENTITY USING INDEX MY_IDX;
               ```
       
           * Для таблиц без индекса измените `REPLICA IDENTITY`:
       
               ```sql
               ALTER TABLE MY_TBL REPLICA IDENTITY FULL;
               ```
             В этом случае {{ data-transfer-name }} будет воспринимать такие таблицы как таблицы, в которых первичный ключ является составным, и в него входят все колонки таблицы.
       
       Если в таблице нет первичных ключей, тогда в логической репликации [не будет событий изменений строк]({{ pg-docs }}/logical-replication-publication.html) (`UPDATE`, `DELETE`).
       
       * Во время трансфера из {{ PG }} в {{ PG }}, если у вас в источнике трансфера не будет исключена таблица без первичных ключей, то вы увидите ошибку: 
       
          ```text
           failed to run (abstract1 source): Cannot parse logical replication message: failed to reload schema: primary key check failed: Tables: n / N check failed: "public"."MY_TBL": no key columns found
           ```
       
        * Во время трансфера из {{ PG }} в другую базу данных, если у вас будет добавлена таблица без первичных ключей, то вы увидите ошибку:
       
          ```text
          failed to run (abstract1 source): Cannot parse logical replication message: failed to reload schema: primary key check failed: Tables: n / N check failed:
          "public"."MY_TBL": no key columns found
          ```
    
    1. Выключите перенос внешних ключей на стадии создания эндпоинта-источника. Создайте их заново после окончания трансфера.

    1. Если база данных содержит таблицы, в которых есть генерируемые столбцы, то такие таблицы не переносятся, и трансфер завершается ошибкой. Подробнее читайте в разделе [Решение проблем](../../../troubleshooting/index.md#generated-columns). Чтобы сохранить работоспособность трансфера при переносе базы данных с такими таблицами, добавьте их в список исключенных таблиц в [настройках эндпоинта для источника](postgresql.md#additional-settings.md).

    1. Найдите и завершите слишком долгие DDL-запросы. Для этого сделайте выборку из системной таблицы {{ PG }} `pg_stat_activity`:
    
        ```sql
        SELECT NOW() - query_start AS duration, query, state
        FROM pg_stat_activity
        WHERE state != 'idle' ORDER BY 1 DESC;
        ```
    
       Будет возвращен список запросов, выполняющихся на сервере. Обратите внимание на запросы с высоким значением `duration`.
    
    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_). Подробнее — в [описании дополнительных настроек эндпоинта для источника {{ PG }}](postgresql.md#additional-settings).
    
    1. Для параллельного чтения из таблицы по диапазонам убедитесь, что указан первичный ключ. После этого укажите количество воркеров и потоков в блоке **Среда выполнения** в [параметрах трансфера](../../transfer.md#create).
    
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
    
    1. Если вы не планируете использовать для подключения к внешнему кластеру [сервис {{ interconnect-name }}](../../../../interconnect/concepts/index.md) или [VPN](../../../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом {{ data-transfer-name }}](../../../../overview/concepts/public-ips.md#virtual-private-cloud}).
       
       Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../../../concepts/network.md#source-external).
    
    1. Настройте пользователя, от имени которого трансфер подключится к источнику:

        1. Создайте нового пользователя:
            
            * Для типа трансфера _{{ dt-type-copy }}_ создайте пользователя командой:
            
                ```sql
                CREATE ROLE <имя_пользователя> LOGIN ENCRYPTED PASSWORD '<пароль>';
                ```
            
            * Для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ создайте пользователя с привилегией `REPLICATION` командой:
            
                ```sql
                CREATE ROLE <имя_пользователя> WITH REPLICATION LOGIN ENCRYPTED PASSWORD '<пароль>';
                ```
        
        1. Выдайте созданному пользователю привилегию на выполнение операции `SELECT` над всеми таблицами базы данных, которые переносит трансфер:
        
            ```sql
            GRANT SELECT ON ALL TABLES IN SCHEMA <название_схемы> TO <имя_пользователя>;
            ```
        
        1. Выдайте созданному пользователю привилегию на схемы переносимой базы данных:

            * Для типа трансфера _{{ dt-type-copy }}_ выдайте привилегию `USAGE`:
        
                ```sql
                GRANT USAGE ON SCHEMA <название_схемы> TO <имя_пользователя>;
                ```

            * Для типа трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ выдайте привилегии `CREATE` и `USAGE` (`ALL PRIVILEGES`), необходимые для создания [служебных таблиц](postgresql.md#additional-settings):

                ```sql
                GRANT ALL PRIVILEGES ON SCHEMA <название_схемы> TO <имя_пользователя>;
                ```

        1. Выдайте созданному пользователю привилегию `SELECT` на все последовательности базы данных, которые переносит трансфер:

            ```sql
            GRANT SELECT ON ALL SEQUENCES IN SCHEMA <название_схемы> TO <имя_пользователя>;
            ```

        1. Выдайте созданному пользователю привилегию `CONNECT`, если настройки кластера-источника по умолчанию не позволяют выполнять подключение для новых пользователей:

            ```sql
            GRANT CONNECT ON DATABASE <название_базы_данных> TO <имя_пользователя>;
            ```

    1. Настройте конфигурацию {{ PG }}:
    
        1. Внесите изменения в конфигурацию и настройки аутентификации кластера-источника. Для этого отредактируйте файлы `postgresql.conf`  и `pg_hba.conf` (на дистрибутивах Debian и Ubuntu они по умолчанию расположены в каталоге `/etc/postgresql/<версия_{{ PG }}>/main/`):
        
            1. Задайте максимальное количество подключений пользователя. Для этого в файле `postgresql.conf` отредактируйте параметр `max_connections`:
        
                ```ini
                max_connections = <количество_подключений>
                ```
                
                Где `<количество_подключений>` — максимальное число подключений. Подробнее о том, как настроить этот параметр, читайте в разделе [Особенности работы с эндпоинтами](../../../concepts/work-with-endpoints.md#postgresql-connection-limit).
        
                Текущее количество подключений вы можете посмотреть в системной таблице `pg_stat_activity`:
        
                ```sql
                SELECT count(*) FROM pg_stat_activity;
                ```
        
            1. Установите уровень логирования для [Write Ahead Log (WAL)](https://www.postgresql.org/docs/current/static/wal-intro.html). Для этого установите значение `logical` для настройки [wal_level](https://www.postgresql.org/docs/current/runtime-config-wal.html#RUNTIME-CONFIG-WAL-SETTINGS) в `postgresql.conf`:
        
                ```ini
                wal_level = logical
                ```
        
            1. (Опционально) Настройте SSL: это поможет не только шифровать данные, но и сжимать их. Чтобы включить использование SSL, задайте нужное значение в файле `postgresql.conf`:
        
                ```ini
                ssl = on
                ```
            
            1. Разрешите подключение к кластеру. Для этого отредактируйте [параметр](https://www.postgresql.org/docs/current/runtime-config-connection.html#GUC-LISTEN-ADDRESSES) `listen_addresses` в файле `postgresql.conf`. Например, чтобы кластер-источник принимал запросы на подключение со всех IP-адресов:
        
                ```ini
                listen_addresses = '*'
                ```
        
            1. Настройте аутентификацию в файле `pg_hba.conf`:
        
                {% list tabs %}
        
                - SSL
        
                    ```txt
                    hostssl         all            all             <IP-адрес_подключения>      md5
                    hostssl         replication    all             <IP-адрес_подключения>      md5
                    ```
        
                - Без SSL
        
                    ```txt
                    host         all            all             <IP-адрес_подключения>      md5
                    host         replication    all             <IP-адрес_подключения>      md5
                    ```
        
                {% endlist %}
        
                Где `<IP-адрес_подключения>` может быть как точным IP-адресом, так и диапазоном IP-адресов. Например, чтобы разрешить доступ из сети {{ yandex-cloud }}, вы можете указать [все публичные IP-адреса](../../../../overview/concepts/public-ips.md) {{ yandex-cloud }}.
        1. Если в кластере-источнике работает файрвол, разрешите входящие соединения с нужных адресов.
        
        1. Чтобы применить настройки, перезапустите сервис {{ PG }}:
        
           ```bash
           sudo systemctl restart postgresql
           ```
        
        1. Проверьте статус сервиса {{ PG }} после перезапуска:
        
           ```bash
           sudo systemctl status postgresql
           ```

    1. Установите и включите расширение [wal2json](https://github.com/eulerto/wal2json).

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
    
    1. Если источник репликации — кластер, установите и включите на его хостах расширение [pg_tm_aux](https://github.com/x4m/pg_tm_aux). Это позволит продолжить репликацию в случае смены хоста-мастера. В некоторых случаях при смене мастера в кластере трансфер может завершиться ошибкой. Подробнее читайте в разделе [Решение проблем](../../../troubleshooting/index.md#master-change).
    
    1. Для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ таблицы без первичных ключей не переносятся. Чтобы сохранить работоспособность трансфера при переносе базы с такими таблицами:
       
       * Не переносите таблицы без первичных ключей. Для этого добавьте их в список исключенных таблиц в [настройках эндпоинта для источника](postgresql.md#additional-settings.md).
       * Добавьте идентификатор реплики на таблицах без `primary key`:
           * Для таблиц с индексом установите `REPLICA IDENTITY` по `unique key`:
       
               ```sql
               ALTER TABLE MY_TBL REPLICA IDENTITY USING INDEX MY_IDX;
               ```
       
           * Для таблиц без индекса измените `REPLICA IDENTITY`:
       
               ```sql
               ALTER TABLE MY_TBL REPLICA IDENTITY FULL;
               ```
             В этом случае {{ data-transfer-name }} будет воспринимать такие таблицы как таблицы, в которых первичный ключ является составным, и в него входят все колонки таблицы.
       
       Если в таблице нет первичных ключей, тогда в логической репликации [не будет событий изменений строк]({{ pg-docs }}/logical-replication-publication.html) (`UPDATE`, `DELETE`).
       
       * Во время трансфера из {{ PG }} в {{ PG }}, если у вас в источнике трансфера не будет исключена таблица без первичных ключей, то вы увидите ошибку: 
       
          ```text
           failed to run (abstract1 source): Cannot parse logical replication message: failed to reload schema: primary key check failed: Tables: n / N check failed: "public"."MY_TBL": no key columns found
           ```
       
        * Во время трансфера из {{ PG }} в другую базу данных, если у вас будет добавлена таблица без первичных ключей, то вы увидите ошибку:
       
          ```text
          failed to run (abstract1 source): Cannot parse logical replication message: failed to reload schema: primary key check failed: Tables: n / N check failed:
          "public"."MY_TBL": no key columns found
          ```
    
    1. Выключите перенос внешних ключей на стадии создания эндпоинта-источника. Создайте их заново после окончания трансфера.

    1. Если база данных содержит таблицы, в которых есть генерируемые столбцы, то такие таблицы не переносятся, и трансфер завершается ошибкой. Подробнее читайте в разделе [Решение проблем](../../../troubleshooting/index.md#generated-columns). Чтобы сохранить работоспособность трансфера при переносе базы данных с такими таблицами, добавьте их в список исключенных таблиц в [настройках эндпоинта для источника](postgresql.md#additional-settings.md).

    1. Найдите и завершите слишком долгие DDL-запросы. Для этого сделайте выборку из системной таблицы {{ PG }} `pg_stat_activity`:
    
        ```sql
        SELECT NOW() - query_start AS duration, query, state
        FROM pg_stat_activity
        WHERE state != 'idle' ORDER BY 1 DESC;
        ```
    
       Будет возвращен список запросов, выполняющихся на сервере. Обратите внимание на запросы с высоким значением `duration`.
    
    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_). Подробнее — в [описании дополнительных настроек эндпоинта для источника {{ PG }}](postgresql.md#additional-settings).
    
    1. Для параллельного чтения из таблицы по диапазонам убедитесь, что указан первичный ключ. После этого укажите количество [воркеров](../../../concepts/index.md#worker) и потоков в блоке **Среда выполнения** в [параметрах трансфера](../../transfer.md#create).
    
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

       Имя базы данных и имя слота репликации должны совпадать со значениями, указанными в [настройках эндпоинта для источника](postgresql.md). По умолчанию `имя слота репликации` совпадает с `ID трансфера`.

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

Об особенностях переноса данных из {{ PG }} в {{ CH }} трансферами типа _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ читайте в разделе [Асинхронная репликация данных из {{ PG }} в {{ CH }}](../../../tutorials/rdbms-to-clickhouse.md).

{% endnote %}

## Настройка эндпоинта-источника {{ PG }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mpg-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

Перед началом работы ознакомьтесь с [особенностями работы сервиса с источниками и приемниками {{ PG }}](../../../concepts/work-with-endpoints.md#postgresql).

### Кластер {{ mpg-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.mpg.viewer }}`](../../../../managed-postgresql/security/index.md#mpg-viewer) или примитивная [роль `viewer`](../../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение к БД с указанием кластера в {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите вариант подключения к базе данных:
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}** — позволяет задать настройки подключения вручную.
    
            Выберите тип инсталляции **Кластер Managed Service for PostgreSQL** и задайте настройки:
    
            * **Кластер управляемой БД** — выберите кластер, к которому необходимо подключиться.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — укажите имя базы данных в выбранном кластере.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}** — укажите пароль пользователя для доступа к базе данных.
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}** — позволяет использовать управляемое подключение к базе данных через [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):
    
            * Выберите каталог, в котором находится кластер {{ mpg-name }}.
            * Выберите тип инсталляции **Кластер управляемой БД** и задайте настройки:
    
                * **Кластер управляемой БД** — выберите кластер, к которому необходимо подключиться.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}** — укажите идентификатор управляемого подключения в {{ connection-manager-name }}.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — укажите имя базы данных в выбранном кластере.
    
            {% note warning %}
            
            Чтобы использовать подключение из {{ connection-manager-name }}, у пользователя должны быть [права доступа](../../../../metadata-hub/operations/connection-access.md) не ниже `connection-manager.user` к этому подключению.
            
            {% endnote %}
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.
      
      Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).

- CLI {#cli}

    * Тип эндпоинта — `postgres-source`.

    * `--cluster-id` — идентификатор кластера, к которому необходимо подключиться.
    * `--database` — имя базы данных.
    * `--user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    
    * Чтобы задать пароль пользователя для доступа к базе данных, используйте один из параметров:
    
        * `--raw-password` — пароль в текстовом виде.
        * `--password-file` — путь к файлу с паролем.

- {{ TF }} {#tf}

    * Тип эндпоинта — `postgres_source`.

    * `security_groups` — [группы безопасности](../../../../vpc/concepts/security-groups.md) для сетевого трафика. 
      
      Правила групп безопасности применяются к трансферу. Они позволяют открыть сетевой доступ с ВМ трансфера к кластеру. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
      
      Группы безопасности должны принадлежать той же сети, в которой размещен кластер.
      
      {% note info %}
      
      В {{ TF }} сеть для групп безопасности задавать не нужно.
      
      {% endnote %}
    * `connection.mdb_cluster_id` — идентификатор кластера, к которому необходимо подключиться.
    * `database` — имя базы данных.
    * `user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    * `password.raw` — пароль в текстовом виде.

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        postgres_source {
          security_groups = ["<список_идентификаторов_групп_безопасности>"]
          connection {
            mdb_cluster_id = "<идентификатор_кластера>"
          }
          database = "<имя_переносимой_базы_данных>"
          user     = "<имя_пользователя_для_подключения>"
          password {
            raw = "<пароль_пользователя>"
          }
          <дополнительные_настройки_эндпоинта>
        }
      }
    }
    ```


    Подробнее в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API {#api}

    * `securityGroups` — группы безопасности для сетевого трафика, правила которых применятся к ВМ и кластерам без изменения их настроек. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
    * `mdbClusterId` — идентификатор кластера, к которому необходимо подключиться.
    * `database` — имя базы данных.
    * `user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    * `password.raw` — пароль пользователя для доступа к базе данных (в текстовом виде).

{% endlist %}

### Пользовательская инсталляция {#on-premise}

Для случая OnPremise все поля заполняются вручную.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите вариант подключения к базе данных:
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}** — позволяет задать настройки подключения вручную.
    
            Выберите тип инсталляции **Пользовательская инсталляция** и задайте настройки:
    
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.host.title }}** — укажите IP-адрес или FQDN хоста-мастера. Если на хостах открыты разные порты для подключения, то вы можете задать несколько значений хостов в формате `хост:порт`. Если вы выбираете такой формат, то значение поля **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.port.title }}** не будет учитываться.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.port.title }}** — укажите номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — укажите имя базы данных в пользовательской инсталляции.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}** — укажите пароль пользователя для доступа к базе данных.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.ca_certificate.title }}** — загрузите файл [сертификата](../../../../managed-postgresql/operations/connect/index.md#get-ssl-cert) или добавьте его содержимое в текстовом виде, если требуется шифрование передаваемых данных, например, для соответствия требованиям PCI DSS.
              
              {% note warning %}
              
              Если не добавить сертификат, трансфер может [завершиться ошибкой](../../../troubleshooting/index.md#failed-to-connect).
              
              {% endnote %}
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md). Трансфер будет использовать эту подсеть для доступа к кластеру.
              
              Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}** — позволяет использовать управляемое подключение к базе данных через [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):
    
            * Выберите каталог, в котором создано управляемое подключение {{ connection-manager-name }}.
            * Выберите тип инсталляции **Пользовательская инсталляция** и задайте настройки:
    
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}** — укажите идентификатор управляемого подключения в {{ connection-manager-name }}.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — укажите имя базы данных в пользовательской инсталляции.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md). Трансфер будет использовать эту подсеть для доступа к кластеру.
                  
                  Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.
    
            {% note warning %}
            
            Чтобы использовать подключение из {{ connection-manager-name }}, у пользователя должны быть [права доступа](../../../../metadata-hub/operations/connection-access.md) не ниже `connection-manager.user` к этому подключению.
            
            {% endnote %}
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.
      
      Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).

- CLI {#cli}

    * Тип эндпоинта — `postgres-source`.

    * `--host` — IP-адрес или FQDN хоста-мастера, к которому необходимо подключиться.
    * `--port` — номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения.
    * `--ca-certificate` — сертификат CA, если требуется шифрование передаваемых данных, например для соответствия требованиям PCI DSS.
      
      {% note warning %}
      
      Если не добавить сертификат, трансфер может [завершиться ошибкой](../../../troubleshooting/index.md#failed-to-connect).
      
      {% endnote %}
    * `--subnet-id` — идентификатор подсети, в которой находится хост. Трансфер будет использовать эту подсеть для доступа к хосту.
    * `--database` — имя базы данных.
    * `--user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    
    * Чтобы задать пароль пользователя для доступа к базе данных, используйте один из параметров:
    
        * `--raw-password` — пароль в текстовом виде.
        * `--password-file` — путь к файлу с паролем.

- {{ TF }} {#tf}

    * Тип эндпоинта — `postgres_source`.

    * `security_groups` — [группы безопасности](../../../../vpc/concepts/security-groups.md) для сетевого трафика.
      
      Правила групп безопасности применяются к трансферу. Они позволяют открыть сетевой доступ с ВМ трансфера к ВМ с базой данных. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
      
      Группы безопасности должны принадлежать той же сети, что и подсеть `subnet_id`, если она указана.
      
      {% note info %}
      
      В {{ TF }} сеть для групп безопасности задавать не нужно.
      
      {% endnote %}
    * `on_premise.hosts` — список IP-адресов или FQDN хостов, к которым необходимо подключиться. Так как поддерживается только список из одного элемента, укажите адрес хоста-мастера.
    * `on_premise.port` — номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения.
    * `on_premise.tls_mode.enabled.ca_certificate` — сертификат CA, если требуется шифрование передаваемых данных, например для соответствия требованиям PCI DSS.
      
      {% note warning %}
      
      Если не добавить сертификат, трансфер может [завершиться ошибкой](../../../troubleshooting/index.md#failed-to-connect).
      
      {% endnote %}
    * `on_premise.subnet_id` — идентификатор [подсети](../../../../vpc/concepts/network.md#subnet), в которой находится хост. Трансфер будет использовать эту подсеть для доступа к хосту.
    * `database` — имя базы данных.
    * `user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    * `password.raw` — пароль в текстовом виде.

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        postgres_source {
          security_groups = ["<список_идентификаторов_групп_безопасности>"]
          connection {
            on_premise {
              hosts = ["<список_хостов>"]
              port  = <порт_для_подключения>
            }
          }
          database = "<имя_переносимой_базы_данных>"
          user     = "<имя_пользователя_для_подключения>"
          password {
            raw = "<пароль_пользователя>"
          }
          <дополнительные_настройки_эндпоинта>
        }
      }
    }
    ```


    Подробнее в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API {#api}

    * `onPremise` — параметры подключения к базе данных:
        * `hosts` — IP-адрес или FQDN хоста-мастера, к которому необходимо подключиться.
        * `port` — номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения.
        * `tlsMode` — параметры шифрования передаваемых данных, если оно требуется, например для соответствия требованиям PCI DSS.
            * `disabled` — отключено.
            * `enabled` — включено
                * `caCertificate` — сертификат CA.
          
                  {% note warning %}
                  
                  Если не добавить сертификат, трансфер может [завершиться ошибкой](../../../troubleshooting/index.md#failed-to-connect).
                  
                  {% endnote %}
        * `subnetId` — идентификатор подсети, в которой находится хост. Трансфер будет использовать эту подсеть для доступа к хосту.
    * `securityGroups` — группы безопасности для сетевого трафика, правила которых применятся к ВМ и кластерам без изменения их настроек. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
    * `database` — имя базы данных.
    * `user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    * `password.raw` — пароль пользователя для доступа к базе данных (в текстовом виде).

{% endlist %}

### Дополнительные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.table_filter.title }}**: 
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTableFilter.include_tables.title }}** — будут передаваться данные только из таблиц этого списка.

            Добавление новых таблиц при редактировании эндпоинта, использующегося в трансферах типа {{ dt-type-copy-repl }} или {{ dt-type-repl }} в статусе {{ dt-status-repl }}, не приведет к загрузке истории данных по этим таблицам. Чтобы добавить таблицу с ее историческими данными, используйте поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** в [настройках трансфера](../../transfer.md#update).

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTableFilter.exclude_tables.title }}** — данные таблиц из этого списка передаваться не будут.

      Списки включают имя [схемы]({{ pg-docs }}/ddl-schemas.html) (описание содержания, структуры и ограничений целостности базы данных) и имя таблицы. Для обоих списков поддерживаются выражения вида:

        * `<имя_схемы>.<имя_таблицы>` — полное имя таблицы;
        * `<имя_схемы>.*` — все таблицы в указанной схеме.

      Имена таблиц должны соответствовать регулярному выражению:

      ```text
      ^"?[-_a-zA-Z0-9.]+"?\\."?[$-_a-zA-Z0-9.*]+"?$
      ```

      Двойные кавычки внутри имени таблицы не поддерживаются. Внешние кавычки используются только как разделители и будут удалены при обработке путей.

      {% note warning %}
      
      Сервис не переносит пользовательские типы данных, если в эндпоинте для источника задан список включенных таблиц. В этом случае перенесите пользовательские типы данных вручную.
      
      {% endnote %}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.object_transfer_settings.title }}** — при необходимости выберите элементы схемы БД, которые будут перенесены в процессе активации или деактивации трансфера.
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.advanced_settings.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSourceAdvancedSettings.slot_byte_lag_limit.title }}** — максимальный размер Write-Ahead Log, удерживаемого слотом репликации. При превышении этого ограничения репликация останавливается и слот репликации удаляется. Значение по умолчанию — 50 ГБ. Данная настройка не является полной гарантией от переполнения диска на базе данных источника. Рекомендованный способ — это [мониторинг значения слота WAL-лога](../../prepare.md#source-pg) на базе данных источника с использованием [настройки](../../prepare.md#wal-setup-recommendation) `Max slot wal keep size`.
          
            {% note warning %}

            Использование настройки **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSourceAdvancedSettings.slot_byte_lag_limit.title }}** не гарантирует удаление слота репликации при превышении указанного в настройке значения в тех случаях, когда нарушена работа трансфера или доступность от трансфера до кластера-источника. См. рекомендации в разделе [Подготовка базы данных источника](#wal-setup-recommendation).  

            {% endnote %}

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSourceAdvancedSettings.service_schema.title }}** — укажите имя схемы для хранения служебных таблиц (`__consumer_keeper`, `__data_transfer_mole_finder`).

            Имя схемы должно соответствовать регулярному выражению:

            ```text
            ^[-_a-zA-Z0-9]*$
            ```

            Двойные кавычки в имени схемы не поддерживаются.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSourceAdvancedSettings.collapse_inherit_table.title }}** — выберите для объединения содержимого таблиц. Поведение трансфера будет также зависеть от настройки **Список включенных таблиц**. Подробнее читайте в разделе [Особенности работы с эндпоинтами](../../../concepts/work-with-endpoints.md#postgresql).

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSourceAdvancedSettings.snapshot_table_sharding_settings.title }}** — при необходимости задайте детальные настройки [параллельного копирования таблиц](../../../concepts/sharded.md) (если в трансфере заданы параметры параллельного копирования):

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.SnapshotTableShardingSettings.min_table_size.title }}** — минимальный размер таблицы для параллельного копирования. Таблицы меньшего размера будут скопированы в один поток.

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.SnapshotTableShardingSettings.degree_of_parallelism.title }}** — максимальное количество частей, на которые будет разделена таблица для параллельного копирования.

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.SnapshotTableShardingSettings.table_sharding_key_fields.title }}** — поля таблицы, по которым будет происходить разделение. Если поля не указаны, разделение будет происходить по первичному ключу.

- CLI {#cli}

    * `--include-table` — список включенных таблиц. Будут передаваться данные только из таблиц этого списка.

        Добавление новых таблиц при редактировании эндпоинта, использующегося в трансферах типа {{ dt-type-copy-repl }} или {{ dt-type-repl }} в статусе {{ dt-status-repl }}, не приведет к загрузке истории данных по этим таблицам. Чтобы добавить таблицу с ее историческими данными, используйте поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** в [настройках трансфера](../../transfer.md#update).

    * `--exclude-table` — список исключенных таблиц. Данные таблиц из этого списка передаваться не будут.

      Списки включают имя схемы (описание содержания, структуры и ограничений целостности базы данных) и имя таблицы. Для обоих списков поддерживаются выражения вида:

        * `<имя_схемы>.<имя_таблицы>` — полное имя таблицы;
        * `<имя_схемы>.*` — все таблицы в указанной схеме.

        {% note warning %}
        
        Сервис не переносит пользовательские типы данных, если в эндпоинте для источника задан список включенных таблиц. В этом случае перенесите пользовательские типы данных вручную.
        
        {% endnote %}

    * `--slot-lag-limit` — максимальный размер Write-Ahead Log, удерживаемого слотом репликации. При превышении этого ограничения репликация останавливается и слот репликации удаляется. Значение по умолчанию – 50 ГБ.

    * `--service-schema` — имя схемы БД для служебных таблиц.

    * Настройки переноса схемы:

        * `--transfer-before-data` — на первичной стадии трансфера.
        * `--transfer-after-data` — на финальной стадии трансфера.

- {{ TF }} {#tf}

    * `include_tables` — список включенных таблиц. Будут передаваться данные только из таблиц этого списка.

        Добавление новых таблиц при редактировании эндпоинта, использующегося в трансферах типа {{ dt-type-copy-repl }} или {{ dt-type-repl }} в статусе {{ dt-status-repl }}, не приведет к загрузке истории данных по этим таблицам. Чтобы добавить таблицу с ее историческими данными, используйте поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** в [настройках трансфера](../../transfer.md#update).

    * `exclude_tables` — список исключенных таблиц. Данные таблиц из этого списка передаваться не будут.

      Списки включают имя схемы (описание содержания, структуры и ограничений целостности базы данных) и имя таблицы. Для обоих списков поддерживаются выражения вида:

      * `<имя_схемы>.<имя_таблицы>` — полное имя таблицы;
      * `<имя_схемы>.*` — все таблицы в указанной схеме.

      {% note warning %}
      
      Сервис не переносит пользовательские типы данных, если в эндпоинте для источника задан список включенных таблиц. В этом случае перенесите пользовательские типы данных вручную.
      
      {% endnote %}

    * `slot_gigabyte_lag_limit` — максимальный размер Write-Ahead Log, удерживаемого слотом репликации. При превышении этого ограничения репликация останавливается и слот репликации удаляется. Значение по умолчанию – 50 ГБ.

    * `service_schema` — имя схемы БД для служебных таблиц.

    * `object_transfer_settings` — настройки переноса схемы:

        * `sequence` — последовательности;
        * `sequence_owned_by` — пользовательские последовательности;
        * `table` — таблицы;
        * `primary_key` —  первичные ключи;
        * `fk_constraint` — внешние ключи;
        * `default_values` — значения по умолчанию;
        * `constraint` — ограничения;
        * `index` — индексы;
        * `view` — представления;
        * `function` — функции;
        * `trigger` — триггеры;
        * `type` — типы;
        * `rule` — правила;
        * `collation` — правила сортировки;
        * `policy` — политики;
        * `cast` — приведения типов.

        Для каждой сущности может быть задано одно из значений:

        * `BEFORE_DATA` — перенос на этапе активации трансфера;
        * `AFTER_DATA` — перенос на этапе деактивации трансфера;
        * `NEVER` — не переносить.

    Подробнее в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API {#api}

    * `includeTables` — список включенных таблиц. Будут передаваться данные только из таблиц этого списка.

        Добавление новых таблиц при редактировании эндпоинта, использующегося в трансферах типа {{ dt-type-copy-repl }} или {{ dt-type-repl }} в статусе {{ dt-status-repl }}, не приведет к загрузке истории данных по этим таблицам. Чтобы добавить таблицу с ее историческими данными, используйте поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** в [настройках трансфера](../../transfer.md#update).

    * `excludeTables` — список исключенных таблиц. Данные таблиц из этого списка передаваться не будут.

      Списки включают имя схемы (описание содержания, структуры и ограничений целостности базы данных) и имя таблицы. Для обоих списков поддерживаются выражения вида:

        * `<имя_схемы>.<имя_таблицы>` — полное имя таблицы;
        * `<имя_схемы>.*` — все таблицы в указанной схеме.

        {% note warning %}
        
        Сервис не переносит пользовательские типы данных, если в эндпоинте для источника задан список включенных таблиц. В этом случае перенесите пользовательские типы данных вручную.
        
        {% endnote %}

    * `slotByteLagLimit` — максимальный размер Write-Ahead Log, удерживаемого слотом репликации. При превышении этого ограничения репликация останавливается и слот репликации удаляется. Значение по умолчанию – 50 ГБ.

    * `serviceSchema` — имя схемы БД для служебных таблиц.

    * `objectTransferSettings` — настройки переноса схемы на первичной и финальной стадиях трансфера (значения `BEFORE_DATA` и `AFTER_DATA`, соответственно).

{% endlist %}

#### Настройки переноса схемы при активации и деактивации трансфера {#schema-migrations-settings}

{% note info %}

Настройки эндпоинта для источника по умолчанию позволяют успешно выполнить трансфер для большинства баз данных. Изменяйте настройки первичной и финальной стадий переноса только если в этом есть необходимость.

{% endnote %}

В процессе работы трансфера схема базы данных переносится с источника на приемник. Перенос выполняется в два этапа:

1. На стадии активации.

    Этот этап выполняется при активации трансфера перед копированием или репликацией для создания схемы на приемнике. Вы можете выбрать, какие части схемы будут перенесены. По умолчанию это `TABLE`, `VIEW`, `PRIMARY KEY`, `SEQUENCE`, `SEQUENCE OWNED BY`, `RULE`, `TYPE`, `FUNCTION`, `DEFAULT`.

1. На стадии деактивации.

    Эта стадия выполняется в конце работы трансфера, при его деактивации. Если трансфер постоянно работает в режиме репликации, то финальная стадия переноса будет выполнена только при остановке репликации. Вы можете выбрать, какие части схемы будут перенесены.

    На финальной стадии предполагается, что при деактивации трансфера на источнике нет пишущей нагрузки. Это можно гарантировать переводом в режим <q>только чтение</q> (read-only). На этой стадии схема базы данных на приемнике приводится в состояние, когда она будет консистентна схеме на источнике.

    Рекомендуется включать в финальную стадию переноса ресурсоемкие операции, например, перенос индексов. Перенос индексов в начале трансфера может замедлить его работу.

Перенос схемы и на первичной, и на финальных стадиях выполняется с помощью [утилиты](https://www.postgresql.org/docs/current/app-pgdump.html) `pg_dump`.

{% note info %}

При редактировании настроек одного из эндпоинтов трансфера, который находится в состоянии {{ dt-status-repl }}, схемы таблиц на приемнике сохраняются. При этом на приемник переносятся только схемы таблиц, отсутствующих в приемнике на момент перезапуска трансфера.

{% endnote %}

Значения позиций в последовательности при репликации нельзя гарантированно сохранить, поэтому рекомендуется сделать обновление `sequence` на приемнике.

## Настройка приемника данных {#supported-targets}

Настройте один из поддерживаемых приемников данных:

* [{{ PG }}](../target/postgresql.md);
* [{{ MY }}](../target/mysql.md);
* [{{ CH }}](../target/clickhouse.md);
* [{{ GP }}](../target/greenplum.md);
* [{{ ydb-full-name }}](../target/yandex-database.md);
* [{{ objstorage-full-name }}](../target/object-storage.md);
* [{{ KF }}](../target/kafka.md);
* [{{ DS }}](../target/data-streams.md);
* [{{ ytsaurus-name }}](yt.md);
* [{{ OS }}](../target/opensearch.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} читайте в разделе [Доступные трансферы](../../../transfer-matrix.md).

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Действия с базой данных во время трансфера {#db-actions}

{% note tip %}

Протокол репликации {{ PG }} не поддерживает передачу изменения схемы данных. Избегайте изменения схемы данных в базах источника и приемника во время трансфера. Если избежать этого невозможно, проведите явные проверки на приемнике.

{% endnote %}

Для трансферов типа _{{ dt-type-copy }}_ и _{{ dt-type-copy-repl }}_:

* в статусе {{ dt-status-copy }} запрещено изменять схему данных на источнике и приемнике;
* в статусе {{ dt-status-repl }} любые изменения схемы данных на источнике вручную примените на приемнике, иначе трансфер не сможет продолжить работу.

  Например, пусть в таблицу `test_table` источника добавили новый столбец:

    ```sql
    ALTER TABLE test_table ADD COLUMN val2 TEXT;
    ```

  Если запись в эту таблицу продолжается, трансфер не сможет выполнить вставку данных на приемнике. Чтобы репликация продолжилась, выполните аналогичный запрос на изменение схемы данных на приемнике:

    ```sql
    ALTER TABLE test_table ADD COLUMN val2 TEXT;
    ```

  После этого трансфер сможет продолжить работу.

## Решение проблем, возникающих при переносе данных {#troubleshooting}

Известные проблемы, связанные с использованием эндпоинта {{ PG }}:

* [Остановка сессии мастер-транзакции трансфера](#master-trans-stop)
* [Превышение квоты на длительность соединения](#conn-duration-quota)
* [Ошибка трансфера при переносе представлений (VIEW)](#view)
* [Ошибка добавления записи в таблицу по constraint](#constraint)
* [Ошибка при переносе всех таблиц схемы](#schema)
* [Невозможно создать объекты с участием функций расширения](#extension-functions)
* [Низкая скорость трансфера](#low-speed)
* [Не переносятся таблицы-наследники](#successor-tables)
* [Не хватает слотов репликации в базе данных источника](#replication-slots)
* [Перестали переноситься данные после изменения эндпоинта-источника](#no-data-transfer)
* [Ошибка трансфера при смене хоста-мастера](#master-change)
* [Не хватает истории в WAL для продолжения репликации при смене хоста-мастера](#no-wal-story)
* [Ошибка при трансфере вложенных транзакций](#inner-tables)
* [Ошибка трансфера таблиц с отложенными ограничениями](#deferrable-constr)
* [Не удается создать слот репликации на стадии активации](#lock-replication)
* [Чрезмерное увеличение журнала WAL](#excessive-wal)
* [Ошибка при репликации из внешнего источника](#external-replication)
* [Ошибка трансфера при переносе таблиц без первичных ключей](#primary-keys)
* [Повторяющееся значение ключа нарушает уникальное ограничение](#duplicate-key)
* [Ошибка удаления таблицы при политике очистки Drop](#drop-table-error)
* [Ошибка при переносе таблиц с генерируемыми столбцами](#generated-columns)

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

### Остановка сессии мастер-транзакции трансфера {#master-trans-stop}

Текст ошибки:

```text
Cannot set transaction snapshot:
ERROR: invalid snapshot identifier: "<идентификатор_снапшота>" (SQLSTATE 22023).
```

Возможные причины:

* На источнике работает cron-задание или другое приложение, которое периодически завершает слишком длительные сессии.
* Кто-то вручную завершил мастер-транзакцию.
* Ресурсов CPU на источнике не хватает для выполнения запроса.
* В настройке кластера {{ PG }} [Session duration timeout](../../../../managed-postgresql/concepts/settings-list.md#setting-session-duration-timeout) установлено ограничение на время жизни активной сессии.

**Решение:** отключите такое cron-задание, добавьте дополнительные ресурсы для CPU на источник, а также установите значение параметра **Session duration timeout** равным `0` на время трансфера. После внесения изменений [активируйте](../../transfer.md#activate) трансфер повторно.

### Превышение квоты на длительность соединения {#conn-duration-quota}

В {{ mpg-full-name }} существует квота на длительность соединения — 12 часов.
​
​**Решение:** если перенос базы данных требует больше времени, [измените настройку кластера](../../../../managed-postgresql/operations/update.md#change-postgresql-config) {{ mpg-full-name }} [Session duration timeout](../../../../managed-postgresql/concepts/settings-list.md#setting-session-duration-timeout).

### Ошибка трансфера при переносе представлений (VIEW) {#view}

Текст ошибки:

```text
[ERROR] "... _view": no key columns found
```

Репликация новых данных из представлений невозможна. При трансфере {{ PG }} — {{ PG }} переносятся только те представления, которые указаны в параметре эндпоинта-источника **Фильтр таблиц** → **Список включенных таблиц**.

**Решение:** вручную исключите из трансфера все представления, записав их в [параметре эндпоинта-источника](postgresql.md#additional-settings) **Фильтр таблиц** → **Список исключённых таблиц**, после чего [активируйте](../../transfer.md#activate) трансфер повторно.

### Ошибка добавления записи в таблицу по constraint {#constraint}

**Решение:** подготовьте источник в соответствии с разделом [Подготовка к трансферу](../../prepare.md#source-pg).

### Ошибка при переносе всех таблиц схемы {#schema}

Текст ошибки:

```text
Unable to apply DDL of type 'TABLE', name '<схема>'.'<таблица>', error:
ERROR: schema "<схема>" does not exist (SQLSTATE 3F000)
```

Трансфер прерывается при указании списка таблиц определенной схемы в виде `<схема>.*`. Это происходит из-за особенностей работы утилиты `pg_dump`, которая используется для переноса схемы. При указании таблиц всей схемы `<схема>.*` в [параметре эндпоинта-источника](postgresql.md#additional-settings) **Фильтр таблиц** → **Список включенных таблиц** типы {{ PG }} из этой схемы не извлекаются, даже если в схеме есть таблицы, зависящие от этих типов.

**Решение:** создайте типы {{ PG }} в базе-приемнике вручную.

### Невозможно создать объекты с участием функций расширения {#extension-functions}

Текст ошибки:

```text
Unable to apply DDL of type 'TABLE', <имя_объекта>, error:
failed to push non-row item 0 of kind "pg:DDL" in batch:
Push failed: ERROR: function <имя_схемы>.<имя_функции>() does not exist 
(SQLSTATE 42883)
```

В {{ mpg-name }} в базе-приемнике невозможно установить расширение в пользовательскую схему. Поэтому трансфер прерывается, если в пользовательской инсталляции {{ mpg-name }} есть расширения, установленные в пользовательскую схему, и эти расширения используются в DDL переносимых объектов.

**Решение:** проверьте DDL объектов, имена которых указаны в ошибке. Если в этих объектах есть вызов функций из пользовательской схемы, вручную создайте в приемнике DDL, которые вызывают функции без указания схемы. В политике очистки эндпоинта-приемника установите значение `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}`, чтобы трансфер не удалил эти объекты.

### Низкая скорость трансфера  {#low-speed}

​Может возникать у трансферов типа _{{ dt-type-copy }}_ или _{{ dt-type-copy-repl }}_ из {{ PG }} в {{ PG }}.

Возможные причины:

* Протокол записи.

    В нормальном режиме трансфер работает через быстрый протокол `copy`, но при конфликтах записи батча переходит на медленную построчную запись. Чем больше конфликтов записи, тем ниже скорость трансфера.

    **Решение:** установите в эндпоинте-приемнике тип политики очистки `Drop` и исключите другие пишущие процессы.

* Параллельность чтения таблиц.

    Параллельность доступна только для таблиц, которые содержат первичный ключ. При использовании ключа [типа `serial`](https://www.postgresql.org/docs/current/datatype-numeric.html#DATATYPE-SERIAL) части таблиц читаются по диапазонам. Другие типы ключей позволяют равномерно распределять таблицы в соответствии со специальным алгоритмом.

    **Решение:** настройте [параллельное копирование](../../../concepts/sharded.md) и [активируйте трансфер](../../transfer.md#activate) повторно.

### Не переносятся таблицы-наследники {#successor-tables}

Во время трансфера не переносятся таблицы-наследники, либо переносятся без данных, если таблица партицированная.

**Решение:** установите следующие параметры эндпоинта-источника:

1. Включите опцию **Объединить наследуемые таблицы** в расширенных настройках.
1. Укажите в поле **Список включенных таблиц** все таблицы-наследники, данные которых нужно перенести.
1. Убедитесь, что у пользователя есть доступ к таблицам-наследникам.

Для увеличения скорости трансфера при переносе таблиц-наследников настройте [параллельное копирование](../../../concepts/sharded.md).

### Не хватает слотов репликации в базе данных источника {#replication-slots}

Текст ошибки:

```text
Warn(Activate): failed to create a replication slot "<идентификатор_трансфера>" at source:
failed to create a replication slot:
failed to create a replication slot:
ERROR: all replication slots are in use
(SQLSTATE 53400)
```

**Решение:** увеличьте количество [слотов репликации]({{ pg-docs }}/logical-replication-config.html) в базе-источнике (по умолчанию `10`).

### Перестали переноситься данные после изменения эндпоинта-источника {#no-data-transfer}

После добавления таблиц в **Список включенных таблиц** в параметрах эндпоинта-источника трансфер перезапустился и перестал переносить данные.

**Решение:**

* Создайте таблицы в базе-приемнике вручную.

    1\. Создайте в базе-приемнике новые таблицы с `Primary Key` и без `Foreign key`.
    2\. Добавьте новые таблицы в **Список включенных таблиц** в [параметрах эндпоинта-источника](postgresql.md#additional-setting).
    3\. Перенесите дамп с историческими данными в базу-приемник.
    4\. При появлении в логах ошибок решите их согласно конкретной ошибке.
    5\. Если ошибок нет, но логи пусты, обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру для снятия дампа горутин. Это может помочь восстановить репликацию без повторного запуска трансфера.

* [Деактивируйте](../../transfer.md#deactivate) и [активируйте](../../transfer.md#activate) трансфер повторно.
* [Создайте](../../transfer.md#create) отдельный трансфер типа _{{ dt-type-copy }}_ для новых таблиц. При этом исходный трансфер можно не деактивировать.

### Ошибка трансфера при смене хоста-мастера {#master-change}

Ошибка возникает в трансферах типа _{{ dt-type-repl }}_ или _{{ dt-type-copy-repl }}_ из-за отсутствия нужных частей Write-Ahead Log (WAL). Это происходит, когда отставание логической репликации WAL с текущего мастера на реплику превышает доступный объем WAL на других хостах. Поэтому при переключении мастера на эту реплику слот репликации не может синхронизироваться с WAL на новом мастере.

**Решение:** увеличьте лимит в [дополнительном параметре эндпоинта-источника](postgresql.md#additional-setting) **Максимальный размер WAL для слота репликации** и [активируйте](../../transfer.md#activate) трансфер повторно.

### Не хватает истории в WAL для продолжения репликации при смене хоста-мастера {#no-wal-story}

При смене хоста-мастера в кластере-источнике трансферы типа _{{ dt-type-repl }}_ или _{{ dt-type-copy-repl }}_ могут завершиться ошибкой:

```text
ERROR: requested WAL segment pg_wal/0000000E0000022700000087 has already been removed (SQLSTATE 58P01)
```

Ошибка возникает, если хранимой в [WAL](https://www.postgresql.org/docs/current/wal-intro.html) на новом мастере истории недостаточно для продолжения репликации с того же места.

**Решение**: увеличьте в кластере-источнике значение [настройки](../../../../managed-postgresql/concepts/settings-list.md#setting-wal-keep-size) `Wal keep size`. В качестве минимального значения рекомендуется взять среднее значение из графика **Source buffer size** в [мониторинге {{ data-transfer-name }}](../../monitoring.md). Если на диске достаточно свободных ресурсов, укажите значение настройки с запасом.

### Ошибка при трансфере вложенных транзакций {#inner-tables}

Трансфер {{ PG }} версий ниже 14 не поддерживает перенос таблиц с примененными транзакциями, которые вложены более 1024 раз и на каждом уровне вложенности есть изменения для репликации. Количество вложенностей определяется по числу вложенных конструкций `begin; .. commit;`.

**Решение:**

* Используйте {{ PG }} версии 14 или выше.
* Исключите из трансфера транзакции с таким уровнем вложенности.

### Ошибка трансфера таблиц с отложенными ограничениями {#deferrable-constr}

Ошибка возникает в трансферах типа {{ dt-type-repl }} или {{ dt-type-copy-repl }}, так как обновление таблиц и транзакций с отложенными (`DEFERRABLE`) ограничениями не поддерживается {{ data-transfer-name }}. Подробнее об отложенных ограничениях в [документации {{ PG }}](https://www.postgresql.org/docs/current/sql-set-constraints.html).

**Решение:** замените тип ограничений в таких таблицах на `IMMEDIATE` и [активируйте](../../transfer.md#activate) трансфер повторно.

### Не удается создать слот репликации на стадии активации {#lock-replication}

В начале работы трансфера создается один или несколько [слотов репликации]({{ pg-docs }}/logicaldecoding-explanation.html#LOGICALDECODING-REPLICATION-SLOTS) в базе-источнике. При этом объекты базы блокируются. Если какой-то объект заблокирован другой транзакцией, возникнет конкурирующая блокировка, и трансфер завершится с ошибкой.

**Решение:**

1. Найдите процесс, конкурирующий за блокировки с трансфером:

   ```sql
   SELECT
     activity.pid,
     activity.usename,
     activity.query,
     blocking.pid AS blocking_id,
     blocking.query AS blocking_query
   FROM
     pg_stat_activity AS activity
     JOIN pg_stat_activity AS blocking ON blocking.pid = ANY(
       pg_blocking_pids(activity.pid)
     )
   WHERE
     activity.query like '%<идентификатор_трансфера>%';
   ```

   Идентификатор трансфера можно получить со [списком трансферов в каталоге](../../transfer.md#list).

   Ответ:

   ```text
          pid      |      usename       |      query      |         blocking_id          |    blocking_query
   ----------------+--------------------+-----------------+------------------------------+----------------------
   <PID_трансфера> | <имя_пользователя> | <текст_запроса> | <PID_блокирующей_транзакции> | <блокирующий_запрос>
   (1 row)
   ```

1. Остановите транзакцию командой:

   ```sql
   SELECT pg_terminate_backend(<PID_блокирующей_транзакции>);
   ```

1. [Активируйте трансфер](../../transfer.md#activate) повторно.

### Чрезмерное увеличение журнала WAL {#excessive-wal}

Рост журнала WAL может происходить при работе трансферов типов {{ dt-type-copy-repl }} и {{ dt-type-repl }}. Увеличение размера WAL можно заметить по:

* увеличению занятого места на диске кластера-источника (график **Disk usage on primary**);
* увеличению объема WAL-файлов на кластере-источнике (график **Total size of WAL files**);
* росту на графиках **[Source buffer size](../../monitoring.md#publisher.consumer.log_usage_bytes)** или **[Maximum data transfer delay](../../monitoring.md#sinker.pusher.time.row_max_lag_sec)** в мониторинге {{ data-transfer-name }}.

**Решение:**

Действуйте в зависимости от текущей стадии трансфера:

   Стадия трансфера | Причина роста WAL | Рекомендуемое действие                                                                            
   --------|-----|---------------------------------------------------------
   Копирование | Рост WAL ожидаем.  |  Дождитесь перехода трансфера на стадию репликации.                          
   Репликация | В базе-источнике присутствуют долгие транзакции (выполняющиеся более 5 минут). Такие запросы вызывают рост журнала WAL и мешают его архивации. | Дождитесь завершения транзакции или завершите сессии самостоятельно. Найти долгие транзакции можно с помощью запроса:<br>```SELECT pid, now() - pg_stat_activity.query_start```<br>```AS duration, query, state```<br>```FROM pg_stat_activity```<br>```WHERE (now() - pg_stat_activity.query_start) > interval '5 minutes'```<br>```AND state != 'idle';```
   Репликация | На источнике наблюдается большой поток изменений, который трансфер не успевает обрабатывать. | [Проверьте](../../../metrics.md) утилизацию ресурсов трансфера. Если ресурсы утилизированы полностью, то увеличьте их, уменьшите количество потоков или разделите один трансфер на несколько трансферов. [Проверьте](../../../metrics.md) утилизацию ресурсов источника и приемника. Если ресурсы утилизированы полностью, то увеличьте их.
   Репликация | На источнике в переносимых объектах была изменена схема (добавлены или удалены поля в таблицах, изменены типы и т.п.). Данные перестали записываться в приемник из-за несоответствия схем. | Самостоятельно повторите изменения схемы на приемнике.

### Ошибка при репликации из внешнего источника {#external-replication}

Текст ошибки:

```text
[XX000] ERROR: could not connect to the publisher:
SSL error: certificate verify failed FATAL:
no pg_hba.conf entry for replication connection
from host "<IP-адрес_хоста_{{ PG }}>", user "postgres", SSL off
```

**Решение:** подготовьте источник в соответствии с разделом [Подготовка к трансферу](../../prepare.md#source-pg).

### Ошибка трансфера при переносе таблиц без первичных ключей {#primary-keys}

Текст ошибки:

```text
Primary key check failed: 14 Tables errors: Table no key columns found
```

Для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ таблицы без первичных ключей не переносятся.

**Решение:** подготовьте источник в соответствии с разделом [Подготовка к трансферу](../../prepare.md).

### Повторяющееся значение ключа нарушает уникальное ограничение {#duplicate-key}

Текст ошибки:

```text
ERROR: duplicate key value violates unique constraint "<название_ограничения>" (SQLSTATE 23505)
```

Ошибка может возникнуть при репликации данных из {{ PG }} в {{ PG }}. Например, когда не все события транзакции поместились в память и в базу-приемник передана только часть строк транзакции из базы-источника. В базе-приемнике эта часть строк по умолчанию применяется в отдельной транзакции, поэтому в определенный момент времени может возникнуть нарушение ограничений, например дублирование ключа.

**Решение:** используйте один из вариантов:

* Для эндпоинта-приемника [включите расширенную настройку](../target/postgresql.md#additional-settings) **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTargetAdvancedSettings.save_tx_boundaries.title }}**. {{ data-transfer-name }} откроет транзакцию, применит пришедшие события, но выполнит коммит транзакции, только когда начнет получать данные следующей транзакции.

    Включение настройки **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTargetAdvancedSettings.save_tx_boundaries.title }}** может немного снизить производительность трансфера, но позволит избежать ошибок, связанных с нарушением ограничений.

* Отключите в базе-приемнике ограничения. В определенный момент времени возможно нарушение ограничений (например, когда применена часть транзакции из базы-источника в базе-приемнике). Но {{ data-transfer-name }} гарантирует согласованность данных в итоге (eventually consistency) — когда вторая часть транзакции применится в базе-приемнике, нарушения ограничений не будет.

### Ошибка удаления таблицы при политике очистки Drop {#drop-table-error}

Текст ошибки:

```text
ERROR: cannot drop table <имя_таблицы> because other objects depend on it (SQLSTATE 2BP01)
```

При политике очистки `Drop` трансфер удаляет таблицы в несколько итераций:

1. Трансфер последовательно пытается удалить все таблицы. Каскадное удаление не используется, так как может привести к удалению таблиц, не участвующих в трансфере. Если таблицу невозможно удалить, например, из-за связанности внешними ключами, возникает ошибка, но трансфер продолжит удаление таблиц.
1. Во время следующей итерации трансфер пытается удалить оставшиеся таблицы. Если блокирующие дочерние таблицы были удалены в предыдущей итерации, таблица со связанностью внешними ключами удаляется. В этом случае ошибка устраняется в процессе работы {{ data-transfer-name }}, дополнительных действий не требуется.
1. Если во время очередной итерации трансфер не удалил ни одной таблицы, процесс удаления таблиц завершается. При этом:

    * Трансфер продолжит работу, если все таблицы были удалены.
    * Трансфер прервется с ошибкой, если остались неудаленные таблицы.

**Решение:**

* Если дочерние таблицы не участвуют в других трансферах и их перенос не противоречит целям трансфера, добавьте эти таблицы:

    * В список включенных таблиц в параметрах эндпоинта-источника.
    * В список объектов для переноса в параметрах трансфера.

* Удалите блокирующие дочерние таблицы в базе-приемнике вручную.
* Используйте политику очистки `Truncate`.
* Пересоздайте базу в приемнике.

    {% note warning %}

    Это приведет к потере всех данных в базе.

    {% endnote %}

### Ошибка при переносе таблиц с генерируемыми столбцами {#generated-columns}

Текст ошибки:

```text
ERROR: column "<имя_столбца>" is a generated column (SQLSTATE 42P10)
```

Ошибка может возникнуть, если из базы-источника переносится таблица, которая содержит генерируемые столбцы. Например, если генерируемый столбец определен как столбец идентификаторов (`GENERATED ... AS IDENTITY`), то ошибка возникнет при репликации данных. Если генерируемый столбец вычисляемый, то ошибка возникнет независимо от типа трансфера. Подробнее о генерируемых столбцах в [документации {{ PG }}]({{ pg-docs }}/ddl-generated-columns.html).

**Решение**: в [параметрах эндпоинта-источника](postgresql.md#additional-settings) исключите из трансфера таблицы, которые содержат генерируемые столбцы.