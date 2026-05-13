# Получение данных из RabbitMQ в Managed Service for ClickHouse®

# Получение данных из RabbitMQ в Yandex Managed Service for ClickHouse®


В кластер Managed Service for ClickHouse® можно поставлять данные из RabbitMQ в реальном времени. Managed Service for ClickHouse® будет автоматически вставлять в таблицу на [движке RabbitMQ](https://clickhouse.com/docs/ru/engines/table-engines/integrations/rabbitmq/) данные, поступающие на определенные точки обмена указанных очередей RabbitMQ.

Чтобы настроить поставку данных из RabbitMQ в Managed Service for ClickHouse®:

1. [Настройте интеграцию с RabbitMQ для кластера Managed Service for ClickHouse®](#configure-mch-for-rmq).
1. [Создайте в кластере Managed Service for ClickHouse® таблицу на движке RabbitMQ](#create-rmq-table).
1. [Отправьте тестовые данные в очередь RabbitMQ](#send-sample-data-to-rmq).
1. [Проверьте наличие тестовых данных в таблице кластера Managed Service for ClickHouse®](#fetch-sample-data).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for ClickHouse®: использование вычислительных ресурсов, выделенных хостам (в том числе хостам ZooKeeper, и дискового пространства (см. [тарифы Managed Service for ClickHouse®](../pricing.md)).
* Плата за использование публичных IP-адресов, если для хостов кластера включен публичный доступ (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Плата за ВМ: использование вычислительных ресурсов, хранилища и публичного IP-адреса (опционально) (см. [тарифы Compute Cloud](../../compute/pricing.md)).


## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер Managed Service for ClickHouse®](../operations/cluster-create.md) любой подходящей вам конфигурации с базой данных `db1`. Для подключения к кластеру с локальной машины пользователя, а не из облачной сети Yandex Cloud, включите публичный доступ к хостам кластера при его создании.

        {% note info %}
        
        Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин Yandex Cloud, расположенных в той же облачной сети, что и кластер.
        
        {% endnote %}

        Интеграцию с RabbitMQ можно настроить уже на этапе создания кластера. В этой статье интеграция будет настроена [позже](#configure-mch-for-rmq).

    1. [Создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) для RabbitMQ. Для подключения к виртуальной машине с локальной машины пользователя, а не из облачной сети Yandex Cloud, включите публичный доступ при ее создании.

- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [clickhouse-cluster-and-vm-for-rabbitmq.tf](https://github.com/yandex-cloud-examples/yc-clickhouse-fetch-data-from-rabbitmq/blob/main/clickhouse-cluster-and-vm-for-rabbitmq.tf).

        В этом файле описаны:

        * сеть;
        * подсеть;
        * группа безопасности по умолчанию и правила, необходимые для подключения к кластеру и виртуальной машине из интернета;
        * кластер Managed Service for ClickHouse®;
        * виртуальная машина.

    1. Укажите в файле `clickhouse-cluster-and-vm-for-rabbitmq.tf`:

        * Имя пользователя и пароль, которые будут использоваться для доступа к кластеру Managed Service for ClickHouse®.
        * Идентификатор публичного [образа](../../compute/operations/images-with-pre-installed-software/get-list.md) с [Ubuntu](https://yandex.cloud/ru/marketplace?tab=software&search=Ubuntu&categories=os) без [GPU](../../glossary/gpu.md) для виртуальной машины.
        * Логин и путь к файлу [открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys), которые будут использоваться для доступа к виртуальной машине. По умолчанию в используемом образе указанный логин игнорируется, вместо него создается пользователь с логином `ubuntu`. Используйте его для подключения к виртуальной машине.

    1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Создайте необходимую инфраструктуру:

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

        В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

### Выполните дополнительные настройки {#additional-settings}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к виртуальной машине по [SSH](../../glossary/ssh-keygen.md).

    1. Установите RabbitMQ:

        ```bash
        sudo apt update && sudo apt install rabbitmq-server --yes
        ```

    1. Создайте пользователя для RabbitMQ:

        ```bash
        sudo rabbitmqctl add_user <имя_пользователя> <пароль>
        ```

    1. Выдайте этому пользователю права на подключение к серверу:

        ```bash
        sudo rabbitmqctl set_permissions -p / <имя_пользователя> ".*" ".*" ".*" && \
        sudo rabbitmqctl set_topic_permissions -p / <имя_пользователя> amq.topic "cars" "cars"
        ```

1. Установите утилиты `amqp-publish` и `amqp-declare-queue` для работы с RabbitMQ и [jq](https://stedolan.github.io/jq/) для потоковой обработки JSON-файлов:

    ```bash
    sudo apt update && sudo apt install amqp-tools --yes && sudo apt-get install jq --yes
    ```

1. Убедитесь, что можете создать в RabbitMQ очередь `cars` с помощью `amqp-declare-queue`:

    ```bash
    amqp-declare-queue \
        --url=amqp://<имя_пользователя>:<пароль>@<IP-адрес_или_FQDN_сервера_RabbitMQ>:5672 \
        --queue=cars
    ```

1. Установите утилиту `clickhouse-client` для подключения к базе данных в кластере Managed Service for ClickHouse®.

    1. Подключите [DEB-репозиторий](https://clickhouse.com/docs/ru/getting-started/install/#install-from-deb-packages) ClickHouse®:

        ```bash
        sudo apt update && sudo apt install --yes apt-transport-https ca-certificates dirmngr && \
        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4 && \
        echo "deb https://packages.clickhouse.com/deb stable main" | sudo tee \
        /etc/apt/sources.list.d/clickhouse.list
        ```

    1. Установите зависимости:

        ```bash
        sudo apt update && sudo apt install clickhouse-client --yes
        ```

    1. Загрузите файл конфигурации для `clickhouse-client`:

        ```bash
        mkdir -p ~/.clickhouse-client && \
        wget "https://storage.yandexcloud.net/doc-files/clickhouse-client.conf.example" \
          --output-document ~/.clickhouse-client/config.xml
        ```

    Убедитесь, что можете с помощью `clickhouse-client` [подключиться к кластеру Managed Service for ClickHouse® через SSL](../operations/connect/clients.md#clickhouse-client).

## Настройте интеграцию RabbitMQ для кластера Managed Service for ClickHouse® {#configure-mch-for-rmq}

{% list tabs group=instructions %}

- Вручную {#manual}

    Укажите в [настройках кластера Managed Service for ClickHouse®](../operations/change-server-level-settings.md#yandex-cloud-interfaces) имя пользователя и пароль для аутентификации RabbitMQ в секции **Настройки СУБД** → **Rabbitmq**.

- Terraform {#tf}

    Добавьте к описанию кластера блок `clickhouse.config.rabbitmq` с именем пользователя и паролем для аутентификации RabbitMQ:

    ```hcl
    resource "yandex_mdb_clickhouse_cluster" "clickhouse-cluster" {
      ...
      clickhouse {
        ...
        config {
          rabbitmq {
            username = "<имя_пользователя>"
            password = "<пароль>"
          }
        }
        ...
      }
    }
    ```

{% endlist %}

## Создайте в кластере Managed Service for ClickHouse® таблицу на движке RabbitMQ {#create-rmq-table}

Пусть в RabbitMQ в очередь `cars` на точке обмена `exchange` в RabbitMQ будут помещены данные от сенсоров автомобиля в формате JSON:

* строковый идентификатор устройства `device_id`;
* дата и время формирования данных `datetime` в формате `YYYY-MM-DD HH:MM:SS`;
* координаты автомобиля:

    * широта `latitude`;
    * долгота `longitude`;
    * высота над уровнем моря `altitude`;

* текущая скорость `speed`;
* напряжение батарей `battery_voltage` (для электромобиля, для автомобиля с ДВС значение этого параметра — `null`);
* температура в салоне `cabin_temperature`;
* уровень топлива `fuel_level` (для автомобиля с ДВС, для электромобиля значение этого параметра — `null`).

Эти данные будут передаваться в виде сообщений RabbitMQ. Каждое такое сообщение будет содержать JSON-объект как строку следующего вида:

```json
{"device_id":"iv9a94th6rzt********","datetime":"2020-06-05 17:27:00","latitude":"55.70329032","longitude":"37.65472196","altitude":"427.5","speed":"0","battery_voltage":"23.5","cabin_temperature":"17","fuel_level":null}
```

Кластер Managed Service for ClickHouse® будет использовать при вставке в таблицу [формат данных JSONEachRow](https://clickhouse.com/docs/ru/interfaces/formats/#jsoneachrow), который преобразует строки из сообщения RabbitMQ в нужные значения столбцов.

Создайте в кластере Managed Service for ClickHouse® таблицу, в которую будут заноситься поступающие от RabbitMQ данные:

1. [Подключитесь](../operations/connect/clients.md#clickhouse-client) к базе данных `db1` кластера Managed Service for ClickHouse® с помощью `clickhouse-client`.

1. Выполните запрос:

    ```sql
    CREATE TABLE IF NOT EXISTS db1.cars (
        device_id String,
        datetime DateTime,
        latitude Float32,
        longitude Float32,
        altitude Float32,
        speed Float32,
        battery_voltage Nullable(Float32),
        cabin_temperature Float32,
        fuel_level Nullable(Float32)
    ) ENGINE = RabbitMQ
    SETTINGS
        rabbitmq_host_port = '<внутренний_IP-адрес_ВМ_с_RabbitMQ>:5672',
        rabbitmq_routing_key_list = 'cars',
        rabbitmq_exchange_name = 'exchange',
        rabbitmq_format = 'JSONEachRow';
    ```

Эта таблица будет автоматически наполняться сообщениями, считываемыми из очереди `cars` в точке обмена `exchange` RabbitMQ. При чтении данных Managed Service for ClickHouse® использует [указанные ранее данные](#configure-mch-for-rmq) для аутентификации.

## Отправьте тестовые данные в очередь RabbitMQ {#send-sample-data-to-rmq}

1. Создайте файл `sample.json` с тестовыми данными:

    ```json
    {
        "device_id": "iv9a94th6rzt********",
        "datetime": "2020-06-05 17:27:00",
        "latitude": 55.70329032,
        "longitude": 37.65472196,
        "altitude": 427.5,
        "speed": 0,
        "battery_voltage": 23.5,
        "cabin_temperature": 17,
        "fuel_level": null
    }

    {
        "device_id": "rhibbh3y08qm********",
        "datetime": "2020-06-06 09:49:54",
        "latitude": 55.71294467,
        "longitude": 37.66542005,
        "altitude": 429.13,
        "speed": 55.5,
        "battery_voltage": null,
        "cabin_temperature": 18,
        "fuel_level": 32
    }

    {
        "device_id": "iv9a94th6rzt********",
        "datetime": "2020-06-07 15:00:10",
        "latitude": 55.70985913,
        "longitude": 37.62141918,
        "altitude": 417.0,
        "speed": 15.7,
        "battery_voltage": 10.3,
        "cabin_temperature": 17,
        "fuel_level": null
    }
    ```

1. Отправьте в созданную ранее очередь `cars` в точку обмена `exchange` данные из файла `sample.json` с помощью `jq` и `amqp-publish`.

    ```bash
    jq \
    --raw-output \
    --compact-output . ./sample.json |\
    amqp-publish \
    --url=amqp://<имя_пользователя_RabbitMQ>:<пароль>@<IP-адрес_или_FQDN_сервера_RabbitMQ>:5672 \
    --routing-key=cars \
    --exchange=exchange
    ```

## Проверьте наличие тестовых данных в таблице кластера Managed Service for ClickHouse® {#fetch-sample-data}

Для доступа к данным используйте материализованное представление (`MATERIALIZED VIEW`). Когда к таблице на движке `RabbitMQ` присоединяется материализованное представление, оно начинает в фоновом режиме собирать данные. Это позволяет непрерывно получать сообщения от RabbitMQ и преобразовывать их в необходимый формат с помощью `SELECT`.

{% note info %}

Сообщение из очереди может быть прочитано ClickHouse® только один раз, поэтому вместо чтения данных напрямую из таблицы используйте материализованное представление.

{% endnote %}

Чтобы создать материализованное представление для таблицы `db1.cars`:

1. [Подключитесь](../operations/connect/clients.md#clickhouse-client) к базе данных `db1` кластера Managed Service for ClickHouse® с помощью `clickhouse-client`.

1. Выполните запросы:

    ```sql
    CREATE TABLE IF NOT EXISTS db1.cars_data_source (
        device_id String,
        datetime DateTime,
        latitude Float32,
        longitude Float32,
        altitude Float32,
        speed Float32,
        battery_voltage Nullable(Float32),
        cabin_temperature Float32,
        fuel_level Nullable(Float32)
    ) ENGINE MergeTree()
      ORDER BY device_id;

    CREATE MATERIALIZED VIEW db1.cars_view TO db1.cars_data_source
      AS SELECT * FROM db1.cars;
    ```

Чтобы получить все данные из материализованного представления `db1.cars_view`:

1. [Подключитесь](../operations/connect/clients.md#clickhouse-client) к базе данных `db1` кластера Managed Service for ClickHouse® с помощью `clickhouse-client`.

1. Выполните запрос:

    ```sql
    SELECT * FROM db1.cars_view;
    ```

Запрос вернет таблицу с данными, отправленными в RabbitMQ.

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

{% list tabs group=instructions %}

- Вручную {#manual}

    * [Удалите кластер Yandex Managed Service for ClickHouse®](../operations/cluster-delete.md).
    * [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
    * Если вы зарезервировали публичные статические IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md).

- Terraform {#tf}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    
        {% note warning %}
    
        Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
    
        {% endnote %}
    
    1. Удалите ресурсы:
    
        1. Выполните команду:
    
            ```bash
            terraform destroy
            ```
    
        1. Подтвердите удаление ресурсов и дождитесь завершения операции.
    
        Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

{% endlist %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._