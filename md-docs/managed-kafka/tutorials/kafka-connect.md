# Настройка Kafka Connect для работы с кластером Managed Service for Apache Kafka®


{% note info %}

Managed Service for Apache Kafka® имеет встроенную поддержку некоторых коннекторов и позволяет управлять ими. Список доступных коннекторов приведен в разделе [Коннекторы](../concepts/connectors.md). Если вам нужны другие коннекторы, или вы хотите управлять работой Kafka Connect вручную, используйте информацию из этого руководства.

{% endnote %}

Инструмент Kafka Connect предназначен для перемещения данных между Apache Kafka® и другими хранилищами данных.

Работа с данными в Kafka Connect осуществляется с помощью _процессов-исполнителей_ (workers). Инструмент может быть развернут как в виде распределенной системы (distributed mode) с несколькими процессами-исполнителями, так и в виде отдельной инсталляции из одного процесса-исполнителя (standalone mode).

Непосредственно перемещение данных выполняется с помощью _коннекторов_, которые запускаются в отдельных потоках процесса-исполнителя.

Подробнее о Kafka Connect смотрите в документации [Apache Kafka®](https://kafka.apache.org/42/kafka-connect/overview/).

Далее будет продемонстрировано, как настроить Kafka Connect для взаимодействия с кластером Managed Service for Apache Kafka®. Инструмент будет развернут на [виртуальной машине Yandex Cloud](../../compute/concepts/vm.md) в виде отдельной инсталляции. Для защиты подключения будет использоваться SSL-шифрование.


Также будет настроен простой коннектор [FileStreamSource](https://docs.confluent.io/home/connect/filestream_connector.html), с помощью которого Kafka Connect прочитает данные из тестового JSON-файла и передаст их в топик кластера.

{% note info %}

Вы можете использовать любой другой коннектор Kafka Connect для взаимодействия с кластером Managed Service for Apache Kafka®.

{% endnote %}

Чтобы настроить Kafka Connect для работы с кластером Managed Service for Apache Kafka®:

1. [Настройте виртуальную машину](#prepare-vm).
1. [Подготовьте тестовые данные](#prepare-test-data).
1. [Настройте Kafka Connect](#configure-kafka-connect).
1. [Запустите Kafka Connect и проверьте его работу](#test-kafka-connect).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for Apache Kafka®: использование вычислительных ресурсов, выделенных хостам (в том числе хостам ZooKeeper), и дискового пространства ([тарифы Apache Kafka®](../../managed-kafka/pricing.md)).
* Плата за использование публичных IP-адресов, если для хостов кластера включен публичный доступ ([тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Плата за ВМ: использование вычислительных ресурсов, хранилища и публичного IP-адреса ([тарифы Compute Cloud](../../compute/pricing.md)).


## Перед началом работы {#before-you-begin}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер Managed Service for Apache Kafka®](../operations/cluster-create.md) любой подходящей конфигурации.
    1. [Создайте топик](../operations/cluster-topics.md#create-topic) с именем `messages` для обмена сообщениями между Kafka Connect и кластером Managed Service for Apache Kafka®.
    1. [Создайте пользователя](../operations/cluster-accounts.md#create-account) с именем `user` и [выдайте ему права](../operations/cluster-accounts.md#grant-permission) на топик `messages`:

        * `ACCESS_ROLE_CONSUMER`,
        * `ACCESS_ROLE_PRODUCER`.

        
    1. В той же сети, что и кластер Managed Service for Apache Kafka®, [создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) с [Ubuntu 20.04](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts) и публичным IP-адресом.
    1. Если вы используете группы безопасности, [настройте их](../operations/connect/index.md#configure-security-groups) так, чтобы был разрешен весь необходимый трафик между кластером Managed Service for Apache Kafka® и виртуальной машиной.


- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [kafka-connect.tf](https://github.com/yandex-cloud-examples/yc-kafka-connect/blob/main/kafka-connect.tf).

        В этом файле описаны:

        * сеть;
        * подсеть;

        
        * группа безопасности по умолчанию и правила, необходимые для подключения к кластеру и виртуальной машине из интернета;


        * виртуальная машина с [Ubuntu 20.04](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts);
        * кластер Managed Service for Apache Kafka® с необходимыми настройками.

    1. Укажите в файле пароль для пользователя `user`, который будет использоваться для доступа к кластеру Managed Service for Apache Kafka®, а также имя пользователя и публичную часть [SSH-ключа](../../glossary/ssh-keygen.md) для виртуальной машины. Если на виртуальную машину будет установлена Ubuntu 20.04 из рекомендованного [списка образов](../../compute/operations/images-with-pre-installed-software/get-list.md), то указанное здесь имя пользователя игнорируется. В таком случае при [подключении](#prepare-vm) используйте имя пользователя `ubuntu`.
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

## Настройте виртуальную машину {#prepare-vm}


1. [Подключитесь к виртуальной машине по SSH](../../compute/operations/vm-connect/ssh.md).


1. Установите JDK и утилиту [kcat](https://docs.confluent.io/platform/current/app-development/kafkacat-usage.html):

    ```bash
    sudo apt update && \
    sudo apt install default-jdk --yes && \
    sudo apt install kafkacat
    ```
    
    Убедитесь, что можете с ее помощью [подключиться к кластеру-источнику Managed Service for Apache Kafka® через SSL](../operations/connect/clients.md#bash-zsh).

1. [Скачайте](https://downloads.apache.org/kafka/) и распакуйте архив с Apache Kafka®:

    ```bash
    wget https://downloads.apache.org/kafka/3.1.0/kafka_2.12-3.1.0.tgz && tar -xvf kafka_2.12-3.1.0.tgz --strip 1 --directory /opt/kafka/
    ```

    В данном примере используется Apache Kafka® версии `3.1.0`.

1. [Получите SSL-сертификат](../operations/connect/index.md#get-ssl-cert).

1. Добавьте SSL-сертификат в хранилище доверенных сертификатов Java (Java Key Store), чтобы драйвер Apache Kafka® мог использовать этот сертификат при защищенном подключении к хостам кластера. Задайте пароль не короче 6 символов в параметре `-storepass` для дополнительной защиты хранилища:
   
   ```bash
   sudo keytool -importcert \
                -alias YandexCA -file /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt \
                -keystore ssl -storepass <пароль_хранилища_сертификатов> \
                --noprompt
   ```

1. Создайте каталог с настройками процесса-исполнителя и скопируйте туда хранилище:

    ```bash
    sudo mkdir --parents /etc/kafka-connect-worker && \
    sudo cp ssl /etc/kafka-connect-worker/client.truststore.jks
    ```

## Подготовьте тестовые данные {#prepare-test-data}

Создайте файл `/var/log/sample.json` с тестовыми данными. В этом файле приведены данные от сенсоров нескольких автомобилей в формате JSON:

{% cut "sample.json" %}

```json
{"device_id":"iv9a94th6rzt********","datetime":"2020-06-05 17:27:00","latitude":55.70329032,"longitude":37.65472196,"altitude":427.5,"speed":0,"battery_voltage":23.5,"cabin_temperature":17,"fuel_level":null}
{"device_id":"rhibbh3y08qm********","datetime":"2020-06-06 09:49:54","latitude":55.71294467,"longitude":37.66542005,"altitude":429.13,"speed":55.5,"battery_voltage":null,"cabin_temperature":18,"fuel_level":32}
{"device_id":"iv9a94th6rzt********","datetime":"2020-06-07 15:00:10","latitude":55.70985913,"longitude":37.62141918,"altitude":417,"speed":15.7,"battery_voltage":10.3,"cabin_temperature":17,"fuel_level":null}
```

{% endcut %}

## Настройте Kafka Connect {#configure-kafka-connect}

1. Создайте файл настроек процесса-исполнителя `/etc/kafka-connect-worker/worker.properties`:

    ```ini
    # AdminAPI connect properties
    bootstrap.servers=<FQDN_хоста-брокера>:9091
    sasl.mechanism=SCRAM-SHA-512
    security.protocol=SASL_SSL
    ssl.truststore.location=/etc/kafka-connect-worker/client.truststore.jks
    ssl.truststore.password=<пароль_к_хранилищу_сертификата>
    sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="user" password="<пароль_пользователя_user>";

    # Producer connect properties
    producer.sasl.mechanism=SCRAM-SHA-512
    producer.security.protocol=SASL_SSL
    producer.ssl.truststore.location=/etc/kafka-connect-worker/client.truststore.jks
    producer.ssl.truststore.password=<пароль_к_хранилищу_сертификата>
    producer.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="user" password="<пароль_пользователя_user>";

    # Worker properties
    plugin.path=/etc/kafka-connect-worker/plugins
    key.converter=org.apache.kafka.connect.json.JsonConverter
    value.converter=org.apache.kafka.connect.json.JsonConverter
    key.converter.schemas.enable=true
    value.converter.schemas.enable=true
    offset.storage.file.filename=/etc/kafka-connect-worker/worker.offset
    ```

    Kafka Connect будет подключаться к кластеру Managed Service for Apache Kafka® от имени пользователя `user`, [созданного ранее](#before-you-begin).

    FQDN хостов-брокеров можно запросить со [списком хостов в кластере](../operations/cluster-hosts.md).

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
    * `topic` — имя топика в кластере Managed Service for Apache Kafka®, куда коннектор будет передавать данные.

## Запустите Kafka Connect и проверьте его работу {#test-kafka-connect}

1. Чтобы отправить тестовые данные в кластер, запустите процесс-исполнитель на виртуальной машине:

    ```bash
    cd ~/opt/kafka/bin/ && \
    sudo ./connect-standalone.sh \
         /etc/kafka-connect-worker/worker.properties \
         /etc/kafka-connect-worker/file-connector.properties
    ```

1. Подключитесь к кластеру [с помощью kcat](../operations/connect/clients.md#bash-zsh) и получите данные из топика кластера:

    ```bash
    kafkacat -C \
        -b <FQDN_хоста-брокера>:9091 \
        -t messages \
        -X security.protocol=SASL_SSL \
        -X sasl.mechanisms=SCRAM-SHA-512 \
        -X sasl.username=user \
        -X sasl.password="<пароль_учетной_записи_user>" \
        -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt -Z -K:
    ```

    FQDN хостов-брокеров можно запросить со [списком хостов в кластере](../operations/cluster-hosts.md).

    В выводе команды вы увидите содержимое тестового файла `/var/log/sample.json`, переданное на предыдущем шаге.

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

{% list tabs group=instructions %}

- Вручную {#manual}

    
    1. [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
    1. Если вы зарезервировали для виртуальной машины публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).
    1. [Удалите кластер Managed Service for Apache Kafka®](../operations/cluster-delete.md).


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