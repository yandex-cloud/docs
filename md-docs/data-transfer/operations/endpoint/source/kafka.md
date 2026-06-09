# Передача данных из эндпоинта-источника {{ KF }}

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные из очереди {{ KF }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных {{ KF }}](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](../../../troubleshooting/index.md) по их устранению.

## Сценарии передачи данных из {{ KF }} {#scenarios}

1. Миграция — перенос данных из одного хранилища в другое. Часто это перенос базы из устаревших локальных баз в управляемые облачные.

   Отдельной задачей миграции является зеркалирование данных между очередями:

    * [Зеркалирование {{ KF }}](../../../tutorials/mkf-to-mkf.md).

1. Поставка данных — процесс доставки произвольных данных в целевые хранилища. Процесс поставки включает извлечение данных из очереди и их десериализацию с последующей трансформацией данных в формат целевого хранилища.

    * [{{ KF }} в {{ CH }}](../../../tutorials/mkf-to-mch.md);
    * [{{ KF }} в {{ PG }}](../../../tutorials/mkf-to-mpg.md);
    * [{{ KF }} в {{ GP }}](../../../tutorials/managed-kafka-to-greenplum.md);
    * [{{ KF }} в {{ MG }}](../../../tutorials/mkf-to-mmg.md);
    * [{{ KF }} в {{ MY }}](../../../tutorials/mkf-to-mmy.md);
    * [{{ KF }} в {{ OS }}](../../../tutorials/mkf-to-mos.md);
    * [{{ KF }} в {{ ydb-short-name }}](../../../tutorials/mkf-to-ydb.md);

    
    * [{{ KF }} в {{ DS }}](../../../tutorials/mkf-to-yds.md).



Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} читайте в разделе [Практические руководства](../../../tutorials/index.md).

## Подготовка базы данных источника {#prepare}

{% list tabs %}

- {{ mkf-name }}
    
    
    [Создайте пользователя](../../../../managed-kafka/operations/cluster-accounts.md#create-account) с ролью `ACCESS_ROLE_CONSUMER` на топике-источнике.


- {{ KF }}
    
    1. Если вы не планируете использовать для подключения к внешнему кластеру [сервис {{ interconnect-name }}](../../../../interconnect/concepts/index.md) или [VPN](../../../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом {{ data-transfer-name }}](../../../../overview/concepts/public-ips.md#virtual-private-cloud}).
       
       Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../../../concepts/network.md#source-external).
    
    1. [Настройте доступ к кластеру-источнику из {{ yandex-cloud }}](../../../concepts/network.md#source-external).
    
    1. [Настройте права доступа](https://kafka.apache.org/42/security/authorization-and-acls/#examples) пользователя к нужному топику.
    
    1. Выдайте права `READ` консьюмер-группе, идентификатор которой совпадает с идентификатором трансфера.
    
        ```text
        bin/kafka-acls --bootstrap-server localhost:9092 \
          --command-config adminclient-configs.conf \
          --add \
          --allow-principal User:username \
          --operation Read \
          --group <идентификатор_трансфера>
        ```
    
    1. (Опционально) Чтобы использовать авторизацию по логину и паролю, [настройте SASL-аутентификацию](https://kafka.apache.org/42/security/authentication-using-sasl/).

{% endlist %}

## Настройка эндпоинта-источника {{ KF }}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mkf-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Расширенные настройки](#additional-settings).

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
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.topic_name.title }}** — укажите имя топика, к которому необходимо подключиться.
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.
      
      Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).

- {{ TF }} {#tf}

    * Тип эндпоинта — `kafka_source`.

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
    
    * `topic_names` — список имен топиков, к которым необходимо подключиться.

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        kafka_source {
          security_groups = ["<список_идентификаторов_групп_безопасности>"]
          connection {
            cluster_id = "<идентификатор_кластера>"
          }
          auth {
            <метод_аутентификации>
          }
          topic_names = ["<список_имен_топиков>"]
          <расширенные_настройки_эндпоинта>
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
    
    * `topicNames` — список имен топиков, к которым необходимо подключиться.

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
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.OnPremiseKafka.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md). Трансфер будет использовать эту подсеть для доступа к источнику.
    
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
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.topic_name.title }}** — укажите имя топика, к которому необходимо подключиться.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.
      
      Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).

