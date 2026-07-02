[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for ClickHouse®](../index.md) > [Концепции](index.md) > Управление пользователями и правами доступа

# Управление пользователями и правами доступа в Yandex Managed Service for ClickHouse®

В Managed Service for ClickHouse® права доступа пользователя определяются назначенными ему привилегиями.

_Привилегия_ — это разрешение выполнять определенные операции в кластере. Подробнее об иерархии привилегий и их области действия читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/grant#privileges).

_Роль_ — это набор привилегий.

Возможности управления правами доступа зависят от выбранного способа управления пользователями:

* [Управление через интерфейсы](#yandex-cloud-user-management) Yandex Cloud ([консоль управления](https://console.yandex.cloud), [CLI](../../cli/index.md), Terraform и [API](../../glossary/rest-api.md)) — позволяет управлять доступом пользователей к базам данных с использованием возможностей сервиса Managed Service for ClickHouse®.
* [Управление через SQL](#sql-user-management) — позволяет управлять доступом пользователей к объектам баз данных на основе ролевой модели ([RBAC](https://ru.wikipedia.org/wiki/Управление_доступом_на_основе_ролей)).


Одновременное управление через интерфейсы Yandex Cloud и через SQL не поддерживается.

При создании кластера автоматически создаются [служебные пользователи](#service-users).


## Управление пользователями через интерфейсы Yandex Cloud {#yandex-cloud-user-management}

Через интерфейсы Yandex Cloud можно:

* [создавать пользователей](../operations/cluster-users.md#adduser) и предоставлять им доступ к базам данных;
* настраивать параметры доступа:
  
  * доступ только для чтения (настройка [Readonly](settings-list.md#setting-readonly));
  * запрет на выполнение DDL-запросов (настройка [Allow DDL](settings-list.md#setting-allow-ddl)).

Включить управление пользователями через интерфейсы Yandex Cloud можно только при [создании кластера](../operations/cluster-create.md).


### Ограничения привилегий для пользователей {#users-privileges-restrictions}

Пользователи, созданные через интерфейсы Yandex Cloud, не имеют следующих привилегий:

* `SYSTEM SHUTDOWN`;
* `FILE`;
* `ALTER FREEZE PARTITION`;
* `CREATE DATABASE` и `DROP DATABASE`;
* `ACCESS MANAGEMENT`;
* привилегии на модифицирующие операции для системных баз данных `system` и `_system`.


## Управление пользователями через SQL {#sql-user-management}


Включить управление пользователями через SQL можно при [создании кластера](../operations/cluster-create.md) или [изменении его настроек](../operations/update.md#SQL-management). После этого управлять пользователями можно будет только через SQL, вернуться к управлению через интерфейсы Yandex Cloud невозможно. При этом пользователи, созданные через интерфейсы Yandex Cloud, сохраняются.

При включении настройки создается пользователь `admin`, от имени которого можно создавать других пользователей и управлять ролями, привилегиями и политиками строк.

Подробнее об управлении правами доступа через SQL читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/operations/access-rights).


### Ограничения привилегий для пользователя admin {#admin-privileges-restrictions}

Пользователь `admin` не имеет следующих привилегий:

* `SYSTEM SHUTDOWN`;
* `FILE`;
* `ALTER FREEZE PARTITION`;
* привилегии на модифицирующие операции для системных баз данных `system` и `_system`.

Также привилегии `CREATE DATABASE` и `DROP DATABASE` предоставляются только при условии, что [управление базами данных](../operations/databases.md) выполняется через SQL.

Поскольку набор привилегий у `admin` ограничен, команда `GRANT ALL` недоступна. Чтобы назначить все доступные привилегии, используйте `GRANT CURRENT GRANTS`.

Подробнее о `GRANT CURRENT GRANTS` читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/grant#grant-current-grants-syntax).




## Служебные пользователи {#service-users}

Служебные пользователи — это пользователи, которые создаются и управляются сервисом Managed Service for ClickHouse®. Они необходимы для работы кластера. Управление такими пользователями вручную недоступно.


#### _admin {#admin}

Пользователь для администрирования и управления кластером ClickHouse®: создания баз данных, пользователей, служебных таблиц.


#### _backup_admin {#backup-admin}

Пользователь для создания резервных копий и восстановления данных из них.


#### _monitor, _sli {#monitor-sli}

Пользователи для выполнения проверок работоспособности кластера ClickHouse® и его подсистем.


#### _metrics {#metrics}

Пользователь для вычисления метрик, отправляемых в Yandex Monitoring.


_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._