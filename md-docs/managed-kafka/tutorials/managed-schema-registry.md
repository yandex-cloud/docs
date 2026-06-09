# Работа с управляемым реестром схем формата данных

Чтобы использовать [{{ mkf-msr }}](../concepts/managed-schema-registry.md#msr) совместно с {{ mkf-name }}:

1. [Создайте скрипты производителя и потребителя на локальной машине](#create-scripts).
1. [Проверьте правильность работы {{ mkf-msr }}](#check-schema-registry).
1. [Удалите созданные ресурсы](#clear-out).

В этом руководстве описана регистрация одной схемы данных. Подробнее о том, как зарегистрировать несколько схем данных, см. в документации [Confluent Schema Registry](https://docs.confluent.io/platform/current/control-center/topics/schema.html).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* плата за вычислительные ресурсы кластера {{ mkf-name }} и объем хранилища (см. [тарифы {{ mkf-name }}](../pricing.md));
* плата за вычислительные ресурсы и диски [ВМ](../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование [публичного IP-адреса](../../vpc/concepts/ips.md) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

1. [Создайте кластер {{ mkf-name }}](../operations/cluster-create.md) любой подходящей конфигурации. При создании кластера включите опции **{{ ui-key.yacloud.kafka.field_schema-registry }}** и **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.

    {% note info %}
    
    Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин {{ yandex-cloud }}, расположенных в той же облачной сети, что и кластер.
    
    {% endnote %}

    1. [Создайте топик](../operations/cluster-topics.md#create-topic) с именем `messages` для обмена сообщениями между производителем и потребителем.
    1. [Создайте пользователя](../operations/cluster-accounts.md#create-account) с именем `user` и [выдайте ему права](../operations/cluster-accounts.md#grant-permission) на топик `messages`:
        * `ACCESS_ROLE_CONSUMER`,
        * `ACCESS_ROLE_PRODUCER`.

1. В той же сети, что и кластер {{ mkf-name }}, [создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) с [Ubuntu 20.04](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts) и публичным IP-адресом.


1. Если вы используете группы безопасности, [настройте их](../operations/connect/index.md#configuring-security-groups) так, чтобы был разрешен весь необходимый трафик между кластером {{ mkf-name }} и виртуальной машиной.


## Создайте скрипты производителя и потребителя {#create-scripts}

Приведенные скрипты отправляют и принимают сообщения в топике `messages` в виде пары `ключ:значение`. В качестве примера схемы форматов данных описаны в формате [Avro](https://avro.apache.org/).

{% note info %}

Скрипты на Python приведены в демонстрационных целях. Вы можете подготовить и передать схемы форматов данных и сами данные, создав аналогичный скрипт на другом языке программирования.

{% endnote %}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к виртуальной машине по [SSH](../../glossary/ssh-keygen.md).

1. Установите необходимые пакеты Python:

    ```bash
    sudo apt-get update && \
    sudo pip3 install avro confluent_kafka
    ```

1. Чтобы использовать шифрованное соединение, установите SSL-сертификат:

    ```bash
    sudo mkdir -p /usr/share/ca-certificates && \
    sudo wget "{{ crt-web-path }}" \
              -O /usr/share/ca-certificates/{{ crt-local-file }} && \
    sudo chmod 655 /usr/share/ca-certificates/{{ crt-local-file }}
    ```

1. Создайте Python-скрипт потребителя.

    Алгоритм работы скрипта:
    
    1. Подключиться к топику `messages` и реестру схем Confluent Schema Registry.
    1. В непрерывном цикле считывать поступающие в топик `messages` сообщения.
    1. При получении сообщения запросить в реестре схем Confluent Schema Registry нужные схемы для разбора сообщения.
    1. Разобрать бинарные данные из сообщения в соответствии со схемами для ключа и значения и вывести результат на экран.

    `consumer.py`

    ```python
    #!/usr/bin/python3

    from confluent_kafka.avro import AvroConsumer
    from confluent_kafka.avro.serializer import SerializerError


    c = AvroConsumer(
        {
            "bootstrap.servers": ','.join([
            "<FQDN_хоста-брокера_1>:9091",
            ...
            "<FQDN_хоста-брокера_N>:9091",
            ]),
            "group.id": "avro-consumer",
            "security.protocol": "SASL_SSL",
            "ssl.ca.location": "/usr/share/ca-certificates/{{ crt-local-file }}",
            "sasl.mechanism": "SCRAM-SHA-512",
            "sasl.username": "user",
            "sasl.password": "<пароль_пользователя_user>",
            "schema.registry.url": "https://<FQDN_или_IP-адрес_сервера_Managed_Schema_Registry>:443",
            "schema.registry.basic.auth.credentials.source": "SASL_INHERIT",
            "schema.registry.ssl.ca.location": "/usr/share/ca-certificates/{{ crt-local-file }}",
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

    Алгоритм работы скрипта:
    
    1. Подключиться к реестру схем и передать ему схемы форматов данных для ключа и значения.
    1. Сформировать на основе переданных схем ключ и значение.
    1. Отправить в топик `messages` сообщение, состоящее из пары `ключ:значение`. Номера версий схем будут добавлены в сообщение автоматически.

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
                "<FQDN_хоста-брокера_1>:9091",
                ...
                "<FQDN_хоста-брокера_N>:9091",
            ]),
            "security.protocol": 'SASL_SSL',
            "ssl.ca.location": '/usr/share/ca-certificates/{{ crt-local-file }}',
            "sasl.mechanism": 'SCRAM-SHA-512',
            "sasl.username": 'user',
            "sasl.password": '<пароль_пользователя_user>',
            "on_delivery": delivery_report,
            "schema.registry.basic.auth.credentials.source": 'SASL_INHERIT',
            "schema.registry.url": 'https://<FQDN_или_IP-адрес_сервера_Managed_Schema_Registry>:443',
            "schema.registry.ssl.ca.location": "/usr/share/ca-certificates/{{ crt-local-file }}"
        },
        default_key_schema=key_schema,
        default_value_schema=value_schema
    )

    avroProducer.produce(topic="messages", key=key, value=value)
    avroProducer.flush()
    ```

## Проверьте правильность работы {{ mkf-msr }} {#check-schema-registry}

1. Запустите потребитель:

    ```bash
    python3 ./consumer.py
    ```

1. В отдельном терминале запустите производитель:

    ```bash
    python3 ./producer.py
    ```

1. Убедитесь, что данные, отправленные производителем, получены и правильно интерпретированы потребителем:

    ```text
    {'name': 'Value'}
    ```

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

* [Удалите кластер {{ mkf-name }}](../operations/cluster-delete.md).
* [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
* Если вы зарезервировали публичные статические IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md)