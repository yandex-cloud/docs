---
title: Подключение к кластеру {{ MG }} в {{ mmg-full-name }}
description: Следуя этой инструкции, вы сможете подключиться к базе данных в кластере {{ MG }} с помощью инструментов командной строки, из графических IDE и Docker-контейнера.
---

# Подключение к кластеру {{ MG }} из приложений

К кластеру {{ MG }} можно подключиться с помощью [инструментов командной строки](#command-line-tools), из [графических IDE](#connection-ide) и [Docker-контейнера](#connection-docker). О подключении из кода вашего приложения см. [Примеры кода](code-examples.md).

В примерах ниже предполагается, что [SSL-сертификат](index.md#get-ssl-cert) `root.crt` расположен в директории:

* `~/.mongodb/` для Ubuntu;
* `$HOME\.mongodb` для Windows.

При успешном подключении к кластеру и выполнении тестового запроса будет выведено имя БД, к которой было выполнено подключение.

## Инструменты командной строки {#command-line-tools}

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

Способ настройки зависит от того, включено ли в кластере [шардирование](../../concepts/sharding.md).

### Linux (Bash) {#bash}

Перед подключением [установите утилиту MongoDB Shell](index.md#install-mongosh).

{% list tabs group=connection %}

- Подключение с SSL для {{ MG }} 4.2 и выше {#with-ssl}

    Для нешардированного кластера:

    ```bash
    mongosh --norc \
            --tls \
            --tlsCAFile ~/.mongodb/root.crt \
            --host '<FQDN_хоста_1_{{ MG }}>:{{ port-mmg }},...,<FQDN_хоста_N_{{ MG }}>:{{ port-mmg }}' \
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

- Подключение с SSL для {{ MG }} 4.0 {#with-ssl-4}

    Для нешардированного кластера:

    ```bash
    mongosh --norc \
            --ssl \
            --sslCAFile ~/.mongodb/root.crt \
            --host '<FQDN_хоста_1_{{ MG }}>:{{ port-mmg }},...,<FQDN_хоста_N_{{ MG }}>:{{ port-mmg }}' \
            --username <имя_пользователя_БД> \
            --password <пароль_пользователя_БД> \
            <имя_БД>
    ```

    Для шардированного кластера:

    ```bash
    mongosh --norc \
            --ssl \
            --sslCAFile ~/.mongodb/root.crt \
            --host '<FQDN_хоста_1_MONGOINFRA_или_MONGOS>:27017,...,<FQDN_хоста_N_MONGOINFRA_или_MONGOS>:27017' \
            --username <имя_пользователя_БД> \
            --password <пароль_пользователя_БД> \
            <имя_БД>
    ```

- Подключение без SSL {#without-ssl}

    Для нешардированного кластера:

    ```bash
    mongosh --norc \
            --host '<FQDN_хоста_1_{{ MG }}>:{{ port-mmg }},...,<FQDN_хоста_N_{{ MG }}>:{{ port-mmg }}' \
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

{% endlist %}

{% include [see-fqdn-host](../../../_includes/mdb/mmg/fqdn-host.md) %}

После подключения выполните команду `db`.

### Windows (PowerShell) {#powershell}

Перед подключением [установите утилиту MongoDB Shell](index.md#install-mongosh).

{% list tabs group=connection %}

- Подключение с SSL для {{ MG }} 4.2 и выше {#with-ssl}

    Для нешардированного кластера:

    ```powershell
    mongosh.exe --norc `
                --host '<FQDN_хоста_1_{{ MG }}>:{{ port-mmg }},...,<FQDN_хоста_N_{{ MG }}>:{{ port-mmg }}' `
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

- Подключение без SSL {#without-ssl}

    Для нешардированного кластера:

    ```powershell
    mongosh.exe --norc `
                --host '<FQDN_хоста_1_{{ MG }}>:{{ port-mmg }},...,<FQDN_хоста_N_{{ MG }}>:{{ port-mmg }}' `
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

{% endlist %}

{% include [see-fqdn-host](../../../_includes/mdb/mmg/fqdn-host.md) %}

После подключения выполните команду `db`.

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
              mongodb://<FQDN_хоста_1_{{ MG }}>:{{ port-mmg }},..,<FQDN_хоста_N_{{ MG }}>:{{ port-mmg }}/<имя_БД>
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

Поддержка подключения к кластеру {{ MG }} доступна только в [коммерческих редакциях DBeaver](https://dbeaver.com/buy/).

Чтобы подключиться к кластеру:

1. Создайте новое соединение с БД:
   1. Выберите в меню **База данных** пункт **Новое соединение**.
   1. Выберите из списка БД **{{ MG }}**.
   1. Нажмите кнопку **Далее**.
   1. Настройте параметры подключения на вкладке **Главное**:
      1. В блоке **Адрес** переключите **Type** на `URL` и укажите строку подключения.

           Для нешардированного кластера:

           ```http
           mongodb://<FQDN_хоста_1_{{ MG }}>:{{ port-mmg }},..,<FQDN_хоста_N_{{ MG }}>:{{ port-mmg }}/<имя_БД>
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

После запуска Docker-контейнера перейдите в него и [установите утилиту](https://www.mongodb.com/docs/mongodb-shell/install/) `mongosh`. Она понадобится для подключения к кластеру.
