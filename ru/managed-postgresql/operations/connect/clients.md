---
title: Подключение к кластеру {{ PG }} в {{ mpg-full-name }}
description: Следуя этой инструкции, вы сможете подключиться к хостам в кластере {{ PG }} с помощью инструментов командной строки, графических IDE, браузера, {{ pgadmin }}, {{ google-looker }} и Docker-контейнера.
---

# Подключение к кластеру {{ PG }} из приложений

К кластеру {{ PG }} можно подключиться с помощью [инструментов командной строки](#command-line-tools), из [графических IDE](#connection-ide), [{{ websql-full-name }}](#websql), [{{ pgadmin }}](#connection-pgadmin), [{{ google-looker }}](#connection-google-looker) и [Docker-контейнера](#connection-docker). О подключении из кода вашего приложения см. [Примеры кода](./code-examples.md).

Вы можете подключаться к хостам кластера {{ PG }} с использованием SSL-сертификатов. В примерах ниже предполагается, что сертификат `root.crt` расположен в директории:

* `/home/<домашняя_директория>/.postgresql/` для Ubuntu;
* `$HOME\AppData\Roaming\postgresql` для Windows.

При необходимости перед подключением [настройте группы безопасности](index.md#configuring-security-groups) кластера.

## Инструменты командной строки {#command-line-tools}

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

### Linux (Bash) {#bash}

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install --yes postgresql-client
```

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

  1. Подключитесь к базе данных:

      ```bash
      psql "host=<список_хостов_кластера> \
            port=6432 \
            sslmode=disable \
            dbname=<имя_БД> \
            user=<имя_пользователя> \
            target_session_attrs=read-write"
      ```
 
      {% include [host lists](../../../_includes/managed-postgresql/host-list.md) %}    
 
      После выполнения команды введите пароль пользователя для завершения процедуры подключения.

  1. Для проверки успешности подключения выполните запрос:

      ```bash
      SELECT version();
      ```

- Подключение с SSL {#with-ssl}

  1. Подключитесь к базе данных:

      {% include [default-connstring](../../../_includes/mdb/mpg/default-connstring.md) %}
  
      {% include [host lists](../../../_includes/managed-postgresql/host-list.md) %}

      После выполнения команды введите пароль пользователя для завершения процедуры подключения.

  1. Для проверки успешности подключения выполните запрос:

      ```bash
      SELECT version();
      ```

{% endlist %}

### Windows (PowerShell) {#powershell}

Перед подключением установите [{{ PG }} для Windows](https://www.postgresql.org/download/windows/) той же версии, которая используется в кластере. Выберите только установку *Command Line Tools*.

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

  1. Установите переменные окружения для подключения:

     ```powershell
     $Env:PGSSLMODE="disable"; $Env:PGTARGETSESSIONATTRS="read-write"
     ```

  1. Подключитесь к базе данных:

     ```powershell
     & "C:\Program Files\PostgreSQL\<версия>\bin\psql.exe" `
           --host=<список_хостов> `
           --port={{ port-mpg }} `
           --username=<имя_пользователя> `
           <имя_БД>
     ```

     {% include [host lists](../../../_includes/managed-postgresql/host-list.md) %}     

     После выполнения команды введите пароль пользователя для завершения процедуры подключения.

  1. Для проверки успешности подключения выполните запрос:

     ```sql
     SELECT version();
     ```

- Подключение с SSL {#with-ssl}

  1. Установите переменные окружения для подключения:

      ```powershell
      $Env:PGSSLMODE="verify-full"; $Env:PGTARGETSESSIONATTRS="read-write"
      ```

  1. Подключитесь к базе данных:

      ```powershell
      & "C:\Program Files\PostgreSQL\<версия>\bin\psql.exe" `
        --host=<список_хостов> `
        --port={{ port-mpg }} `
        --username<имя_пользователя> `
        <имя_БД>
      ```

      {% include [host lists](../../../_includes/managed-postgresql/host-list.md) %}

      После выполнения команды введите пароль пользователя для завершения процедуры подключения.

  1. Для проверки успешности подключения выполните запрос:

     ```sql
     SELECT version();
     ```

{% endlist %}


### Подключение с аутентификацией через IAM {#iam}

К базе данных {{ PG }} можно подключиться с помощью [интерфейса командной строки {{ yandex-cloud }} (CLI)](../../../cli/quickstart.md#install), используя аутентификацию через IAM. Этот метод доступен для [аккаунтов на Яндексе](../../../iam/concepts/users/accounts.md#passport), [федеративных аккаунтов](../../../iam/concepts/users/accounts.md#saml-federation) и [локальных пользователей](../../../iam/concepts/users/accounts.md#local). Подключение с аутентификацией через IAM не требует получения SSL-сертификата или указания FQDN хостов кластера.

Перед подключением установите клиент {{ PG }}:

```bash
sudo apt update && sudo apt install --yes postgresql-client
```

Подготовьте кластер {{ PG }} к подключению:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера.
  1. Включите публичный доступ для хостов кластера:
     1. Выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}**.
     1. Нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке первого хоста и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
     1. Включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.
     1. Повторите операцию для остальных хостов кластера.
  1. Назначьте роль аккаунту пользователя, который будет подключаться к БД:
     1. Выберите вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** и нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
     1. Введите электронную почту пользователя, к которой привязан аккаунт.
     1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role}}** и выберите роль `managed-postgresql.clusters.connector`.
     1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.
  1. Создайте пользователя {{ PG }}:
     1. Выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_users }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
     1. Выберите способ аутентификации **{{ ui-key.yacloud.mdb.AuthMethodColumn.value_iam_boWet }}**.
     1. Выберите аккаунт, которому была назначена роль `managed-postgresql.clusters.connector`.
     1. В поле **{{ ui-key.yacloud.mdb.dialogs.popup_field_permissions }}** нажмите значок ![image](../../../_assets/console-icons/plus.svg).
     1. Выберите базу данных из выпадающего списка.
     1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

{% endlist %}

Чтобы подключиться к БД {{ PG }}, выполните команду:

```bash
{{ yc-mdb-pg }} connect <имя_или_идентификатор_кластера> --db <имя_БД>
```



## Подключение из графических IDE {#connection-ide}

{% include [ide-environments](../../../_includes/mdb/mdb-ide-envs.md) %}

Подключаться из графических IDE можно только к хостам кластера в публичном доступе с использованием SSL-сертификата.

{% include [note-connection-ide](../../../_includes/mdb/note-connection-ide.md) %}

{% list tabs group=ide %}

- DataGrip {#datagrip}

  1. Создайте источник данных:
     1. Выберите в меню **File** → **New** → **Data Source** → **{{ PG }}**.
     1. Укажите параметры подключения на вкладке **General**:
        * **User**, **Password** — имя и пароль пользователя БД;
        * **URL** — строка подключения:

          ```http
          jdbc:postgresql://<особый_FQDN>:{{ port-mpg }}/<имя_БД>
          ```

          Также в строке подключения можно использовать список [FQDN](./fqdn.md) всех хостов кластера:

          ```http
          jdbc:postgresql://<хост_1_{{ PG }}>:{{ port-mpg }},...,<хост_N_{{ PG }}>:{{ port-mpg }}/<имя_БД>
          ```

        * Нажмите ссылку **Download**, чтобы загрузить драйвер соединения.
     1. На вкладке **SSH/SSL**:
         1. Включите настройку **Use SSL**.
         1. В поле **CA file** укажите путь к файлу [SSL-сертификата для подключения](./index.md#get-ssl-cert).
  1. Нажмите ссылку **Test Connection** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
  1. Нажмите кнопку **OK**, чтобы сохранить источник данных.

- DBeaver {#dbeaver}

  1. Создайте новое соединение с БД:
     1. Выберите в меню **База данных** пункт **Новое соединение**.
     1. Выберите из списка БД **{{ PG }}**.
     1. Нажмите кнопку **Далее**.
     1. Укажите параметры подключения на вкладке **Главное**:
        * **Хост** — [особый FQDN хоста-мастера](./fqdn.md#fqdn-master) или [обычный FQDN хоста](./fqdn.md);
        * **Порт** — `{{ port-mpg }}`;
        * **База данных** — имя БД для подключения;
        * В блоке **Аутентификация** укажите имя и пароль пользователя БД.
     1. На вкладке **SSL**:
         1. Включите настройку **Использовать SSL**.
         1. В поле **Корневой сертификат** укажите путь к сохраненному файлу [SSL-сертификата](./index.md#get-ssl-cert).
  1. Нажмите кнопку **Тест соединения ...** для проверки подключения. При успешном подключении будут выведены статус подключения, информация о СУБД и драйвере.
  1. Нажмите кнопку **Готово**, чтобы сохранить настройки соединения с БД.

{% endlist %}




## Подключение из {{ websql-full-name }} {#websql}

{% include [WebSQL](../../../_includes/mdb/mpg/websql.md) %}




## Подключение из {{ pgadmin }} {#connection-pgadmin}

Подключение проверялось для [{{ pgadmin }}](https://www.pgadmin.org) версии 7.0 в Ubuntu 20.04.

Подключаться из {{ pgadmin }} можно только к хостам кластера в публичном доступе с [использованием SSL-сертификата](./index.md#get-ssl-cert).

Создайте новое подключение к серверу:

1. Выберите в меню **Object** → **Register** → **Server...**
1. На вкладке **General** в поле **Name** укажите имя, под которым кластер будет отображаться в интерфейсе {{ pgadmin }}. Имя может быть любым.
1. На вкладке **Connection** укажите параметры подключения:

    * **Host name/address** — [особый FQDN хоста-мастера](./fqdn.md#fqdn-master) или обычный [FQDN](../../concepts/network.md#hostname) хоста;
    * **Port** — `{{ port-mpg }}`;
    * **Maintenance database** — имя БД для подключения;
    * **Username** — имя пользователя, от имени которого выполняется подключение;
    * **Password** — пароль пользователя.

1. На вкладке **Parameters**:

    * Установите параметр **SSL mode** в значение `verify-full`.
    * Добавьте новый параметр **Root certificate** и укажите в нем путь к сохраненному файлу SSL-сертификата.

1. Нажмите кнопку **Save**, чтобы сохранить настройки подключения к серверу.

Кластер появится в списке серверов в навигационном меню.


## Подключение из {{ google-looker }} {#connection-google-looker}


Подключаться из [{{ google-looker }}](https://lookerstudio.google.com/overview) можно только к хостам кластера в публичном доступе.


1. Сохраните [сертификат сервера]({{ crt-web-path }}) `CA.pem` в локальную папку.
1. В той же папке сгенерируйте сертификат клиента с приватным ключом:

    ```bash
    openssl req -newkey rsa:2048 -nodes -keyout private.pem -out cert.pem
    ```

    При создании сертификата программа предложит изменить ряд настроек. Нажмите **Enter**, чтобы использовать для них значения по умолчанию.

    В локальной папке появятся два файла: `cert.pem` и `private.pem`.

1. На [странице навигации {{ google-looker }}](https://lookerstudio.google.com/navigation/reporting) выберите **Создать** → **Источник данных**.
1. Выберите {{ PG }}.
1. Заполните поля:

    * **Имя хоста или IP-адрес** — [особый FQDN хоста-мастера](./fqdn.md#fqdn-master) или обычный [FQDN](../../concepts/network.md#hostname) хоста;
    * **Порт** — `{{ port-mpg }}`;
    * **База данных** — имя БД для подключения;
    * **Имя пользователя** — имя пользователя, от имени которого выполняется подключение;
    * **Пароль** — пароль пользователя.

1. Выберите опции **Включить SSL** и **Включить аутентификацию клиента**.
1. Укажите файлы сертификатов и приватный ключ клиента в соответствующих полях:

    * **Server certificate** — выберите файл `CA.pem`.
    * **Client certificate** — выберите файл `cert.pem`.
    * **Client private key** — выберите файл `private.pem`.

1. Нажмите **Выполнить аутентификацию**.

## Подготовка к подключению из Docker-контейнера {#connection-docker}

Чтобы подключаться к кластеру {{ mpg-name }} из Docker-контейнера, добавьте в Dockerfile строки:


{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    ```bash
    RUN apt-get update && \
        apt-get install postgresql-client --yes
    ```

    Пример подключения из {{ serverless-containers-full-name }} см. в [практическом руководстве](../../../serverless-containers/tutorials/pg-connect.md).

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