- {{ TF }} {#tf}

    * Тип эндпоинта — `kafka_source`.

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
    
    * `topic_names` — список имен топиков, к которым необходимо подключиться.

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        kafka_source {
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
          topic_names = ["<список_имен_топиков>"]
          <расширенные_настройки_эндпоинта>
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
    
    * `topicNames` — список имен топиков, к которым необходимо подключиться.

{% endlist %}

### Расширенные настройки {#additional-settings}

В расширенных настройках вы можете задать правила трансформации и правила конвертации. Данные обрабатываются в следующем порядке:

1. **Трансформация**. Данные в формате JSON передаются функции [{{ sf-full-name }}](../../../../functions/index.md). В теле функции содержатся метаинформация и необработанные данные, которые переданы в очередь. С помощью функции данные обрабатываются и возвращаются в {{ data-transfer-name }}.

1. **Конвертация**. Выполняется парсинг, с помощью которого данные подготавливаются для передачи приемнику.

Если не заданы правила трансформации, то парсинг применяется к необработанным данным из очереди. Если не заданы правила конвертации, то данные сразу передаются в приемник.

{% list tabs group=instructions %}

- Консоль управления {#console}

    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceAdvancedSettings.transformer.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.cloud_function.title }}** — выберите одну из функций, созданных в сервисе {{ sf-name }}.

        
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.service_account_id.title }}** — выберите или [создайте](../../../../iam/operations/sa/create.md) сервисный аккаунт, от имени которого будет запускаться функция обработки.


        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.number_of_retries.title }}** — укажите количество попыток вызова функции обработки.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_size.title }}** — укажите размер буфера (в байтах), при заполнении которого данные будут переданы функции обработки.

            Максимальный размер буфера — 3,5 МБ. Подробнее об ограничениях, действующих при работе с функциями в сервисе {{ sf-name }}, читайте в [соответствующем разделе](../../../../functions/concepts/limits.md).

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_flush_interval.title }}** — укажите длительность интервала (в секундах), по истечении которого данные из потока должны быть переданы функции обработки.

            {% note info %}

            Если буфер заполнится или истечет интервал отправки, данные будут переданы функции обработки.

            {% endnote %}

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.invocation_timeout.title }}** — укажите допустимое время ожидания ответа от функции обработки (в секундах).

        {% note warning %}

        Значения в полях **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_flush_interval.title }}** и **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.invocation_timeout.title }}** указываются с постфиксом `s`, например, `10s`.

        {% endnote %}
    

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.converter.title }}**:
      
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.format.title }}** — выберите один из доступных форматов:
             * `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}` — формат JSON. Для оптимизации пропускной способности поддерживается обработка сообщений JSON, записанных одной строкой — без символов перевода строки `\n`. Пример: `{"attr": "value"}`
             * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_config_audit_trails_v1.title }}` — формат логов сервиса [{{ at-name }}](../../../../audit-trails/index.md).
             * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_config_common_cloud_logging.title }}` — формат логов сервиса [{{ cloud-logging-short-name }}](../../../../logging/index.md).
             * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_config_common_debezium_cdc.title }}` — Debezium CDC. Позволяет указать настройки подключения к Schema Registry: `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.title }}` для [Confluent Schema Registry](https://docs.confluent.io/platform/current/schema-registry/index.html), идентификатор [пространства имен](../../../../metadata-hub/operations/list-name-space.md) для `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.yandex_sr.title }}`.
             * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.title }}` — позволяет сохранять сообщения целиком «как есть» в отдельную таблицу приемника.
      
                Для формата **JSON** укажите:
      
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}** — задайте схему в виде списка полей или загрузите файл с описанием схемы в формате JSON.
                  
                 {% cut "Пример задания схемы данных" %}
                 ```json
                 [
                     {
                         "name": "request",
                         "type": "string"
                       }
                 ]
                 ```
                 {% endcut %}
          
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.GenericParser.null_keys_allowed.title }}** — выберите эту опцию, чтобы разрешить значение `null` в ключевых колонках.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.add_rest_column.title }}** — выберите эту опцию, чтобы поля, отсутствующие в схеме, попадали в колонку `_rest`.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.parsers.GenericParserCommon.unescape_string_values.title }}** — выберите эту опцию, чтобы убрать кавычки из строковых переменных (если этого не сделать, значения строковых полей останутся без изменений).
      
               Для **Debezium CDC** укажите:
                 * Для `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.title }}` — URL для Schema Registry, способ аутентификации (с указанием логина и пароля пользователя в случае использования аутентификации) и CA-сертификат.
                 * Для `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.yandex_sr.title }}` — идентификатор [пространства имен](../../../../metadata-hub/operations/list-name-space.md) реестра схем.
      
               Для **Raw-to-table** укажите:
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.table_name.title }}** — имя таблицы, в которую сохраняются сообщения. По умолчанию совпадает с именем топика.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.is_key_enabled.title }}** — выберите эту опцию, чтобы записывать ключ сообщения в отдельный столбец.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.key_type.title }}** — выберите подходящий формат для записи ключа в таблицу.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.value_type.title }}** — выберите подходящий формат для записи значения в таблицу.
                 * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.advanced.title }}**:
                   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.is_timestamp_enabled.title }}** — выберите опцию, чтобы сохранять время записи сообщения в отдельном столбце.
                   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.is_headers_enabled.title }}** — выберите опцию, чтобы сохранять заголовки сообщения в отдельном столбце.
                   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_raw_to_table.dlq_suffix.title }}** — укажите суффикс, который будет использоваться для именования отдельной таблицы с недоставленными сообщениями по схеме `<имя_таблицы_сообщений>_<суффикс>`. По умолчанию применяется суффикс `_dlq`.

