# Передача данных в эндпоинт-приемник {{ KF }}

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные в очередь {{ KF }} и реализовывать различные сценарии обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте один из поддерживаемых источников данных](#supported-sources).
1. [Настройте эндпоинт-приемник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](../../../troubleshooting/index.md) по их устранению.

## Сценарии передачи данных в {{ KF }} {#scenarios}

1. Миграция — перенос данных из одного хранилища в другое. Часто это перенос базы из устаревших локальных баз в управляемые облачные.

    Отдельной задачей миграции является зеркалирование данных между очередями:
    * [Зеркалирование {{ KF }}](../../../tutorials/mkf-to-mkf.md)

1. Захват изменений данных — это процесс отслеживания изменений в базе данных и поставка этих изменений потребителям. Применяется для приложений, которые чувствительны к изменению данных в реальном времени.
  
    * [Захват изменений из {{ MY }} и поставка в {{ KF }}](../../../tutorials/cdc-mmy.md);
    * [Захват изменений {{ ydb-short-name }} и поставка в {{ KF }}](../../../tutorials/cdc-ydb.md);
    * [Захват изменений из {{ PG }} и поставка в {{ KF }}](../../../tutorials/cdc-mpg.md).

1. Поставка данных — процесс доставки произвольных данных в целевые хранилища. Процесс поставки включает извлечение данных из очереди и их десериализацию с последующей трансформацией данных в формат целевого хранилища.
    * [Поставка данных из очереди {{ DS }} в {{ KF }}](../../../tutorials/yds-to-kafka.md)

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} читайте в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [{{ PG }}](../source/postgresql.md);
* [{{ MY }}](../source/mysql.md);
* [{{ KF }}](../source/kafka.md);
* [{{ AB }}](../../../transfer-matrix.md#airbyte);
* [{{ DS }}](../source/data-streams.md);
* [{{ ydb-name }}](../source/ydb.md);
* [{{ OS }}](../source/opensearch.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} читайте в разделе [Доступные трансферы](../../../transfer-matrix.md).

## Настройка эндпоинта-приемника {{ KF }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mkf-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise) и [настройки сериализации](#serializer), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Это обязательные параметры.
* [Настройки топика Apache Kafka](#kafka-settings).

### Кластер {{ mkf-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.mkf.viewer }}`](../../../../managed-kafka/security/index.md#mkf-viewer) или примитивная [роль `viewer`](../../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение с указанием кластера в {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите вариант подключения к кластеру:
    
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}** — позволяет задать настройки подключения вручную.
    
        Выберите тип инсталляции **Кластер Managed Service for Apache Kafka** и задайте настройки:
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.cluster_id.title }}** — выберите кластер, к которому необходимо подключиться.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafka.auth.title }}** — выберите тип: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafkaAuth.sasl.title }}` или `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafkaAuth.no_auth.title }}`.
          
          При выборе значения `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafkaAuth.sasl.title }}`:
          
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafkaSASLAuth.user.title }}** — укажите имя учетной записи, от имени которой сервис {{ data-transfer-name }} будет подключаться к топику.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.ManagedKafkaSASLAuth.password.title }}** — укажите пароль учетной записи.
    
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}** — позволяет подключиться к кластеру через [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):
    
        * Выберите каталог, в котором находится кластер {{ mkf-name }}.
        * Выберите тип инсталляции **Кластер управляемой БД** и задайте настройки:
    
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.mdb_cluster_id.title }}** — выберите кластер, к которому необходимо подключиться.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}** — выберите подключение в {{ connection-manager-name }} или создайте его.
    
        {% note warning %}
        
        Чтобы использовать подключение из {{ connection-manager-name }}, у пользователя должны быть [права доступа](../../../../metadata-hub/operations/connection-access.md) не ниже `connection-manager.user` к этому подключению.
        
        {% endnote %}
    
    * В блоке **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}** выберите способ указания топика:
      
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.topic_name.title }}** — введите полное имя топика.
      
            Если вы не хотите разбивать поток событий на независимые очереди по таблицам, включите настройку **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.save_tx_order.title }}**.
      
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}** — введите префикс топика.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.
      
      Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
    * В блоке **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }}** выберите тип [сериализации](../../../concepts/serializer.md). Подробнее читайте в разделе [Настройки сериализации](kafka.md#serializer).
    * При необходимости задайте **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTarget.advanced_settings.title }}** эндпоинта:
      
        * Укажите конфигурацию топиков в формате **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.TopicConfigEntry.config_name.title }}**-**{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.TopicConfigEntry.config_value.title }}**.
        * Выберите тип сжатия.

- {{ TF }} {#tf}

    * Тип эндпоинта — `kafka_target`.

    * `security_groups` — [группы безопасности](../../../../vpc/concepts/security-groups.md) для сетевого трафика.
    
        Правила групп безопасности применяются к трансферу. Они позволяют открыть сетевой доступ с ВМ трансфера к кластеру. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
    
        Группы безопасности должны принадлежать той же сети, в которой размещен кластер.
    
        {% note info %}
        
        В {{ TF }} сеть для групп безопасности задавать не нужно.
        
        {% endnote %}
    
    
    * `connection.cluster_id` — идентификатор кластера, к которому необходимо подключиться.
    
    * `auth` — метод аутентификации. Используется при подключении к хостам-брокерам:
      
      * `sasl` — аутентификация с помощью SASL.
      * `no_auth` — без аутентификации.

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        kafka_target {
          security_groups = ["<список_идентификаторов_групп_безопасности>"]
          connection {
            cluster_id = "<идентификатор_кластера>"
          }
          auth {
            <метод_аутентификации>
          }
          <настройки_топика>
          <настройки_сериализации>
        }
      }
    }
    ```


    Подробнее в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API {#api}

    * `securityGroups` — группы безопасности для сетевого трафика, правила которых применятся к ВМ и кластерам без изменения их настроек. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
    
    * `connection.clusterId` — идентификатор кластера, к которому необходимо подключиться.
    
    * `auth` — метод аутентификации. Используется при подключении к хостам-брокерам:
      
      * `sasl` — аутентификация с помощью SASL. Необходимо указать следующие параметры:
      
          * `user` — имя учетной записи, от имени которой сервис {{ data-transfer-name }} будет подключаться к топику.
          * `password.raw` — пароль учетной записи (в текстовом виде).
          * `mechanism` — механизм хеширования.
      
      * `noAuth` — без аутентификации.

{% endlist %}

### Пользовательская инсталляция {#on-premise}

Подключение к кластеру {{ KF }} с явным указанием сетевых адресов и портов хостов-брокеров.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите вариант подключения к базе данных:
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}** — позволяет задать настройки подключения вручную.
    
            Выберите тип инсталляции **Пользовательская инсталляция** и задайте настройки:
    
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.OnPremiseKafka.broker_urls.title }}** — укажите IP-адреса или FQDN хостов-брокеров.
              
              Если номер порта {{ KF }} отличается от стандартного, укажите его через двоеточие после имени хоста:
              
              ```text
              <IP-адрес_или_FQDN_хоста-брокера>:<номер_порта>
              ```
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.OnPremiseKafka.ssl_enabled.title }}** — использовать шифрование для защиты соединения.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.OnPremiseKafka.pem_file_content.title }}** — если требуется шифрование передаваемых данных, например для соответствия требованиям PCI DSS, загрузите файл [сертификата](../../../../managed-kafka/operations/connect/index.md#get-ssl-cert) или добавьте его содержимое в текстовом виде.
              
              {% note warning %}
              
              Если не добавить сертификат, трансфер может [завершиться ошибкой](../../../troubleshooting/index.md#failed-to-connect).
              
              {% endnote %}
            *  **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.OnPremiseKafka.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md). Трансфер будет использовать эту подсеть для доступа к приемнику.
    
                Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.
    
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.OnPremiseKafka.auth.title }}** — выберите тип: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.OnPremiseKafkaAuth.sasl.title }}` или `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.OnPremiseKafkaAuth.no_auth.title }}`.
              
              При выборе значения `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.OnPremiseKafkaAuth.sasl.title }}`:
              
              * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSaslSecurity.user.title }}** — укажите имя учетной записи, от имени которой сервис {{ data-transfer-name }} будет подключаться к топику.
              * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSaslSecurity.password.title }}** — укажите пароль учетной записи.
              * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSaslSecurity.mechanism.title }}** — выберите механизм хеширования: {{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaAuthMechanism.KAFKA_AUTH_MECHANISM_SHA256.title }} или {{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaAuthMechanism.KAFKA_AUTH_MECHANISM_SHA512.title }}.
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}** — позволяет подключиться к базе данных через [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):
    
            * Выберите каталог, в котором создано подключение {{ connection-manager-name }}.
            * Выберите тип инсталляции **Пользовательская инсталляция** и задайте настройки:
    
              * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}** — выберите подключение в {{ connection-manager-name }} или создайте его.
              * **Идентификатор подсети** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md). Трансфер будет использовать эту подсеть для доступа к базе данных.
    
                Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.
    
    * В блоке **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}** выберите способ указания топика:
      
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.topic_name.title }}** — введите полное имя топика.
      
            Если вы не хотите разбивать поток событий на независимые очереди по таблицам, включите настройку **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.save_tx_order.title }}**.
      
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}** — введите префикс топика.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.
      
      Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
    * В блоке **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }}** выберите тип [сериализации](../../../concepts/serializer.md). Подробнее читайте в разделе [Настройки сериализации](kafka.md#serializer).
    * При необходимости задайте **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTarget.advanced_settings.title }}** эндпоинта:
      
        * Укажите конфигурацию топиков в формате **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.TopicConfigEntry.config_name.title }}**-**{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.TopicConfigEntry.config_value.title }}**.
        * Выберите тип сжатия.

- {{ TF }} {#tf}

    * Тип эндпоинта — `kafka_target`.

    * `security_groups` — [группы безопасности](../../../../vpc/concepts/security-groups.md) для сетевого трафика.
    
        Правила групп безопасности применяются к трансферу. Они позволяют открыть сетевой доступ с ВМ трансфера к хостам-брокерам. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
    
        Группы безопасности должны принадлежать той же сети, что и подсеть `subnet_id`, если она указана.
    
        {% note info %}
        
        В {{ TF }} сеть для групп безопасности задавать не нужно.
        
        {% endnote %}
    
    
    * `connection.on_premise` — параметры подключения к хостам-брокерам:
    
        * `broker_urls` — IP-адреса или FQDN хостов-брокеров.
          
          Если номер порта {{ KF }} отличается от стандартного, укажите его через двоеточие после имени хоста:
          
          ```text
          <IP-адрес_или_FQDN_хоста-брокера>:<номер_порта>
          ```
        * `tls_mode` — параметры шифрования передаваемых данных, если оно требуется, например для соответствия требованиям PCI DSS.
          
          * `disabled` — отключено.
          * `enabled` — включено.
              * `ca_certificate` — сертификат CA.
          
                {% note warning %}
                
                Если не добавить сертификат, трансфер может [завершиться ошибкой](../../../troubleshooting/index.md#failed-to-connect).
                
                {% endnote %}
        * `subnet_id` — идентификатор подсети, в которой находятся хосты-брокеры. Трансфер будет использовать эту подсеть для доступа к ним.
    
    * `auth` — метод аутентификации. Используется при подключении к хостам-брокерам:
      
      * `sasl` — аутентификация с помощью SASL.
      * `no_auth` — без аутентификации.

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        kafka_target {
          security_groups = ["<список_идентификаторов_групп_безопасности>"]
          connection {
            on_premise {
              broker_urls = ["<список_IP-адресов_или_FQDN_хостов-брокеров>"]
              subnet_id  = "<идентификатор_подсети_c_хостами-брокерами>"
            }
          }
          auth = {
            <метод_аутентификации>
          }
          <настройки_топика>
          <настройки_сериализации>
        }
      }
    }
    ```


    Подробнее в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API {#api}

    * `securityGroups` — группы безопасности для сетевого трафика, правила которых применятся к ВМ и кластерам без изменения их настроек. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
    
    * `connection.onPremise` — параметры подключения к хостам-брокерам:
    
        * `brokerUrls` — IP-адреса или FQDN хостов-брокеров.
          
          Если номер порта {{ KF }} отличается от стандартного, укажите его через двоеточие после имени хоста:
          
          ```text
          <IP-адрес_или_FQDN_хоста-брокера>:<номер_порта>
          ```
        * `tlsMode` — параметры шифрования передаваемых данных, если оно требуется, например для соответствия требованиям PCI DSS.
          
          * `disabled` — отключено.
          * `enabled` — включено.
              * `caCertificate` — сертификат CA.
          
                {% note warning %}
                
                Если не добавить сертификат, трансфер может [завершиться ошибкой](../../../troubleshooting/index.md#failed-to-connect).
                
                {% endnote %}
        * `subnetId` — идентификатор подсети, в которой находятся хосты-брокеры. Трансфер будет использовать эту подсеть для доступа к ним.
    
    * `auth` — метод аутентификации. Используется при подключении к хостам-брокерам:
      
      * `sasl` — аутентификация с помощью SASL. Необходимо указать следующие параметры:
      
          * `user` — имя учетной записи, от имени которой сервис {{ data-transfer-name }} будет подключаться к топику.
          * `password.raw` — пароль учетной записи (в текстовом виде).
          * `mechanism` — механизм хеширования.
      
      * `noAuth` — без аутентификации.

{% endlist %}

### Настройки топика {{ KF }} {#kafka-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetConnection.topic_settings.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.topic_name.title }}** — укажите имя топика, в который будут отправляться сообщения. Выберите **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopic.save_tx_order.title }}**, чтобы не разбивать поток событий на независимые очереди по таблицам.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaTargetTopicSettings.topic_prefix.title }}** — укажите префикс топика, аналог настройки `Debezium database.server.name`. Сообщения будут отправляться в топик с именем `<префикс_топика>.<схема>.<имя_таблицы>`.

- {{ TF }} {#tf}

    Укажите в блоке `topic_settings` одну из опций отправки сообщений в топик:

    * `topic` — укажите параметры в этом блоке, чтобы отправлять все сообщения в один топик:
        * `topic_name` — имя топика, в который будут отправляться сообщения.
        * `save_tx_order` — опция, позволяющая сохранять порядок транзакций. Укажите значение `true`, чтобы не разбивать поток событий на независимые очереди по таблицам.

    * `topic_prefix` — укажите префикс, чтобы отправлять сообщения в разные топики с заданным префиксом.

        Это аналог настройки Debezium `database.server.name`. Сообщения будут отправляться в топик с именем `<префикс_топика>.<схема>.<имя_таблицы>`.

- API {#api}

    Укажите в поле `topicSettings` одну из опций отправки сообщений в топик:

    * `topic` — укажите параметры в этом поле, чтобы отправлять все сообщения в один топик:
        * `topicName` — имя топика, в который будут отправляться сообщения.
        * `saveTxOrder` — опция, позволяющая сохранять порядок транзакций. Укажите значение `true`, чтобы не разбивать поток событий на независимые очереди по таблицам.

    * `topicPrefix` — укажите префикс, чтобы отправлять сообщения в разные топики с заданным префиксом.

        Это аналог настройки Debezium `database.server.name`. Сообщения будут отправляться в топик с именем `<префикс_топика>.<схема>.<имя_таблицы>`.

{% endlist %}

{{ data-transfer-full-name }} поддерживает CDC-режим для трансферов из баз данных {{ PG }}, {{ MY }} и {{ ydb-short-name }} в {{ KF }} и {{ yds-full-name }}. При этом данные в приемник попадают в формате Debezium. Подробнее о CDC-режиме читайте в разделе [Захват изменения данных](../../../concepts/cdc.md).

{% note info %}

В {{ ydb-short-name }} CDC-режим поддерживается, начиная с версии {{ ydb.version-cdc }} и выше.

{% endnote %}

### Настройки сериализации {#serializer}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * В блоке **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }}** выберите тип [сериализации](../../../concepts/serializer.md):
    
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_auto.title }}** — автоматическая сериализация.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_debezium.title }}** — сериализация по стандартам Debezium:
      
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_yandex_schema_registry_debezium.title }}**:
    
          * Выберите схему сообщения (формат данных).
          * Выберите из списка [пространство имен](../../../../metadata-hub/operations/list-name-space.md) реестра схем {{ schema-registry-full-name }}.
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_on_premise_debezium.title }}**:
    
          * Выберите схему ключа сообщения (соответствует Debezium-параметру `key.converter`). Значение по умолчанию соответствует Debezium-параметрам `key.converter.schemas.enable=true` и  `key.converter=org.apache.kafka.connect.json.JsonConverter`. При выборе значения **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.disabled.title }}** Debezium-параметр `key.converter.schemas.enable` принимает значение `false`.
          * Выберите схему значения сообщения (соответствует Debezium-параметру `value.converter`). Значение по умолчанию соответствует Debezium-параметрам `value.converter.schemas.enable=true` и  `value.converter=org.apache.kafka.connect.json.JsonConverter`. При выборе значения **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.disabled.title }}** Debezium-параметр `value.converter.schemas.enable` принимает значение `false`.
          * При выборе значений **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.avro.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.json.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.protobuf.title }}** для схем ключа и значения сообщения укажите параметры доступа к внешнему сервису Confluent Schema Registry:
    
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.url.title }}** — URL сервиса.
            * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.username.title }}**.
            * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.password.title }}**.
            * (Опционально) **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.ca_cert.title }}** — загрузите SSL-сертификат для подключения. Чтобы пропустить проверку сертификата, не задавайте его.
    
        * При необходимости задайте [**{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.parameters.title }}**](../../../concepts/serializer.md#debezium) в формате `Параметр`-`Значение`.
    
    Если вы хотите использовать JSON-схемы в {{ schema-registry-full-name }}, сохраняя [совместимость схем при добавлении и удалении опциональных полей](../../../../metadata-hub/concepts/schema-registry-content-model.md#optional-parameters-compatibility-solution), укажите следующие настройки:
    
    **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }}** — **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_debezium.title }}** — **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_on_premise_debezium.title }}**
    
    * Чтобы использовать {{ schema-registry-name }} для ключей, выберите **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.key_converter_settings.title }}** — **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.json.title }}**. Чтобы использовать {{ schema-registry-name }} для значений, выберите **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.value_converter_settings.title }}** — **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.json.title }}**. Укажите параметры доступа к Schema Registry:
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.url.title }}** — `https://<идентификатор_пространства_имен>.{{ schema-registry-endpoint }}`.
    
          {% note warning %}
    
          В пространстве имен должна быть [выставлена](../../../../metadata-hub/operations/update-name-space.md) **Политика проверок совместимости для JSON** — `optional friendly`.
    
          {% endnote %}
    
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.username.title }}** — `api-key`.
    
      
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.password.title }}** — значение [API-ключа](../../../../iam/concepts/authorization/api-key.md) с ограниченной областью действия для подключения к {{ schema-registry-name }}. Чтобы получить значение:
          1. Создайте API-ключ с ограниченной областью действия и поместите его в локальную переменную `SECRET`:
    
              ```bash
              yc iam api-key create --folder-id <идентификатор_каталога> \
                --service-account-name <имя_сервисного_аккаунта_для_работы_со_Schema_Registry> \
                --scopes yc.schema-registry.schemas.manage \
                --expires-at '2030-01-01T00:00:00Z' >./api-key.yaml && \
              SECRET=`cat ./api-key.yaml | grep 'secret:' | awk '{print $2}'`
              ```
    
          1. Выведите в терминал значение переменной `SECRET`:
    
              ```bash
              echo $SECRET
              ```
    
    
    * В блоке **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.parameters.title }}**:
        * Чтобы генерировать закрытую схему для ключей, добавьте параметр `key.converter.dt.json.generate.closed.content.schema` со значением `true`.
        * Чтобы генерировать закрытую схему для значений, добавьте параметр `value.converter.dt.json.generate.closed.content.schema` со значением `true`.

