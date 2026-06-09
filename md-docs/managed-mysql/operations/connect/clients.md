# Подключение к кластеру {{ MY }} из приложений

В этом разделе представлены настройки для подключения к хостам кластера {{ mmy-name }} с помощью [инструментов командной строки](#command-line-tools), из [графических IDE](#connection-ide), из [{{ websql-full-name }}](#websql) и [Docker-контейнера](#connection-docker). О подключении из кода вашего приложения см. [Примеры кода](code-examples.md).

## Инструменты командной строки {#command-line-tools}

Примеры кода с заполненным FQDN хоста доступны в [консоли управления]({{ link-console-main }}) по нажатию кнопки **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}** на странице кластера.

### Linux (Bash)/macOS (Zsh) {#bash-zsh}

Перед подключением установите утилиту `mysql`:

```bash
sudo apt update && sudo apt install --yes mysql-client
```

{% list tabs group=connection %}

- Подключение с SSL {#with-ssl}

  ```bash
  mysql --host=<имя_хоста_{{ MY }}>.{{ dns-zone }} \
        --port={{ port-mmy }} \
        --ssl-ca=~/.mysql/root.crt \
        --ssl-mode=VERIFY_IDENTITY \
        --user=<имя_пользователя> \
        --password \
        <имя_БД>
  ```

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

О том, как получить FQDN хоста, см. [инструкцию](fqdn.md).

При выполнении любой из команд введите пароль пользователя БД.

После подключения к СУБД выполните команду `SELECT version();`.

При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ MY }}.

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

О том, как получить FQDN хоста, см. [инструкцию](fqdn.md).

При выполнении любой из команд введите пароль пользователя БД.

После подключения к СУБД выполните команду `SELECT version();`.

При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ MY }}.


### Подключение с аутентификацией через IAM {#iam}

К базе данных {{ mmy-name }} можно подключиться с помощью [интерфейса командной строки {{ yandex-cloud }} (CLI)](../../../cli/quickstart.md#install), используя аутентификацию через IAM. Этот метод доступен для [аккаунтов на Яндексе](../../../iam/concepts/users/accounts.md#passport), [федеративных аккаунтов](../../../iam/concepts/users/accounts.md#saml-federation) и [локальных пользователей](../../../iam/concepts/users/accounts.md#local). Подключение с аутентификацией через IAM не требует получения SSL-сертификата или указания FQDN хостов кластера.

Перед подключением:

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. Установите клиент {{ MY }}:

    ```bash
    sudo apt update && sudo apt install --yes mysql-client
    ```

Подготовьте кластер {{ mmy-name }} к подключению:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера.
  1. Включите публичный доступ для хостов кластера:
     1. Выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}**.
     1. Нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке первого хоста и выберите пункт **{{ ui-key.yacloud.common.edit }}**.
     1. Включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.
     1. Повторите операцию для остальных хостов кластера.
  1. Назначьте роль `managed-mysql.clusters.connector` аккаунту пользователя, который будет подключаться к БД:
     1. Выберите вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** и нажмите кнопку **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
     1. Введите электронную почту пользователя, к которой привязан аккаунт.
     1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите роль `managed-mysql.clusters.connector`.
     1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.
  1. Создайте пользователя {{ MY }}:
     1. Выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_users }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
     1. Выберите способ аутентификации **{{ ui-key.yacloud.mysql.cluster.label_iam_dgBhy }}**.
     1. Выберите аккаунт, которому была назначена роль `managed-mysql.clusters.connector`.
     1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.button_add-database }}** и выберите нужную базу данных из выпадающего списка.
     1. Нажмите значок ![image](../../../_assets/console-icons/plus.svg) в столбце **{{ ui-key.yacloud.mdb.dialogs.popup_field_roles }}** и выберите необходимые привилегии из выпадающего списка.
     1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-add_button_add }}**.

{% endlist %}

Чтобы подключиться к БД {{ mmy-name }}, выполните команду:

```bash
{{ yc-mdb-my }} connect <имя_или_идентификатор_кластера> --db <имя_БД>
```

Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).


## Подключение из графических IDE {#connection-ide}

