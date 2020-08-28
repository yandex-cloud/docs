# Как начать работать с {{ mch-short-name }}

Чтобы начать работу с сервисом:

- [Создайте кластер БД](#cluster-create).
- [Подключитесь к БД](#connect).


## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. Если у вас еще нет каталога, создайте его:

    {% include [create-folder](../_includes/create-folder.md) %}

Подключаться к кластерам БД можно как изнутри, так и извне {{ yandex-cloud }}:

1. Чтобы подключаться изнутри {{ yandex-cloud }}, создайте виртуальную машину в той же сети, что и кластер БД (на основе [Linux](../compute/quickstart/quick-create-linux.md) или [Windows](../compute/quickstart/quick-create-windows.md))
1. Чтобы подключаться к кластеру из интернета, запросите публичный доступ к хостам при создании кластера.


## Создайте кластер {#cluster-create}

1. В консоли управления выберите каталог, в котором нужно создать кластер БД.
1. Выберите сервис **{{ mch-name }}**.
1. Нажмите кнопку **Создать кластер**.
1. Задайте параметры кластера и нажмите кнопку **Создать кластер**. Процесс подробно рассмотрен в разделе [{#T}](operations/cluster-create.md).
1. Когда кластер будет готов к работе, его статус на панели {{ mch-short-name }} сменится на **Running**, а состояние - на **Alive**. Это может занять некоторое время.

## Подключитесь к БД {#connect}

1. Для подключения к серверу БД получите SSL-сертификат:

        
    1. Создайте каталог:

        ```bash
        $ mkdir ~/.clickhouse
        ```

    1. Получите сертификат:
        
        ```bash
        $ wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O ~/.clickhouse/root.crt
        ```

    1. Настройте права доступа к сертификату:

        ```bash
        $ chmod 0600 ~/.clickhouse/root.crt
        ```

   

1. Используйте для подключения ClickHouse CLI:

    1. Укажите путь к SSL-сертификату в [конфигурационном файле](https://clickhouse.yandex/docs/ru/interfaces/cli/#interfaces_cli_configuration), в элементе `<caConfig>`:

    ```xml
    <config>
      <openSSL>
        <client>
          <loadDefaultCAFile>true</loadDefaultCAFile>
          <caConfig>~/.clickhouse/root.crt</caConfig>
          <cacheSessions>true</cacheSessions>
          <disableProtocols>sslv2,sslv3</disableProtocols>
          <preferServerCiphers>true</preferServerCiphers>
          <invalidCertificateHandler>
            <name>RejectCertificateHandler</name>
          </invalidCertificateHandler>
        </client>
      </openSSL>
    </config>
    ```
    1.  Запустите ClickHouse CLI со следующими параметрами:

    ```bash
    clickhouse-client --host <FQDN хоста> \
                      -s \
                      --user <имя пользователя БД> \
                      --password <пароль пользователя БД> \
                      -q "<запрос к БД>" \
                      --port 9440 
    ```

## Что дальше

- Изучите [концепции сервиса](./concepts/index.md).
- Узнайте подробнее о [создании кластера](./operations/cluster-create.md) и [подключении к БД](./operations/connect.md).
- Ознакомьтесь с [вопросами и ответами](./qa/general.md).
