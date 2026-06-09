# Передача данных из эндпоинта-источника {{ MY }}

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные из базы {{ MY }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных {{ MY }}](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. [Выполняйте необходимые действия по работе с базой](#db-actions) и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных из {{ MY }} {#scenarios}

1. Миграция — перенос данных из одного хранилища в другое. Часто это перенос базы из устаревших локальных баз в управляемые облачные.

    * [Миграция кластера {{ MY }}](../../../tutorials/managed-mysql-to-mysql.md);
    * [Миграция со сменой хранилища: {{ MY }} в {{ ydb-short-name }}](../../../tutorials/managed-mysql-to-ydb.md);
    * [Миграция со сменой хранилища: {{ MY }} в {{ PG }}](../../../tutorials/mmy-to-mpg.md);
    * [Миграция со сменой хранилища: {{ MY }} в {{ GP }}](../../../tutorials/mmy-to-mgp.md).

1. Захват изменений данных — это процесс отслеживания изменений в базе данных и поставка этих изменений потребителям. Применяется для приложений, которые чувствительны к изменению данных в реальном времени.

    * [Захват изменений из {{ MY }} и поставка в {{ DS }}](../../../tutorials/mmy-to-yds.md);
    * [Захват изменений из {{ MY }} и поставка в {{ KF }}](../../../tutorials/cdc-mmy.md).

1. Загрузка данных в витрины — процесс трансфера подготовленных данных в хранилища с целью последующей визуализации.

    * [Загрузка данных из {{ MY }} в витрину {{ CH }}](../../../tutorials/mysql-to-clickhouse.md).

1. Загрузка данных в масштабируемое хранилище {{ objstorage-name }} позволяет удешевить хранение и облегчает обмен данных с контрагентами.

    * [Загрузка данных {{ MY }} в масштабируемое хранилище {{ objstorage-name }}](../../../tutorials/mmy-objs-migration.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} читайте в разделе [Практические руководства](../../../tutorials/index.md).

## Подготовка базы данных источника {#prepare}

{% list tabs %}

- {{ mmy-name }}

    
    1. [Включите режим полного бинарного лога](../../../../managed-mysql/operations/update.md#change-mysql-config) на источнике, установив значение `FULL` или `NOBLOB` для [параметра **Binlog row image**](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_row_image).
 
    1. (Опционально) [Настройте лимит](../../../../managed-mysql/operations/update.md#change-mysql-config) на размер отправляемых кусков данных (chunk) с помощью параметра **Max allowed packet**.
    
    1. [Создайте пользователя](../../../../managed-mysql/operations/cluster-users.md#adduser) для подключения к источнику.
        
        1. [Выдайте пользователю привилегию](../../../../managed-mysql/operations/grant.md#grant-privilege) `ALL_PRIVILEGES` для базы-источника.
        
        1. [Выдайте пользователю административные привилегии](../../../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges) `REPLICATION CLIENT` и `REPLICATION SLAVE`.
    
    1. Для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ таблицы без уникальных индексов не переносятся. 
       
       Если в таблице, содержащей строку, есть первичный ключ, то при изменении строки в бинарный лог записываются только столбцы первичного ключа. Если первичного ключа нет, но есть уникальный индекс, все столбцы которого не равны `NULL`, то в бинарный лог записываются только эти столбцы. Если нет ни первичного ключа, ни уникального индекса без `NULL`, то в бинарный лог записываются все столбцы в строке.
       
       Чтобы сохранить работоспособность трансфера при переносе базы, содержащей таблицы без уникальных индексов:
       
       * Не переносите такие таблицы. Для этого добавьте их в список исключенных таблиц в [настройках эндпоинта для источника](mysql.md#additional-settings).
       
       * Создайте уникальные индексы, например первичные ключи (`PRIMARY KEY`), в тех мигрируемых таблицах, где их нет.
       
           1. Чтобы получить список таблиц без первичного ключа, выполните запрос:
       
               ```sql
               SELECT
                   tab.table_schema AS database_name,
                   tab.table_name AS table_name,
                   tab.table_rows AS table_rows,
                   tco.*
               FROM information_schema.tables tab
                   LEFT JOIN information_schema.table_constraints tco
                       ON (tab.table_schema = tco.table_schema
                           AND tab.table_name = tco.table_name
               )
               WHERE
                   tab.table_schema NOT IN ('mysql', 'information_schema', 'performance_schema', 'sys')
                   AND tco.constraint_type IS NULL
                   AND tab.table_type = 'BASE TABLE';
               ```
       
           1. Изучите структуру таблиц без первичного ключа, которые необходимо перенести на приемник:
       
               ```sql
               SHOW CREATE TABLE <имя_базы>.<имя_таблицы>;
               ```
       
           1. Добавьте простой или составной первичный ключ к таблицам, которые необходимо перенести на приемник:
       
               ```sql
               ALTER TABLE <имя_таблицы> ADD PRIMARY KEY (<столбец_или_группа_столбцов>);
               ```
       
           1. Если в переносимой на приемник таблице нет столбца или группы столбцов, подходящих на роль первичного ключа, создайте новый столбец:
       
               ```sql
               ALTER TABLE <имя_таблицы> ADD id BIGINT PRIMARY KEY AUTO_INCREMENT;
               ```
    
       {% note info %}
    
       Если создание первичного ключа завершается ошибкой _`Creating index 'PRIMARY' required more than 'innodb_online_alter_log_max_size' bytes of modification log. Please try again`_, [увеличьте в настройках СУБД](../../../../managed-mysql/operations/update.md#change-mysql-config) значение [параметра `Innodb log file size`](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size).
    
       {% endnote %}
    
    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_). Подробнее — в [описании дополнительных настроек эндпоинта для источника {{ MY }}](mysql.md#additional-settings).

- {{ MY }}
    
    1. Если вы не планируете использовать для подключения к внешнему кластеру [сервис {{ interconnect-name }}](../../../../interconnect/concepts/index.md) или [VPN](../../../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом {{ data-transfer-name }}](../../../../overview/concepts/public-ips.md#virtual-private-cloud}).
       
       Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../../../concepts/network.md#source-external).
    
    1. Убедитесь, что источник использует подсистему хранения данных низкого уровня MyISAM или InnoDB. При использовании других подсистем трансфер может завершиться с ошибкой.
    
    1. [Включите режим полного бинарного лога](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image) на источнике, установив значение `FULL` или `NOBLOB` для параметра `binlog_row_image`.

       {% note info %}

       Для MariaDB 11.4 и выше задайте параметр `binlog_legacy_event_pos = true`.

       {% endnote %}    
    
    1. [Задайте строковый формат бинарного лога](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_format) на источнике, установив значение `ROW` для параметра `binlog_format`.

    1. Для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_:

        * [Укажите путь к расположению бинарного лог-файла]({{ my.docs }}/refman/8.0/en/replication-options-binary-log.html#option_mysqld_log-bin) в параметре `log_bin`.

        * Выведите информацию о бинарном логе с помощью запроса [SHOW MASTER STATUS]({{ my.docs }}/refman/8.0/en/show-master-status.html) (для версий {{ MY }} 5.7 и 8.0) или [SHOW BINARY LOG STATUS]({{ my.docs }}/refman/8.4/en/show-binary-log-status.html) (для версии {{ MY }} 8.4). Запрос должен возвращать строку с информацией, а не пустой ответ.

    1. Если источник репликации — кластер, который находится за балансером, включите для него GTID-режим (`GTID-MODE = ON`).
    
       Если по какой-то причине включить GTID-режим невозможно, убедитесь, что шаблон имен бинарных логов содержит имя хоста.
    
       В обоих случаях это позволит продолжить репликацию в случае смены хоста-мастера.
    
    1. (Опционально) [Настройте лимит](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet) на размер отправляемых кусков данных (chunk) с помощью параметра `max_allowed_packet`.
    
    1. Создайте пользователя для подключения к источнику и выдайте ему необходимые привилегии:
    
        ```sql
        CREATE USER '<имя_пользователя>'@'%' IDENTIFIED BY '<пароль>';
        GRANT ALL PRIVILEGES ON <имя_базы>.* TO '<имя_пользователя>'@'%';
        GRANT REPLICATION CLIENT, REPLICATION SLAVE ON *.* TO '<имя_пользователя>'@'%';
        ```

    1. Для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ таблицы без уникальных индексов не переносятся. 
       
       Если в таблице, содержащей строку, есть первичный ключ, то при изменении строки в бинарный лог записываются только столбцы первичного ключа. Если первичного ключа нет, но есть уникальный индекс, все столбцы которого не равны `NULL`, то в бинарный лог записываются только эти столбцы. Если нет ни первичного ключа, ни уникального индекса без `NULL`, то в бинарный лог записываются все столбцы в строке.
       
       Чтобы сохранить работоспособность трансфера при переносе базы, содержащей таблицы без уникальных индексов:
       
       * Не переносите такие таблицы. Для этого добавьте их в список исключенных таблиц в [настройках эндпоинта для источника](mysql.md#additional-settings).
       
       * Создайте уникальные индексы, например первичные ключи (`PRIMARY KEY`), в тех мигрируемых таблицах, где их нет.
       
           1. Чтобы получить список таблиц без первичного ключа, выполните запрос:
       
               ```sql
               SELECT
                   tab.table_schema AS database_name,
                   tab.table_name AS table_name,
                   tab.table_rows AS table_rows,
                   tco.*
               FROM information_schema.tables tab
                   LEFT JOIN information_schema.table_constraints tco
                       ON (tab.table_schema = tco.table_schema
                           AND tab.table_name = tco.table_name
               )
               WHERE
                   tab.table_schema NOT IN ('mysql', 'information_schema', 'performance_schema', 'sys')
                   AND tco.constraint_type IS NULL
                   AND tab.table_type = 'BASE TABLE';
               ```
       
           1. Изучите структуру таблиц без первичного ключа, которые необходимо перенести на приемник:
       
               ```sql
               SHOW CREATE TABLE <имя_базы>.<имя_таблицы>;
               ```
       
           1. Добавьте простой или составной первичный ключ к таблицам, которые необходимо перенести на приемник:
       
               ```sql
               ALTER TABLE <имя_таблицы> ADD PRIMARY KEY (<столбец_или_группа_столбцов>);
               ```
       
           1. Если в переносимой на приемник таблице нет столбца или группы столбцов, подходящих на роль первичного ключа, создайте новый столбец:
       
               ```sql
               ALTER TABLE <имя_таблицы> ADD id BIGINT PRIMARY KEY AUTO_INCREMENT;
               ```
    
       {% note info %}
    
       Если создание первичного ключа завершается ошибкой _`Creating index 'PRIMARY' required more than 'innodb_online_alter_log_max_size' bytes of modification log. Please try again`_, увеличьте в настройках СУБД значение параметра [`inno_db_log_file_size`](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size).
    
       {% endnote %}
    
    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_). Подробнее — в [описании дополнительных настроек эндпоинта для источника {{ MY }}](mysql.md#additional-settings).

{% endlist %}

## Настройка эндпоинта-источника {{ MY }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mmy-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

### Кластер {{ mmy-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.mmy.viewer }}`](../../../../managed-mysql/security/index.md#mmy-viewer) или примитивная [роль `viewer`](../../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение к БД с указанием кластера в {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите вариант подключения к базе данных:
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}** — позволяет задать настройки подключения вручную.
    
            Выберите тип инсталляции **Кластер Managed Service for MySQL** и задайте настройки:
    
            * **Кластер управляемой БД** — выберите кластер, к которому необходимо подключиться.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — укажите имя базы данных в выбранном кластере.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.password.title }}** — укажите пароль пользователя для доступа к базе данных.
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}** — позволяет использовать управляемое подключение к базе данных через [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):
    
            * Выберите каталог, в котором находится кластер {{ mmy-name }}.
            * Выберите тип инсталляции **Кластер управляемой БД** и задайте настройки:
    
                * **Кластер управляемой БД** — выберите кластер, к которому необходимо подключиться.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}** — укажите идентификатор управляемого подключения в {{ connection-manager-name }}.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — укажите имя базы данных в выбранном кластере.
    
            {% note warning %}
            
            Чтобы использовать подключение из {{ connection-manager-name }}, у пользователя должны быть [права доступа](../../../../metadata-hub/operations/connection-access.md) не ниже `connection-manager.user` к этому подключению.
            
            {% endnote %}
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.
      
      Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).

- CLI {#cli}

    * Тип эндпоинта — `mysql-source`.

    * `--cluster-id` — идентификатор кластера, к которому необходимо подключиться.
    * `--database` — имя базы данных. Оставьте поле пустым, если хотите перенести таблицы из нескольких баз данных одновременно.
    * `--user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    
    * Чтобы задать пароль пользователя для доступа к базе данных, используйте один из параметров:
    
        * `--raw-password` — пароль в текстовом виде.
        * `--password-file` — путь к файлу с паролем.

- {{ TF }} {#tf}

    * Тип эндпоинта — `mysql_source`.

    * `security_groups` — [группы безопасности](../../../../vpc/concepts/security-groups.md) для сетевого трафика.
      
      Правила групп безопасности применяются к трансферу. Они позволяют открыть сетевой доступ с ВМ трансфера к кластеру. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
      
      Группы безопасности должны принадлежать той же сети, в которой размещен кластер.
      
      {% note info %}
      
      В {{ TF }} сеть для групп безопасности задавать не нужно.
      
      {% endnote %}
    * `connection.mdb_cluster_id` — идентификатор кластера, к которому необходимо подключиться.
    * `database` — имя базы данных. Оставьте поле пустым, если хотите перенести таблицы из нескольких баз данных одновременно.
    * `user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    * `password.raw` — пароль в текстовом виде.

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        mysql_source {
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
    * `database` — имя базы данных. Оставьте поле пустым, если хотите перенести таблицы из нескольких баз данных одновременно.
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
    
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.OnPremiseMysql.host.title }}** — укажите IP-адрес или FQDN хоста, к которому необходимо подключиться.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.OnPremiseMysql.port.title }}** — укажите номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — укажите имя базы данных в пользовательской инсталляции.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.password.title }}** — укажите пароль пользователя для доступа к базе данных.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.OnPremiseMysql.ca_certificate.title }}** — загрузите файл [сертификата](../../../../managed-mysql/operations/connect/index.md#get-ssl-cert) или добавьте его содержимое в текстовом виде, если требуется шифрование передаваемых данных, например, для соответствия требованиям PCI DSS.
              
              {% note warning %}
              
              Если не добавить сертификат, трансфер может [завершиться ошибкой](../../../troubleshooting/index.md#failed-to-connect).
              
              {% endnote %}
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.OnPremiseMysql.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md). Трансфер будет использовать эту подсеть для доступа к источнику.
              
              Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}** — позволяет использовать управляемое подключение к базе данных через [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):
    
            * Выберите каталог, в котором создано управляемое подключение {{ connection-manager-name }}.
            * Выберите тип инсталляции **Пользовательская инсталляция** и задайте настройки:
    
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}** — укажите идентификатор управляемого подключения в {{ connection-manager-name }}.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — укажите имя базы данных в пользовательской инсталляции.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.OnPremiseMysql.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md). Трансфер будет использовать эту подсеть для доступа к источнику.
                  
                  Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.
    
            {% note warning %}
            
            Чтобы использовать подключение из {{ connection-manager-name }}, у пользователя должны быть [права доступа](../../../../metadata-hub/operations/connection-access.md) не ниже `connection-manager.user` к этому подключению.
            
            {% endnote %}
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.
      
      Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).

