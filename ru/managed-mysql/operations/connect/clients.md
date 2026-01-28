---
title: Подключение к кластеру {{ MY }} в {{ mmy-full-name }}
description: Следуя этой инструкции, вы сможете подключиться к базе данных в кластере {{ MY }} с помощью инструментов командной строки, из {{ websql-full-name }}, графических IDE и Docker-контейнера.
---

# Подключение к кластеру {{ MY }} из приложений

В этом разделе представлены настройки для подключения к хостам кластера {{ mmy-name }} с помощью [инструментов командной строки](#command-line-tools), из [графических IDE](#connection-ide), из [{{ websql-full-name }}](#websql) и [Docker-контейнера](#connection-docker). О подключении из кода вашего приложения см. [Примеры кода](./code-examples.md).

## Инструменты командной строки {#command-line-tools}

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

### Linux (Bash)/macOS (Zsh) {#bash-zsh}

Перед подключением установите утилиту `mysql`:

```bash
sudo apt update && sudo apt install --yes mysql-client
```

{% list tabs group=connection %}

- Подключение с SSL {#with-ssl}

  {% include [default-connstring](../../../_includes/mdb/mmy/default-connstring.md) %}

- Подключение без SSL {#without-ssl}

  ```bash
  mysql --host=<FQDN_любого_хоста_{{ MY }}> \
        --port={{ port-mmy }} \
        --ssl-mode=DISABLED \
        --user=<имя_пользователя> \
        --password \
        <имя_БД>
  ```

{% endlist %}

{% include [see-fqdn](../../../_includes/mdb/mmy/fqdn-host.md) %}

При выполнении любой из команд введите пароль пользователя БД.

После подключения к СУБД выполните команду `SELECT version();`.

{% include [Successful connection](../../../_includes/mdb/mmy/successful-connect.md) %}

### Windows (PowerShell) {#powershell}

Перед подключением [скачайте](https://dev.mysql.com/downloads/shell/) и установите утилиту `MySQL Shell`.

{% list tabs group=connection %}

- Подключение с SSL {#with-ssl}

  ```PowerShell
  mysqlsh --host=<FQDN_любого_хоста_{{ MY }}> `
          --port={{ port-mmy }} `
          --ssl-ca=<абсолютный_путь_к_файлу_сертификата> `
          --ssl-mode=VERIFY_IDENTITY `
          --user=<имя_пользователя> `
          --password `
          --database=<имя_БД> `
          --sql
  ```

- Подключение без SSL {#without-ssl}

  ```PowerShell
  mysqlsh --host=<FQDN_любого_хоста_{{ MY }}> `
          --port={{ port-mmy }} `
          --ssl-mode=DISABLED `
          --user=<имя_пользователя> `
          --password `
          --database=<имя_БД>
  ```

{% endlist %}

{% include [see-fqdn](../../../_includes/mdb/mmy/fqdn-host.md) %}

При выполнении любой из команд введите пароль пользователя БД.

После подключения к СУБД выполните команду `SELECT version();`.

{% include [Successful connection](../../../_includes/mdb/mmy/successful-connect.md) %}


### Подключение с аутентификацией через IAM {#iam}

К базе данных {{ mmy-name }} можно подключиться с помощью [интерфейса командной строки {{ yandex-cloud }} (CLI)](../../../cli/quickstart.md#install), используя аутентификацию через IAM. Этот метод доступен для [аккаунтов на Яндексе](../../../iam/concepts/users/accounts.md#passport), [федеративных аккаунтов](../../../iam/concepts/users/accounts.md#saml-federation) и [локальных пользователей](../../../iam/concepts/users/accounts.md#local). Подключение с аутентификацией через IAM не требует получения SSL-сертификата или указания FQDN хостов кластера.

Перед подключением установите клиент {{ MY }}:

```bash
sudo apt update && sudo apt install --yes mysql-client
```

Подготовьте кластер {{ mmy-name }} к подключению:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера.
  1. Включите публичный доступ для хостов кластера:
     1. Выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}**.
     1. Нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке первого хоста и выберите пункт **{{ ui-key.yacloud.common.edit }}**.
     1. Включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.
     1. Повторите операцию для остальных хостов кластера.
  1. Назначьте роль аккаунту пользователя, который будет подключаться к БД:
     1. Выберите вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** и нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
     1. Введите электронную почту пользователя, к которой привязан аккаунт.
     1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role}}** и выберите роль `managed-mysql.clusters.connector`.
     1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.
  1. Создайте пользователя {{ MY }}:
     1. Выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_users }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
     1. Выберите способ аутентификации **{{ ui-key.yacloud.mysql.cluster.label_iam_dgBhy }}**.
     1. Выберите аккаунт, которому была назначена роль `managed-mysql.clusters.connector`.
     1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.button_add-database }}** и выберите нужную базу данных из выпадающего списка.
     1. Нажмите значок ![image](../../../_assets/console-icons/plus.svg) в столбце **{{ ui-key.yacloud.mdb.dialogs.popup_field_roles }}** и выберите привилегию из выпадающего списка.
     1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-add_button_add }}**.

