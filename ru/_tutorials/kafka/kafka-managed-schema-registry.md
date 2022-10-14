Чтобы использовать [{{ mkf-msr }}](../../managed-kafka/concepts/managed-schema-registry.md#msr) совместно с {{ mkf-name }}:

1. [Создайте скрипты производителя и потребителя на локальной машине](#create-scripts).
1. [Проверьте правильность работы {{ mkf-msr }}](#check-schema-registry).
1. [Удалите созданные ресурсы](#clear-out).

## Перед началом работы {#before-you-begin}

1. [Создайте кластер {{ mkf-name }}](../../managed-kafka/operations/cluster-create.md) любой подходящей конфигурации. При создании кластера включите опции **Реестр схем данных** и **Публичный доступ**.

    1. [Создайте топик](../../managed-kafka/operations/cluster-topics.md#create-topic) с именем `messages` для обмена сообщениями между производителем и потребителем.
    1. [Создайте пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) с именем `user` и [выдайте ему права](../../managed-kafka/operations/cluster-accounts.md#grant-permission) на топик `messages`:
        * `ACCESS_ROLE_CONSUMER`,
        * `ACCESS_ROLE_PRODUCER`.

1. В той же сети, что и кластер {{ mkf-name }}, {% if audience != "internal" %}[создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md){% else %}создайте виртуальную машину{% endif %} c Ubuntu 20.04 и публичным IP-адресом.

{% if audience != "internal" %}

1. Чтобы разрешить прохождение трафика между кластером {{ mkf-name }} и виртуальной машиной, [настройте группы безопасности](../../managed-kafka/operations/connect.md#configuring-security-groups).

{% endif %}

## Создайте скрипты производителя и потребителя {#create-scripts}

{% include [Schema registry scripts explanation](./schema-registry-scripts-explanation.md) %}

1. {% if audience != "internal" %}[Подключитесь](../../compute/operations/vm-connect/ssh.md){% else %}Подключитесь{% endif %} к виртуальной машине по SSH.

1. Установите необходимые пакеты Python:

    ```bash
    sudo apt-get update && \
    sudo pip3 install avro confluent_kafka
    ```

1. Чтобы использовать шифрованное соединение, установите SSL-сертификат:

    ```bash
    sudo mkdir -p /usr/share/ca-certificates && \
    sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" \
              -O /usr/share/ca-certificates/{{ crt-local-file }} && \
    sudo chmod 655 /usr/share/ca-certificates/{{ crt-local-file }}
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
            "ssl.ca.location": "/usr/share/ca-certificates/{{ crt-local-file }}",
            "sasl.mechanism": "SCRAM-SHA-512",
            "sasl.username": "user",
            "sasl.password": "<пароль пользователя user>",
            "schema.registry.url": "https://<FQDN или IP-адрес сервера {{ mkf-msr }}>:443",
            "schema.registry.basic.auth.credentials.source": "SASL_INHERIT",
            "auto.offset.reset": "earliest"
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
            "security.protocol": 'SASL_SSL',
            "ssl.ca.location": '/usr/share/ca-certificates/{{ crt-local-file }}',
            "sasl.mechanism": 'SCRAM-SHA-512',
            "sasl.username": 'user',
            "sasl.password": '<пароль пользователя user>',
            "on_delivery": delivery_report,
            "schema.registry.basic.auth.credentials.source": 'SASL_INHERIT',
            "schema.registry.url": 'https://<FQDN или IP-адрес сервера {{ mkf-msr }}>:443'
        },
        default_key_schema=key_schema,
        default_value_schema=value_schema
    )

    avroProducer.produce(topic="messages", key=key, value=value)
    avroProducer.flush()
    ```

## Проверьте правильность работы {{ mkf-msr }} {#check-schema-registry}

{% include [Check schema registry](./check-schema-registry.md) %}

## Удалите созданные ресурсы {#clear-out}

{% include [Clear out](./clear-out.md) %}