- CLI {#cli}

    * Тип эндпоинта — `mysql-source`.

    * `--host` — IP-адрес или FQDN хоста-мастера, к которому необходимо подключиться.
    * `--port` — номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения.
    * `--ca-certificate` — сертификат CA, если требуется шифрование передаваемых данных, например для соответствия требованиям PCI DSS.
      
      {% note warning %}
      
      Если не добавить сертификат, трансфер может [завершиться ошибкой](../../../troubleshooting/index.md#failed-to-connect).
      
      {% endnote %}
    * `--subnet-id` — идентификатор подсети, в которой находится хост. Трансфер будет использовать эту подсеть для доступа к хосту.
    * `--database` — имя базы данных. Оставьте поле пустым, если хотите перенести таблицы из нескольких баз данных одновременно.
    * `--user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    
    * Чтобы задать пароль пользователя для доступа к базе данных, используйте один из параметров:
    
        * `--raw-password` — пароль в текстовом виде.
        * `--password-file` — путь к файлу с паролем.

- {{ TF }} {#tf}

    * Тип эндпоинта — `mysql_source`.

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
    * `database` — имя базы данных. Оставьте поле пустым, если хотите перенести таблицы из нескольких баз данных одновременно.
    * `user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    * `password.raw` — пароль в текстовом виде.

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        mysql_source {
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
    * `database` — имя базы данных. Оставьте поле пустым, если хотите перенести таблицы из нескольких баз данных одновременно.
    * `user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    * `password.raw` — пароль пользователя для доступа к базе данных (в текстовом виде).

{% endlist %}

### Дополнительные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.table_filter.title }}**:
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTableFilter.include_tables.title }}** — будут передаваться данные только из таблиц этого списка. Задается с помощью регулярных выражений.

            Добавление новых таблиц при редактировании эндпоинта, использующегося в трансферах типа {{ dt-type-copy-repl }} или {{ dt-type-repl }} в статусе {{ dt-status-repl }}, не приведет к загрузке истории данных по этим таблицам. Чтобы добавить таблицу с ее историческими данными, используйте поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** в [настройках трансфера](../../transfer.md#update).

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTableFilter.exclude_tables.title }}** — данные таблиц из этого списка передаваться не будут. Задается с помощью регулярных выражений.

        Регулярные выражения для включенных и исключенных таблиц должны соответствовать правилам именования идентификаторов в {{ MY }}. Подробнее в [документации {{ MY }}]({{ my.docs }}/refman/8.0/en/identifiers.html). Экранирование двойных кавычек не требуется.

        {% note warning %}

        Если имя включаемой или исключаемой таблицы совпадает с именем базы данных, для корректной работы фильтра укажите таблицу в формате `<имя_БД>.<имя_таблицы>`.

        {% endnote %}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.object_transfer_settings.title }}** — позволяет выбрать элементы схемы БД, которые будут перенесены в процессе активации или деактивации трансфера.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.advanced_settings.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSourceAdvancedSettings.timezone.title }}** — указывается как идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется локальная таймзона сервера.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSourceAdvancedSettings.service_database.title }}** — база данных для технических таблиц (`__tm_keeper`, `__tm_gtid_keeper`). По умолчанию это БД, из которой происходит перенос данных.

- CLI {#cli}

    * `--include-table-regex` — список включенных таблиц. Будут передаваться данные только из таблиц этого списка. Задается с помощью регулярных выражений.

        Добавление новых таблиц при редактировании эндпоинта, использующегося в трансферах типа {{ dt-type-copy-repl }} или {{ dt-type-repl }} в статусе {{ dt-status-repl }}, не приведет к загрузке истории данных по этим таблицам. Чтобы добавить таблицу с ее историческими данными, используйте поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** в [настройках трансфера](../../transfer.md#update).

    * `--exclude-table-regex` — список исключенных таблиц. Данные таблиц из этого списка передаваться не будут. Задается с помощью регулярных выражений.

    * `--timezone` — часовой пояс базы, указывается как идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется UTC+0.

    * Настройки переноса схемы:
        * `--transfer-before-data` — при активации трансфера.
        * `--transfer-after-data` — при деактивации трансфера.

- {{ TF }} {#tf}

    * `include_table_regex` — список включенных таблиц. Будут передаваться данные только из таблиц этого списка. Задается с помощью регулярных выражений.

        Добавление новых таблиц при редактировании эндпоинта, использующегося в трансферах типа {{ dt-type-copy-repl }} или {{ dt-type-repl }} в статусе {{ dt-status-repl }}, не приведет к загрузке истории данных по этим таблицам. Чтобы добавить таблицу с ее историческими данными, используйте поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** в [настройках трансфера](../../transfer.md#update).

    * `exclude_table_regex` — список исключенных таблиц. Данные таблиц из этого списка передаваться не будут. Задается с помощью регулярных выражений.

    * `timezone` — часовой пояс базы, указывается как идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется UTC+0.

    * `object_transfer_settings` — настройки переноса схемы:

        * `view` — представления;
        * `routine` — процедуры и функции;
        * `trigger` — триггеры.

        Для каждой сущности может быть задано одно из значений:

        * `BEFORE_DATA` — перенос на этапе активации трансфера;
        * `AFTER_DATA` — перенос на этапе деактивации трансфера;
        * `NEVER` — не переносить.

- API {#api}

    * `includeTablesRegex` — список включенных таблиц. Будут передаваться данные только из таблиц этого списка. Задается с помощью регулярных выражений.

        Добавление новых таблиц при редактировании эндпоинта, использующегося в трансферах типа {{ dt-type-copy-repl }} или {{ dt-type-repl }} в статусе {{ dt-status-repl }}, не приведет к загрузке истории данных по этим таблицам. Чтобы добавить таблицу с ее историческими данными, используйте поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** в [настройках трансфера](../../transfer.md#update).

    * `excludeTablesRegex` — список исключенных таблиц. Данные таблиц из этого списка передаваться не будут. Задается с помощью регулярных выражений.

    * `timezone` — часовой пояс базы, указывается как идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется UTC+0.

    * `objectTransferSettings` — настройки переноса схемы при активации и деактивации трансфера (значения `BEFORE_DATA` и `AFTER_DATA`, соответственно).

{% endlist %}

#### Настройки переноса схемы при активации и деактивации трансфера {#schema-migrations-settings}

В процессе работы трансфера схема базы данных переносится с источника на приемник. Перенос выполняется в два этапа:

1. На стадии активации.

    Этап выполняется перед копированием или репликацией для создания схемы на приемнике. На этом этапе вы можете включить перенос представлений, хранимых процедур и функций, триггеров.

1. На стадии деактивации.

    Этот этап выполняется в конце работы трансфера, при его деактивации. Если трансфер постоянно работает в режиме репликации, то финальная стадия переноса будет выполнена только при остановке репликации. На этом этапе вы можете включить перенос представлений, хранимых процедур и функций, триггеров.

    На финальной стадии предполагается, что при деактивации трансфера на источнике нет пишущей нагрузки. Это можно гарантировать переводом в режим «только чтение» (read-only). На этой стадии схема базы данных на приемнике приводится в состояние, когда она будет консистентна схеме на источнике.

### Известные ограничения {#known-limitations}

Если вы настраиваете трансфер из кластера {{ MY }} в кластер {{ CH }}, учитывайте особенности переноса данных с [типами для хранения даты и времени]({{ my.docs }}/refman/8.0/en/date-and-time-types.html):

* Данные с типом `TIME` переносятся как строки, часовые пояса источника и приемника не учитываются.
* При переносе данных с типом `TIMESTAMP` применяется часовой пояс, указанный в настройках источника {{ MY }} или в [дополнительных настройках эндпоинта](#additional-settings). Подробнее в [документации {{ MY }}]({{ my.docs }}/refman/8.0/en/datetime.html).
* Эндпоинт-источник присваивает данным с типом `DATETIME` часовой пояс UTC+0.

Для трансфера из {{ MY }} в базу данных другого вида не поддерживается перенос полей с типом `DECIMAL`, чтобы избежать потери точности данных. Для трансфера из {{ MY }} в {{ MY }} такого ограничения нет.

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

* Для трансферов в статусе {{ dt-status-copy }} любые изменения схемы данных (`ALTER`) на источнике или приемнике прервут трансфер.

* Для трансферов в статусе {{ dt-status-repl }} схему данных на источнике можно изменять. Все операции `ALTER`, попавшие в бинарный лог (binlog) на источнике, автоматически применятся на приемнике. Этот процесс занимает некоторое время, поэтому трансфер может замедлиться.

## Решение проблем, возникающих при переносе данных {#troubleshooting}

Известные проблемы, связанные с использованием эндпоинта {{ MY }}:

* [Размер лога одной транзакции превышает 4 ГБ](#binlog-size)
* [Не добавляются новые таблицы](#no-new-tables)
* [Ошибка при трансфере из AWS RDS for {{ MY }}](#aws-binlog-time)
* [Ошибка трансфера при переносе таблиц без первичных ключей](#primary-keys)
* [Ошибка обращения к бинарному логу](#binlog-bytes)
* [Не удается получить позицию в бинарном логе](#binlog-position)
* [Ошибка удаления таблицы при политике очистки Drop](#drop-table-error)
* [Сдвиг времени в типе данных DATETIME при трансфере в {{ CH }}](#timeshift)

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

### Размер лога одной транзакции превышает 4 ГБ {#binlog-size}

Текст ошибки:

```text
Last binlog file <имя_файла>:<размер_файла> is more than 4GB
```

Если размер лога одной транзакции превышает 4 ГБ, активация трансферов _{{ dt-type-repl }}_ или _{{ dt-type-copy-repl }}_ завершается ошибкой из-за [внутренних ограничений](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_max_binlog_cache_size) {{ MY }} на размер лога одной транзакции.

**Решение:** [активируйте](../../transfer.md#activate) трансфер повторно.

### Не добавляются новые таблицы {#no-new-tables}

​В трансфер типа _{{ dt-type-copy-repl }}_ не добавляются новые таблицы.

**Решение:**

* [Деактивируйте](../../transfer.md#deactivate) и [активируйте](../../transfer.md#activate) трансфер повторно.
* Создайте таблицы в базе-приемнике вручную.
* [Создайте](../../transfer.md#create) отдельный трансфер типа _{{ dt-type-copy }}_ и добавьте в него только вновь созданные таблицы. При этом исходный трансфер типа _{{ dt-type-copy-repl }}_ можно не деактивировать.

### Ошибка при трансфере из AWS RDS for {{ MY }} {#aws-binlog-time}

В трансферах типа _{{ dt-type-copy-repl }}_ и _{{ dt-type-repl }}_ из источника [Amazon RDS for {{ MY }}](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html) может возникнуть ошибка загрузки таблиц.

Пример ошибки:

```text
Failed to execute LoadSnapshot: 
Cannot load table "name": unable to read rows and push by chunks: 
unable to push changes: unable to execute per table push: 
error: err: sql: transaction has already been committed or rolled back 
rollback err: sql: transaction has already been committed or rolled back
```

Ошибка вызвана коротким временем хранения файлов бинарного лога {{ MY }} в Amazon RDS.

**Решение:**

Увеличьте время хранения бинарного лога с помощью команды:

```sql
call mysql.rds_set_configuration('binlog retention hours', <количество_часов>);
```

Максимальное значение времени хранения — 168 ч (7 дней). Значение по умолчанию — `NULL` (файлы бинарного лога не сохраняются). Подробнее в [документации Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/mysql_rds_set_configuration.html).

### Ошибка трансфера при переносе таблиц без первичных ключей {#primary-keys}

Текст ошибки:

```text
Primary key check failed: 14 Tables errors: Table no key columns found
```

Для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ таблицы без первичных ключей не переносятся.

**Решение:** подготовьте источник в соответствии с разделом [Подготовка к трансферу](../../prepare.md).

### Ошибка обращения к бинарному логу {#binlog-bytes}

В трансферах типа _{{ dt-type-copy-repl }}_ может возникнуть ошибка:

```text
Warn(replication): failed to run (abstract1 source):
failed to run canal: failed to start binlog sync:
failed to get canal event: ERROR 1236 (HY000): Could not find first log file name in binary log index file
```

Ошибка возникает, если необходимые для репликации файлы бинарного лога недоступны. Обычно это связано с добавлением в бинарный лог новых изменений, из-за чего размер файла превышает допустимый. В этом случае часть старых данных лога удаляется.

**Решение:**

[Увеличьте](../../../../managed-mysql/operations/update.md#change-mysql-config) допустимый размер файлов бинарного лога в настройках {{ MY }} с помощью параметра [Mdb preserve binlog bytes](../../../../managed-mysql/concepts/settings-list.md#setting-mdb-preserve-binlog-bytes).

Минимальное значение — `1073741824` (1 ГБайт), максимальное значение — `107374182400` (100 ГБайт), по умолчанию — `1073741824` (1 ГБайт).

### Не удается получить позицию в бинарном логе {#binlog-position}

Текст ошибки:

```text
unable to get binlog position: Storage <адрес_источника> is not master
```

Ошибка может возникнуть при активации трансферов с типами _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_, если источником данных является пользовательская инсталляция {{ MY }} и в ней неправильно настроена репликация на основе позиции в бинарном лог-файле.

**Решение:**

Выполните проверки в {{ MY }}:

* Убедитесь, что в качестве источника репликации используется мастер.

* Убедитесь, что для параметра [log_bin]({{ my.docs }}/refman/8.0/en/replication-options-binary-log.html#option_mysqld_log-bin) указан правильный путь к расположению бинарного лог-файла.

* Выведите информацию о бинарном логе с помощью запроса [SHOW MASTER STATUS]({{ my.docs }}/refman/8.0/en/show-master-status.html) (для версий {{ MY }} 5.7 и 8.0) или [SHOW BINARY LOG STATUS]({{ my.docs }}/refman/8.4/en/show-binary-log-status.html) (для версии {{ MY }} 8.4). Запрос должен возвращать строку с информацией, а не пустой ответ.

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

### Сдвиг времени в типе данных DATETIME при трансфере в {{ CH }} {#timeshift}

Сдвиг времени наблюдается, так как эндпоинт-источник применяет часовой пояс UTC+0 для данных с типом `DATETIME`. Подробнее читайте в разделе [{#T}](mysql.md#known-limitations).

**Решение:** Примените нужный часовой пояс на уровне приемника вручную.

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._

_{{ CH }} является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._