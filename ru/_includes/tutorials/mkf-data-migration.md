Перенести топики из _кластера-источника_ {{ KF }} в _кластер-приемник_ {{ mkf-name }} можно двумя способами:

* [С помощью встроенного в {{ mkf-full-name }} MirrorMaker-коннектора](#kf-connnector).

  Этот способ прост в настройке и не требует создания промежуточной виртуальной машины.

* [С помощью утилиты MirrorMaker 2.0](#kf-mirrormaker).

  Для этого потребуется самостоятельная инсталляция и настройка утилиты на промежуточной виртуальной машине. Используйте этот способ только в том случае, если перенос данных с помощью встроенного MirrorMaker-коннектора по каким-либо причинам невозможен.

## Перед началом работы {#before-you-begin}

{% list tabs %}

* Миграция с MirrorMaker-коннектором

  1. Подготовьте кластер-приемник:
      * Включите [управление топиками](../../managed-kafka/concepts/topics.md#management) через Admin API.
      * Создайте учетную запись [администратора](../../managed-kafka/operations/cluster-accounts.md#create-account) с именем `admin-cloud`.
      * Включите настройку [Auto create topics enable](../../managed-kafka/concepts/settings-list.md#settings-auto-create-topics).
      * Настройте [группы безопасности](../../managed-kafka/operations/connect.md#configuring-security-groups), если это требуется для подключения к кластеру-приемнику.

  1. Создайте в кластере-источнике учетную запись `admin-source` с правом управления топиками через Admin API.
  1. Настройте в кластере-источнике межсетевой экран (firewall), если это требуется для подключения извне к кластеру.

* Миграция с утилитой MirrorMaker 2.0

  1. Подготовьте кластер-приемник:
      * Включите [управление топиками](../../managed-kafka/concepts/topics.md#management) через Admin API.
      * Создайте учетную запись [администратора](../../managed-kafka/operations/cluster-accounts.md#create-account) с именем `admin-cloud`.
      * Включите настройку [Auto create topics enable](../../managed-kafka/concepts/settings-list.md#settings-auto-create-topics).
  1. Создайте в кластере-источнике учетную запись `admin-source` с правом управления топиками через Admin API.
  1. Подготовьте ВМ с MirrorMaker:
      1. {% if audience != "internal" %}[Создайте новую ВМ Linux](../../compute/operations/vm-create/create-linux-vm.md){% else %}Создайте новую ВМ Linux{% endif %} в той же сети, к которой подключен кластер-приемник.
      1. Установите JDK:

         ```bash
         sudo apt update && sudo apt install -y default-jdk
         ```

      1. [Скачайте](https://kafka.apache.org/downloads) и распакуйте архив {{ KF }} той же версии, которая установлена на кластере-приемнике.
  1. Настройте межсетевой экран (firewall) и [группы безопасности](../../managed-kafka/operations/connect.md#configuring-security-groups), если это требуется для подключения MirrorMaker к кластеру-приемнику и кластеру-источнику.
  1. Убедитесь с помощью утилиты [kafkacat](../../managed-kafka/operations/connect.md#bash), что ВМ с MirrorMaker может подключаться к кластеру-источнику и к кластеру-приемнику.

{% endlist %}

## Перенос данных с использованием сервиса {{ mkf-full-name }} Connector {#kf-connnector}

1. [Создайте коннектор](#create-connector).
1. [Проверьте наличие данных в топике кластера-приемника](#check-data-mkf-connector).

### Создайте коннектор {#create-connector}

[Создайте для кластера-приемника коннектор](../../managed-kafka/operations/cluster-connector.md#create-connector) с типом `MirrorMaker` и настройками:

* **Топики** — список топиков, которые нужно перенести. Также можно указать регулярное выражение для выбора топиков. Для переноса всех топиков укажите `.*`.
* В блоке **Кластер-источник** укажите параметры для подключения к кластеру-источнику:
  * **Псевдоним** — префикс для обозначения кластера-источника в настройках коннектора. По умолчанию `source`. Топики в кластере-приемнике будут созданы с указанным префиксом.  
  * **Бутстрап-серверы** — список FQDN хостов-брокеров кластера-источника с номерами портов для подключения, разделенный запятыми.
  * **SASL имя пользователя**, **SASL пароль** — имя и пароль созданной ранее учетной записи `admin-source`.
  * **SASL механизм** — механизм шифрования имени и пароля `SCRAM-SHA-512`.
  * **Протокол безопасности** — выберите протокол подключения коннектора:
    * `SASL_PLAINTEXT` — если к кластеру-источнику подключаются без SSL;
    * `SASL_SSL` – если к кластеру-источнику подключаются с SSL.

* В блоке **Кластер-приемник** выберите опцию **Использовать этот кластер**.

После создания коннектор автоматически активируется и начнется перенос данных.
   
### Проверьте наличие данных в топике кластера-приемника {#check-data-mkf-connector}

{% include [check-topics](includes/check-mkf-topic.md) %}

## Перенос данных с использованием утилиты MirrorMaker {#kf-mirrormaker}

1. [Настройте конфигурацию MirrorMaker](#configure-mirrormaker).
1. [Запустите репликацию](#replication-start).
1. [Проверьте наличие данных в топике кластера-приемника](#check-data-mkf).

### Настройте конфигурацию MirrorMaker {#configure-mirrormaker}

1. {% if audience != "internal" %}[Подключитесь к ВМ с MirrorMaker по SSH](../../compute/operations/vm-connect/ssh.md){% else %}Подключитесь к ВМ с MirrorMaker по SSH{% endif %}.
1. Скачайте [SSL-сертификат](../../managed-kafka/operations/connect#get-ssl-cert) для подключения к кластеру {{ mkf-name }}.
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
   source.cluster.alias=source
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
   source.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="admin-source" password="<пароль>";

   # Target cluster authentication parameters
   cloud.client.id=mm2_producer_test
   cloud.group.id=mm2_producer_group
   cloud.ssl.enabled.protocols=TLSv1.2,TLSv1.1,TLSv1
   cloud.ssl.truststore.location=<путь к файлу Java Key Store>
   cloud.ssl.truststore.password=<пароль хранилища сертификатов>
   cloud.ssl.protocol=TLS
   cloud.security.protocol=SASL_SSL
   cloud.sasl.mechanism=SCRAM-SHA-512
   cloud.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="admin-cloud" password="<пароль>";

   # Enable heartbeats and checkpoints
   source->target.emit.heartbeats.enabled=true
   source->target.emit.checkpoints.enabled=true
   ```
   {% endcut %}

   Пояснения к конфигурации MirrorMaker:

   * Выполняется односторонняя репликация (параметры `source->cloud.enabled = true`, `cloud->source.enabled = false`).
   * В параметре `topics` указывается список топиков, которые нужно перенести. Также можно указать регулярное выражение для выбора топиков. Для переноса всех топиков укажите `.*`. В данной конфигурации реплицируются все топики.
   * Названия топиков в кластере-приемнике совпадают с их названиями в кластере-источнике.
   * Параметр `<R>` — [фактор репликации служебных топиков](../../managed-kafka/concepts/settings-list.md#settings-topic-replication-factor) MirrorMaker. Значение этого параметра не должно превышать меньшего между количеством брокеров в кластере-источнике и количеством брокеров в кластере-приемнике.
   * Параметр `<M>` — [фактор репликации по умолчанию](../../managed-kafka/concepts/settings-list.md#settings-topic-replication-factor), установленный для топиков в кластере-приемнике.
   * Параметр `<T>` — количество одновременно работающих процессов MirrorMaker. Рекомендуется указывать не менее `2` для равномерного распределения нагрузки репликации. Подробнее см. [в документации {{ KF }}](https://kafka.apache.org/documentation/#georeplication-config-syntax).

   FQDN брокеров {{ mkf-name }} можно запросить со [списком хостов в кластере](../../managed-kafka/operations/cluster-hosts.md#list-hosts).

### Запустите репликацию {#replication-start}

Запустите MirrorMaker на ВМ командой:

```bash
<путь установки Kafka>/bin/connect-mirror-maker.sh <путь к файлу конфигурации mm2.properties>
```

### Проверьте наличие данных в топике кластера-приемника {#check-data-mkf}

{% include [check-topics](includes/check-mkf-topic.md) %}

Подробнее о работе с сервисом MirrorMaker 2.0 см. [в документации {{ KF }}](https://cwiki.apache.org/confluence/display/KAFKA/KIP-382%3A+MirrorMaker+2.0).
