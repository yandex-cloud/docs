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

Примеры кода с заполненным FQDN хоста доступны в [консоли управления]({{ link-console-main }}) по нажатию кнопки **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}** на странице кластера.


### clickhouse-client {#clickhouse-client}

**Перед подключением:**

1. Подключите [DEB-репозиторий]({{ ch.docs }}{{ lang }}/install#install-from-deb-packages) {{ CH }}:

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

   ```bash
   mkdir -p ~/.clickhouse-client && \
   wget "https://{{ s3-storage-host-doc-files }}/clickhouse-client.conf.example" \
     --output-document ~/.clickhouse-client/config.xml
   ```

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

  ```bash
  clickhouse-client --host <FQDN_любого_хоста_{{ CH }}> \
                    --secure \
                    --user <имя_пользователя> \
                    --database <имя_БД> \
                    --port 9440 \
                    --ask-password
  ```

{% endlist %}

О том, как получить FQDN хоста, см. [инструкцию](fqdn.md).

После выполнения команды введите пароль пользователя для завершения процедуры подключения.

После подключения к СУБД выполните команду `SELECT version();`.

### mysql-client {#mysql-client}

{% note warning %}

Используйте интерфейс подключения через клиент {{ MY }} только если использование стандартных интерфейсов {{ CH }} по каким-либо причинам невозможно.

{% endnote %}

Перед подключением установите утилиту `mysql`:

```bash
sudo apt update && sudo apt install --yes mysql-client
```

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

    ```bash
    mysql --host=<FQDN_любого_хоста_{{ CH }}> \
          --port={{ port-mmy }} \
          --ssl-mode=DISABLED \
          --user <имя_пользователя> \
          --password \
          <имя_БД>
    ```


- Подключение с SSL {#with-ssl}

    ```bash
    mysql --host=<FQDN_любого_хоста_{{ CH }}> \
          --port={{ port-mmy }} \
          --ssl-ca={{ crt-local-dir }}{{ crt-local-file-root }} \
          --ssl-mode=VERIFY_IDENTITY \
          --user=<имя_пользователя> \
          --password \
          <имя_БД>
    ```

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

**Подключения проверялись в следующем окружении:**

* Ubuntu 20.04, DBeaver: `22.2.4`;
* MacOS Monterey 12.7:
  * JetBrains DataGrip: `2023.3.4`;
  * DBeaver Community: `24.0.0`.


Подключаться из графических IDE можно только к хостам кластера в публичном доступе с использованием SSL-сертификата.


Чтобы избежать ошибок при подключении, [сохраните сертификат]({{ crt-web-path-root }}) в локальную папку, для доступа к которой не требуются права администратора.

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

{% note info %}

Функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}

Используйте сервис [{{ websql-full-name }}](../../../websql/index.md) для подключения к кластеру {{ CH }} в {{ yandex-cloud }}.

Перед созданием подключения убедитесь, что вы выбрали нужный каталог. Если у вас есть доступ к ранее созданным в этом каталоге кластерам {{ PG }}, {{ CH }}, {{ MY }}, {{ GP }}, {{ VLK }} или {{ SD }}, они автоматически отобразятся в подразделе **Подключения {{ yandex-cloud }}**. Вам нужно будет только создать подключение к нужной БД в кластере.


{% note info %}

[{{ mtr-full-name }}](../../../managed-trino/index.md) находится на стадии [Preview](../../../overview/concepts/launch-stages.md). В интерфейсе {{ websql-full-name }} пока нельзя создавать подключения к {{ mtr-full-name }}, но если в текущем каталоге есть кластер {{ mtr-full-name }} и у пользователя есть к нему доступ, подключение отобразится в {{ websql-name }} и будет доступно для использования. 

{% endnote %}


{{ websql-name }} использует подключения в {{ connection-manager-name }} сервиса {{ metadata-hub-full-name }}, поэтому все подключения, настроенные в {{ connection-manager-name }}, доступны для работы в {{ websql-name }} автоматически при условии, что у пользователя есть [роли](../../../metadata-hub/security/index.md#service-roles).

Чтобы создать подключение к кластеру управляемых БД {{ yandex-cloud }}:

1. Убедитесь, что в настройках кластера включена опция **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}**.
1. Откройте [**Подключения**]({{ websql-link }}) {{ websql-full-name }}.
1. В разделе ![image](../../../_assets/console-icons/folder-tree.svg) **Подключения** нажмите ![image](../../../_assets/console-icons/square-plus.svg).
1. В поле **Тип базы данных** выберите нужную БД: {{ PG }}, {{ CH }}, {{ MY }}, {{ VLK }}, {{ SD }}, {{ GP }}.
1. В поле **Каталог кластера** выберите каталог, в котором содержится нужный кластер.
1. В поле **Кластер** выберите кластер управляемых БД, к которому вы хотите подключиться. 
1. Укажите **Имя пользователя**, от лица которого будете подключаться к БД в кластере.
1. Введите **Пароль** пользователя.
1. Перечислите **Базы данных**, к которым вы хотите подключиться. Вы можете подключиться только к существующим в этом кластере БД. У пользователя, которого вы указали, должен быть настроен доступ к ним.
1. Нажмите кнопку **Создать**.

Для формирования запроса:
1. В разделе [**Подключения**]({{ websql-link }}) выберите базу данных, таблицу или представление.
1. На панели данных появится форма с запросом по умолчанию:
 
    ```sql
    SELECT * FROM <имя_таблицы> LIMIT 10;
    ```
1. Используйте этот запрос или измените его. Интерфейс подскажет вам возможные части запроса и подсветит ошибки.
1. Нажмите кнопку **Выполнить**.

На панели результатов появится таблица с результатами запроса.

При редактировании и выполнении запроса вы можете использовать комбинации горячих клавиш (нажмите ![image](../../../_assets/websql/questionmark.svg) для просмотра полного списка):

{% list tabs group=operating_system %}

- Windows/Linux {#window-linux}

   * показать подсказки: **Ctrl** + **I** , **Ctrl** + **Space**;
   * закомментировать строку: **Ctrl** + **/**;
   * выполнить запрос: **Ctrl** + **Enter**.

- macOS {#macos}

   * показать подсказки: **⌘** + **I** , **⌃** + **Space**;
   * закомментировать строку: **⌘** + **/**;
   * выполнить запрос: **⌘** + **⏎**.

{% endlist %}

Нажмите ![image](../../../_assets/websql/palette.svg) **Открыть палитру команд**, чтобы просмотреть полный список доступных команд и соответствующих им горячих клавиш.


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

_{{ CH }} является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._