**Подключения проверялись в следующем окружении:**

* Ubuntu 20.04, DBeaver: `22.2.4`;
* MacOS Monterey 12.7:
  * JetBrains DataGrip: `2023.3.4`;
  * DBeaver Community: `24.0.0`.


Подключаться из графических IDE можно только к хостам кластера в публичном доступе с использованием SSL-сертификата.


Чтобы избежать ошибок при подключении, [сохраните сертификат]({{ crt-web-path-root }}) в локальную папку, для доступа к которой не требуются права администратора.

{% list tabs group=ide %}

- DataGrip {#datagrip}

  1. Создайте источник данных:
     1. Выберите в меню **File** → **New** → **Data Source** → **{{ MY }}**.
     1. На вкладке **General**:
        1. Укажите параметры подключения:
           * **Host** — [FQDN любого хоста {{ MY }}](fqdn.md) или один из [особых FQDN](fqdn.md#fqdn-master);
           * **Port** — `{{ port-mmy }}`;
           * **User**, **Password** — имя и пароль пользователя БД;
           * **Database** — имя БД для подключения.
        1. Нажмите ссылку **Download**, чтобы загрузить драйвер соединения.
     1. На вкладке **SSH/SSL**:
         1. Включите настройку **Use SSL**.
         1. В поле **CA file** укажите путь к файлу [SSL-сертификата для подключения](fqdn.md#get-ssl-cert).
  1. Чтобы проверить подключение, нажмите ссылку **Test Connection**. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
  1. Нажмите кнопку **OK**, чтобы сохранить источник данных.

- DBeaver {#dbeaver}

  1. Создайте новое соединение с БД:
     1. Выберите в меню **База данных** пункт **Новое соединение**.
     1. Выберите из списка БД **{{ MY }}**.
     1. Нажмите кнопку **Далее**.
     1. Укажите параметры подключения на вкладке **Главное**:
        * **Сервер** — [FQDN любого хоста {{ MY }}](fqdn.md#fqdn) или один из [особых FQDN](fqdn.md#fqdn-master);
        * **Порт** — `{{ port-mmy }}`;
        * **База данных** — имя БД для подключения;
        * **Пользователь**, **Пароль** — имя и пароль пользователя БД.
     1. На вкладке **SSL**:
         1. Включите настройку **Использовать SSL**.
         1. В поле **Корневой сертификат** укажите путь к сохраненному файлу [SSL-сертификата](index.md#get-ssl-cert).
         1. В блоке **Дополнительные**:
            1. Включите настройку **Только SSL**.
            1. Выключите настройку **Проверять сертификат сервера**.
  1. Нажмите кнопку **Тест соединения ...** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
  1. Нажмите кнопку **Готово**, чтобы сохранить настройки соединения с БД.

{% endlist %}

### Подключение с аутентификацией через IAM {#ide-iam}

Для подключения к базе данных {{ mmy-name }} из графических IDE с аутентификацией через [{{ iam-full-name }}](../../../iam/index.md) необходимо запустить утилиту [CLI {{ yandex-cloud }}](../../../cli/index.md) в режиме слушающего прокси-сервера.

Подключение доступно для [аккаунтов на Яндексе](../../../iam/concepts/users/accounts.md#passport), [федеративных аккаунтов](../../../iam/concepts/users/accounts.md#saml-federation) и [локальных пользователей](../../../iam/concepts/users/accounts.md#local). Оно не требует получения SSL-сертификата или указания FQDN хостов кластера.

Подключаться из графических IDE можно только к хостам кластера в публичном доступе.

Чтобы подключиться к БД {{ mmy-name }}:

1. Назначьте роль `managed-mysql.clusters.connector` аккаунту пользователя, который будет подключаться к БД:

    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
    1. Нажмите на имя нужного кластера.
    1. Выберите вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** и нажмите кнопку **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
    1. Введите электронную почту пользователя, к которой привязан аккаунт.
    1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role}}** и выберите роль `managed-mysql.clusters.connector`.
    1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

1. Создайте пользователя {{ MY }}:

    1. Выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_users }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.action_add-user }}**.
    1. Выберите способ аутентификации **{{ ui-key.yacloud.mysql.cluster.label_iam_dgBhy }}**.
    1. Выберите аккаунт, которому была назначена роль `managed-mysql.clusters.connector`.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.button_add-database }}** и выберите нужную базу данных из выпадающего списка.
    1. Нажмите значок ![image](../../../_assets/console-icons/plus.svg) в столбце **{{ ui-key.yacloud.mdb.dialogs.popup_field_roles }}** и выберите необходимые привилегии из выпадающего списка.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-add_button_add }}**.

