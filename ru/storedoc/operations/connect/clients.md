---
title: Подключение к кластеру {{ SD }} в {{ mmg-full-name }}
description: Следуя этой инструкции, вы сможете подключиться к базе данных в кластере {{ SD }} с помощью инструментов командной строки, из графических IDE и Docker-контейнера.
---

# Подключение к кластеру {{ SD }} из приложений

К кластеру {{ SD }} можно подключиться с помощью [инструментов командной строки](#command-line-tools), из [графических IDE](#connection-ide) и [Docker-контейнера](#connection-docker). О подключении из кода вашего приложения смотрите [Примеры кода](code-examples.md).

В примерах ниже предполагается, что [SSL-сертификат](index.md#get-ssl-cert) `root.crt` расположен в директории:

* `~/.mongodb/` для Ubuntu;
* `$HOME\.mongodb` для Windows.

При успешном подключении к кластеру и выполнении тестового запроса будет выведено имя БД, к которой было выполнено подключение.

{% include [warning-write-concern](../../../_includes/storedoc/warning-write-concern.md) %}

## Инструменты командной строки {#command-line-tools}

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

Способ настройки зависит от того, включено ли в кластере [шардирование](../../concepts/sharding.md).


### Linux (Bash) {#bash}

Перед подключением [установите утилиту MongoDB Shell](index.md#install-mongosh).

{% list tabs group=connection %}

- Подключение с SSL {#with-ssl}

    Для нешардированного кластера:

    ```bash
    mongosh --norc \
            --tls \
            --tlsCAFile ~/.mongodb/root.crt \
            --host '<FQDN_хоста_1_Yandex_StoreDoc>:{{ port-mmg }},...,<FQDN_хоста_N_Yandex_StoreDoc>:{{ port-mmg }}' \
            --username <имя_пользователя_БД> \
            --password <пароль_пользователя_БД> \
            <имя_БД>
    ```

    Для шардированного кластера:

    ```bash
    mongosh --norc \
            --tls \
            --tlsCAFile ~/.mongodb/root.crt \
            --host '<FQDN_хоста_1_MONGOINFRA_или_MONGOS>:27017,...,<FQDN_хоста_N_MONGOINFRA_или_MONGOS>:27017' \
            --username <имя_пользователя_БД> \
            --password <пароль_пользователя_БД> \
            <имя_БД>
    ```

    {% include [see-fqdn-host](../../../_includes/mdb/mmg/fqdn-host.md) %}

    {% include [db-command](../../../_includes/mdb/mmg/db-command.md) %}

- Подключение без SSL {#without-ssl}

    Для нешардированного кластера:

    ```bash
    mongosh --norc \
            --host '<FQDN_хоста_1_Yandex_StoreDoc>:{{ port-mmg }},...,<FQDN_хоста_N_Yandex_StoreDoc>:{{ port-mmg }}' \
            --username <имя_пользователя_БД> \
            --password <пароль_пользователя_БД> \
            <имя_БД>
    ```

    Для шардированного кластера:

    ```bash
    mongosh --norc \
            --host '<FQDN_хоста_1_MONGOINFRA_или_MONGOS>:27017,...,<FQDN_хоста_N_MONGOINFRA_или_MONGOS>:27017' \
            --username <имя_пользователя_БД> \
            --password <пароль_пользователя_БД> \
            <имя_БД>
    ```

    {% include [see-fqdn-host](../../../_includes/mdb/mmg/fqdn-host.md) %}

    {% include [db-command](../../../_includes/mdb/mmg/db-command.md) %}

- SRV-подключение {#srv}

    ```bash
    mongosh "mongodb+srv://<имя_пользователя_БД>:<пароль_пользователя_БД>\
    @<идентификатор_кластера>.{{ dns-zone }}/<имя_БД>"
    ```

  Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

  {% include [db-command](../../../_includes/mdb/mmg/db-command.md) %}

  {% include [srv-parameters](../../../_includes/mdb/mmg/srv-parameters.md) %}

  Пример команды с параметрами подключения:

    ```bash
    mongosh "mongodb+srv://user********:qwe********@c9qng7jhsgtg********.{{ dns-zone }}\
    /db********?authSource=admin&appName=debug"
    ```

{% endlist %}

### Windows (PowerShell) {#powershell}

Перед подключением [установите утилиту MongoDB Shell](index.md#install-mongosh).

{% list tabs group=connection %}

- Подключение с SSL {#with-ssl}

    Для нешардированного кластера:

    ```powershell
    mongosh.exe --norc `
                --host '<FQDN_хоста_1_Yandex_StoreDoc>:{{ port-mmg }},...,<FQDN_хоста_N_Yandex_StoreDoc>:{{ port-mmg }}' `
                --tls `
                --tlsCAFile $HOME\.mongodb\root.crt `
                --username <имя_пользователя_БД> `
                --password <пароль_пользователя_БД> `
                <имя_БД>
    ```

    Для шардированного кластера:

    ```powershell
    mongosh.exe --norc `
                --host '<FQDN_хоста_1_MONGOINFRA_или_MONGOS>:{{ port-mmg-sharded }},...,<FQDN_хоста_N_MONGOINFRA_или_MONGOS>:{{ port-mmg-sharded }}' `
                --tls `
                --tlsCAFile $HOME\.mongodb\root.crt `
                --username <имя_пользователя_БД> `
                --password <пароль_пользователя_БД> `
                <имя_БД>
    ```

    {% include [see-fqdn-host](../../../_includes/mdb/mmg/fqdn-host.md) %}

    {% include [db-command](../../../_includes/mdb/mmg/db-command.md) %}

- Подключение без SSL {#without-ssl}

    Для нешардированного кластера:

    ```powershell
    mongosh.exe --norc `
                --host '<FQDN_хоста_1_Yandex_StoreDoc>:{{ port-mmg }},...,<FQDN_хоста_N_Yandex_StoreDoc>:{{ port-mmg }}' `
                --username <имя_пользователя_БД> `
                --password <пароль_пользователя_БД> `
                <имя_БД>
    ```

    Для шардированного кластера:

    ```powershell
    mongosh.exe --norc `
                --host '<FQDN_хоста_1_MONGOINFRA_или_MONGOS>:{{ port-mmg-sharded }},...,<FQDN_хоста_N_MONGOINFRA_или_MONGOS>:{{ port-mmg-sharded }}' `
                --username <имя_пользователя_БД> `
                --password <пароль_пользователя_БД> `
                <имя_БД>
    ```

    {% include [see-fqdn-host](../../../_includes/mdb/mmg/fqdn-host.md) %}

    {% include [db-command](../../../_includes/mdb/mmg/db-command.md) %}

- SRV-подключение {#srv}

    ```powershell
    mongosh.exe "mongodb+srv://<имя_пользователя_БД>:<пароль_пользователя_БД>`
    @<идентификатор_кластера>.{{ dns-zone }}/<имя_БД>"
    ```

  Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

  {% include [db-command](../../../_includes/mdb/mmg/db-command.md) %}

  {% include [srv-parameters](../../../_includes/mdb/mmg/srv-parameters.md) %}

  Пример команды с параметрами подключения:

    ```powershell
    mongosh.exe "mongodb+srv://user********:qwe********@c9qng7jhsgtg********.{{ dns-zone }}`
    /db********?authSource=admin&appName=debug"
    ```

{% endlist %}



### Подключение с аутентификацией через IAM {#iam}

Вы можете подключиться к кластеру {{ mmg-name }} с помощью аутентификации через IAM. Для аутентификации используйте [аккаунт на Яндексе](../../../iam/concepts/users/accounts.md#passport), [федеративный](../../../iam/concepts/users/accounts.md#saml-federation) или [локальный](../../../iam/concepts/users/accounts.md#local) аккаунт.

Подключение выполняется через MongoDB Shell. О том, как установить утилиту MongoDB Shell, читайте в [инструкции](index.md#mongosh-install).

Перед подключением [настройте группы безопасности](index.md#configuring-security-groups), а также [включите публичный доступ](../hosts.md#update) к хостам кластера, если подключение выполняется через интернет.

Чтобы подключиться к кластеру с помощью аутентификации через IAM:

1. Настройте аутентификацию:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. Перейдите на [страницу каталога]({{ link-console-main }}).
      1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
      1. Выберите кластер.
      1. Назначьте аккаунту в {{ yandex-cloud }} роль `managed-mongodb.clusters.connector` на кластер:
         
          1. Выберите вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
          1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
          1. В поле **{{ ui-key.yacloud_components.acl.label.subject }}** выберите аккаунт.
              
              Чтобы найти нужный аккаунт, введите в это поле адрес почты, к которому привязан аккаунт.
          
          1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите роль `managed-mongodb.clusters.connector`.
          1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.
      
      1. Создайте пользователя {{ SD }}:

          1. Выберите вкладку ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}**.
          1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
          1. Выберите способ авторизации **{{ ui-key.yacloud.mongodb.UserAddDialog.label_iam_ffBD5 }}**.
          1. Выберите аккаунт в {{ yandex-cloud }} с ролью `managed-mongodb.clusters.connector`.
          1. Выберите базы данных и настройте для них [роли](../../concepts/users-and-roles.md):
          
              1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.mdb.dialogs.button_add-database }}** и выберите базу данных.
              1. Назначьте роли для выбранной базы данных.
              
                  Чтобы назначить роль, нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) и выберите роль.
          
          1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-add_button_add }}**.

    {% endlist %}

1. Получите IAM-токен и поместите его в переменную окружения `IAM_TOKEN`:
    
    * [Инструкция](../../../iam/operations/iam-token/create.md) для аккаунта на Яндексе.
    * [Инструкция](../../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.
    * [Инструкция](../../../iam/operations/iam-token/create-for-local.md) для локального аккаунта.

1. [Получите SSL-сертификат](index.md#get-ssl-cert).
1. Подключитесь к кластеру, выполнив команду:

    Для нешардированного кластера:

    ```bash
    mongosh --norc \
            --tls \
            --tlsCAFile ~/.mongodb/root.crt \
            --host '<FQDN_хоста_1_MONGOINFRA_или_MONGOS>:27018,...,<FQDN_хоста_N_MONGOINFRA_или_MONGOS>:27018' \
            --username "<имя_пользователя_БД>" \
            --password "$IAM_TOKEN" \
            --authenticationDatabase '$external' \
            --authenticationMechanism PLAIN \
            <имя_БД>
    ```

    Для шардированного кластера:

    ```bash
    mongosh --norc \
            --tls \
            --tlsCAFile ~/.mongodb/root.crt \
            --host '<FQDN_хоста_1_MONGOINFRA_или_MONGOS>:27017,...,<FQDN_хоста_N_MONGOINFRA_или_MONGOS>:27017' \
            --username "<имя_пользователя_БД>" \
            --password "$IAM_TOKEN" \
            --authenticationDatabase '$external' \
            --authenticationMechanism PLAIN \
            <имя_БД>
    ```

    Где `--username` — имя пользователя базы данных, которое совпадает с адресом почты аккаунта в {{ yandex-cloud }}.

    {% include [see-fqdn-host](../../../_includes/mdb/mmg/fqdn-host.md) %}



## Подключение из графических IDE {#connection-ide}

{% include [ide-environments](../../../_includes/mdb/mmg-ide-envs.md) %}


Подключаться из графических IDE можно только к хостам кластера в публичном доступе с использованием [SSL-сертификата](index.md#get-ssl-cert).


{% include [note-connection-ide](../../../_includes/mdb/note-connection-ide.md) %}

### DataGrip {#datagrip}

1. Создайте источник данных:
   1. Выберите в меню **File** → **New** → **Data Source** → **{{ MG }}**.
   1. На вкладке **General**:
      1. Укажите параметры подключения:
         * **User**, **Password** — имя и пароль пользователя БД;
         * **URL** — строка подключения.

              Для нешардированного кластера:

              ```http
              mongodb://<FQDN_хоста_1_Yandex_StoreDoc>:{{ port-mmg }},..,<FQDN_хоста_N_Yandex_StoreDoc>:{{ port-mmg }}/<имя_БД>
              ```

              Для [шардированного](../../concepts/sharding.md) кластера:

              ```http
              mongodb://<FQDN_хоста_1_MONGOINFRA_или_MONGOS>:{{ port-mmg-sharded }},...<FQDN_хоста_N_MONGOINFRA_или_MONGOS>:{{ port-mmg-sharded }}/<имя_БД>
              ```

              {% include [see-fdqn-host](../../../_includes/mdb/mmg/fqdn-host.md) %}

      1. Нажмите ссылку **Download**, чтобы загрузить драйвер соединения.
   1. На вкладке **SSH/SSL**:
      1. Включите настройку **Use SSL**.
      1. В поле **CA file** укажите путь к файлу [SSL-сертификата для подключения](./index.md#get-ssl-cert).
1. Нажмите ссылку **Test Connection** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
1. Нажмите кнопку **OK**, чтобы сохранить источник данных.

### DBeaver {#dbeaver}

Поддержка подключения к кластеру {{ SD }} доступна только в [коммерческих редакциях DBeaver](https://dbeaver.com/buy/).

Чтобы подключиться к кластеру:

1. Создайте новое соединение с БД:
   1. Выберите в меню **База данных** пункт **Новое соединение**.
   1. Выберите из списка БД **{{ MG }}**.
   1. Нажмите кнопку **Далее**.
   1. Настройте параметры подключения на вкладке **Главное**:
      1. В блоке **Адрес** переключите **Type** на `URL` и укажите строку подключения.

           Для нешардированного кластера:

           ```http
           mongodb://<FQDN_хоста_1_Yandex_StoreDoc>:{{ port-mmg }},..,<FQDN_хоста_N_Yandex_StoreDoc>:{{ port-mmg }}/<имя_БД>
           ```

           Для [шардированного](../../concepts/sharding.md) кластера:

           ```http
           mongodb://<FQDN_хоста_1_MONGOINFRA_или_MONGOS>:{{ port-mmg-sharded }},...<FQDN_хоста_N_MONGOINFRA_или_MONGOS>:{{ port-mmg-sharded }}/<имя_БД>
           ```

           {% include [see-fdqn-host](../../../_includes/mdb/mmg/fqdn-host.md) %}

      1. В списке **Устройство** выберите значение `SCRAM-SHA-256` (тип шифрования пароля при подключении).
      1. В блоке **Полномочия** укажите имя и пароль пользователя БД.
   1. На вкладке **SSL**:
      1. Включите настройку **Использовать SSL**.
      1. В поле **Корневой сертификат** укажите путь к сохраненному файлу [SSL-сертификата](./index.md#get-ssl-cert).
      1. В блоке **Настройки** включите **Пропустить валидацию имени хоста**.
1. Нажмите кнопку **Тест соединения ...** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
1. Нажмите кнопку **Готово**, чтобы сохранить настройки соединения с БД.

## Подготовка к подключению из Docker-контейнера {#connection-docker}

Чтобы подключаться к кластеру {{ mmg-name }} из Docker-контейнера с SSL, добавьте в Dockerfile строки:

```bash
RUN apt-get update && \
    apt-get install wget --yes && \
    mkdir --parents ~/.mongodb && \
    wget "{{ crt-web-path }}" \
         --output-document ~/.mongodb/root.crt && \
    chmod 0644 ~/.mongodb/root.crt
```

Чтобы подключаться без SSL, дополнительно настраивать Dockerfile не нужно.

После запуска Docker-контейнера перейдите в него и установите утилиту `mongosh`. Она понадобится для подключения к кластеру.
