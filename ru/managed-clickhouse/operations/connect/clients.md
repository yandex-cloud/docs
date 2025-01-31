---
title: Подключение к кластеру {{ CH }} в {{ mch-full-name }}
description: Следуя этой инструкции, вы сможете подключиться к базе данных в кластере {{ CH }} с помощью инструментов командной строки, из браузера, графических IDE и Docker-контейнера.
---

# Подключение к кластеру {{ CH }} из приложений

В этом разделе представлены настройки для подключения к хостам кластера {{ mch-name }} с помощью [инструментов командной строки](#command-line-tools), из [графических IDE](#ide), [браузера](#browser) и [Docker-контейнера](#docker). О подключении из кода вашего приложения см. [Примеры кода](code-examples.md).

Вы можете подключаться к хостам кластера {{ CH }} в публичном доступе только с использованием [SSL-сертификатов](index.md#get-ssl-cert). В примерах ниже предполагается, что сертификаты `{{ crt-local-file-root }}` и `{{ crt-local-file-int }}`:

* расположены в директории `{{ crt-local-dir }}` — для Ubuntu;
* импортированы в хранилище доверенных корневых сертификатов — для Windows.

Подключение без использования SSL-сертификатов поддерживается только для хостов, находящихся не в публичном доступе. В этом случае трафик внутри виртуальной сети при подключении к БД шифроваться не будет.

При необходимости перед подключением [настройте группы безопасности](index.md#configure-security-groups) кластера.

Примеры для Linux проверялись в следующем окружении:

* Виртуальная машина в {{ yandex-cloud }} с Ubuntu 20.04 LTS.
* Bash: `5.0.16`.

Примеры для Windows проверялись в следующем окружении:

* Локальная машина с Windows 10 Pro build `19042.1052`.
* PowerShell: `5.1.19041`.

## Инструменты командной строки {#command-line-tools}

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

### clickhouse-client {#clickhouse-client}

**Перед подключением:**

1. Подключите [DEB-репозиторий]({{ ch.docs }}/getting-started/install/#install-from-deb-packages) {{ CH }}:

    ```bash
    sudo apt update && sudo apt install --yes apt-transport-https ca-certificates dirmngr && \
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8919F6BD2B48D754 && \
    echo "deb https://packages.{{ ch-domain }}/deb stable main" | sudo tee \
    /etc/apt/sources.list.d/clickhouse.list
    ```

1. Установите зависимости:

    ```bash
    sudo apt update && sudo apt install --yes clickhouse-client
    ```

1. Загрузите файл конфигурации для `clickhouse-client`:

   {% include [ClickHouse client config](../../../_includes/mdb/mch/client-config.md) %}

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

    ```bash
    clickhouse-client --host <FQDN_любого_хоста_{{ CH }}> \
                      --user <имя_пользователя> \
                      --database <имя_БД> \
                      --port 9000 \
                      --ask-password
    ```


- Подключение с SSL {#with-ssl}

  {% include [default-connstring](../../../_includes/mdb/mch/default-connstring.md) %}

{% endlist %}

О том, как получить FQDN хоста, см. [инструкцию](fqdn.md).

После выполнения команды введите пароль пользователя для завершения процедуры подключения.

После подключения к СУБД выполните команду `SELECT version();`.

### cURL {#curl}

#### Linux (Bash)/macOS (Zsh) {#curl-bash-zsh}

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

    ```bash
    curl --header "X-ClickHouse-User: <имя_пользователя_БД>" \
         --header "X-ClickHouse-Key: <пароль_пользователя_БД>" \
         'http://<FQDN_любого_хоста_{{ CH }}>:8123/?database=<имя_БД>&query=SELECT%20version()'
    ```


- Подключение с SSL {#with-ssl}

    ```bash
    curl --cacert {{ crt-local-dir }}{{ crt-local-file-root }} \
         --header "X-ClickHouse-User: <имя_пользователя_БД>" \
         --header "X-ClickHouse-Key: <пароль_пользователя_БД>" \
         'https://<FQDN_любого_хоста_{{ CH }}>:8443/?database=<имя_БД>&query=SELECT%20version()'
    ```

{% endlist %}

О том, как получить FQDN хоста, см. [инструкцию](fqdn.md).

#### Windows (PowerShell) {#curl-powershell}

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

    ```powershell
    curl.exe `
        --header "X-ClickHouse-User: <имя_пользователя_БД>" `
        --header "X-ClickHouse-Key: <пароль_пользователя_БД>" `
        'http://<FQDN_любого_хоста_{{ CH }}>:8123/?database=<имя_БД>&query=SELECT+version()'
    ```


- Подключение с SSL {#with-ssl}

    ```powershell
    curl.exe `
        --header "X-ClickHouse-User: <имя_пользователя_БД>" `
        --header "X-ClickHouse-Key: <пароль_пользователя_БД>" `
        'https://<FQDN_любого_хоста_{{ CH }}>:8443/?database=<имя_БД>&query=SELECT+version()'
    ```

{% endlist %}

О том, как получить FQDN хоста, см. [инструкцию](fqdn.md).

## Подключение из графических IDE {#ide}

{% include [ide-environments](../../../_includes/mdb/mdb-ide-envs.md) %}

Подключаться из графических IDE можно только к хостам кластера в публичном доступе с использованием SSL-сертификата.

{% include [note-connection-ide](../../../_includes/mdb/note-connection-ide.md) %}

### DataGrip {#datagrip}

1. Создайте источник данных:
    1. Выберите в меню **File** → **New** → **Data Source** → **{{ CH }}**.
    1. На вкладке **General**:
        1. Укажите параметры подключения:
            * **Host** — [FQDN любого хоста {{ CH }}](fqdn.md) или один из [особых FQDN](fqdn.md#auto);
            * **Port** — `{{ port-mch-http }}`;
            * **User**, **Password** — имя и пароль пользователя БД;
            * **Database** — имя БД для подключения.
        1. Нажмите ссылку **Download**, чтобы загрузить драйвер соединения.
    1. На вкладке **SSH/SSL**:
        1. Включите настройку **Use SSL**.
        1. Укажите папку с файлом скачанного [SSL-сертификата для подключения](index.md#get-ssl-cert).
1. Нажмите ссылку **Test Connection** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
1. Нажмите кнопку **OK**, чтобы сохранить источник данных.

### DBeaver {#dbeaver}

1. Создайте новое соединение с БД:
    1. Выберите в меню **База данных** пункт **Новое соединение**.
    1. Выберите из списка БД **{{ CH }}**.
    1. Нажмите кнопку **Далее**.
    1. Укажите параметры подключения на вкладке **Главное**:
        * **Хост** — [FQDN любого хоста {{ CH }}](fqdn.md) или один из [особых FQDN](fqdn.md#auto);
        * **Порт** — `{{ port-mch-http }}`;
        * **БД/Схема** — имя БД для подключения;
        * В блоке **Аутентификация** укажите имя и пароль пользователя БД.
    1. На вкладке **Свойства драйвера**:
        1. Нажмите **Скачать** в новом окне с приглашением скачать файлы драйвера.
        1. Укажите параметры [для SSL-соединения](index.md#get-ssl-cert) в списке свойств драйвера:
            * `ssl:true`;
            * `sslrootcert:<путь_к_сохраненному_файлу_SSL-сертификата>`.
1. Нажмите кнопку **Тест соединения ...** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
1. Нажмите кнопку **Готово**, чтобы сохранить настройки соединения с БД.

{% endlist %}

## Подключение из браузера {#browser}

Для выполнения SQL-запросов из браузера используйте:


* [Встроенный SQL-редактор {{ CH }}](#inline-editor).


* [Сервис {{ websql-full-name }}](#websql).




### Встроенный SQL-редактор {{ CH }} {#inline-editor}

Чтобы подключиться к хосту кластера из встроенного SQL-редактора, укажите в браузере адресную строку:

```text
https://<FQDN_любого_хоста_{{ CH }}>:8443/play
```

Подключаться можно только к хостам кластера в публичном доступе. О том, как получить FQDN хоста, см. [инструкцию](fqdn.md).

Чтобы подключиться к кластеру с помощью [автоматического выбора доступного хоста](fqdn.md#auto), используйте адрес:

* `https://c-<идентификатор_кластера>.rw.{{ dns-zone }}:8443/play` — для подключения к доступному хосту кластера.
* `https://<имя_шарда>.c-<идентификатор_кластера>.rw.{{ dns-zone }}:8443/play` — для подключения к доступному хосту [шарда](../../concepts/sharding.md).

Для выполнения запросов к базе данных укажите имя пользователя и пароль в правом верхнем углу страницы.


При подключении из встроенного редактора SQL-запросы выполняются отдельно, без создания единой сессии с сервером {{ CH }}. Поэтому запросы, которые действуют в пределах сессии (например, `USE` или `SET`), не имеют эффекта.



### Сервис {{ websql-full-name }} {#websql}

{% include notitle [preview](../../../_includes/note-preview.md) %}

Используйте сервис [{{ websql-full-name }}](../../../websql) для подключения к кластеру {{ CH }} в {{ yandex-cloud }}.

{% include notitle [connect-to-cluster](../../../_includes/websql/connect-to-cluster.md) %}

{% include notitle [execute-sql](../../../_includes/websql/execute-sql.md) %}


## Подготовка к подключению из Docker-контейнера {#docker}

Чтобы подключаться к кластеру {{ mch-name }} из Docker-контейнера, добавьте в Dockerfile строки:

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

   ```bash
   # Подключить DEB-репозиторий.
   RUN apt-get update && \
       apt-get install wget --yes apt-transport-https ca-certificates dirmngr && \
       apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8919F6BD2B48D754 && \
       echo "deb https://packages.{{ ch-domain }}/deb stable main" | tee \
       /etc/apt/sources.list.d/clickhouse.list && \
       # Установить зависимости.
       apt-get update && \
       apt-get install wget clickhouse-client --yes && \
       # Загрузить файл конфигурации для clickhouse-client.
       mkdir --parents ~/.clickhouse-client && \
       wget "https://{{ s3-storage-host-doc-files }}/clickhouse-client.conf.example" \
            --output-document ~/.clickhouse-client/config.xml
   ```


- Подключение с SSL {#with-ssl}

   ```bash
   # Подключить DEB-репозиторий.
   RUN apt-get update && \
       apt-get install wget --yes apt-transport-https ca-certificates dirmngr && \
       apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8919F6BD2B48D754 && \
       echo "deb https://packages.{{ ch-domain }}/deb stable main" | tee \
       /etc/apt/sources.list.d/clickhouse.list && \
       # Установить зависимости.
       apt-get update && \
       apt-get install wget clickhouse-client --yes && \
       # Загрузить файл конфигурации для clickhouse-client.
       mkdir --parents ~/.clickhouse-client && \
       wget "https://{{ s3-storage-host-doc-files }}/clickhouse-client.conf.example" \
            --output-document ~/.clickhouse-client/config.xml && \
       # Получить SSL-сертификаты.
       mkdir --parents {{ crt-local-dir }} && \
       wget "{{ crt-web-path-root }}" \
            --output-document {{ crt-local-dir }}{{ crt-local-file-root }} && \
       wget "{{ crt-web-path-int }}" \
            --output-document {{ crt-local-dir }}{{ crt-local-file-int }} && \
       chmod 655 \
            {{ crt-local-dir }}{{ crt-local-file-root }} \
            {{ crt-local-dir }}{{ crt-local-file-int }} && \
       update-ca-certificates
   ```

{% endlist %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
