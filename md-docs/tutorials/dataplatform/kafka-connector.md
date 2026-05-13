# Миграция базы данных из стороннего кластера Apache Kafka® в Yandex Managed Service for Apache Kafka®

Перенести топики из _кластера-источника_ Apache Kafka® в _кластер-приемник_ Managed Service for Apache Kafka® можно двумя способами:

* [С помощью встроенного в Yandex Managed Service for Apache Kafka® MirrorMaker-коннектора](#kf-connector).

  Этот способ прост в настройке и не требует создания промежуточной виртуальной машины.

* [С помощью утилиты MirrorMaker 2.0](#kf-mirrormaker).

  Для этого потребуется самостоятельная инсталляция и настройка утилиты на промежуточной виртуальной машине. Используйте этот способ только в том случае, если перенос данных с помощью встроенного MirrorMaker-коннектора по каким-либо причинам невозможен.

Оба способа подойдут в том числе для [миграции кластера](../../managed-kafka/operations/host-migration.md#one-host) Managed Service for Apache Kafka® с одним хостом в другую зону доступности.


## Перенос данных с использованием сервиса Yandex Managed Service for Apache Kafka® Connector {#kf-connector}

Чтобы перенести данные с использованием сервиса Yandex Managed Service for Apache Kafka® Connector:

1. [Подготовьте кластер-источник](#prepare-source).
1. [Создайте кластер-приемник и коннектор](#create-cluster-connector).
1. [Проверьте наличие данных в топике кластера-приемника](#check-data-mkf-connector).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out-connector).


### Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

##### **Необходимые платные ресурсы** {#paid-resources-connector}

* Кластер Managed Service for Apache Kafka®: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы Managed Service for Apache Kafka®](../../managed-kafka/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).


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

        * **Топики** — список топиков, которые нужно перенести. Также можно указать регулярное выражение для выбора топиков. Для переноса всех топиков укажите `.*`.
        * В блоке **Кластер-источник** укажите параметры для подключения к кластеру-источнику:
          * **Псевдоним** — префикс для обозначения кластера-источника в настройках коннектора. По умолчанию `source`. Топики в кластере-приемнике будут созданы с указанным префиксом.  
          * **Бутстрап-серверы** — разделенный запятыми список FQDN хостов-брокеров кластера-источника с номерами портов, например:

              ```text
              FQDN_1:9091,FQDN_2:9091,...,FQDN_N:9091
              ```

          * **SASL механизм** — механизм шифрования имени и пароля `SCRAM-SHA-512`.
          * **SASL имя пользователя**, **SASL пароль** — имя и пароль созданного ранее пользователя `admin-source`.
          * **Протокол безопасности** — выберите протокол подключения коннектора:
            * `SASL_PLAINTEXT` — если к кластеру-источнику подключаются без SSL;
            * `SASL_SSL` – если к кластеру-источнику подключаются с SSL.

        * В блоке **Кластер-приёмник** выберите опцию **Использовать этот кластер**.


- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [kafka-mirrormaker-connector.tf](https://github.com/yandex-cloud-examples/yc-kafka-data-migration-from-on-premise/blob/main/kafka-mirrormaker-connector.tf).

        В этом файле описаны:

        * сеть;
        * подсеть;
        * группа безопасности по умолчанию и правила, необходимые для подключения к кластеру из интернета;
        * кластер-приемник Managed Service for Apache Kafka® с включенной настройкой [Auto create topics enable](../../managed-kafka/concepts/settings-list.md#settings-auto-create-topics);
        * [пользователь-администратор](../../managed-kafka/operations/cluster-accounts.md#create-account) `admin-cloud` для кластера-приемника;
        * MirrorMaker-коннектор для кластера-приемника.

    1. Укажите в файле `kafka-mirrormaker-connector.tf`:

        * имя пользователя кластера-источника и пароли для пользователей кластера-источника и кластера-приемника;
        * FQDN хостов-брокеров кластера-источника;
        * псевдонимы кластера-источника и кластера-приемника;
        * шаблон фильтрации для переносимых топиков;
        * версию Apache Kafka®.

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

{% note info %}

После создания коннектор автоматически активируется, и начнется перенос данных.

{% endnote %}

### Проверьте наличие данных в топике кластера-приемника {#check-data-mkf-connector}

1. В [консоли управления](https://console.yandex.cloud) откройте кластер-приемник.
1. Убедитесь, что на вкладке **Топики** отображается перенесенный топик.

   К имени топика будет добавлен префикс, по умолчанию — `source`. Например, топик `mytopic` будет перенесен на кластер-приемник как `source.mytopic`.

1. [Подключитесь](../../managed-kafka/operations/connect/clients.md#bash-zsh) к топику кластера-приемника с помощью утилиты kafkacat. К имени топика кластера-источника добавьте префикс.
1. Убедитесь, что в консоли отображаются сообщения из топика кластера-источника.

### Удалите созданные ресурсы {#clear-out-connector}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    [Удалите кластер Yandex Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-delete.md). Коннектор удалится вместе с кластером.


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


## Перенос данных с использованием утилиты MirrorMaker {#kf-mirrormaker}

Чтобы перенести данные с использованием утилиты MirrorMaker:

1. [Подготовьте инфраструктуру](#prepare-infrastructure).
1. [Настройте кластер-источник и ВМ](#additional-settings).
1. [Настройте конфигурацию MirrorMaker](#configure-mirrormaker).
1. [Запустите репликацию](#replication-start).
1. [Проверьте наличие данных в топике кластера-приемника](#check-data-mkf).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out-mm).


### Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

##### **Необходимые платные ресурсы** {#paid-resources-mirrormaker}

* Кластер Managed Service for Apache Kafka®: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы Managed Service for Apache Kafka®](../../managed-kafka/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Виртуальная машина: использование вычислительных ресурсов, хранилища, публичного IP-адреса и операционной системы (см. [тарифы Compute Cloud](../../compute/pricing.md)).


### Подготовьте инфраструктуру {#prepare-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Создайте кластер-приемник Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-create.md).
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

- Terraform {#tf}

  1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
  1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
  1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
  1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

  1. Скачайте в ту же рабочую директорию файл конфигурации [kafka-mirror-maker.tf](https://github.com/yandex-cloud-examples/yc-kafka-data-migration-from-on-premise/blob/main/kafka-mirror-maker.tf).

      В этом файле описаны:

      * сеть;
      * подсеть;
      * группа безопасности по умолчанию и правила, необходимые для подключения к кластеру и виртуальной машине из интернета;
      * кластер Managed Service for Apache Kafka® с включенной настройкой [Auto create topics enable](../../managed-kafka/concepts/settings-list.md#settings-auto-create-topics);
      * [пользователь-администратор](../../managed-kafka/operations/cluster-accounts.md#create-account) Apache Kafka® `admin-cloud`, которому назначена роль `ACCESS_ROLE_ADMIN` на все топики кластера;
      * виртуальная машина с публичным доступом из интернета.

  1. Укажите в файле `kafka-mirror-maker.tf`:

      * Имя кластера Managed Service for Apache Kafka®
      * Пароль пользователя-администратора Apache Kafka®.
      * Идентификатор публичного [образа](../../compute/operations/images-with-pre-installed-software/get-list.md) с Ubuntu без [GPU](../../glossary/gpu.md), например [Ubuntu 24.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-24-04-lts).
      * Логин и путь к файлу [открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys), которые будут использоваться для доступа к виртуальной машине.

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

### Настройте кластер-источник и ВМ {#additional-settings}

1. Подготовьте кластер-источник:

    1. Создайте в кластере-источнике пользователя `admin-source` и назначьте ему роль `ACCESS_ROLE_ADMIN` на все топики (`*`).
    1. Включите настройку `Auto create topics enable`.

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к виртуальной машине по [SSH](../../glossary/ssh-keygen.md).

    1. Установите JDK:

        ```bash
        sudo apt update && sudo apt install --yes default-jdk
        ```

    1. [Скачайте](https://kafka.apache.org/community/downloads/) и распакуйте архив Apache Kafka® той же версии, которая установлена на кластере-приемнике. Например, для версии 3.9:

        ```bash
        wget https://archive.apache.org/dist/kafka/3.9.0/kafka_2.12-3.9.0.tgz && \
        tar -xvf kafka_2.12-3.9.0.tgz
        ```

    1. Скачайте [SSL-сертификат](../../managed-kafka/operations/connect/index.md#get-ssl-cert) для подключения к кластеру Managed Service for Apache Kafka®:

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
   sudo keytool --noprompt -importcert -alias YandexCA \
      -file /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt \
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
   * Параметр `<T>` — количество одновременно работающих процессов MirrorMaker. Рекомендуется указывать не менее `2` для равномерного распределения нагрузки репликации. Подробнее [в документации Apache Kafka®](https://kafka.apache.org/42/operations/geo-replication-cross-cluster-data-mirroring/#configuration-file-syntax).

   FQDN брокеров Managed Service for Apache Kafka® можно запросить со [списком хостов в кластере](../../managed-kafka/operations/cluster-hosts.md).

### Запустите репликацию {#replication-start}

1. [Подключитесь к ВМ с MirrorMaker по SSH](../../compute/operations/vm-connect/ssh.md).
1. Запустите MirrorMaker на ВМ командой:

    ```bash
    <путь_установки_Apache_Kafka>/bin/connect-mirror-maker.sh /home/<домашняя_директория>/mirror-maker/mm2.properties
    ```

### Проверьте наличие данных в топике кластера-приемника {#check-data-mkf}

1. В [консоли управления](https://console.yandex.cloud) откройте кластер-приемник.
1. Убедитесь, что на вкладке **Топики** отображается перенесенный топик.

   К имени топика будет добавлен префикс, по умолчанию — `source`. Например, топик `mytopic` будет перенесен на кластер-приемник как `source.mytopic`.

1. [Подключитесь](../../managed-kafka/operations/connect/clients.md#bash-zsh) к топику кластера-приемника с помощью утилиты kafkacat. К имени топика кластера-источника добавьте префикс.
1. Убедитесь, что в консоли отображаются сообщения из топика кластера-источника.

Подробнее о работе с сервисом MirrorMaker 2.0 в [документации Apache Kafka®](https://cwiki.apache.org/confluence/display/KAFKA/KIP-382%3A+MirrorMaker+2.0).

### Удалите созданные ресурсы {#clear-out-mm}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    * [Удалите кластер Yandex Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-delete.md).
    * [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
    * Если вы зарезервировали публичные статические IP-адреса, освободите и [удалите их](../../vpc/operations/address-delete.md)

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