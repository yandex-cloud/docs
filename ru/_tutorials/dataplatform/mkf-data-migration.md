


Перенести топики из _кластера-источника_ {{ KF }} в _кластер-приемник_ {{ mkf-name }} можно двумя способами:

* [С помощью встроенного в {{ mkf-full-name }} MirrorMaker-коннектора](#kf-connector).

  Этот способ прост в настройке и не требует создания промежуточной виртуальной машины.

* [С помощью утилиты MirrorMaker 2.0](#kf-mirrormaker).

  Для этого потребуется самостоятельная инсталляция и настройка утилиты на промежуточной виртуальной машине. Используйте этот способ только в том случае, если перенос данных с помощью встроенного MirrorMaker-коннектора по каким-либо причинам невозможен.

Оба способа подойдут в том числе для [миграции кластера](../../managed-kafka/operations/host-migration.md#one-host) {{ mkf-name }} с одним хостом в другую зону доступности.


## Перенос данных с использованием сервиса {{ mkf-full-name }} Connector {#kf-connector}

Чтобы перенести данные с использованием сервиса {{ mkf-full-name }} Connector:

1. [Подготовьте кластер-источник](#prepare-source).
1. [Создайте кластер-приемник и коннектор](#create-cluster-connector).
1. [Проверьте наличие данных в топике кластера-приемника](#check-data-mkf-connector).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out-connector).


### Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

##### **Необходимые платные ресурсы** {#paid-resources-connector}

* Кластер {{ mkf-name }}: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий ([тарифы {{ mkf-name }}](../../managed-kafka/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы {{ vpc-name }}](../../vpc/pricing.md)).


### Подготовьте кластер-источник {#prepare-source}

1. Создайте пользователя `admin-source` и назначьте ему роль `ACCESS_ROLE_ADMIN` на все топики (`*`).
1. Убедитесь, что настройки сети, в которой размещен кластер-источник, разрешают подключение к нему из интернета.

### Создайте кластер-приемник и коннектор {#create-cluster-connector}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер-приемник](../../managed-kafka/operations/cluster-create.md).
    1. Подготовьте кластер-приемник:
        1. Создайте [пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) с именем `admin-cloud`.
        1. [Создайте топик](../../managed-kafka/operations/cluster-topics.md#create-topic) с произвольными настройками. Он понадобится только для настройки доступа пользователя к топикам.
        1. [Назначьте пользователю роль](../../managed-kafka/operations/cluster-accounts.md#grant-permission) `ACCESS_ROLE_ADMIN` на все топики (`*`).
        1. Включите настройку [Auto create topics enable](../../managed-kafka/concepts/settings-list.md#settings-auto-create-topics).
        1. Настройте [группы безопасности](../../managed-kafka/operations/connect/index.md#configuring-security-groups) для подключения к кластеру-приемнику.

    1. [Создайте для кластера-приемника коннектор](../../managed-kafka/operations/cluster-connector.md#create-connector) с типом `MirrorMaker` и настройками:

        * **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-topics }}** — список топиков, которые нужно перенести. Также можно указать регулярное выражение для выбора топиков. Для переноса всех топиков укажите `.*`.
        * В блоке **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-source-cluster }}** укажите параметры для подключения к кластеру-источнику:
          * **{{ ui-key.yacloud.kafka.field_connector-alias }}** — префикс для обозначения кластера-источника в настройках коннектора. По умолчанию `source`. Топики в кластере-приемнике будут созданы с указанным префиксом.  
          * **{{ ui-key.yacloud.kafka.field_connector-bootstrap-servers }}** — разделенный запятыми список FQDN хостов-брокеров кластера-источника с номерами портов, например:

              ```text
              FQDN_1:9091,FQDN_2:9091,...,FQDN_N:9091
              ```

          * **{{ ui-key.yacloud.kafka.field_connector-sasl-mechanism }}** — механизм шифрования имени и пароля `SCRAM-SHA-512`.
          * **{{ ui-key.yacloud.kafka.field_connector-sasl-username }}**, **{{ ui-key.yacloud.kafka.field_connector-sasl-password }}** — имя и пароль созданного ранее пользователя `admin-source`.
          * **{{ ui-key.yacloud.kafka.field_connector-security-protocol }}** — выберите протокол подключения коннектора:
            * `SASL_PLAINTEXT` — если к кластеру-источнику подключаются без SSL;
            * `SASL_SSL` – если к кластеру-источнику подключаются с SSL.

        * В блоке **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-target-cluster }}** выберите опцию **{{ ui-key.yacloud.kafka.label_connector-this-cluster }}**.


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [kafka-mirrormaker-connector.tf](https://github.com/yandex-cloud-examples/yc-kafka-data-migration-from-on-premise/blob/main/kafka-mirrormaker-connector.tf).

        В этом файле описаны:

        * сеть;
        * подсеть;
        * группа безопасности по умолчанию и правила, необходимые для подключения к кластеру из интернета;
        * кластер-приемник {{ mkf-name }} с включенной настройкой [Auto create topics enable](../../managed-kafka/concepts/settings-list.md#settings-auto-create-topics);
        * [пользователь-администратор](../../managed-kafka/operations/cluster-accounts.md#create-account) `admin-cloud` для кластера-приемника;
        * MirrorMaker-коннектор для кластера-приемника.

    1. Укажите в файле `kafka-mirrormaker-connector.tf`:

        * имя пользователя кластера-источника и пароли для пользователей кластера-источника и кластера-приемника;
        * FQDN хостов-брокеров кластера-источника;
        * псевдонимы кластера-источника и кластера-приемника;
        * шаблон фильтрации для переносимых топиков;
        * версию {{ KF }}.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}


{% endlist %}

{% note info %}

После создания коннектор автоматически активируется, и начнется перенос данных.

{% endnote %}

### Проверьте наличие данных в топике кластера-приемника {#check-data-mkf-connector}

{% include [check-topics](../_tutorials_includes/check-mkf-topic.md) %}

### Удалите созданные ресурсы {#clear-out-connector}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    [Удалите кластер {{ mkf-full-name }}](../../managed-kafka/operations/cluster-delete.md). Коннектор удалится вместе с кластером.


- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}


{% endlist %}


## Перенос данных с использованием утилиты MirrorMaker {#kf-mirrormaker}

Чтобы перенести данные с использованием утилиты MirrorMaker:

1. [Подготовьте инфраструктуру](#prepare-infrastructure).
1. [Настройте кластер-источник и ВМ](#additional-settings).
1. [Настройте конфигурацию MirrorMaker](#configure-mirrormaker).
1. [Запустите репликацию](#replication-start).
1. [Проверьте наличие данных в топике кластера-приемника](#check-data-mkf).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out-mm).


### Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

##### **Необходимые платные ресурсы** {#paid-resources-mirrormaker}

* Кластер {{ mkf-name }}: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий ([тарифы {{ mkf-name }}](../../managed-kafka/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы {{ vpc-name }}](../../vpc/pricing.md)).
* Виртуальная машина: использование вычислительных ресурсов, хранилища, публичного IP-адреса и операционной системы ([тарифы {{ compute-name }}](../../compute/pricing.md)).


### Подготовьте инфраструктуру {#prepare-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Создайте кластер-приемник {{ mkf-name }}](../../managed-kafka/operations/cluster-create.md).
  1. Подготовьте кластер-приемник:
      * [Создайте пользователя](../../managed-kafka/operations/cluster-accounts.md#create-account) с именем `admin-cloud`.
      * [Создайте топик](../../managed-kafka/operations/cluster-topics.md#create-topic) с произвольными настройками. Он понадобится только для настройки доступа пользователя к топикам.
      * [Назначьте пользователю роль](../../managed-kafka/operations/cluster-accounts.md#grant-permission) `ACCESS_ROLE_ADMIN` на все топики (`*`).
      * Включите настройку [Auto create topics enable](../../managed-kafka/concepts/settings-list.md#settings-auto-create-topics).
      * Настройте [группы безопасности](../../managed-kafka/operations/connect/index.md#configuring-security-groups) для подключения к кластеру-приемнику.

  1. [Создайте новую ВМ Linux](../../compute/operations/vm-create/create-linux-vm.md) для MirrorMaker в той же сети, к которой подключен кластер-приемник. 

      Чтобы подключаться к виртуальной машине через интернет:

      * Включите публичный доступ при создании ВМ.
      * Убедитесь, что группа безопасности ВМ разрешает подключение к ней через интернет.

- {{ TF }} {#tf}

  1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
  1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
  1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
  1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

  1. Скачайте в ту же рабочую директорию файл конфигурации [kafka-mirror-maker.tf](https://github.com/yandex-cloud-examples/yc-kafka-data-migration-from-on-premise/blob/main/kafka-mirror-maker.tf).

      В этом файле описаны:

      * сеть;
      * подсеть;
      * группа безопасности по умолчанию и правила, необходимые для подключения к кластеру и виртуальной машине из интернета;
      * кластер {{ mkf-name }} с включенной настройкой [Auto create topics enable](../../managed-kafka/concepts/settings-list.md#settings-auto-create-topics);
      * [пользователь-администратор](../../managed-kafka/operations/cluster-accounts.md#create-account) {{ KF }} `admin-cloud`, которому назначена роль `ACCESS_ROLE_ADMIN` на все топики кластера;
      * виртуальная машина с публичным доступом из интернета.

  1. Укажите в файле `kafka-mirror-maker.tf`:

      * Имя кластера {{ mkf-name}}
      * Пароль пользователя-администратора {{ KF }}.
      * Идентификатор публичного [образа](../../compute/operations/images-with-pre-installed-software/get-list.md) с Ubuntu без [GPU](../../glossary/gpu.md), например [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-24-04-lts).
      * Логин и путь к файлу [открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys), которые будут использоваться для доступа к виртуальной машине.

  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Создайте необходимую инфраструктуру:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Настройте кластер-источник и ВМ {#additional-settings}

1. Подготовьте кластер-источник:

    1. Создайте в кластере-источнике пользователя `admin-source` и назначьте ему роль `ACCESS_ROLE_ADMIN` на все топики (`*`).
    1. Включите настройку `Auto create topics enable`.

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к виртуальной машине по [SSH](../../glossary/ssh-keygen.md).

    1. Установите JDK:

        ```bash
        sudo apt update && sudo apt install --yes default-jdk
        ```

    1. [Скачайте](https://kafka.apache.org/community/downloads/) и распакуйте архив {{ KF }} той же версии, которая установлена на кластере-приемнике. Например, для версии 3.9:

        ```bash
        wget https://archive.apache.org/dist/kafka/3.9.0/kafka_2.12-3.9.0.tgz && \
        tar -xvf kafka_2.12-3.9.0.tgz
        ```

    1. Скачайте [SSL-сертификат](../../managed-kafka/operations/connect#get-ssl-cert) для подключения к кластеру {{ mkf-name }}:

        ```bash
        sudo mkdir -p /usr/local/share/ca-certificates/Yandex && \
        sudo wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
            --output-document /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt && \
        sudo chmod 0655 /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
        ```

    1. Установите утилиту [kafkacat](https://github.com/edenhill/kcat):

        ```bash
        sudo apt update && sudo apt install --yes kafkacat
        ```

1. Настройте межсетевой экран (firewall) и [группы безопасности](../../managed-kafka/operations/connect/index.md#configuring-security-groups), если это требуется для подключения MirrorMaker к кластеру-приемнику и кластеру-источнику.

### Настройте конфигурацию MirrorMaker {#configure-mirrormaker}

1. [Подключитесь к ВМ с MirrorMaker по SSH](../../compute/operations/vm-connect/ssh.md).
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
   clusters=source, cloud
   source.bootstrap.servers=<FQDN_брокера_кластера-источника>:9091
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
   * Параметр `<R>` — [фактор репликации служебных топиков](../../managed-kafka/concepts/settings-list.md#settings-topic-replication-factor) MirrorMaker. Значение этого параметра не должно превышать меньшего между количеством брокеров в кластере-источнике и количеством брокеров в кластере-приемнике.
   * Параметр `<M>` — [фактор репликации по умолчанию](../../managed-kafka/concepts/settings-list.md#settings-topic-replication-factor), установленный для топиков в кластере-приемнике.
   * Параметр `<T>` — количество одновременно работающих процессов MirrorMaker. Рекомендуется указывать не менее `2` для равномерного распределения нагрузки репликации. Подробнее [в документации {{ KF }}](https://kafka.apache.org/42/operations/geo-replication-cross-cluster-data-mirroring/#configuration-file-syntax).

   FQDN брокеров {{ mkf-name }} можно запросить со [списком хостов в кластере](../../managed-kafka/operations/cluster-hosts.md).

### Запустите репликацию {#replication-start}

1. [Подключитесь к ВМ с MirrorMaker по SSH](../../compute/operations/vm-connect/ssh.md).
1. Запустите MirrorMaker на ВМ командой:

    ```bash
    <путь_установки_Apache_Kafka>/bin/connect-mirror-maker.sh /home/<домашняя_директория>/mirror-maker/mm2.properties
    ```

### Проверьте наличие данных в топике кластера-приемника {#check-data-mkf}

{% include [check-topics](../_tutorials_includes/check-mkf-topic.md) %}

Подробнее о работе с сервисом MirrorMaker 2.0 в [документации {{ KF }}](https://cwiki.apache.org/confluence/display/KAFKA/KIP-382%3A+MirrorMaker+2.0).

### Удалите созданные ресурсы {#clear-out-mm}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    * [Удалите кластер {{ mkf-full-name }}](../../managed-kafka/operations/cluster-delete.md).
    * [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
    * Если вы зарезервировали публичные статические IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md)

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}

