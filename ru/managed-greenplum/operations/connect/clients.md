---
title: Подключение к кластеру {{ GP }} в {{ mgp-full-name }}
description: Следуя этой инструкции, вы сможете подключиться к базе данных в кластере {{ GP }} с помощью инструментов командной строки, из графических IDE, {{ pgadmin }} и Docker-контейнера.
---

# Подключение к кластеру {{ GP }} из приложений

В этом разделе представлены настройки для подключения к хостам кластера {{ mgp-name }} с помощью [инструментов командной строки](#command-line-tools), из [графических IDE](#connection-ide), [{{ pgadmin }}](#connection-pgadmin) и [Docker-контейнера](#connection-docker). О подключении из кода вашего приложения см. [Примеры кода](code-examples.md).

При создании кластера {{ GP }} пользовательская база данных не создается. Для проверки подключения используйте служебную базу `postgres`.

Для подключения к кластеру с публичным доступом [подготовьте SSL-сертификат](index.md#get-ssl-cert). В примерах предполагается, что SSL-сертификат `root.crt` расположен в директории:

* `/home/<домашняя_директория>/.postgresql/` для Ubuntu;
* `$HOME\AppData\Roaming\postgresql` для Windows.

Подключиться к кластеру можно как с использованием обычного FQDN хоста-мастера, так и [особого FQDN](fqdn.md#fqdn-master) первичного хоста-мастера. О том, как получить FQDN хоста, см. [инструкцию](fqdn.md).


## Инструменты командной строки {#command-line-tools}

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

### Linux (Bash) {#bash}

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install --yes postgresql-client
```

Подключитесь к базе данных:

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

  ```bash
  psql "host=c-<идентификатор_кластера>.rw.{{ dns-zone }} \
        port={{ port-mgp }} \
        sslmode=disable \
        dbname=postgres \
        user=<имя_пользователя> \
        target_session_attrs=read-write"
  ```

- Подключение с SSL {#with-ssl}

  {% include [default-connstring](../../../_includes/mdb/mgp/default-connstring.md) %}

{% endlist %}

После выполнения команды введите пароль пользователя для завершения процедуры подключения.

Для проверки успешности подключения выполните запрос:

```sql
SELECT version();
```

### Windows (PowerShell) {#powershell}

Перед подключением установите [{{ PG }} для Windows](https://www.postgresql.org/download/windows/) актуальной версии. Выберите только установку *Command Line Tools*.

Подключитесь к базе данных:

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

  ```powershell
  & "C:\Program Files\PostgreSQL\<версия>\bin\psql.exe" "`
      host=c-<идентификатор_кластера>.rw.{{ dns-zone }} `
      port={{ port-mgp }} `
      sslmode=disable `
      dbname=postgres `
      user=<имя_пользователя>"
  ```

- Подключение с SSL {#with-ssl}

  ```powershell
  & "C:\Program Files\PostgreSQL\<версия>\bin\psql.exe" "`
      host=c-<идентификатор_кластера>.rw.{{ dns-zone }} `
      port={{ port-mgp }} `
      sslmode=verify-full `
      dbname=postgres `
      user=<имя_пользователя>"
  ```

{% endlist %}

После выполнения команды введите пароль пользователя для завершения процедуры подключения.

Для проверки успешности подключения выполните запрос:

```sql
SELECT version();
```


### Подключение с авторизацией через IAM {#iam}

К базе данных {{ GP }} можно подключиться с помощью [интерфейса командной строки {{ yandex-cloud }} (CLI)](../../../cli/quickstart.md#install), используя авторизацию через IAM. Для этого нужно привязать к пользователю {{ GP }} [аккаунт на Яндексе](../../../iam/concepts/users/accounts.md#passport) или [федеративный аккаунт](../../../iam/concepts/users/accounts.md#saml-federation). Подключаться с авторизацией через IAM можно только к кластеру в публичном доступе, при этом использование SSL-сертификата не требуется.

Перед подключением установите клиент {{ PG }}:

```bash
sudo apt update && sudo apt install --yes postgresql-client
```

Подготовьте кластер {{ mgp-name }} к подключению:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.

  1. Нажмите на имя нужного кластера.

  1. [Включите публичный доступ к кластеру](../update.md#change-public-access).
 
  1. Назначьте роль аккаунту пользователя, который будет подключаться к БД:
     1. Выберите вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** и нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
     1. Введите электронную почту пользователя, к которой привязан аккаунт.
     1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role}}** и выберите роль `managed-greenplum.clusters.connector`.
     1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

  1. Создайте пользователя {{ GP }} и предоставьте ему доступ к нужной БД:
     1. Подключитесь к кластеру {{ mgp-name }} любым удобным методом.
     1. Создайте пользователя {{ GP }}, указав в качестве его имени электронную почту, к которой привязан аккаунт:

        ```sql
        CREATE ROLE "<электронная_почта_аккаунта>"
            LOGIN
            ENCRYPTED PASSWORD '<пароль>';
        ```
     1. При необходимости [настройте привилегии](../roles-and-users.md#privileges) и атрибуты созданного пользователя {{ GP }}.

  1. Добавьте правило аутентификации созданного пользователя:
     1. Выберите вкладку **{{ ui-key.yacloud.greenplum.label_user-auth }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_edit-rules }}**.
     1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_add-rule }}** и задайте его параметры:

        * **{{ ui-key.yacloud.greenplum.cluster.user-auth.title_column-type }}** — тип соединения.
        * **{{ ui-key.yacloud.greenplum.cluster.user-auth.title_column-databases }}** — имя БД.
        * **{{ ui-key.yacloud.greenplum.cluster.user-auth.title_column-user }}** — электронная почта пользователя, к которой привязан аккаунт.
        * **{{ ui-key.yacloud.greenplum.cluster.user-auth.title_column-address }}** — диапазон IP-адресов, с которых будет выполняться подключение к базе данных.
        * **{{ ui-key.yacloud.greenplum.cluster.user-auth.title_column-method }}** — `iam`.

     1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

Чтобы подключиться к БД {{ GP }}, выполните команду:

```bash
{{ yc-mdb-gp }} connect <имя_или_идентификатор_кластера> --db <имя_БД>
```


## Подключение из графических IDE {#connection-ide}

{% include [ide-environments](../../../_includes/mdb/mdb-ide-envs.md) %}

Подключаться из графических IDE можно только к кластеру в публичном доступе с использованием SSL-сертификата.

{% include [note-connection-ide](../../../_includes/mdb/note-connection-ide.md) %}

{% list tabs group=ide %}

- DataGrip {#datagrip}

    1. Создайте источник данных:

        1. Выберите в меню **File** → **New** → **Data Source** → **{{ GP }}**.
        1. На вкладке **General**:

            1. Укажите параметры подключения:

                * **User**, **Password** — имя и пароль пользователя БД;
                * **URL** — строка подключения. Используйте [особый FQDN первичного мастера](./fqdn.md#fqdn-master):

                    ```http
                    jdbc:postgresql://c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mgp }}/<имя_БД>
                    ```

            1. Нажмите ссылку **Download**, чтобы загрузить драйвер соединения.
        1. На вкладке **SSH/SSL**:
            1. Включите настройку **Use SSL**.
            1. В поле **CA file** укажите путь к файлу [SSL-сертификата для подключения](#get-ssl-cert).
    1. Нажмите ссылку **Test Connection** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
    1. Нажмите кнопку **OK**, чтобы сохранить источник данных.

- DBeaver {#dbeaver}

    1. Создайте новое соединение с БД:
        1. Выберите в меню **База данных** пункт **Новое соединение**.
        1. Выберите из списка БД **{{ GP }}**.
        1. Нажмите кнопку **Далее**.
        1. Укажите параметры подключения на вкладке **Главное**:
            * **Хост** — [особый FQDN первичного мастера](./fqdn.md#fqdn-master): `c-<идентификатор_кластера>.rw.{{ dns-zone }}`;
            * **Порт** — `{{ port-mgp }}`;
            * **База данных** — имя БД для подключения;
            * В блоке **Аутентификация** укажите имя и пароль пользователя БД.
        1. На вкладке **SSL**:
            1. Включите настройку **Использовать SSL**.
            1. В поле **Корневой сертификат** укажите путь к сохраненному файлу [SSL-сертификата](#get-ssl-cert).
    1. Нажмите кнопку **Тест соединения ...** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
    1. Нажмите кнопку **Готово**, чтобы сохранить настройки соединения с БД.

{% endlist %}

## Подключение из {{ pgadmin }} {#connection-pgadmin}

Подключение проверялось для [{{ pgadmin }}](https://www.pgadmin.org) версии 7.1 в macOS Ventura 13.0 и Microsoft Windows 10 Pro 21H1.

Подключаться из {{ pgadmin }} можно только к хостам кластера в публичном доступе с [использованием SSL-сертификата](#get-ssl-cert).

Создайте новое подключение к серверу:

1. Выберите в меню **Object** → **Register** → **Server...**
1. На вкладке **General** в поле **Name** укажите имя, под которым кластер будет отображаться в интерфейсе {{ pgadmin }}. Имя может быть любым.
1. На вкладке **Connection** укажите параметры подключения:

    * **Host name/address** — [особый FQDN хоста-мастера](./fqdn.md#fqdn-master) или обычный FQDN хоста;
    * **Port** — `{{ port-mgp }}`;
    * **Maintenance database** — имя служебной базы данных `postgres`;
    * **Username** — имя пользователя, от имени которого выполняется подключение;
    * **Password** — пароль пользователя.

1. На вкладке **Parameters**:

    * Установите параметр **SSL mode** в значение `verify-full`.
    * Добавьте новый параметр **Root certificate** и укажите в нем путь к сохраненному файлу SSL-сертификата.

1. Нажмите кнопку **Save**, чтобы сохранить настройки подключения к серверу.

Кластер появится в списке серверов в навигационном меню.

Для наблюдения за состоянием кластера рекомендуется использовать сервис [{{ monitoring-full-name }}](../monitoring.md) вместо вкладки **Dashboard** в {{ pgadmin }}, потому что в ней может возникать ошибка:

```text
column "wait_event_type" does not exist LINE 10: wait_event_type || ': ' || wait_event AS wait_event, ^
```

При работе с другими вкладками в {{ pgadmin }} эта ошибка не возникает.

## Подготовка к подключению из Docker-контейнера {#connection-docker}

Чтобы подключаться к кластеру {{ GP }} из Docker-контейнера, добавьте в Dockerfile строки:

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

    ```bash
    RUN apt-get update && \
        apt-get install postgresql-client --yes
    ```


- Подключение с SSL {#with-ssl}

    ```bash
    RUN apt-get update && \
        apt-get install wget postgresql-client --yes && \
        mkdir --parents ~/.postgresql && \
        wget "{{ crt-web-path }}" \
             --output-document ~/.postgresql/root.crt && \
        chmod 0655 ~/.postgresql/root.crt
    ```

{% endlist %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
