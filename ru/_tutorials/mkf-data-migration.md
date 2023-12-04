Перенести топики из _кластера-источника_ {{ KF }} в _кластер-приемник_ {{ mkf-name }} можно двумя способами:

* [С помощью встроенного в {{ mkf-full-name }} MirrorMaker-коннектора](#kf-connnector).

  Этот способ прост в настройке и не требует создания промежуточной виртуальной машины.

* [С помощью утилиты MirrorMaker 2.0](#kf-mirrormaker).

  Для этого потребуется самостоятельная инсталляция и настройка утилиты на промежуточной виртуальной машине. Используйте этот способ только в том случае, если перенос данных с помощью встроенного MirrorMaker-коннектора по каким-либо причинам невозможен.

## Перенос данных с использованием сервиса {{ mkf-full-name }} Connector {#kf-connector}

1. [Создайте коннектор](#create-connector).
1. [Проверьте наличие данных в топике кластера-приемника](#check-data-mkf-connector).

### Создайте кластер и коннектор {#create-cluster-connector}

{% list tabs %}

* Вручную

    1. Подготовьте кластер-приемник:
        * Создайте [пользователя-администратора](../managed-kafka/operations/cluster-accounts.md#create-account) с именем `admin-cloud`.
        * Включите настройку [Auto create topics enable](../managed-kafka/concepts/settings-list.md#settings-auto-create-topics).
        * Настройте [группы безопасности](../managed-kafka/operations/connect.md#configuring-security-groups), если это требуется для подключения к кластеру-приемнику.

    1. Создайте в кластере-источнике пользователя `admin-source` с правом управления топиками через Admin API.
    1. Убедитесь, что настройки сети, в которой размещен кластер-источник, разрешают подключение к нему из интернета.
    1. [Создайте для кластера-приемника коннектор](../managed-kafka/operations/cluster-connector.md#create-connector) с типом `MirrorMaker` и настройками:

        * **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-topics }}** — список топиков, которые нужно перенести. Также можно указать регулярное выражение для выбора топиков. Для переноса всех топиков укажите `.*`.
        * В блоке **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-source-cluster }}** укажите параметры для подключения к кластеру-источнику:
          * **{{ ui-key.yacloud.kafka.field_connector-alias }}** — префикс для обозначения кластера-источника в настройках коннектора. По умолчанию `source`. Топики в кластере-приемнике будут созданы с указанным префиксом.  
          * **{{ ui-key.yacloud.kafka.field_connector-bootstrap-servers }}** — разделенный запятыми список FQDN хостов-брокеров кластера-источника с номерами портов, например:

              ```text
              FQDN1:9091,FQDN2:9091,...,FQDN:9091
              ```

          * **{{ ui-key.yacloud.kafka.field_connector-sasl-username }}**, **{{ ui-key.yacloud.kafka.field_connector-sasl-password }}** — имя и пароль созданного ранее пользователя `admin-source`.
          * **{{ ui-key.yacloud.kafka.field_connector-sasl-mechanism }}** — механизм шифрования имени и пароля `SCRAM-SHA-512`.
          * **{{ ui-key.yacloud.kafka.field_connector-security-protocol }}** — выберите протокол подключения коннектора:
            * `SASL_PLAINTEXT` — если к кластеру-источнику подключаются без SSL;
            * `SASL_SSL` – если к кластеру-источнику подключаются с SSL.

        * В блоке **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-target-cluster }}** выберите опцию **{{ ui-key.yacloud.kafka.label_connector-this-cluster }}**.

* С помощью {{ TF }}

    1. {% include [terraform-install-without-setting](../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [kafka-mirrormaker-connector.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/kafka-connectors/kafka-mirrormaker-connector.tf).

        В этом файле описаны:

        * сеть;
        * подсеть;
        * группа безопасности по умолчанию и правила, необходимые для подключения к кластеру из интернета;
        * кластер {{ mkf-name }} с [пользователем-администратором](../managed-kafka/operations/cluster-accounts.md#create-account) `admin-cloud` и с включенной настройкой [Auto create topics enable](../managed-kafka/concepts/settings-list.md#settings-auto-create-topics);
        * MirrorMaker-коннектор.

    1. Укажите в файле `kafka-mirrormaker-connector.tf`:

        * имена и пароли пользователей кластера-источника и кластера-приемника;
        * FQDN хостов-брокеров кластера-источника;
        * псевдонимы кластера-источника и кластера-приемника;
        * шаблон фильтрации для переносимых топиков;
        * версию {{ KF }} (не выше 2.8).

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../_includes/mdb/terraform/explore-resources.md) %}

После создания коннектор автоматически активируется и начнется перенос данных.

{% endlist %}

### Проверьте наличие данных в топике кластера-приемника {#check-data-mkf-connector}

{% include [check-topics](_tutorials_includes/check-mkf-topic.md) %}

## Перенос данных с использованием утилиты MirrorMaker {#kf-mirrormaker}

1. [Настройте конфигурацию MirrorMaker](#configure-mirrormaker).
1. [Запустите репликацию](#replication-start).
1. [Проверьте наличие данных в топике кластера-приемника](#check-data-mkf).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

### Перед началом работы {#before-you-begin}

#### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs %}

- Вручную

    1. [Создайте кластер-приемник {{ mkf-name }}](../managed-kafka/operations/cluster-create.md):

        * С [пользователем-администратором](../managed-kafka/operations/cluster-accounts.md#create-account) `admin-cloud`.
        * С включенной настройкой [Auto create topics enable](../managed-kafka/concepts/settings-list.md#settings-auto-create-topics).

    1. [Создайте новую ВМ Linux](../compute/operations/vm-create/create-linux-vm.md) для MirrorMaker в той же сети, к которой подключен кластер-приемник. Для подключения к виртуальной машине с локальной машины пользователя, а не из облачной сети {{ yandex-cloud }}, включите публичный доступ при ее создании.

- С помощью {{ TF }}

    1. {% include [terraform-install-without-setting](../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [kafka-mirror-maker.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/kafka-mirror-maker.tf).

        В этом файле описаны:

        * сеть;
        * подсеть;
        * группа безопасности по умолчанию и правила, необходимые для подключения к кластеру и виртуальной машине из интернета;
        * кластер {{ mkf-name }} с [пользователем-администратором](../managed-kafka/operations/cluster-accounts.md#create-account) `admin-cloud` и с включенной настройкой [Auto create topics enable](../managed-kafka/concepts/settings-list.md#settings-auto-create-topics);
        * виртуальная машина с публичным доступом из интернета.

    1. Укажите в файле `kafka-mirror-maker.tf`:

        * Пароль пользователя-администратора {{ mkf-name }}.
        * Идентификатор публичного [образа](../compute/operations/images-with-pre-installed-software/get-list) с Ubuntu без [GPU](../glossary/gpu.md). Например, для [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts).
        * Логин и путь к файлу [открытого ключа](../compute/operations/vm-connect/ssh.md#creating-ssh-keys), которые будут использоваться для доступа к виртуальной машине. По умолчанию в используемом образе указанный логин игнорируется, вместо него создается пользователь с логином `ubuntu`. Используйте его для подключения к виртуальной машине.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

#### Выполните дополнительные настройки {#additional-settings}

1. Создайте в кластере-источнике пользователя `admin-source` с правом управления топиками через Admin API.

1. [Подключитесь](../compute/operations/vm-connect/ssh.md) к виртуальной машине по [SSH](../glossary/ssh-keygen.md).

    1. Установите JDK:

        ```bash
        sudo apt update && sudo apt install --yes default-jdk
        ```

    1. [Скачайте](https://kafka.apache.org/downloads) и распакуйте архив {{ KF }} той же версии, которая установлена на кластере-приемнике. Например, для версии 2.8:

        ```bash
        wget https://archive.apache.org/dist/kafka/2.8.0/kafka_2.12-2.8.0.tgz && \
        tar -xvf kafka_2.12-2.8.0.tgz
        ```

    1. Установите утилиту [kafkacat](https://github.com/edenhill/kcat):

        ```bash
        sudo apt update && sudo apt install --yes kafkacat
        ```

        Убедитесь, что можете с ее помощью [подключиться к кластеру-источнику и кластеру-приемнику через SSL](../managed-kafka/operations/connect.md#connection-string).

1. Настройте межсетевой экран (firewall) и [группы безопасности](../managed-kafka/operations/connect.md#configuring-security-groups), если это требуется для подключения MirrorMaker к кластеру-приемнику и кластеру-источнику.

### Настройте конфигурацию MirrorMaker {#configure-mirrormaker}

1. [Подключитесь к ВМ с MirrorMaker по SSH](../compute/operations/vm-connect/ssh.md).
1. Скачайте [SSL-сертификат](../managed-kafka/operations/connect#get-ssl-cert) для подключения к кластеру {{ mkf-name }}.
1. В домашней директории создайте каталог `mirror-maker` для хранения сертификатов Java Keystore и конфигураций MirrorMaker:

   ```bash
   mkdir --parents /home/<домашняя_директория>/mirror-maker
   ```

1. Выберите пароль для хранилища сертификатов не короче 6 символов, создайте хранилище и добавьте в него SSL-сертификат для подключения к кластеру:

   ```bash
   sudo keytool --noprompt -importcert -alias {{ crt-alias }} \
      -file {{ crt-local-dir }}{{ crt-local-file }} \
      -keystore /home/<домашняя_директория>/mirror-maker/keystore \
      -storepass <пароль_хранилища_сертификатов>
   ```

1. Создайте в каталоге `mirror-maker` файл конфигурации MirrorMaker `mm2.properties`:

   ```text
   # Kafka clusters
   clusters=cloud, source
   source.bootstrap.servers=<FQDN_брокера_кластера-источника>:9092
   cloud.bootstrap.servers=<FQDN_брокера_1_кластера-приемника>:9091, ..., <FQDN_брокера_N_кластера-приемника>:9091

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
   cloud.ssl.truststore.location=/home/<домашняя_директория>/mirror-maker/keystore
   cloud.ssl.truststore.password=<пароль_хранилища_сертификатов>
   cloud.ssl.protocol=TLS
   cloud.security.protocol=SASL_SSL
   cloud.sasl.mechanism=SCRAM-SHA-512
   cloud.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="admin-cloud" password="<пароль>";

   # Enable heartbeats and checkpoints
   source->target.emit.heartbeats.enabled=true
   source->target.emit.checkpoints.enabled=true
   ```

   Пояснения к конфигурации MirrorMaker:

   * Выполняется односторонняя репликация (параметры `source->cloud.enabled = true`, `cloud->source.enabled = false`).
   * В параметре `topics` указывается список топиков, которые нужно перенести. Также можно указать регулярное выражение для выбора топиков. Для переноса всех топиков укажите `.*`. В данной конфигурации реплицируются все топики.
   * Названия топиков в кластере-приемнике совпадают с их названиями в кластере-источнике.
   * Параметр `<R>` — [фактор репликации служебных топиков](../managed-kafka/concepts/settings-list.md#settings-topic-replication-factor) MirrorMaker. Значение этого параметра не должно превышать меньшего между количеством брокеров в кластере-источнике и количеством брокеров в кластере-приемнике.
   * Параметр `<M>` — [фактор репликации по умолчанию](../managed-kafka/concepts/settings-list.md#settings-topic-replication-factor), установленный для топиков в кластере-приемнике.
   * Параметр `<T>` — количество одновременно работающих процессов MirrorMaker. Рекомендуется указывать не менее `2` для равномерного распределения нагрузки репликации. Подробнее см. [в документации {{ KF }}](https://kafka.apache.org/documentation/#georeplication-config-syntax).

   FQDN брокеров {{ mkf-name }} можно запросить со [списком хостов в кластере](../managed-kafka/operations/cluster-hosts.md#list-hosts).

### Запустите репликацию {#replication-start}

Запустите MirrorMaker на ВМ командой:

```bash
<путь_установки_Apache_Kafka>/bin/connect-mirror-maker.sh /home/<домашняя_директория>/mirror-maker/mm2.properties
```

### Проверьте наличие данных в топике кластера-приемника {#check-data-mkf}

{% include [check-topics](_tutorials_includes/check-mkf-topic.md) %}

Подробнее о работе с сервисом MirrorMaker 2.0 см. в [документации {{ KF }}](https://cwiki.apache.org/confluence/display/KAFKA/KIP-382%3A+MirrorMaker+2.0).

### Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

{% list tabs %}

- Вручную

    * [Удалите кластер {{ mkf-full-name }}](../managed-kafka/operations/cluster-delete.md).
    * [Удалите виртуальную машину](../compute/operations/vm-control/vm-delete.md).
    * Если вы зарезервировали публичные статические IP-адреса, освободите и [удалите их](../vpc/operations/address-delete.md)

- С помощью {{ TF }}

    Чтобы удалить инфраструктуру, [созданную с помощью {{ TF }}](#deploy-infrastructure):

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `kafka-mirror-maker.tf` или `kafka-mirrormaker-connector.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `kafka-mirror-maker.tf` или `kafka-mirrormaker-connector.tf`, будут удалены.

{% endlist %}
