[Документация Yandex Cloud](../index.md) > [Yandex Managed Service for Trino](index.md) > Начало работы

# Как начать работать с Yandex Managed Service for Trino

Чтобы начать работу с сервисом:
1. [Создайте кластер Managed Service for Trino](#cluster-create).
1. [Подключитесь к кластеру Managed Service for Trino](#connect).
1. [Отправьте запросы к кластеру Yandex Managed Service for PostgreSQL через Trino](#query-mpg-via-trino).
1. [Проверьте запросы в кластере Managed Service for PostgreSQL](#check-queries-in-psql).


## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужное [облако](../resource-manager/concepts/resources-hierarchy.md#cloud).
   1. Справа от названия облака нажмите ![image](../_assets/console-icons/ellipsis.svg).
   1. Выберите ![image](../_assets/console-icons/plus.svg) **Создать каталог**.
   
      ![create-folder1](../_assets/resource-manager/create-folder-1.png)
   
   1. Введите имя [каталога](../resource-manager/concepts/resources-hierarchy.md#folder). Требования к имени:
   
       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.
   
   1. (Опционально) Введите описание каталога.
   1. Выберите опцию **Создать сеть по умолчанию**. Будет создана [сеть](../vpc/concepts/network.md#network) с подсетями в каждой зоне доступности. Также в этой сети будет создана [группа безопасности по умолчанию](../vpc/concepts/security-groups.md#default-security-group), внутри которой весь сетевой трафик разрешен.
   1. Нажмите кнопку **Создать**.
   
      ![create-folder2](../_assets/resource-manager/create-folder-2.png)

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роли:

    * [managed-trino.admin](security.md#managed-trino-admin) — чтобы создать кластер;
    * [vpc.user](../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../vpc/concepts/network.md#network) кластера;
    * [logging.reader](../logging/security/index.md#logging-reader) — чтобы просматривать логи кластера;
    * [logging.editor](../logging/security/index.md#logging-editor) — чтобы управлять настройками логирования кластера;
    * [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user) — чтобы привязать сервисный аккаунт к кластеру.

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md#create-sa) с ролями `managed-trino.integrationProvider` и `storage.editor`.    

1. [Создайте кластер](../managed-postgresql/operations/cluster-create.md#create-cluster) Yandex Managed Service for PostgreSQL, с которым будет работать Trino.

## Создайте кластер Managed Service for Trino {#cluster-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать кластер Managed Service for Trino.
    1. Перейдите в сервис **Managed Service for&nbsp;Trino**.
    1. Нажмите кнопку **Создать кластер**.
    1. Задайте имя кластера.
    1. В поле **Сервисный аккаунт** выберите созданный ранее сервисный аккаунт.
    1. В блоке **Сетевые настройки** выберите [сеть](../vpc/operations/network-create.md), [подсеть](../vpc/operations/subnet-create.md) и [группу безопасности](../vpc/concepts/security-groups.md) для кластера.
    1. Задайте конфигурацию [координатора](concepts/index.md#coordinator) и [воркеров](concepts/index.md#workers).
    1. В блоке **Каталоги** добавьте по одному [каталогу Trino](operations/catalog-create.md):

        1. Для [созданного ранее](#before-you-begin) кластера Managed Service for PostgreSQL:

           * **Имя каталога** — `test`.
           * **Тип коннектора** — `PostgreSQL`.
           * **Тип подключения** — `On-premise`.
           * **URL** — `jdbc:postgresql://<FQDN_хоста>:6432/<имя_БД>`.

             О том, как получить FQDN хоста, читайте в [инструкции](../managed-postgresql/operations/connect/fqdn.md).

           * **Имя пользователя** — имя пользователя в кластере Managed Service for PostgreSQL.
           * **Пароль** — пароль пользователя.

        1. Для генерации тестовых данных:

            * **Имя каталога** — `data`.
            * **Тип коннектора** — `TPC-H`.
   
        Вы можете добавить каталоги как при создании кластера, так и после его создания.

    1. (Опционально) В блоке **Дополнительные настройки** настройте логирование:

        1. Включите настройку **Запись логов**.
        1. Выберите место записи логов:
            * **Каталог** — выберите каталог из списка.
            * **Группа** — выберите [лог-группу](../logging/concepts/log-group.md) из списка или создайте новую.
        1. Выберите **Минимальный уровень логирования** из списка.

    1. Нажмите кнопку **Создать**.
    1. Дождитесь, когда кластер будет готов к работе: его статус на панели Managed Service for Trino сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время.

{% endlist %}

## Подключитесь к кластеру Managed Service for Trino через Trino CLI {#connect-to-trino}

Если у вас еще нет интерфейса командной строки Trino, установите его по [инструкции на официальном сайте Trino](https://trino.io/docs/current/client/cli.html#installation).

Чтобы подключиться к кластеру Managed Service for Trino:

1. Создайте [IAM-токен](../iam/concepts/authorization/iam-token.md) и поместите его в переменную окружения `TRINO_PASSWORD`:

   ```bash
   export TRINO_PASSWORD=$(yc iam create-token)
   ```

   IAM-токен, хранящийся в переменной `TRINO_PASSWORD`, служит паролем для подключения к кластеру Managed Service for Trino. Чтобы использовать его, укажите при подключении флаг `--password`.

1. Подключитесь к кластеру Managed Service for Trino:

   ```bash
   ./trino c-<идентификатор_кластера>.trino.yandexcloud.net --user iam --password
   ```

   Идентификатор кластера можно запросить со [списком кластеров в каталоге](operations/cluster-list.md#list-clusters).

## Отправьте запросы к кластеру Managed Service for PostgreSQL через Trino {#query-mpg-via-trino}

1. [Подключитесь к кластеру Trino через Trino CLI](#connect-to-trino).

   Все дальнейшие шаги выполняются через Trino CLI.

1. Создайте в кластере Managed Service for PostgreSQL новую схему:

   ```sql
   CREATE SCHEMA IF NOT EXISTS test.tpch_postgresql;
   ```

1. Создайте таблицу:

   ```sql
   CREATE TABLE IF NOT EXISTS test.tpch_postgresql.customers (
      name VARCHAR,
      phone VARCHAR,
      acctbal DOUBLE
   );
   ```

1. Наполните таблицу данными из каталога с тестовыми данными:

   ```sql
   INSERT INTO test.tpch_postgresql.customers
   SELECT
     name,
     phone,
     acctbal
   FROM data.sf100000.customer
   LIMIT 1000000;
   ```

1. Запросите количество строк в таблице:

   ```sql
   SELECT COUNT(*) as count FROM test.tpch_postgresql.customers;
   ```

   Ожидаемый ответ:

   ```sql
     count  
   ---------
    1000000 
   (1 row)
   ```

## Проверьте запросы в кластере Managed Service for PostgreSQL {#check-queries-in-psql}

Чтобы проверить выполнение запросов в кластере Managed Service for PostgreSQL, [подключитесь к БД в кластере](../managed-postgresql/operations/connect/index.md) и запросите количество строк в таблице `customers`:

```sql
SELECT COUNT(*) FROM tpch_postgresql.customers;
```

Ожидаемый ответ:

```sql
  count  
---------
 1000000
(1 row)

```


# Что дальше {#whats-next}

* Изучите [взаимосвязь ресурсов сервиса](concepts/index.md).
* Ознакомьтесь с другими [способами подключения к кластеру Managed Service for Trino](operations/connect.md).