- {{ TF }} {#tf}

    Укажите в блоке `serializer` выбранный тип [сериализации](../../../concepts/serializer.md):
    
    * `serializer_auto`.
    * `serializer_json`.
    * `serializer_debezium`.
    
        Для этого типа можно указать параметры [сериализации Debezium](../../../concepts/serializer.md#debezium), задав их в блоке `serializer_debezium.serializer_parameters` в виде пар `key`/`value`.
    
    Если вы хотите использовать JSON-схемы в {{ schema-registry-full-name }}, сохраняя [совместимость схем при добавлении и удалении опциональных полей](../../../../metadata-hub/concepts/schema-registry-content-model.md#optional-parameters-compatibility-solution), добавьте в конфигурационный файл блок `serializer` с описанием настроек сериализации. Чтобы генерировать закрытую схему для ключей, добавьте в блок `serializer` переменную `key.converter.dt.json.generate.closed.content.schema` со значением `true`. Чтобы генерировать закрытую схему для значений, добавьте в блок `serializer` переменную `value.converter.dt.json.generate.closed.content.schema` со значением `true`.
    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      ...
      settings {
        kafka_target {
          ...
          serializer {
            serializer_debezium {
              serializer_parameters {            
                key = "key.converter.dt.json.generate.closed.content.schema"
                value = "true"
              }    
              serializer_parameters {            
                key = "value.converter.dt.json.generate.closed.content.schema"
                value = "true"
              }
              serializer_parameters {
                key = "value.converter.schemas.enable"
                value = "true"
              }
              serializer_parameters {
                key = "value.converter.schema.registry.url"
                value = "<URL_пространства_имен_Schema_Registry>"
              }
              serializer_parameters {
                key = "value.converter.basic.auth.user.info"
                value = "api-key:<значение_API-ключа>"
              }
            }
          }
        }
      }
    }
    ```
    Где:
    
    * `URL_пространства_имен_Schema_Registry` — эндпоинт пространства имен {{ schema-registry-name }}. Вы можете скопировать эндпоинт из подсказки по подключению к пространству имен {{ schema-registry-name }} на вкладке **Debezium**, в параметре `value.converter.schema.registry.url`.
    
        {% note warning %}
    
        В пространстве имен должна быть [выставлена](../../../../metadata-hub/operations/update-name-space.md) **Политика проверок совместимости для JSON** — `optional friendly`.
    
        {% endnote %}
    
    * `значение_API-ключа` — значение [API-ключа](../../../../iam/concepts/authorization/api-key.md) с ограниченной областью действия для подключения к {{ schema-registry-name }}. Чтобы получить значение:
        1. Создайте API-ключ с ограниченной областью действия и поместите его в локальную переменную `SECRET`:
    
            ```bash
            yc iam api-key create --folder-id <идентификатор_каталога> \
              --service-account-name <имя_сервисного_аккаунта_для_работы_со_Schema_Registry> \
              --scopes yc.schema-registry.schemas.manage \
              --expires-at '2030-01-01T00:00:00Z' >./api-key.yaml && \
            SECRET=`cat ./api-key.yaml | grep 'secret:' | awk '{print $2}'`
            ```
    
        1. Выведите в терминал значение переменной `SECRET`:
    
            ```bash
            echo $SECRET
            ```
    
        1. Скопируйте полученное значение и вставьте его в параметр `value` в конфигурационном файле.

- API {#api}

    Укажите в блоке `serializer` выбранный тип [сериализации](../../../concepts/serializer.md):
    
    * `serializerAuto`.
    * `serializerJson`.
    * `serializerDebezium`.
    
        Для этого типа можно указать параметры [сериализации Debezium](../../../concepts/serializer.md#debezium), задав их в поле `serializerDebezium.serializerParameters` в виде пар `key`/`value`.
    
    Если вы хотите использовать JSON-схемы в {{ schema-registry-full-name }}, сохраняя [совместимость схем при добавлении и удалении опциональных полей](../../../../metadata-hub/concepts/schema-registry-content-model.md#optional-parameters-compatibility-solution), добавьте в тело запроса объект `serializer` с описанием настроек сериализации. Чтобы генерировать закрытую схему для ключей, добавьте в объект `serializer` переменную `key.converter.dt.json.generate.closed.content.schema` со значением `true`. Чтобы генерировать закрытую схему для значений, добавьте в объект `serializer` переменную `value.converter.dt.json.generate.closed.content.schema` со значением `true`.
    
    ```json
    "serializer": {
      "serializerDebezium": {
        "serializerParameters": [
          {
            "key": "converter.dt.json.generate.closed.content.schema",
            "value": "true"
          },
          {
            "key": "value.converter",
            "value": "io.confluent.connect.json.JsonSchemaConverter"
          },
          {
            "key": "value.converter.schemas.enable",
            "value": "true"
          },
          {
            "key": "value.converter.schema.registry.url",
            "value": "<URL_пространства_имен_Schema_Registry>"
          },
          {
            "key": "value.converter.basic.auth.user.info",
            "value": "api-key:<значение_API-ключа>"
          }
        ]
      }
    }
    ```
    
    Где:
    
    * `URL_пространства_имен_Schema_Registry` — эндпоинт пространства имен {{ schema-registry-name }}. Вы можете скопировать эндпоинт из подсказки по подключению к пространству имен {{ schema-registry-name }} на вкладке **Debezium**, в параметре `value.converter.schema.registry.url`.
    
        {% note warning %}
    
        В пространстве имен должна быть [выставлена](../../../../metadata-hub/operations/update-name-space.md) **Политика проверок совместимости для JSON** — `optional friendly`.
    
        {% endnote %}
    
    * `значение_API-ключа` — значение [API-ключа](../../../../iam/concepts/authorization/api-key.md) с ограниченной областью действия для подключения к {{ schema-registry-name }}. Чтобы получить значение:
        1. Создайте API-ключ с ограниченной областью действия и поместите его в локальную переменную `SECRET`:
    
            ```bash
            yc iam api-key create --folder-id <идентификатор_каталога> \
              --service-account-name <имя_сервисного_аккаунта_для_работы_со_Schema_Registry> \
              --scopes yc.schema-registry.schemas.manage \
              --expires-at '2030-01-01T00:00:00Z' >./api-key.yaml && \
            SECRET=`cat ./api-key.yaml | grep 'secret:' | awk '{print $2}'`
            ```
    
        1. Выведите в терминал значение переменной `SECRET`:
    
            ```bash
            echo $SECRET
            ```
    
        1. Скопируйте полученное значение и вставьте его в параметр `value` в конфигурационном файле.

{% endlist %}

### Дополнительные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    Вы можете указать [параметры конфигурации топика](https://docs.confluent.io/platform/current/installation/configuration/topic-configs.html), которые будут применяться при создании новых топиков.

    Укажите параметр и одно из его допустимых значений: например, `cleanup.policy` и `compact`.

{% endlist %}

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).