1. Запустите CLI {{ yandex-cloud }} в режиме прокси-сервера:

    1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

        По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Выполните команду:

        ```bash
        {{ yc-mdb-my }} connect <имя_или_идентификатор_кластера> --db <имя_БД> --daemon
        ```

        Будет запущен прокси-сервер на порте `3306`. Чтобы выбрать другой порт, укажите в команде параметр `--port <номер_порта>`.

        Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

1. Подключитесь к кластеру {{ mmy-name }}:

    {% list tabs group=ide %}

    - DBeaver {#dbeaver}

        1. Создайте новое соединение с БД:
            1. Выберите в меню **База данных** пункт **Новое соединение**.
            1. Выберите из списка БД **{{ MY }}**.
            1. Нажмите кнопку **Далее**.
            1. Укажите параметры подключения на вкладке **Главное**:
                * **Сервер** — `localhost`;
                * **Порт** — `3306` или порт, который вы указали при запуске прокси-сервера;
                * **База данных** — имя БД для подключения;
                * **Пользователь** — логин или электронная почта вашего аккаунта;
                * **Пароль** — оставьте это поле пустым.
        1. Нажмите кнопку **Тест соединения ...** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
        1. Нажмите кнопку **Готово**, чтобы сохранить настройки соединения с БД.

    - {{ MY }} Workbench {#mysql-workbench}

        1. Создайте новое соединение с БД:
            1. Выберите в меню **Database** пункт **Manage connections...**
            1. Нажмите кнопку **New**.
            1. Укажите параметры подключения на вкладке **Connection**:
                * **Hostname** — `127.0.0.1`;
                * **Port** — `3306` или порт, который вы указали при запуске прокси-сервера;
                * **Username** — логин или электронная почта вашего аккаунта;
                * **Default schema** — имя БД для подключения;
                * **SSL** → **Use SSL** — `No`.
        1. Нажмите кнопку **Test Connection** для проверки подключения. При успешном подключении будет выведена информация о нем.

    {% endlist %}


## Подключение из {{ websql-full-name }} {#websql}

Вы можете отправлять SQL-запросы к базам данных в кластере {{ mmy-name }} с помощью сервиса [{{ websql-full-name }}](../../../websql/index.md).

{{ websql-name }} — это сервис {{ yandex-cloud }}, который позволяет подключаться к кластерам управляемых баз данных, работать с БД, таблицами и схемами и выполнять запросы. Сервис работает в браузере, не требует дополнительной авторизации и предлагает удобные подсказки для работы с SQL-командами.

Для подключения из {{ websql-name }} в настройках кластера должна быть включена опция **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}**. Опцию можно включить при [создании](../cluster-create.md) или [изменении](../update.md#change-additional-settings) кластера.

В кластере {{ mmy-name }} для каждого пользователя БД автоматически создается [подключение {{ connection-manager-name }}](../../../metadata-hub/concepts/connection-manager.md), которое можно использовать для подключения к БД из {{ websql-name }}. При необходимости вы также можете [создать новое подключение](../../../websql/operations/create-connection.md#connect-cluster).

Чтобы подключиться к БД из {{ websql-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.switch_explore-websql }}**.
  1. Выберите нужное подключение.

      Откроется подключение в сервисе {{ websql-name }}. Чтобы перейти в редактор запросов, выберите нужную БД.

      Справочник по поддерживаемым запросам можно найти в [документации {{ MY }}](https://dev.mysql.com/doc/refman/9.0/en/sql-statements.html).
    
{% endlist %}

Подробнее о работе с {{ websql-name }} см. в [документации сервиса](../../../websql/operations/index.md).



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