# Миграция с помощью MirrorMaker 2.0

{% note info %}

В этом руководстве описана миграция с помощью самостоятельной инсталляции утилиты Mirrormaker 2.0. О работе со встроенным в {{ mkf-name }} MirrorMaker-коннектором читайте в разделе [{#T}](../operations/cluster-connector.md).

{% endnote %}

MirrorMaker 2.0 — утилита для репликации [топиков](../concepts/topics.md) между кластерами {{ KF }}. Подробнее см. [в документации {{ KF }}](https://kafka.apache.org/documentation/#georeplication).

Утилиту можно использовать для непрерывной миграции данных в кластер {{ mkf-name }} с включенным [управлением топиками через Admin API {{ KF }}](../concepts/topics.md#management).

Чтобы мигрировать данные из _кластера-источника_ {{ KF }} в _кластер-приемник_ {{ mkf-name }}:
1. [Настройте конфигурацию MirrorMaker](#configure-mirrormaker).
1. [Запустите репликацию](#replication-start).
1. [Проверьте наличие данных в топике {{ KF }} кластера-приемника](#check-data-mkf).

## Перед началом работы {#before-you-begin}

1. [Создайте кластер-приемник {{ mkf-name }}](../../managed-kafka/operations/cluster-create.md):
    
    * С включенным [управлением топиками](../concepts/topics#management) через Admin API.
    * С учетной записью [администратора](../operations/cluster-accounts.md#create-account).
    * С включенной настройкой [Auto create topics enable](../concepts/settings-list.md#settings-auto-create-topics).

1. Создайте в кластере-источнике пользователя с правом управления топиками через Admin API.

1. Подготовьте ВМ с MirrorMaker:

    1. [Создайте новую ВМ Linux](../../compute/operations/vm-create/create-linux-vm.md) в той же сети, к которой подключен кластер-приемник.
    1. Установите JDK:
        ```bash
        sudo apt update && sudo apt install -y default-jdk
        ```
    1. [Скачайте](https://kafka.apache.org/downloads) и распакуйте архив {{ KF }} той же версии, которая установлена на кластере-приемнике.

1. Настройте межсетевой экран (firewall) и [группы безопасности](../operations/connect.md#configuring-security-groups), если это требуется для подключения MirrorMaker к кластеру-приемнику и кластеру-источнику.

1. Убедитесь, что ВМ с MirrorMaker может подключаться к кластеру-источнику и к кластеру-приемнику с помощью утилиты [kafkacat](../operations/connect.md#bash).

## Настройте конфигурацию MirrorMaker {#configure-mirrormaker}

1. [Подключитесь к ВМ с MirrorMaker по SSH](../../compute/operations/vm-connect/ssh.md).
1. Скачайте [SSL-сертификат](../operations/connect#get-ssl-cert) для подключения кластеру {{ mkf-name }}.
1. Выберите пароль для хранилища сертификатов, создайте хранилище и добавьте в него SSL-сертификат для подключения к кластеру:

   ```bash
   keytool --noprompt -importcert -alias YandexCA \
      -file /usr/local/share/ca-certificates/Yandex/YandexCA.crt \
      -keystore <путь к файлу Java Key Store> \
      -storepass <пароль хранилища сертификатов, не короче 6 символов>
   ```

1. Создайте файл конфигурации MirrorMaker `mm2.properties`:
   
   {% cut "mm2.properties" %}
   ```
   # Kafka clusters
   clusters=cloud, source
   source.bootstrap.servers=<FQDN брокера кластера-источника>:9092
   cloud.bootstrap.servers=<FQDN брокера 1 кластера-приемника>:9091, ..., <FQDN брокера N кластера-приемника>:9091
   
   # Source and target cluster settings
   source->cloud.enabled=true
   cloud->source.enabled=false
   replication.policy.separator=
   source.cluster.alias=
   cloud.cluster.alias=cloud
   
   # Internal topics settings
   source.config.storage.replication.factor=<R>
   source.status.storage.replication.factor=<R>
   source.offset.storage.replication.factor=<R>
   source.offsets.topic.replication.factor=<R>
   source.errors.deadletterqueue.topic.replication.factor=<R>
   source.offset-syncs.topic.replication.factor=<R>
   source.heartbeats.topic.replication.factor=<R>
   source.checkpoints.topic.replication.factor=<R>
   source.transaction.state.log.replication.factor=<R>
   cloud.config.storage.replication.factor=<R>
   cloud.status.storage.replication.factor=<R>
   cloud.offset.storage.replication.factor=<R>
   cloud.offsets.topic.replication.factor=<R>
   cloud.errors.deadletterqueue.topic.replication.factor=<R>
   cloud.offset-syncs.topic.replication.factor=<R>
   cloud.heartbeats.topic.replication.factor=<R>
   cloud.checkpoints.topic.replication.factor=<R>
   cloud.transaction.state.log.replication.factor=<R>
   
   # Topics
   topics=.*
   groups=.*
   topics.blacklist=.*[\-\.]internal, .*\replica, __consumer_offsets
   groups.blacklist=console-consumer-.*, connect-.*, __.*
   replication.factor=<M>
   refresh.topics.enable=true
   sync.topic.configs.enabled=true
   refresh.topics.interval.seconds=10
   
   # Tasks
   tasks.max=<T>
   
   # Source cluster authentication parameters. Comment out if no authentication required
   source.client.id=mm2_consumer_test
   source.group.id=mm2_consumer_group
   source.security.protocol=SASL_PLAINTEXT
   source.sasl.mechanism=SCRAM-SHA-512
   source.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="<имя пользователя кластера-источника>" password="<пароль пользователя кластера-источника>";
   
   # Target cluster authentication parameters
   cloud.client.id=mm2_producer_test
   cloud.group.id=mm2_producer_group
   cloud.ssl.enabled.protocols=TLSv1.2,TLSv1.1,TLSv1
   cloud.ssl.truststore.location=<путь к файлу Java Key Store>
   cloud.ssl.truststore.password=<пароль хранилища сертификатов>
   cloud.ssl.protocol=TLS
   cloud.security.protocol=SASL_SSL
   cloud.sasl.mechanism=SCRAM-SHA-512
   cloud.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="<имя пользователя кластера-приемника>" password="<пароль пользователя кластера-приемника>";
   
   # Enable heartbeats and checkpoints
   source->target.emit.heartbeats.enabled=true
   source->target.emit.checkpoints.enabled=true
   ```
   {% endcut %}

   Пояснения к конфигурации MirrorMaker:

   * Выполняется односторонняя репликация (параметры `source->cloud.enabled = true`, `cloud->source.enabled = false`).
   * Реплицируются все топики. В параметре `topics` можно указать регулярное выражение для выбора топиков.
   * Названия топиков в кластере-приемнике совпадают с их названиями в кластере-источнике.
   * Параметр `<R>` — [фактор репликации служебных топиков](../concepts/settings-list.md#settings-topic-replication-factor) MirrorMaker. Значение этого параметра не должно превышать меньшего между количеством брокеров в кластере-источнике и количеством брокеров в кластере-приемнике.
   * Параметр `<M>` — [фактор репликации по умолчанию](../concepts/settings-list.md#settings-topic-replication-factor), установленный для топиков в кластере-приемнике.
   * Параметр `<T>` — количество одновременно работающих процессов MirrorMaker. Рекомендуется указывать не менее `2` для равномерного распределения нагрузки репликации. Подробнее см. [в документации {{ KF }}](https://kafka.apache.org/documentation/#georeplication-config-syntax).

   FQDN брокеров {{ mkf-name }} можно запросить со [списком хостов в кластере](../operations/cluster-hosts.md#list-hosts).

## Запустите репликацию {#replication-start}

Запустите MirrorMaker на ВМ командой:

```bash
<путь установки Kafka>/bin/connect-mirror-maker.sh <путь к файлу конфигурации mm2.properties>
```

## Проверьте наличие данных в топике кластера-приемника {#check-data-mkf}

1. Подключитесь к топику кластера-приемника с помощью [kafkacat](../operations/connect.md#bash).

1. Убедитесь, что в консоли отображаются сообщения из топика кластера-источника.

Подробнее о работе с сервисом MirrorMaker 2.0 см. [в документации {{ KF }}](https://cwiki.apache.org/confluence/display/KAFKA/KIP-382%3A+MirrorMaker+2.0).
