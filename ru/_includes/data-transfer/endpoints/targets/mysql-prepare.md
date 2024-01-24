{% list tabs %}

- {{ mmy-name }}
    
    1. Убедитесь, что мажорная версия {{ MY }} на приемнике не ниже версии на источнике.
    
    1. [Установите SQL Mode](../../../../managed-mysql/operations/update.md#change-mysql-config), который совпадает с источником.
    
    1. [Создайте пользователя](../../../../managed-mysql/operations/cluster-users.md#adduser) для подключения к приемнику.
        
        1. [Назначьте пользователю роль](../../../../managed-mysql/operations/grant.md#grant-role) `ALL_PRIVILEGES` для базы-приемника.

- {{ MY }}
    
    1. {% include notitle [White IP list](../../configure-white-ip.md) %}
    
    1. Убедитесь, что мажорная версия {{ MY }} на приемнике не ниже версии на источнике.
    
    1. Убедитесь, что приемник использует подсистему хранения данных низкого уровня MyISAM или InnoDB.
    
    1. [Установите SQL Mode](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting), который совпадает с источником.
    
    1. Создайте пользователя для подключения к приемнику и выдайте ему необходимые привилегии:
    
        ```sql
        CREATE USER '<имя_пользователя>'@'%' IDENTIFIED BY '<пароль>';
        GRANT ALL PRIVILEGES ON <имя_базы>.* TO '<имя_пользователя>'@'%';
        ```

{% endlist %}