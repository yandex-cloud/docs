{% list tabs %}

- {{ mmy-name }}
    
    1. [Включите режим полного бинарного лога](../../../../managed-mysql/operations/update.md#change-mysql-config) на источнике, установив значение `FULL` или `NOBLOB` для [параметра **Binlog row image**](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_row_image).
    
    1. (Опционально) [Настройте лимит](../../../../managed-mysql/operations/update.md#change-mysql-config) на размер отправляемых кусков данных (chunk) с помощью параметра **Max allowed packet**.
    
    1. [Создайте пользователя](../../../../managed-mysql/operations/cluster-users.md#adduser) для подключения к источнику.
        
        1. [Выдайте пользователю привилегию](../../../../managed-mysql/operations/grant.md#grant-privilege) `ALL_PRIVILEGES` для базы-источника.
        
        1. [Выдайте пользователю административные привилегии](../../../../managed-mysql/concepts/settings-list#setting-administrative-privileges) `REPLICATION CLIENT` и `REPLICATION SLAVE`.
    
    1. {% include [primary-keys-mysql](../../primary-keys-mysql.md) %}
    
       {% note info %}
    
       Если создание первичного ключа завершается ошибкой _`Creating index 'PRIMARY' required more than 'innodb_online_alter_log_max_size' bytes of modification log. Please try again`_, [увеличьте в настройках СУБД](../../../../managed-mysql/operations/update.md#change-mysql-config) значение [параметра `Innodb log file size`](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size).
    
       {% endnote %}
    
    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_). Подробнее см. в [описании дополнительных настроек эндпоинта для источника {{ MY }}](../../../../data-transfer/operations/endpoint/source/mysql.md#additional-settings).

- {{ MY }}
    
    1. {% include notitle [White IP list](../../configure-white-ip.md) %}
    
    1. Убедитесь, что источник использует подсистему хранения данных низкого уровня MyISAM или InnoDB. При использовании других подсистем трансфер может завершиться с ошибкой.
    
    1. [Включите режим полного бинарного лога](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image) на источнике, установив значение `FULL` или `NOBLOB` для параметра `binlog_row_image`.
    
    1. [Задайте строковый формат бинарного лога](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_format) на источнике, установив значение `ROW` для параметра `binlog_format`.
    
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

    1. {% include [Таблицы без первичных ключей](../../primary-keys-mysql.md) %}
    
       {% note info %}
    
       Если создание первичного ключа завершается ошибкой _`Creating index 'PRIMARY' required more than 'innodb_online_alter_log_max_size' bytes of modification log. Please try again`_, увеличьте в настройках СУБД значение параметра [`inno_db_log_file_size`](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size).
    
       {% endnote %}
    
    1. Выключите перенос триггеров на стадии активации трансфера и включите его на стадии деактивации (для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }})_. Подробнее см. в [описании дополнительных настроек эндпоинта для источника {{ MY }}](../../../../data-transfer/operations/endpoint/source/mysql.md#additional-settings).

{% endlist %}