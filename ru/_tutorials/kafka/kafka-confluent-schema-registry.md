Чтобы использовать [Confluent Schema Registry](https://docs.confluent.io/platform/current/schema-registry/index.html) совместно с {{ mkf-name }}:

1. [Создайте топик для уведомлений об изменении схем форматов данных](#create-schemas-topic).
1. [Установите и настройте Confluent Schema Registry на виртуальной машине](#configure-vm).
1. [Создайте скрипты производителя и потребителя](#create-scripts).
1. [Проверьте правильность работы Confluent Schema Registry](#check-schema-registry).
1. [Удалите созданные ресурсы](#clear-out).

## Перед началом работы {#before-you-begin}

1. [Создайте кластер {{ mkf-name }}](../../managed-kafka/operations/cluster-create.md) любой подходящей конфигурации.

    1. [Создайте топик](../../managed-kafka/operations/cluster-topics.md#create-topic) с именем `messages` для обмена сообщениями между производителем и потребителем.
    1. [Создайте учетную запись](../../managed-kafka/operations/cluster-accounts.md#create-account) с именем `user` и [выдайте ей права](../../managed-kafka/operations/cluster-accounts.md#grant-permission) на топик `messages`:
        * `ACCESS_ROLE_CONSUMER`,
        * `ACCESS_ROLE_PRODUCER`.

{% if audience != "internal" %}

1. В той же сети, что и кластер {{ mkf-name }}, [создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) c [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) из {{ marketplace-name }} и публичным IP-адресом.

{% else %}

1. В той же сети, что и кластер {{ mkf-name }}, создайте виртуальную машину c [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) из {{ marketplace-name }} и публичным IP-адресом.

{% endif %}

1. Чтобы разрешить прохождение трафика между кластером {{ mkf-name }} и виртуальной машиной, [настройте группы безопасности](../../managed-kafka/operations/connect.md#configuring-security-groups).

{% if audience != "internal" %}

1. В группах безопасности виртуальной машины [создайте правило](../../vpc/operations/security-group-add-rule.md) для входящего трафика, разрешающее подключение через порт `8081` — через него производитель и потребитель будут обращаться к реестру схем:

{% else %}

1. В группах безопасности виртуальной машины создайте правило для входящего трафика, разрешающее подключение через порт `8081` — через него производитель и потребитель будут обращаться к реестру схем:

{% endif %}

    * **Диапазон портов**: `8081`.
    * **Протокол**: `TCP`.
    * **Назначение**: `CIDR`.
    * **CIDR блоки**: `0.0.0.0/0` или диапазоны адресов подсетей, в которых работают производитель и потребитель.

## Создайте топик для уведомлений об изменении схем форматов данных {#create-schemas-topic}

1. [Создайте служебный топик](../../managed-kafka/operations/cluster-topics.md#create-topic) с именем `_schemas` со следующими настройками:

    * **Количество разделов** — `1`.
    * **Политика очистки лога** — `Compact`.

    {% note warning %}

    Указанные значения настроек **Количество разделов** и **Политика очистки лога** необходимы для работы Confluent Schema Registry.

    {% endnote %}

1. [Создайте учетную запись](../../managed-kafka/operations/cluster-accounts.md#create-account) с именем `registry` и [выдайте ей права](../../managed-kafka/operations/cluster-accounts.md#grant-permission) на топик `_schemas`:
    * `ACCESS_ROLE_CONSUMER`,
    * `ACCESS_ROLE_PRODUCER`.

    От имени этой учетной записи Confluent Schema Registry будет работать со служебным топиком `_schemas`.

## Установите и настройте Confluent Schema Registry на виртуальной машине {#configure-vm}
{% if audience != "internal" %}

1. [Подключитесь к виртуальной машине по SSH](../../compute/operations/vm-connect/ssh.md).

{% else %}

1. Подключитесь к виртуальной машине по SSH.

{% endif %}
1. Подключите репозиторий Confluent Schema Registry:

    ```bash
    wget -qO - https://packages.confluent.io/deb/6.2/archive.key | sudo apt-key add - && \
    sudo add-apt-repository "deb [arch=amd64] https://packages.confluent.io/deb/6.2 stable main"
    ```

1. Установите пакеты:

    ```bash
    sudo apt-get update && \
    sudo apt-get install \
         confluent-schema-registry \
         openjdk-11-jre-headless \
         python3-pip --yes
    ```

1. [Получите SSL-сертификат](../../managed-kafka/operations/connect.md#get-ssl-cert).

1. Создайте для сертификата защищенное хранилище:

    ```bash
    sudo keytool \
         -keystore /etc/schema-registry/client.truststore.jks \
         -alias CARoot \
         -import -file {{ crt-local-dir }}{{ crt-local-file }} \
         -storepass <пароль защищенного хранилища сертификатов> \
         --noprompt
    ```

1. Создайте файл `/etc/schema-registry/jaas.conf` с настройками для подключения к кластеру:

    ```scala
    KafkaClient {
      org.apache.kafka.common.security.scram.ScramLoginModule required
      username="registry"
      password="<пароль учетной записи registry>";
    };
    ```

1. Измените файл `/etc/schema-registry/schema-registry.properties`, отвечающий за настройки Confluent Schema Registry:

    1. Закомментируйте строку:

        ```ini
        kafkastore.bootstrap.servers=PLAINTEXT://localhost:9092
        ```

    1. Раскомментируйте строку с параметром `listeners`. Она отвечает за сетевой адрес и порт, которые будет слушать Confluent Schema Registry. По умолчанию используется порт `8081` на всех сетевых интерфейсах:

        ```ini
        listeners=http://0.0.0.0:8081
        ```

    1. Добавьте в конец файла строки:

        ```ini
        kafkastore.bootstrap.servers=SASL_SSL://<FQDN 1-го хоста-брокера:9091>,<FQDN 2-го хоста-брокера:9091>,...,<FQDN N-го хоста-брокера:9091>
        kafkastore.ssl.truststore.location=/etc/schema-registry/client.truststore.jks
        kafkastore.ssl.truststore.password=<пароль защищенного хранилища сертификатов>
        kafkastore.sasl.mechanism=SCRAM-SHA-512
        kafkastore.security.protocol=SASL_SSL
        ```

        Список хостов-брокеров можно получить [со списком хостов кластера](../../managed-kafka/operations/cluster-hosts.md).

1. Измените файл с описанием модуля systemd `/lib/systemd/system/confluent-schema-registry.service`.

    1. Перейдите в блок `[Service]`.
    1. Добавьте параметр `Environment` с настройками Java:

        ```ini
        ...

        [Service]
        Type=simple
        User=cp-schema-registry
        Group=confluent
        Environment="LOG_DIR=/var/log/confluent/schema-registry"
        Environment="_JAVA_OPTIONS='-Djava.security.auth.login.config=/etc/schema-registry/jaas.conf'"
        ...
        ```

1. Обновите сведения о модулях systemd:

    ```bash
    sudo systemctl daemon-reload
    ```

1. Запустите сервис Confluent Schema Registry:

    ```bash
    sudo systemctl start confluent-schema-registry.service
    ```

1. Включите автоматический запуск Confluent Schema Registry после перезагрузки ОС:

    ```bash
    sudo systemctl enable confluent-schema-registry.service
    ```

## Создайте скрипты производителя и потребителя {#create-scripts}

{% include [Schema registry scripts explanation](./schema-registry-scripts-explanation.md) %}

1. Установите необходимые пакеты Python:

    ```bash
    sudo pip3 install avro confluent_kafka
    ```

1. Создайте Python-скрипт потребителя.

    {% include [Consumer script algorithm](./consumer-script-algorithm.md) %}

    `consumer.py`

    ```python
    #!/usr/bin/python3

    from confluent_kafka.avro import AvroConsumer
    from confluent_kafka.avro.serializer import SerializerError


    c = AvroConsumer(
        {
            "bootstrap.servers": ','.join([
                "<FQDN 1-го хоста-брокера>:9091",
                ...
                "<FQDN N-го хоста-брокера>:9091",
            ]),
            "group.id": "avro-consumer",
            "security.protocol": "SASL_SSL",
            "ssl.ca.location": "{{ crt-local-dir }}{{ crt-local-file }}",
            "sasl.mechanism": "SCRAM-SHA-512",
            "sasl.username": "user",
            "sasl.password": "<пароль учетной записи user>",
            "schema.registry.url": "http://<FQDN или IP-адрес сервера Confluent Schema Registry>:8081",
        }
    )

    c.subscribe(["messages"])

    while True:
        try:
            msg = c.poll(10)

        except SerializerError as e:
            print("Message deserialization failed for {}: {}".format(msg, e))
            break

        if msg is None:
            continue

        if msg.error():
            print("AvroConsumer error: {}".format(msg.error()))
            continue

        print(msg.value())

    c.close()
    ```

1. Создайте Python-скрипт производителя.

    {% include [Producer script algorithm](./producer-script-algorithm.md) %}

    `producer.py`

    ```python
    #!/usr/bin/python3

    from confluent_kafka import avro
    from confluent_kafka.avro import AvroProducer


    value_schema_str = """
    {
        "namespace": "my.test",
        "name": "value",
        "type": "record",
        "fields": [
            {
                "name": "name",
                "type": "string"
            }
        ]
    }
    """

    key_schema_str = """
    {
        "namespace": "my.test",
        "name": "key",
        "type": "record",
        "fields": [
            {
                "name": "name",
                "type": "string"
            }
        ]
    }
    """

    value_schema = avro.loads(value_schema_str)
    key_schema = avro.loads(key_schema_str)
    value = {"name": "Value"}
    key = {"name": "Key"}


    def delivery_report(err, msg):
        """Called once for each message produced to indicate delivery result.
        Triggered by poll() or flush()."""
        if err is not None:
            print("Message delivery failed: {}".format(err))
        else:
            print("Message delivered to {} [{}]".format(msg.topic(), msg.partition()))


    avroProducer = AvroProducer(
        {
            "bootstrap.servers": ','.join([
                "<FQDN 1-го хоста-брокера>:9091",
                ...
                "<FQDN N-го хоста-брокера>:9091",
            ]),
            "security.protocol": "SASL_SSL",
            "ssl.ca.location": "{{ crt-local-dir }}{{ crt-local-file }}",
            "sasl.mechanism": "SCRAM-SHA-512",
            "sasl.username": "user",
            "sasl.password": "<пароль учетной записи user>",
            "on_delivery": delivery_report,
            "schema.registry.url": "http://<FQDN или IP-адрес сервера Schema Registry>:8081",
        },
        default_key_schema=key_schema,
        default_value_schema=value_schema,
    )

    avroProducer.produce(topic="messages", key=key, value=value)
    avroProducer.flush()
    ```


## Проверьте правильность работы Confluent Schema Registry {#check-schema-registry}

{% include [Check schema registry](./check-schema-registry.md) %}

## Удалите созданные ресурсы {#clear-out}

{% include [Clear out](./clear-out.md) %}
