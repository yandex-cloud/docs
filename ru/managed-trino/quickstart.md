---
title: Начало работы с {{ mtr-full-name }}
description: В этой инструкции вы научитесь создавать кластер {{ TR }} и подключаться к нему.
---

# Как начать работать с {{ mtr-full-name }}

{% include [preview](../_includes/managed-trino/note-preview.md) %}

Чтобы начать работу с сервисом:
1. [Создайте кластер {{ mtr-name }}](#cluster-create).
1. [Подключитесь к кластеру {{ mtr-name }}](#connect).
1. [Отправьте запросы к кластеру {{ mpg-full-name }} через {{ TR }}](#query-mpg-via-trino).
1. [Проверьте запросы в кластере {{ mpg-name }}](#check-queries-in-psql).


## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   {% include [create-folder](../_includes/create-folder.md) %}

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роли:

    * [managed-trino.admin](security.md#managed-trino-admin) — чтобы создать кластер;
    * [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../vpc/concepts/network.md#network) кластера;
    * [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user) — чтобы привязать сервисный аккаунт к кластеру.

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md#create-sa) с ролями `managed-trino.integrationProvider` и `storage.editor`.    

1. [Создайте кластер](../managed-postgresql/operations/cluster-create.md#create-cluster) {{ mpg-full-name }}, с которым будет работать {{ TR }}.

## Создайте кластер {{ mtr-name }} {#cluster-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер {{ mtr-name }}.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Задайте имя кластера.
    1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** выберите созданный ранее сервисный аккаунт.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите [сеть](../vpc/operations/network-create.md), [подсеть](../vpc/operations/subnet-create.md) и [группу безопасности](../vpc/concepts/security-groups.md) для кластера.
    1. Задайте конфигурацию [координатора](concepts/index.md#coordinator) и [воркеров](concepts/index.md#workers).
    1. В блоке **{{ ui-key.yacloud.trino.title_catalogs }}** добавьте по одному [каталогу Trino](operations/catalog-create.md):

        1. Для [созданного ранее](#before-you-begin) кластера {{ mpg-name }}:

           * **{{ ui-key.yacloud.trino.catalogs.field_catalog-name }}** — `test`.
           * **{{ ui-key.yacloud.trino.catalogs.field_catalog-type }}** — `PostgreSQL`.
           * **Тип подключения** — `On-premise`.
           * **URL** — `jdbc:postgresql://<адрес_хоста>:<порт>/<имя_БД>`.
           * **Имя пользователя** — имя пользователя в кластере {{ mpg-name }}.
           * **Пароль** — пароль пользователя.

        1. Для генерации тестовых данных:

            * **{{ ui-key.yacloud.trino.catalogs.field_catalog-name }}** — `data`.
            * **{{ ui-key.yacloud.trino.catalogs.field_catalog-type }}** — `TPC-H`.
   
        Вы можете добавить каталоги как при создании кластера, так и после его создания.

    1. (Опционально) В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}** настройте логирование:

        1. Включите настройку **{{ ui-key.yacloud.logging.field_logging }}**.
        1. Выберите место записи логов:
            * **{{ ui-key.yacloud.common.folder }}** — выберите каталог из списка.
            * **{{ ui-key.yacloud.logging.label_group }}** — выберите [лог-группу](../logging/concepts/log-group.md) из списка или создайте новую.
        1. Выберите **{{ ui-key.yacloud.logging.label_minlevel }}** из списка.

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
    1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ mtr-name }} сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время.

{% endlist %}

## Подключитесь к кластеру {{ mtr-name }} через {{ TR }} CLI {#connect-to-trino}

{% include [trino-cli-connect](../_includes/managed-trino/trino-cli-connect.md) %}

## Отправьте запросы к кластеру {{ mpg-name }} через {{ TR }} {#query-mpg-via-trino}

1. [Подключитесь к кластеру {{ TR }} через {{ TR }} CLI](#connect-to-trino).

   Все дальнейшие шаги выполняются через {{ TR }} CLI.

1. Создайте в кластере {{ mpg-name }} новую схему:

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

## Проверьте запросы в кластере {{ mpg-name }} {#check-queries-in-psql}

Чтобы проверить выполнение запросов в кластере {{ mpg-name }}, [подключитесь к БД в кластере](../managed-postgresql/operations/connect.md) и запросите количество строк в таблице `customers`:

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
* Ознакомьтесь с другими [способами подключения к кластеру {{ mtr-name }}](operations/connect.md).
