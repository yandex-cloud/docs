[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for ClickHouse®](../../index.md) > [Пошаговые инструкции](../index.md) > [Подключение](index.md) > Подключение из приложений

# Подключение к кластеру ClickHouse® из приложений

В этом разделе представлены настройки для подключения к хостам кластера Managed Service for ClickHouse® с помощью [инструментов командной строки](#command-line-tools), из [графических IDE](#ide), [браузера](#browser) и [Docker-контейнера](#docker). Как подключиться из кода приложения, описано в разделе [Примеры кода](code-examples.md).


Вы можете подключаться к хостам кластера ClickHouse® в публичном доступе только с использованием [SSL-сертификатов](index.md#get-ssl-cert). В примерах ниже предполагается, что сертификаты `RootCA.crt` и `IntermediateCA.crt`:

* расположены в директории `/usr/local/share/ca-certificates/Yandex/` — для Ubuntu;
* импортированы в хранилище доверенных корневых сертификатов — для Windows.

Подключение без использования SSL-сертификатов поддерживается только для хостов, находящихся не в публичном доступе. В этом случае трафик внутри виртуальной сети при подключении к БД шифроваться не будет.

При необходимости перед подключением [настройте группы безопасности](index.md#configure-security-groups) кластера.


Примеры для Linux проверялись в следующем окружении:

* Виртуальная машина в Yandex Cloud с Ubuntu 20.04 LTS.
* Bash: `5.0.16`.

Примеры для Windows проверялись в следующем окружении:

* Локальная машина с Windows 10 Pro build `19042.1052`.
* PowerShell: `5.1.19041`.

## Инструменты командной строки {#command-line-tools}

Примеры кода с заполненным FQDN хоста доступны в [консоли управления](https://console.yandex.cloud) по нажатию кнопки **Подключиться** на странице кластера.


### clickhouse-client {#clickhouse-client}

**Перед подключением:**

1. Подключите [DEB-репозиторий](https://clickhouse.com/docs/ru/install#install-from-deb-packages) ClickHouse®:

    ```bash
    sudo apt update && sudo apt install --yes apt-transport-https ca-certificates dirmngr && \
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8919F6BD2B48D754 && \
    echo "deb https://packages.clickhouse.com/deb stable main" | sudo tee \
    /etc/apt/sources.list.d/clickhouse.list
    ```

1. Установите зависимости:

    ```bash
    sudo apt update && sudo apt install --yes clickhouse-client
    ```

1. Загрузите файл конфигурации для `clickhouse-client`:

   ```bash
   mkdir -p ~/.clickhouse-client && \
   wget "https://storage.yandexcloud.net/doc-files/clickhouse-client.conf.example" \
     --output-document ~/.clickhouse-client/config.xml
   ```

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

    ```bash
    clickhouse-client --host <FQDN_любого_хоста_ClickHouse®> \
                      --user <имя_пользователя> \
                      --database <имя_БД> \
                      --port 9000 \
                      --ask-password
    ```


- Подключение с SSL {#with-ssl}

  ```bash
  clickhouse-client --host <FQDN_любого_хоста_ClickHouse®> \
                    --secure \
                    --user <имя_пользователя> \
                    --database <имя_БД> \
                    --port 9440 \
                    --ask-password
  ```

{% endlist %}

Как получить FQDN хоста, описано в [инструкции](fqdn.md).

После выполнения команды введите пароль пользователя для завершения процедуры подключения.

После подключения к СУБД выполните команду `SELECT version();`.

### mysql-client {#mysql-client}

{% note warning %}

Используйте интерфейс подключения через клиент MySQL® только если использование стандартных интерфейсов ClickHouse® по каким-либо причинам невозможно.

{% endnote %}

Перед подключением установите утилиту `mysql`:

```bash
sudo apt update && sudo apt install --yes mysql-client
```

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

    ```bash
    mysql --host=<FQDN_любого_хоста_ClickHouse®> \
          --port=3306 \
          --ssl-mode=DISABLED \
          --user <имя_пользователя> \
          --password \
          <имя_БД>
    ```


- Подключение с SSL {#with-ssl}

    ```bash
    mysql --host=<FQDN_любого_хоста_ClickHouse®> \
          --port=3306 \
          --ssl-ca=/usr/local/share/ca-certificates/Yandex/RootCA.crt \
          --ssl-mode=VERIFY_IDENTITY \
          --user=<имя_пользователя> \
          --password \
          <имя_БД>
    ```

{% endlist %}

Как получить FQDN хоста, описано в [инструкции](fqdn.md).

После выполнения команды введите пароль пользователя для завершения процедуры подключения.

После подключения к СУБД выполните команду `SELECT version();`.

### cURL {#curl}

#### Linux (Bash)/macOS (Zsh) {#curl-bash-zsh}

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

    ```bash
    curl --header "X-ClickHouse-User: <имя_пользователя_БД>" \
         --header "X-ClickHouse-Key: <пароль_пользователя_БД>" \
         'http://<FQDN_любого_хоста_ClickHouse®>:8123/?database=<имя_БД>&query=SELECT%20version()'
    ```


- Подключение с SSL {#with-ssl}

    ```bash
    curl --cacert /usr/local/share/ca-certificates/Yandex/RootCA.crt \
         --header "X-ClickHouse-User: <имя_пользователя_БД>" \
         --header "X-ClickHouse-Key: <пароль_пользователя_БД>" \
         'https://<FQDN_любого_хоста_ClickHouse®>:8443/?database=<имя_БД>&query=SELECT%20version()'
    ```

{% endlist %}

Как получить FQDN хоста, описано в [инструкции](fqdn.md).

#### Windows (PowerShell) {#curl-powershell}

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

    ```powershell
    curl.exe `
        --header "X-ClickHouse-User: <имя_пользователя_БД>" `
        --header "X-ClickHouse-Key: <пароль_пользователя_БД>" `
        'http://<FQDN_любого_хоста_ClickHouse®>:8123/?database=<имя_БД>&query=SELECT+version()'
    ```


- Подключение с SSL {#with-ssl}

    ```powershell
    curl.exe `
        --header "X-ClickHouse-User: <имя_пользователя_БД>" `
        --header "X-ClickHouse-Key: <пароль_пользователя_БД>" `
        'https://<FQDN_любого_хоста_ClickHouse®>:8443/?database=<имя_БД>&query=SELECT+version()'
    ```

{% endlist %}

Как получить FQDN хоста, описано в [инструкции](fqdn.md).

## Подключение из графических IDE {#ide}

**Подключения проверялись в следующем окружении:**

* Ubuntu 20.04, DBeaver: `22.2.4`;
* MacOS Monterey 12.7:
  * JetBrains DataGrip: `2023.3.4`;
  * DBeaver Community: `24.0.0`.


Подключаться из графических IDE можно только к хостам кластера в публичном доступе с использованием SSL-сертификата.


Чтобы избежать ошибок при подключении, [сохраните сертификат](https://storage.yandexcloud.net/cloud-certs/RootCA.pem) в локальную папку, для доступа к которой не требуются права администратора.

### DataGrip {#datagrip}

1. Создайте источник данных:
    1. Выберите в меню **File** → **New** → **Data Source** → **ClickHouse®**.
    1. На вкладке **General**:
        1. Укажите параметры подключения:
            * **Host** — [FQDN любого хоста ClickHouse®](fqdn.md) или один из [особых FQDN](fqdn.md#auto);
            * **Port** — `8443`;
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
    1. Выберите из списка БД **ClickHouse®**.
    1. Нажмите кнопку **Далее**.
    1. Укажите параметры подключения на вкладке **Главное**:
        * **Хост** — [FQDN любого хоста ClickHouse®](fqdn.md) или один из [особых FQDN](fqdn.md#auto);
        * **Порт** — `8443`;
        * **БД/Схема** — имя БД для подключения;
        * В блоке **Аутентификация** укажите имя и пароль пользователя БД.
    1. На вкладке **Свойства драйвера**:
        1. Нажмите **Скачать** в новом окне с приглашением скачать файлы драйвера.
        1. Укажите параметры [для SSL-соединения](index.md#get-ssl-cert) в списке свойств драйвера:
            * `ssl:true`;
            * `sslrootcert:<полный_путь_к_сохраненному_файлу_корневого_SSL-сертификата_включая_имя_файла>`.
1. Нажмите кнопку **Тест соединения ...** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
1. Нажмите кнопку **Готово**, чтобы сохранить настройки соединения с БД.


## Подключение из браузера {#browser}

Для выполнения SQL-запросов из браузера используйте:


* [Встроенный SQL-редактор ClickHouse®](#inline-editor).


* [Сервис Yandex WebSQL](#websql).



### Встроенный SQL-редактор ClickHouse® {#inline-editor}

Чтобы подключиться к хосту кластера из встроенного SQL-редактора, укажите в браузере адресную строку:

```text
https://<FQDN_любого_хоста_ClickHouse®>:8443/play
```

Подключаться можно только к хостам кластера в публичном доступе. Как получить FQDN хоста, описано в [инструкции](fqdn.md).

Чтобы подключиться к кластеру с помощью [автоматического выбора доступного хоста](fqdn.md#auto), используйте адрес:

* `https://c-<идентификатор_кластера>.rw.mdb.yandexcloud.net:8443/play` — для подключения к доступному хосту кластера.
* `https://<имя_шарда>.c-<идентификатор_кластера>.rw.mdb.yandexcloud.net:8443/play` — для подключения к доступному хосту [шарда](../../concepts/sharding.md).

Для выполнения запросов к базе данных укажите имя пользователя и пароль в правом верхнем углу страницы.


При подключении из встроенного редактора SQL-запросы выполняются отдельно, без создания единой сессии с сервером ClickHouse®. Поэтому запросы, которые действуют в пределах сессии (например, `USE` или `SET`), не имеют эффекта.



### Сервис Yandex WebSQL {#websql}

{% note info %}

Функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}

Используйте сервис [Yandex WebSQL](../../../websql/index.md) для подключения к кластеру ClickHouse® в Yandex Cloud.

Перед созданием подключения убедитесь, что вы выбрали нужный каталог. Если у вас есть доступ к ранее созданным в этом каталоге кластерам PostgreSQL, ClickHouse®, MySQL®, Greenplum®, Valkey™ или Yandex StoreDoc, они автоматически отобразятся в подразделе **Подключения Yandex Cloud**. Вам нужно будет только создать подключение к нужной БД в кластере.


{% note info %}

[Yandex Managed Service for Trino](../../../managed-trino/index.md) находится на стадии [Preview](../../../overview/concepts/launch-stages.md). В интерфейсе Yandex WebSQL пока нельзя создавать подключения к Yandex Managed Service for Trino, но если в текущем каталоге есть кластер Yandex Managed Service for Trino и у пользователя есть к нему доступ, подключение отобразится в WebSQL и будет доступно для использования. 

{% endnote %}


WebSQL использует подключения в Connection Manager сервиса Yandex MetaData Hub, поэтому все подключения, настроенные в Connection Manager, доступны для работы в WebSQL автоматически при условии, что у пользователя есть [роли](../../../metadata-hub/security/index.md#service-roles).

Чтобы создать подключение к кластеру управляемых БД Yandex Cloud:

1. Убедитесь, что в настройках кластера включена опция **Доступ из WebSQL**.
1. Откройте [**Подключения**](https://websql.yandex.cloud) Yandex WebSQL.
1. В разделе ![image](../../../_assets/console-icons/folder-tree.svg) **Подключения** нажмите ![image](../../../_assets/console-icons/square-plus.svg).
1. В поле **Тип базы данных** выберите нужную БД: PostgreSQL, ClickHouse®, MySQL®, Valkey™, Yandex StoreDoc, Greenplum®.
1. В поле **Каталог кластера** выберите каталог, в котором содержится нужный кластер.
1. В поле **Кластер** выберите кластер управляемых БД, к которому вы хотите подключиться. 
1. Укажите **Имя пользователя**, от лица которого будете подключаться к БД в кластере.
1. Введите **Пароль** пользователя.
1. Перечислите **Базы данных**, к которым вы хотите подключиться. Вы можете подключиться только к существующим в этом кластере БД. У пользователя, которого вы указали, должен быть настроен доступ к ним.
1. Нажмите кнопку **Создать**.

Для формирования запроса:
1. В разделе [**Подключения**](https://websql.yandex.cloud) выберите базу данных, таблицу или представление.
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

Чтобы подключаться к кластеру Managed Service for ClickHouse® из Docker-контейнера, добавьте в Dockerfile строки:

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

   ```bash
   # Подключить DEB-репозиторий.
   RUN apt-get update && \
       apt-get install wget --yes apt-transport-https ca-certificates dirmngr && \
       apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8919F6BD2B48D754 && \
       echo "deb https://packages.clickhouse.com/deb stable main" | tee \
       /etc/apt/sources.list.d/clickhouse.list && \
       # Установить зависимости.
       apt-get update && \
       apt-get install wget clickhouse-client --yes && \
       # Загрузить файл конфигурации для clickhouse-client.
       mkdir --parents ~/.clickhouse-client && \
       wget "https://storage.yandexcloud.net/doc-files/clickhouse-client.conf.example" \
            --output-document ~/.clickhouse-client/config.xml
   ```


- Подключение с SSL {#with-ssl}

   ```bash
   # Подключить DEB-репозиторий.
   RUN apt-get update && \
       apt-get install wget --yes apt-transport-https ca-certificates dirmngr && \
       apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8919F6BD2B48D754 && \
       echo "deb https://packages.clickhouse.com/deb stable main" | tee \
       /etc/apt/sources.list.d/clickhouse.list && \
       # Установить зависимости.
       apt-get update && \
       apt-get install wget clickhouse-client --yes && \
       # Загрузить файл конфигурации для clickhouse-client.
       mkdir --parents ~/.clickhouse-client && \
       wget "https://storage.yandexcloud.net/doc-files/clickhouse-client.conf.example" \
            --output-document ~/.clickhouse-client/config.xml && \
       # Получить SSL-сертификаты.
       mkdir --parents /usr/local/share/ca-certificates/Yandex/ && \
       wget "https://storage.yandexcloud.net/cloud-certs/RootCA.pem" \
            --output-document /usr/local/share/ca-certificates/Yandex/RootCA.crt && \
       wget "https://storage.yandexcloud.net/cloud-certs/IntermediateCA.pem" \
            --output-document /usr/local/share/ca-certificates/Yandex/IntermediateCA.crt && \
       chmod 655 \
            /usr/local/share/ca-certificates/Yandex/RootCA.crt \
            /usr/local/share/ca-certificates/Yandex/IntermediateCA.crt && \
       update-ca-certificates
   ```

{% endlist %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._