{% endlist %}

Чтобы подключиться к БД {{ mmy-name }}, выполните команду:

```bash
{{ yc-mdb-my }} connect <имя_или_идентификатор_кластера> --db <имя_БД>
```


## Подключение из графических IDE {#connection-ide}

{% include [ide-environments](../../../_includes/mdb/mdb-ide-envs.md) %}

Подключаться из графических IDE можно только к хостам кластера в публичном доступе с использованием SSL-сертификата.

{% include [note-connection-ide](../../../_includes/mdb/note-connection-ide.md) %}

{% list tabs group=ide %}

- DataGrip {#datagrip}

  1. Создайте источник данных:
     1. Выберите в меню **File** → **New** → **Data Source** → **{{ MY }}**.
     1. На вкладке **General**:
        1. Укажите параметры подключения:
           * **Host** — [FQDN любого хоста {{ MY }}](./fqdn.md) или один из [особых FQDN](./fqdn.md#fqdn-master);
           * **Port** — `{{ port-mmy }}`;
           * **User**, **Password** — имя и пароль пользователя БД;
           * **Database** — имя БД для подключения.
        1. Нажмите ссылку **Download**, чтобы загрузить драйвер соединения.
     1. На вкладке **SSH/SSL**:
         1. Включите настройку **Use SSL**.
         1. В поле **CA file** укажите путь к файлу [SSL-сертификата для подключения](./fqdn.md#get-ssl-cert).
  1. Чтобы проверить подключение, нажмите ссылку **Test Connection**. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
  1. Нажмите кнопку **OK**, чтобы сохранить источник данных.

- DBeaver {#dbeaver}

  1. Создайте новое соединение с БД:
     1. Выберите в меню **База данных** пункт **Новое соединение**.
     1. Выберите из списка БД **{{ MY }}**.
     1. Нажмите кнопку **Далее**.
     1. Укажите параметры подключения на вкладке **Главное**:
        * **Сервер** — [FQDN любого хоста {{ MY }}](./fqdn.md#fqdn) или один из [особых FQDN](./fqdn.md#fqdn-master);
        * **Порт** — `{{ port-mmy }}`;
        * **База данных** — имя БД для подключения;
        * **Пользователь**, **Пароль** — имя и пароль пользователя БД.
     1. На вкладке **SSL**:
         1. Включите настройку **Использовать SSL**.
         1. В поле **Корневой сертификат** укажите путь к сохраненному файлу [SSL-сертификата](./index.md#get-ssl-cert).
         1. В блоке **Дополнительные**:
            1. Включите настройку **Только SSL**.
            1. Выключите настройку **Проверять сертификат сервера**.
  1. Нажмите кнопку **Тест соединения ...** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
  1. Нажмите кнопку **Готово**, чтобы сохранить настройки соединения с БД.

{% endlist %}


## Подключение из {{ websql-full-name }} {#websql}

{% include [WebSQL](../../../_includes/mdb/mmy/websql.md) %}


## Подготовка к подключению из Docker-контейнера {#connection-docker}

Чтобы подключаться к кластеру {{ mmy-name }} из Docker-контейнера, добавьте в Dockerfile строки:

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

  ```bash
  RUN apt-get update && \
      apt-get install mysql-client --yes
  ```


- Подключение с SSL {#with-ssl}

  ```bash
  RUN apt-get update && \
      apt-get install wget mysql-client --yes && \
      mkdir --parents ~/.mysql && \
      wget "{{ crt-web-path }}" \
           --output-document ~/.mysql/root.crt && \
      chmod 0600 ~/.mysql/root.crt
  ```

{% endlist %}
