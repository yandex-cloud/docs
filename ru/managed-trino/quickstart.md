---
title: Начало работы с {{ mtr-full-name }}
description: В этой инструкции вы научитесь создавать кластер {{ TR }} и подключаться к нему.
noIndex: true
---

# Как начать работать с {{ mtr-full-name }}

Чтобы начать работу с сервисом:
* [Создайте кластер {{ mtr-name }}](#cluster-create).
* [Установите {{ TR }} CLI](#install-trino-cli).
* [Подключитесь к {{ TR }}](#connect).
* [Отправьте запросы к кластеру {{ mpg-full-name }} через {{ TR }}](#query-mpg-via-trino).
* [Проверьте запросы в кластере {{ mpg-name }}](#check-queries-in-psql).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   {% include [create-folder](../_includes/create-folder.md) %}

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роли:

    * `managed-trino.admin` — чтобы создать кластер;
    * [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../vpc/concepts/network.md#network) кластера;
    * [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user) — чтобы привязать сервисный аккаунт к кластеру.

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md#create-sa) с ролями `managed-trino.integrationProvider` и `storage.editor`.    

1. [Создайте кластер](../managed-postgresql/operations/cluster-create.md#create-cluster) {{ mpg-full-name }}, с которым будет работать {{ TR }}.

## Создайте кластер {{ mtr-name }} {#cluster-create}

1. В консоли управления выберите каталог, в котором нужно создать кластер {{ mtr-name }}.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Задайте имя кластера.
1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** выберите созданный ранее сервисный аккаунт.
1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите сеть, подсеть и группу безопасности для кластера.
1. Задайте конфигурацию координатора и воркеров.
1. В блоке **{{ ui-key.yacloud.trino.title_catalogs }}** добавьте каталоги:

   1. Для кластера {{ mpg-name }} со следующими параметрами:
       * **{{ ui-key.yacloud.trino.catalogs.field_catalog-name }}** — `test`.
       * **{{ ui-key.yacloud.trino.catalogs.field_catalog-type }}** — `PostgreSQL`.
       * **{{ ui-key.yacloud.trino.catalogs.label_url }}** — `jdbc:postgresql://<FQDN_хоста_кластера_Managed_Service_for_Postgresql>:6432/<имя_базы_данных>?ssl=true&sslmode=verify-full`.

           Подробнее о получении FQDN хоста в кластере {{ mpg-name }} см. в [инструкции](../managed-postgresql/operations/connect.md#fqdn).

       * **{{ ui-key.yacloud.trino.catalogs.label_userName }}** — имя пользователя в кластере {{ mpg-name }}.
       * **{{ ui-key.yacloud.trino.catalogs.label_password }}** — пароль пользователя в кластере {{ mpg-name }}.

   1. Для тестовых данных со следующими параметрами:
       * **{{ ui-key.yacloud.trino.catalogs.field_catalog-name }}** — `data`.
       * **{{ ui-key.yacloud.trino.catalogs.field_catalog-type }}** — `TPC-H`.
   
   Вы можете добавить каталоги как при создании кластера, так и после его создания.

1. (Опционально) В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}** настройте логирование:

   1. Включите настройку **{{ ui-key.yacloud.logging.field_logging }}**.
   1. Выберите место записи логов:
       * **{{ ui-key.yacloud.common.folder }}** — выберите каталог из списка.
       * **{{ ui-key.yacloud.logging.label_group }}** — выберите лог-группу из списка или создайте новую.
   1. Выберите **{{ ui-key.yacloud.logging.label_minlevel }}** из списка.

1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ mtr-name }} сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время.

## Установите {{ TR }} CLI {#install-trino-cli}

1. Скачайте {{ TR }} CLI из центрального репозитория Apache Maven в файл `trino`:

   ```bash
   wget -O trino \
   https://repo.maven.apache.org/maven2/io/trino/trino-cli/<номер_версии>/trino-cli-<номер_версии>-executable.jar
   ```

   Номера доступных версий вы можете посмотреть в [списке](https://repo.maven.apache.org/maven2/io/trino/trino-cli/).

1. Сделайте скачанный файл исполняемым:

   ```bash
   sudo chmod +x trino
   ```

1. Убедитесь, что {{ TR }} установлен успешно. Для этого запросите версию {{ TR }}:

   ```bash
   ./trino --version
   ```

   Ответ на запрос будет выглядеть так:

   ```bash
   Trino CLI <номер_версии>
   ```
## Подключитесь к кластеру {{ mtr-name }} {#connect-to-trino}

1. Создайте [IAM-токен](../iam/concepts/authorization/iam-token.md) и поместите его в переменную окружения `TRINO_PASSWORD`:

   ```bash
   export TRINO_PASSWORD=$(yc iam create-token)
   ```

   IAM-токен, хранящийся в переменной `TRINO_PASSWORD`, служит паролем для подключения к кластеру {{ mtr-name }}. Чтобы использовать его, укажите при подключении флаг `--password`.

1. Подключитесь к кластеру {{ mtr-name }}:

   ```bash
   ./trino <URL_координатора> --user iam --password
   ```

   Вы можете скопировать URL координатора в поле **{{ ui-key.yacloud.trino.overview.field_coordinator-url }}** на странице обзора кластера {{ TR }} в [Консоли управления]({{ link-console-main }}).

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