- {{ TF }} {#tf}

    
    * `transformer` — правила трансформации.


    * `parser` — правила конвертации, которые определяются одним из выбранных парсеров:
      
      * `audit_trails_v1_parser` — парсер для логов сервиса [{{ at-name }}](../../../../audit-trails/index.md).
      * `cloud_logging_parser` — парсер для логов сервиса [{{ cloud-logging-short-name }}](../../../../logging/index.md).
      * `json_parser` или `tskv_parser` — парсеры JSON и TSKV, соответственно.
      
          Атрибуты, задающие параметры их работы, одинаковы для обоих парсеров:
      
          * `data_schema` — схема данных, представленная либо в виде JSON-объекта с описанием схемы, либо в виде списка полей:
      
              * `fields` — схема в виде JSON-объекта. Объект содержит в себе массив JSON-объектов, которые описывают отдельные колонки.
              * `json_fields` — схема в виде списка JSON-полей.
      
          * `null_keys_allowed` — задайте значение `true` для этого атрибута, чтобы разрешить значение `null` в ключевых колонках.
          * `add_rest_column` — задайте значение `true` для этого атрибута, чтобы поля, отсутствующие в схеме, попадали в колонку `_rest`.
          * `unescape_string_values` — задайте значение `true` для этого атрибута, чтобы убрать кавычки из строковых переменных (если этого не сделать, значения строковых полей останутся без изменений).

- API {#api}

    
    * `transformer` — правила трансформации:
      
      * `cloudFunction` — идентификатор функции, созданной в сервисе {{ sf-name }}.
      
      
      * `serviceAccountId` — идентификатор сервисного аккаунта, от имени которого будет запускаться функция обработки.
      
      
      * `numberOfRetries` — количество попыток вызова функции обработки.
      * `bufferSize` — размер буфера (в байтах), при заполнении которого данные будут переданы функции обработки.
      
          Максимальный размер буфера — 3,5 МБ. Подробнее об ограничениях, действующих при работе с функциями в сервисе {{ sf-name }}, читайте в [соответствующем разделе](../../../../functions/concepts/limits.md).
      
      * `bufferFlushInterval` — длительность интервала (в секундах), по истечении которого данные из потока должны быть переданы функции обработки.
      
          {% note info %}
      
          Если буфер заполнится или истечет интервал отправки, данные будут переданы функции обработки.
      
          {% endnote %}
      
      * `invocationTimeout` — допустимое время ожидания ответа от функции обработки (в секундах).
      
      {% note warning %}
      
      Значения для `bufferFlushInterval` и `invocationTimeout` указываются с постфиксом `s`, например, `10s`.
      
      {% endnote %}


    * `parser` — правила конвертации, которые определяются одним из выбранных парсеров:
      
      * `auditTrailsV1Parser` — парсер для логов сервиса [{{ at-name }}](../../../../audit-trails/index.md).
      
      * `cloudLoggingParser` — парсер для логов сервиса [{{ cloud-logging-short-name }}](../../../../logging/index.md).
      
      * `jsonParser` или `tskvParser` — парсеры JSON и TSKV, соответственно.
      
          Поля, задающие параметры их работы, одинаковы для обоих парсеров:
      
          * `dataSchema` — схема данных, представленная либо в виде JSON-объекта с описанием схемы, либо в виде списка полей:
      
              * `fields` — схема в виде JSON-объекта. Объект содержит в себе массив JSON-объектов, которые описывают отдельные колонки.
      
              * `jsonFields` — схема в виде списка JSON-полей.
      
          * `nullKeysAllowed` — задайте значение `true` для этого поля, чтобы разрешить значение `null` в ключевых колонках.
      
          * `addRestColumn` — задайте значение `true` для этого поля, чтобы поля, отсутствующие в схеме, попадали в колонку `_rest`.
      
          * `unescapeStringValues` — задайте значение `true` для этого поля, чтобы убрать кавычки из строковых переменных (если этого не сделать, значения строковых полей останутся без изменений).

{% endlist %}

## Настройка приемника данных {#supported-targets}

Настройте один из поддерживаемых приемников данных:

* [{{ PG }}](../target/postgresql.md);
* [{{ MY }}](../target/mysql.md);
* [{{ MG }}](../target/mongodb.md)
* [{{ CH }}](../target/clickhouse.md);
* [{{ GP }}](../target/greenplum.md);
* [{{ ydb-full-name }}](../target/yandex-database.md);
* [{{ objstorage-full-name }}](../target/object-storage.md);
* [{{ KF }}](../target/kafka.md);
* [{{ DS }}](../target/data-streams.md);
* [{{ ytsaurus-name }}](yt.md);
* [{{ OS }}](../target/opensearch.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} читайте в разделе [Доступные трансферы](../../../transfer-matrix.md).

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).