{% list tabs %}

- {{ mch-name }}
    
    1. [Создайте базу-приемник](../../../../managed-clickhouse/operations/databases.md#add-db).
    
       Если нужно перенести несколько баз данных, создайте для каждой из них отдельный трансфер.
    
    1. [Создайте пользователя](../../../../managed-clickhouse/operations/cluster-users.md#adduser) с доступом к базе приемника.
    
       После старта трансфер подключится к приемнику от имени этого пользователя.

    1. Если в кластере включено [управление пользователями через SQL](../../../../managed-clickhouse/operations/cluster-users.md#sql-user-management), выдайте созданному пользователю права:

        ```sql
        GRANT CLUSTER ON *.* TO <имя_пользователя>
        GRANT SELECT, INSERT, ALTER DELETE, CREATE TABLE, CREATE VIEW, DROP TABLE, TRUNCATE, dictGet ON <имя_базы_данных>.* TO <имя_пользователя>
        GRANT SELECT(macro, substitution) ON system.macros TO <имя_пользователя>
        ``` 
    
       Если управление пользователями через SQL выключено, [права назначаются](../../../../managed-clickhouse/operations/cluster-users.md) через консоль управления и CLI.

    1. [Создайте группу безопасности](../../../../vpc/operations/security-group-create.md) и [настройте ее](../../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).
    
    1. Назначьте кластеру {{ mch-name }} созданную группу безопасности.

- {{ CH }}
    
    1. {% include notitle [White IP list](../../configure-white-ip.md) %}
    
    1. Создайте базу-приемник. Ее имя должно совпадать с именем базы-источника. Если нужно перенести несколько баз данных, создайте для каждой из них отдельный трансфер.
    
    1. Создайте пользователя с доступом к базе приемника.
    
       После старта трансфер подключится к приемнику от имени этого пользователя.

    1. Выдайте созданному пользователю права:
 
        ```sql
        GRANT CLUSTER ON *.* TO <имя_пользователя>
        GRANT SELECT, INSERT, ALTER DELETE, CREATE TABLE, CREATE VIEW, DROP TABLE, TRUNCATE, dictGet ON <имя_базы_данных>.* TO <имя_пользователя>
        GRANT SELECT(macro, substitution) ON system.macros TO <имя_пользователя>
        ```

{% endlist %}