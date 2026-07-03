[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Базы данных > Managed Service for ClickHouse® > Создать роль

# Создать роль

Если у вас есть [кластер](create-cluster.md) [ClickHouse®](../../concepts/components/clickhouse.md), вы можете создать в нем роль с помощью кастомного ресурса `ClickhouseRole`.

В роли задаются:

* наследование других ролей (`spec.membership`);
* блоки прав (`spec.grants`) на объекты ClickHouse® четырех типов: база данных, таблица, именованная коллекция, администрирование пользователей и ролей.

Ресурс `ClickhouseRole` должен находиться в том же пространстве имен, что и кластер `ClickhouseCluster`. Имя ресурса должно соответствовать шаблону `<название_кластера>-<имя_роли>`.

## Через CLI {#cli}

1. Создайте файл ресурса `ClickhouseRole`. Например, с помощью команды `touch clickhouserole.yaml`.
1. Откройте файл и вставьте конфигурацию ниже:

    {% list tabs %}

    - Роль с правом чтения

        ```yaml
        apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
        kind: ClickhouseRole
        metadata:
          name: <название_кластера>-reader
        spec:
          cluster: <название_кластера>
          name: reader
          grants:
            - database:
                name: <имя_базы>
                privileges:
                  - SELECT
        ```

    - Роль с наследованием и правами на таблицу

        ```yaml
        apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
        kind: ClickhouseRole
        metadata:
          name: <название_кластера>-writer
        spec:
          cluster: <название_кластера>
          name: writer
          membership:
            - reader
          grants:
            - database:
                name: <имя_базы>
                privileges:
                  - SELECT
                  - INSERT
                  - CREATE TABLE
                  - ALTER TABLE
            - table:
                database: <имя_базы>
                table: <имя_таблицы>
                privileges:
                  - SELECT
                  - INSERT
        ```

    {% endlist %}

    Где:

    * `spec.cluster` — название кластера `ClickhouseCluster`.
    * `spec.name` — имя роли в ClickHouse®.
    * `spec.membership` — необязательный список ролей, от которых наследуется эта роль. В списке указываются значения `spec.name` других ресурсов `ClickhouseRole`.
    * `spec.grants` — список блоков прав. В каждом блоке заполняется ровно одно из полей: `database`, `table`, `namedCollection`, `access`.

1. Примените манифест: `kubectl apply -f clickhouserole.yaml -n <название_проекта>`.

### Допустимые привилегии {#privileges}

Набор допустимых привилегий зависит от типа блока прав. Значения должны совпадать с CRD посимвольно, включая пробелы в многословных привилегиях.

#|
|| **Тип блока** | **Поле в манифесте** | **Допустимые привилегии** ||
|| База данных | `spec.grants[].database` | `SELECT`, `INSERT`, `ALTER TABLE`, `ALTER VIEW`, `CREATE TABLE`, `CREATE VIEW`, `CREATE DICTIONARY`, `DROP TABLE`, `DROP VIEW`, `DROP DICTIONARY`, `TRUNCATE`, `OPTIMIZE`, `SHOW TABLES`, `SHOW DICTIONARIES`, `ALTER DELETE`, `ALTER UPDATE` ||
|| Таблица | `spec.grants[].table` | `SELECT`, `INSERT`, `ALTER TABLE`, `ALTER VIEW`, `DROP TABLE`, `DROP VIEW`, `TRUNCATE`, `OPTIMIZE`, `ALTER DELETE`, `ALTER UPDATE` ||
|| Именованная коллекция | `spec.grants[].namedCollection` | `CREATE`, `DROP`, `ALTER` ||
|| Администрирование пользователей и ролей | `spec.grants[].access` | `CREATE USER`, `ALTER USER`, `DROP USER`, `CREATE ROLE`, `ALTER ROLE`, `DROP ROLE` ||
|#

## Через консоль управления {#console}

1. Если вы еще не открыли проект, выберите проект.
1. В левом меню выберите **ClickHouse® Clusters**.
1. Выберите кластер.
1. Перейдите на вкладку **Роли**.
1. Нажмите **Создать**.
1. Заполните поля:

    * **Имя роли** — имя роли в ClickHouse®.
    * **Наследовать роли от** — необязательный список ролей этого же кластера, от которых наследуется новая роль. Можно выбрать несколько ролей.

1. В блоке **Права доступа** настройте права. По умолчанию доступен один блок прав:

    * В переключателе **Права на** выберите тип объекта: **База данных**, **Таблица**, **Именованная коллекция** или **Администрирование пользователей и ролей**.
    * Для типа **База данных** выберите базу и привилегии.
    * Для типа **Таблица** выберите базу, укажите имя таблицы и выберите привилегии.
    * Для типов **Именованная коллекция** и **Администрирование пользователей и ролей** выберите только привилегии.

    Чтобы добавить еще один блок прав, нажмите **Добавить**. Чтобы удалить блок прав, нажмите **Удалить** на нужном блоке.

    Перечень допустимых привилегий для каждого типа блока приведен в разделе [Допустимые привилегии](#privileges).

1. Нажмите **Создать**.

Готово, роль появится в списке на вкладке **Роли**.