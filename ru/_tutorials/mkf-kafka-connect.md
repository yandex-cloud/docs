
{% note info %}

{{ mkf-name }} имеет встроенную поддержку некоторых коннекторов и позволяет управлять ими. Список доступных коннекторов приведен в разделе [{#T}](../managed-kafka/concepts/connectors.md). Если вам нужны другие коннекторы, или вы хотите управлять работой Kafka Connect вручную, используйте информацию из этого руководства.

{% endnote %}

Инструмент {{ KFC }} предназначен для перемещения данных между {{ KF }} и другими хранилищами данных.

Работа с данными в {{ KFC }} осуществляется с помощью _процессов-исполнителей_ (workers). Инструмент может быть развернут как в виде распределенной системы (distributed mode) с несколькими процессами-исполнителями, так и в виде отдельной инсталляции из одного процесса-исполнителя (standalone mode).

Непосредственно перемещение данных выполняется с помощью _коннекторов_, которые запускаются в отдельных потоках процесса-исполнителя.

Подробнее о Kafka Connect см. в документации [{{ KF }}](https://kafka.apache.org/documentation/#connect).

Далее будет продемонстрировано, как настроить {{ KFC }} для взаимодействия с кластером {{ mkf-name }}. Инструмент будет развернут на [виртуальной машине {{ yandex-cloud }}](../compute/concepts/vm.md) в виде отдельной инсталляции. Для защиты подключения будет использоваться SSL-шифрование.


Также будет настроен простой коннектор [FileStreamSource](https://docs.confluent.io/home/connect/filestream_connector.html), с помощью которого {{ KFC }} прочитает данные из тестового JSON-файла и передаст их в топик кластера.

{% note info %}

Вы можете использовать любой другой коннектор {{ KFC }} для взаимодействия с кластером {{ mkf-name }}.

{% endnote %}

Чтобы настроить {{ KFC }} для работы с кластером {{ mkf-name }}:

1. [Настройте виртуальную машину](#prepare-vm).
1. [Подготовьте тестовые данные](#prepare-test-data).
1. [Настройте {{ KFC }}](#configure-kafka-connect).
1. [Запустите {{ KFC }} и проверьте его работу](#test-kafka-connect).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% list tabs %}

- Вручную
    1. [Создайте кластер {{ mkf-name }}](../managed-kafka/operations/cluster-create.md) любой подходящей конфигурации.
    1. [Создайте топик](../managed-kafka/operations/cluster-topics.md#create-topic) с именем `messages` для обмена сообщениями между {{ KFC }} и кластером {{ mkf-name }}.
    1. [Создайте пользователя](../managed-kafka/operations/cluster-accounts.md#create-account) с именем `user` и [выдайте ему права](../managed-kafka/operations/cluster-accounts.md#grant-permission) на топик `messages`:

        * `ACCESS_ROLE_CONSUMER`,
        * `ACCESS_ROLE_PRODUCER`.

        
    1. В той же сети, что и кластер {{ mkf-name }}, [создайте виртуальную машину](../compute/operations/vm-create/create-linux-vm.md) с [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts) и публичным IP-адресом.


- С помощью Terraform

    1. Если у вас еще нет {{ TF }}, [установите его](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
    1. Скачайте в ту же рабочую директорию файл конфигурации [kafka-connect.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/kafka-connect.tf).

        В этом файле описаны:

        * сеть;
        * подсеть;
                * группа безопасности по умолчанию и правила, необходимые для подключения к кластеру и виртуальной машине из интернета;
        * виртуальная машина с [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts);
        * кластер {{ mkf-name }} с необходимыми настройками.

    1. Укажите в файле пароль для пользователя `user`, который будет использоваться для доступа к кластеру {{ mkf-name }}, а также имя пользователя и публичную часть [SSH-ключа](../glossary/ssh-keygen.md) для виртуальной машины. Если на виртуальную машину будет установлена Ubuntu 20.04 из рекомендованного [списка образов](../compute/operations/images-with-pre-installed-software/get-list.md), то указанное здесь имя пользователя игнорируется. В таком случае при [подключении](#prepare-vm) используйте имя пользователя `ubuntu`.
    1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдеров, указанных в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

       ```bash
       terraform validate
       ```

       Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
    1. Создайте необходимую инфраструктуру:

       {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

       {% include [explore-resources](../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Настройте виртуальную машину {#prepare-vm}


1. [Подключитесь к виртуальной машине по SSH](../compute/operations/vm-connect/ssh.md).


1. Установите JDK и утилиту [kcat](https://docs.confluent.io/platform/current/app-development/kafkacat-usage.html):

    ```bash
    sudo apt update && \
    sudo apt install default-jdk --yes && \
    sudo apt install kafkacat
    ```

1. [Скачайте](https://downloads.apache.org/kafka/) и распакуйте архив с {{ KF }}:

    ```bash
    wget https://downloads.apache.org/kafka/3.1.0/kafka_2.12-3.1.0.tgz && tar -xvf kafka_2.12-3.1.0.tgz --strip 1 --directory /opt/kafka/
    ```

    В данном примере используется {{ KF }} версии `3.1.0`.

1. [Получите SSL-сертификат](../managed-kafka/operations/connect#get-ssl-cert).

1. {% include [keytool-importcert](../_includes/mdb/keytool-importcert.md) %}

1. Создайте каталог с настройками процесса-исполнителя и скопируйте туда хранилище:

    ```bash
    sudo mkdir --parents /etc/kafka-connect-worker && \
    sudo cp ssl /etc/kafka-connect-worker/client.truststore.jks
    ```

## Подготовьте тестовые данные {#prepare-test-data}

Создайте файл `/var/log/sample.json` с тестовыми данными. В этом файле приведены данные от сенсоров нескольких автомобилей в формате JSON:

{% cut "sample.json" %}

```json
{"device_id":"iv9a94th6rztooxh5ur2","datetime":"2020-06-05 17:27:00","latitude":55.70329032,"longitude":37.65472196,"altitude":427.5,"speed":0,"battery_voltage":23.5,"cabin_temperature":17,"fuel_level":null}
{"device_id":"rhibbh3y08qmz3sdbrbu","datetime":"2020-06-06 09:49:54","latitude":55.71294467,"longitude":37.66542005,"altitude":429.13,"speed":55.5,"battery_voltage":null,"cabin_temperature":18,"fuel_level":32}
{"device_id":"iv9a94th6rztooxh5ur2","datetime":"2020-06-07 15:00:10","latitude":55.70985913,"longitude":37.62141918,"altitude":417,"speed":15.7,"battery_voltage":10.3,"cabin_temperature":17,"fuel_level":null}
```

{% endcut %}

## Настройте {{ KFC }} {#configure-kafka-connect}

1. Создайте файл настроек процесса-исполнителя `/etc/kafka-connect-worker/worker.properties`:

    ```ini
    # AdminAPI connect properties
    bootstrap.servers=<FQDN хоста-брокера>:9091
    sasl.mechanism=SCRAM-SHA-512
    security.protocol=SASL_SSL
    ssl.truststore.location=/etc/kafka-connect-worker/client.truststore.jks
    ssl.truststore.password=<пароль к хранилищу сертификата>
    sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="user" password="<пароль пользователя user>";

    # Producer connect properties
    producer.sasl.mechanism=SCRAM-SHA-512
    producer.security.protocol=SASL_SSL
    producer.ssl.truststore.location=/etc/kafka-connect-worker/client.truststore.jks
    producer.ssl.truststore.password=<пароль к хранилищу сертификата>
    producer.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="user" password="<пароль пользователя user>";

    # Worker properties
    plugin.path=/etc/kafka-connect-worker/plugins
    key.converter=org.apache.kafka.connect.json.JsonConverter
    value.converter=org.apache.kafka.connect.json.JsonConverter
    key.converter.schemas.enable=true
    value.converter.schemas.enable=true
    offset.storage.file.filename=/etc/kafka-connect-worker/worker.offset
    ```

    {{ KFC }} будет подключаться к кластеру {{ mkf-name }} от имени пользователя `user`, [созданного ранее](#before-you-begin).

    FQDN хостов-брокеров можно запросить со [списком хостов в кластере](../managed-kafka/operations/cluster-hosts.md#list-hosts).

1. Создайте файл настроек коннектора `/etc/kafka-connect-worker/file-connector.properties`:

    ```ini
    name=local-file-source
    connector.class=FileStreamSource
    tasks.max=1
    file=/var/log/sample.json
    topic=messages
    ```

    Где:

    * `file` — имя файла, из которого коннектор будет читать данные.
    * `topic` — имя топика в кластере {{ mkf-name }}, куда коннектор будет передавать данные.

## Запустите {{ KFC }} и проверьте его работу {#test-kafka-connect}

1. Чтобы отправить тестовые данные в кластер, запустите процесс-исполнитель на виртуальной машине:

    ```bash
    cd ~/opt/kafka/bin/ && \
    sudo ./connect-standalone.sh \
         /etc/kafka-connect-worker/worker.properties \
         /etc/kafka-connect-worker/file-connector.properties
    ```

1. Подключитесь к кластеру [с помощью kcat](../managed-kafka/operations/connect.md#bash) и получите данные из топика кластера:

    ```bash
    kafkacat -C \
        -b <FQDN хоста-брокера>:9091 \
        -t messages \
        -X security.protocol=SASL_SSL \
        -X sasl.mechanisms=SCRAM-SHA-512 \
        -X sasl.username=user \
        -X sasl.password="<пароль учетной записи user>" \
        -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z -K:
    ```

    FQDN хостов-брокеров можно запросить со [списком хостов в кластере](../managed-kafka/operations/cluster-hosts.md#list-hosts).

    В выводе команды вы увидите содержимое тестового файла `/var/log/sample.json`, переданное на предыдущем шаге.

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

{% list tabs %}

- Вручную

    
    1. [Удалите виртуальную машину](../compute/operations/vm-control/vm-delete.md).
    1. Если вы зарезервировали для виртуальной машины публичный статический IP-адрес, [удалите его](../vpc/operations/address-delete.md).
    1. [Удалите кластер {{ mkf-name }}](../managed-kafka/operations/cluster-delete.md).


- С помощью Terraform

    Чтобы удалить инфраструктуру, [созданную с помощью {{ TF }}](#before-you-begin):

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `kafka-connect.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле, будут удалены.

{% endlist %}
