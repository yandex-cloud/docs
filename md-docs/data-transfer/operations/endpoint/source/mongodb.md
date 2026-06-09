# Передача данных из эндпоинта-источника {{ MG }}/{{ SD }} (Managed Service for MongoDB)


С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные из базы {{ MG }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Подготовьте базу данных {{ MG }}](#prepare) к трансферу.
1. [Настройте эндпоинт-источник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Настройте один из поддерживаемых приемников данных](#supported-targets).
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. [Выполняйте необходимые действия по работе с базой](#db-actions) и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных из {{ MG }}/{{ SD }} (Managed Service for MongoDB) {#scenarios}

1. Миграция — перенос данных из одного хранилища в другое. Часто это перенос базы из устаревших локальных баз в управляемые облачные.

    * [Миграция кластера {{ MG }}](../../../tutorials/storedoc.md);
    * [Миграция кластера {{ SD }} (Managed Service for MongoDB) с версии 4.4 на 6.0](../../../tutorials/storedoc-versions.md).

1. Загрузка данных в масштабируемое хранилище {{ objstorage-name }} позволяет удешевить хранение и облегчает обмен данных с контрагентами.

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} читайте в разделе [Практические руководства](../../../tutorials/index.md).

## Подготовка базы данных источника {#prepare}

{% list tabs %}

- {{ mmg-name }} (Managed Service for MongoDB)


    1. Оцените общее количество баз данных для трансфера и общую нагрузку на {{ mmg-name }}. Если нагрузка на базы выше 10 000 операций записи в секунду, создайте несколько эндпоинтов и трансферов. Подробнее читайте в разделе [{#T}](mongodb.md).
    
    1. [Создайте пользователя](../../../../storedoc/operations/cluster-users.md#adduser) с ролью `readWrite` на каждую базу в источнике, которая будет реплицироваться. Роль `readWrite` нужна для того, чтобы у трансфера было право записи в служебную коллекцию `__data_transfer.__dt_cluster_time`.

- {{ MG }}
    
    1. Оцените общее количество баз данных для трансфера и общую нагрузку на {{ MG }}. Если нагрузка на базы выше 10 000 операций записи в секунду, создайте несколько эндпоинтов и трансферов. Подробнее читайте в разделе [{#T}](mongodb.md).
    
    1. Если вы не планируете использовать для подключения к внешнему кластеру [сервис {{ interconnect-name }}](../../../../interconnect/concepts/index.md) или [VPN](../../../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом {{ data-transfer-name }}](../../../../overview/concepts/public-ips.md#virtual-private-cloud}).
       
       Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../../../concepts/network.md#source-external).
    
    1. Убедитесь, что версия {{ MG }} на приемнике не ниже `4.0`.
    
    1. Убедитесь, что кластер {{ MG }} сконфигурирован таким образом, чтобы на запросы к нему он возвращал корректно разрешающиеся IP-адреса или FQDN (Fully Qualified Domain Name).
    
    1. [Настройте доступ к кластеру-источнику из {{ yandex-cloud }}](../../../concepts/network.md#source-external). Чтобы настроить кластер-источник для подключения из интернета:
        
        1. Измените в конфигурационном файле значение настройки `net.bindIp` со `127.0.0.1` на `0.0.0.0`:
        
            ```yaml
            # network interfaces
            net:
              port: 27017
              bindIp: 0.0.0.0
            ```
        
        1. Перезапустите сервис `mongod`:
        
            ```bash
            sudo systemctl restart mongod.service
            ```
    
    1. Если кластер-источник не использует репликацию, включите ее:
        
        1. Добавьте в конфигурационный файл `/etc/mongod.conf` настройки репликации:
        
            ```yaml
            replication:
              replSetName: <имя_набора_реплик>
            ```
        
        1. Перезапустите сервис `mongod`:
        
            ```bash
            sudo systemctl restart mongod.service
            ```
        
        1. Подключитесь к {{ MG }} и инициализируйте набор реплик командой:
        
            ```javascript
            rs.initiate({
                _id: "<имя_набора_реплик>",
                members: [{
                    _id: 0,
                    host: "<IP-адрес_который_слушает_Yandex_StoreDoc>:<порт>"
                }]
            });
            ```
    
    1. Создайте пользователя с ролью `readWrite` на все базы в источнике, которые будут реплицироваться:
    
        ```javascript
        use admin
        db.createUser({
            user: "<имя_пользователя>",
            pwd: "<пароль>",
            mechanisms: ["SCRAM-SHA-1"],
            roles: [
                {
                    db: "<имя_базы-источника_1>",
                    role: "readWrite"
                },
                {
                    db: "<имя_базы-источника_2>",
                    role: "readWrite"
                },
                ...
            ]
        });
        ```
    
       После старта трансфер подключится к источнику от имени этого пользователя. Роль `readWrite` нужна для того, чтобы у трансфера было право записи в служебную коллекцию `__data_transfer.__dt_cluster_time`.
    
       {% note info %}
    
       Для версий {{ MG }}, начиная с {{ dt-mg-version }}, достаточно выдать созданному пользователю роль `read` на реплицируемые базы.
    
       {% endnote %}
    
    1. При использовании {{ MG }}, начиная с версии {{ dt-mg-version }}, для работы трансфера необходимо, чтобы пользователь обладал правами на чтение коллекции `local.oplog.rs`, а также на запись с чтением коллекции `__data_transfer.__dt_cluster_time`. Чтобы назначить пользователю роль `clusterAdmin`, предоставляющую такие права, подключитесь к {{ MG }} и выполните команды:
    
        ```js
        use admin;
        db.grantRolesToUser("<имя_пользователя>", ["clusterAdmin"]);
        ```
    
       Для выдачи более гранулярных прав можно назначить роль `clusterMonitor`, необходимую для чтения коллекции `local.oplog.rs`, а также дать доступ на чтение и запись системной коллекции `__data_transfer.__dt_cluster_time`.

{% endlist %}

## Настройка эндпоинта-источника {{ MG }}/{{ SD }} (Managed Service for MongoDB) {#endpoint-settings}

{{ data-transfer-name }} поддерживает трансферы с {{ MG }}, начиная с версии {{ dt-mg-version }}.

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mmg-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

### Кластер {{ mmg-name }} (Managed Service for MongoDB) {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.mmg.viewer }}`](../../../../storedoc/security/index.md#mmg-viewer) или примитивная [роль `viewer`](../../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение к БД с указанием кластера в {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите вариант подключения к базе данных:
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}** — позволяет задать настройки подключения вручную.
    
            Выберите тип инсталляции **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.mdb_cluster_id.title }}** и задайте настройки:
    
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.mdb_cluster_id.title }}** — выберите кластер, к которому необходимо подключиться.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.auth_source.title }}** — укажите имя базы данных в кластере.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}** — укажите пароль пользователя для доступа к базе данных.
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}** — позволяет подключаться к кластеру через [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):
    
            * Выберите каталог, в котором находится кластер {{ mmg-name }}.
            * Выберите тип инсталляции **Кластер управляемой БД** и задайте настройки:
    
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.mdb_cluster_id.title }}** — выберите кластер, к которому необходимо подключиться.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}** — выберите подключение {{ connection-manager-name }} или создайте его.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.auth_source.title }}** — укажите имя базы данных в кластере.
    
            {% note warning %}
            
            Чтобы использовать подключение из {{ connection-manager-name }}, у пользователя должны быть [права доступа](../../../../metadata-hub/operations/connection-access.md) не ниже `connection-manager.user` к этому подключению.
            
            {% endnote %}
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.
    
      Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).

- CLI {#cli}

    * Тип эндпоинта — `mongo-source`.

    * `--cluster-id` — идентификатор кластера, к которому необходимо подключиться.
    * `--database` — имя базы данных.
    * `--user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    * `--security-group` — группы безопасности для сетевого трафика, правила которых применятся к ВМ и кластерам без изменения их настроек. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
    
    * Чтобы задать пароль пользователя для доступа к базе данных, используйте один из параметров:
    
        * `--raw-password` — пароль в текстовом виде.
        * `--password-file` — путь к файлу с паролем.

- {{ TF }} {#tf}

    * Тип эндпоинта — `mongo_source`.

    * `connection.connection_options.mdb_cluster_id` — идентификатор кластера, к которому необходимо подключиться.
    * `subnet_id` — идентификатор [подсети](../../../../vpc/concepts/network.md#subnet), в которой находится кластер. Трансфер будет использовать эту подсеть для доступа к кластеру. Если идентификатор не указан, то кластер должен быть доступен из интернета.
      
      Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.
    * `security_groups` — [группы безопасности](../../../../vpc/concepts/security-groups.md) для сетевого трафика.
      
      Правила групп безопасности применяются к трансферу. Они позволяют открыть сетевой доступ с ВМ трансфера к кластеру. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
      
      Группы безопасности и подсеть `subnet_id`, если она указана, должны принадлежать той же сети, в которой размещен кластер.
      
      {% note info %}
      
      В {{ TF }} сеть для групп безопасности задавать не нужно.
      
      {% endnote %}
    * `auth_source` — имя базы данных в кластере.
    * `connection.connection_options.user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    * `connection.connection_options.password.raw` — пароль в текстовом виде.

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        mongo_source {
          security_groups = ["<список_идентификаторов_групп_безопасности>"]
          subnet_id       = "<идентификатор_подсети>"
          connection {
            connection_options {
              mdb_cluster_id = "<идентификатор_кластера>"
              auth_source    = "<имя_базы_данных>"
              user           = "<имя_пользователя>"
              password {
                raw = "<пароль_пользователя>"
              }
            }
          }
          <дополнительные_настройки_эндпоинта>
        }
      }
    }
    ```


    Подробнее в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API {#api}

    * `securityGroups` — группы безопасности для сетевого трафика, правила которых применятся к ВМ и кластерам без изменения их настроек. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
    * `mdbClusterId` — идентификатор кластера, к которому необходимо подключиться.
    * `database` — имя базы данных.
    * `user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    * `password.raw` — пароль пользователя для доступа к базе данных (в текстовом виде).

{% endlist %}

### Пользовательская инсталляция {#on-premise}

Настройки приведены для случая OnPremise, когда все поля заполняются вручную.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите вариант подключения к базе данных:
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}** — позволяет задать настройки подключения вручную.
    
            Выберите тип инсталляции **Пользовательская инсталляция** и задайте настройки:
    
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.hosts.title }}** — укажите IP-адреса или FQDN хостов, к которым необходимо подключиться.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.replica_set.title }}** — укажите имя набора реплик.
    
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.port.title }}** — укажите номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения.
    
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.ca_certificate.title }}** — для шифрования передаваемых данных загрузите файл [PEM-сертификата](../../../../storedoc/operations/connect/index.md#get-ssl-cert) или добавьте его содержимое в текстовом виде.
              
              {% note warning %}
              
              Если не добавить сертификат, трансфер может [завершиться ошибкой](../../../troubleshooting/index.md#failed-to-connect).
              
              {% endnote %}
    
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md). Трансфер будет использовать эту подсеть для доступа к базе данных.
    
              Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.
    
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.auth_source.title }}** — укажите имя базы данных в пользовательской инсталляции.
    
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}** — укажите пароль пользователя для доступа к базе данных.
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}** — позволяет подключаться к базе данных через [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):
    
            * Выберите каталог, в котором создано подключение {{ connection-manager-name }}.
            * Выберите тип инсталляции **Пользовательская инсталляция** и задайте настройки:
    
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}** — выберите подключение {{ connection-manager-name }} или создайте его.
    
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.replica_set.title }}** — укажите имя набора реплик.
    
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.auth_source.title }}** — укажите имя базы данных в пользовательской инсталляции.
    
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md). Трансфер будет использовать эту подсеть для доступа к базе данных.
    
                  Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.
    
            {% note warning %}
            
            Чтобы использовать подключение из {{ connection-manager-name }}, у пользователя должны быть [права доступа](../../../../metadata-hub/operations/connection-access.md) не ниже `connection-manager.user` к этому подключению.
            
            {% endnote %}
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.
    
      Это позволит применить к ВМ и БД в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и БД. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).

- CLI {#cli}

    * Тип эндпоинта — `mongo-source`.

    * `--host` — IP-адрес или FQDN хоста-мастера, к которому необходимо подключиться.
    * `--port` — номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения.
    * `--ca-certificate` — сертификат CA, если требуется шифрование передаваемых данных, например для соответствия требованиям PCI DSS.
      
      {% note warning %}
      
      Если не добавить сертификат, трансфер может [завершиться ошибкой](../../../troubleshooting/index.md#failed-to-connect).
      
      {% endnote %}
    * `--subnet-id` — идентификатор подсети, в которой находится хост. Трансфер будет использовать эту подсеть для доступа к хосту.
    * `--database` — имя базы данных.
    * `--user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    * `--security-group` — группы безопасности для сетевого трафика, правила которых применятся к ВМ и кластерам без изменения их настроек. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
    
    * Чтобы задать пароль пользователя для доступа к базе данных, используйте один из параметров:
    
        * `--raw-password` — пароль в текстовом виде.
        * `--password-file` — путь к файлу с паролем.

- {{ TF }} {#tf}

    * Тип эндпоинта — `mongo_source`.

    * `on_premise.port` — номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения.
    * `connection.connection_options.on_premise.tls_mode.enabled.ca_certificate` — сертификат CA, если требуется шифрование передаваемых данных, например, для соответствия требованиям PCI DSS.
      
      {% note warning %}
      
      Если не добавить сертификат, трансфер может [завершиться ошибкой](../../../troubleshooting/index.md#failed-to-connect).
      
      {% endnote %}
    * `subnet_id` — идентификатор [подсети](../../../../vpc/concepts/network.md#subnet), в которой находится кластер. Трансфер будет использовать эту подсеть для доступа к кластеру. Если идентификатор не указан, то кластер должен быть доступен из интернета.
      
      Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.
    * `security_groups` — [группы безопасности](../../../../vpc/concepts/security-groups.md) для сетевого трафика.
      
      Правила групп безопасности применяются к трансферу. Они позволяют открыть сетевой доступ с ВМ трансфера к ВМ с базой данных. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
      
      Группы безопасности должны принадлежать той же сети, что и подсеть `subnet_id`, если она указана.
      
      {% note info %}
      
      В {{ TF }} сеть для групп безопасности задавать не нужно.
      
      {% endnote %}
    * `connection.connection_options.on_premise.replica_set` — укажите имя набора реплик.
    * `connection.connection_options.on_premise.hosts` — укажите IP-адреса или FQDN хостов, к которым необходимо подключиться.
    * `auth_source` — имя базы данных в кластере.
    * `connection.connection_options.user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    * `connection.connection_options.password.raw` — пароль в текстовом виде.

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        mongo_source {
          security_groups = ["<список_идентификаторов_групп_безопасности>"]
          subnet_id       = "<идентификатор_подсети>"
          connection {
            connection_options {
              on_premise {
                hosts       = [ "список хостов набора реплик" ]
                port        = "<порт_для_подключения>"
                replica_set = "<имя_набора_реплик>"
                tls_mode {
                  enabled {
                    ca_certificate = "<сертификат_в_формате_PEM>"
                  }
                }
              }
              auth_source = "<имя_базы_данных>"
              user        = "<имя_пользователя>"
              password {
                raw = "<пароль_пользователя>"
              }
            }
          }
          <дополнительные_настройки_эндпоинта>
        }
      }
    }
    ```


    Подробнее в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API {#api}

    * `onPremise` — параметры подключения к базе данных:
        * `hosts` — IP-адрес или FQDN хоста-мастера, к которому необходимо подключиться.
        * `port` — номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения.
        * `tlsMode` — параметры шифрования передаваемых данных, если оно требуется, например для соответствия требованиям PCI DSS.
            * `disabled` — отключено.
            * `enabled` — включено
                * `caCertificate` — сертификат CA.
          
                  {% note warning %}
                  
                  Если не добавить сертификат, трансфер может [завершиться ошибкой](../../../troubleshooting/index.md#failed-to-connect).
                  
                  {% endnote %}
        * `subnetId` — идентификатор подсети, в которой находится хост. Трансфер будет использовать эту подсеть для доступа к хосту.
    * `securityGroups` — группы безопасности для сетевого трафика, правила которых применятся к ВМ и кластерам без изменения их настроек. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
    * `database` — имя базы данных.
    * `user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    * `password.raw` — пароль пользователя для доступа к базе данных (в текстовом виде).

{% endlist %}

### Фильтр коллекций {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoCollectionFilter.collections.title }}** — будут передаваться данные только из перечисленных коллекций. По умолчанию передаются все коллекции.

        Добавление новых коллекций при редактировании эндпоинта, использующегося в трансферах типа {{ dt-type-copy-repl }} или {{ dt-type-repl }} в статусе {{ dt-status-repl }}, не приведет к загрузке истории данных по этим коллекциям. Чтобы добавить коллекцию с ее историческими данными, используйте поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** в [настройках трансфера](../../transfer.md#update).

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoCollectionFilter.excluded_collections.title }}** — будут передаваться данные из всех коллекций, кроме указанных.

    Имена включенных и исключенных коллекций должны соответствовать правилам именования идентификаторов в {{ MG }}. Экранирование двойных кавычек не требуется.

- CLI {#cli}

    * `--include-collection` — будут передаваться данные только из перечисленных коллекций. Значения указываются в формате `<имя_базы_данных>.<имя_коллекции>`. По умолчанию передаются все коллекции.

        Добавление новых коллекций при редактировании эндпоинта, использующегося в трансферах типа {{ dt-type-copy-repl }} или {{ dt-type-repl }} в статусе {{ dt-status-repl }}, не приведет к загрузке истории данных по этим коллекциям. Чтобы добавить коллекцию с ее историческими данными, используйте поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** в [настройках трансфера](../../transfer.md#update).

    * `--exclude-collection` — будут передаваться данные из всех коллекций, кроме указанных. Значения указываются в формате `<имя_базы_данных>.<имя_коллекции>`.

    * `--prefer-secondary` — задайте значение `true` для этого параметра, чтобы использовать для чтения данных реплики (если они есть в кластере) вместо хоста-мастера.

- {{ TF }} {#tf}

    * `collections` — будут передаваться данные только из перечисленных коллекций. По умолчанию передаются все коллекции.

        Добавление новых коллекций при редактировании эндпоинта, использующегося в трансферах типа {{ dt-type-copy-repl }} или {{ dt-type-repl }} в статусе {{ dt-status-repl }}, не приведет к загрузке истории данных по этим коллекциям. Чтобы добавить коллекцию с ее историческими данными, используйте поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** в [настройках трансфера](../../transfer.md#update).

    * `excluded_collections` — будут передаваться данные из всех коллекций, кроме указанных.

    * `secondary_preferred_mode` — задайте значение `true` для этого параметра, чтобы использовать для чтения данных реплики (если они есть в кластере) вместо хоста-мастера.

- API {#api}

    * `collections` — будут передаваться данные только из перечисленных коллекций. Для каждой коллекции указываются:
      
      * `databaseName` — имя базы данных.
      * `collectionName` — имя коллекции.
      
      По умолчанию передаются все коллекции.

        Добавление новых коллекций при редактировании эндпоинта, использующегося в трансферах типа {{ dt-type-copy-repl }} или {{ dt-type-repl }} в статусе {{ dt-status-repl }}, не приведет к загрузке истории данных по этим коллекциям. Чтобы добавить коллекцию с ее историческими данными, используйте поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.data_objects.title }}** в [настройках трансфера](../../transfer.md#update).

    * `excludedCollections` — будут передаваться данные из всех коллекций, кроме указанных. Для каждой коллекции указываются:
      
      * `databaseName` — имя базы данных.
      * `collectionName` — имя коллекции.

    * `secondaryPreferredMode` — задайте значение `true` для этого параметра, чтобы использовать для чтения данных реплики (если они есть в кластере) вместо хоста-мастера.

{% endlist %}

Если источник испытывает высокую рабочую нагрузку (более 10000 транзакций на запись в секунду), то рекомендуется задать эти настройки так, чтобы в каждом эндпоинте присутствовало не более десяти различных баз. Это позволит избежать ошибок подключения к базам во время работы трансфера.

{% note info %}

* Если вы используете несколько эндпоинтов, то для каждого из них необходимо создать отдельный трансфер.
* Так как трансферы не поддерживают перенос коллекций `Time Series`, такие коллекции необходимо исключить.

{% endnote %}


## Настройка приемника данных {#supported-targets}

Настройте один из поддерживаемых приемников данных:

* [{{ objstorage-full-name }}](../target/object-storage.md);
* [{{ ytsaurus-name }}](yt.md);
* [{{ mmg-name }} (Managed Service for MongoDB)](../target/mongodb.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} читайте в разделе [Доступные трансферы](../../../transfer-matrix.md).

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Действия с базой данных во время трансфера {#db-actions}

* Для трансферов в статусе {{ dt-status-copy }} запрещено производить действия, которые сокращают временное окно _журнала операций_ (oplog) на источнике. Не стоит добавлять, удалять шарды или каким-либо образом их переконфигурировать в процессе копирования, а также производить другие действия, приводящие к уменьшению временного окна журнала операций.

* Для трансферов в статусе {{ dt-status-repl }} можно столкнуться с проблемой дублирования ключа в ситуациях, когда приемником выступает шардированный кластер {{ MG }} (Managed Service for MongoDB) с индексом шардирования, отличным от `_id`. Во время работы трансфера не рекомендуется создавать на приемнике кластеры с индексами шардирования, отличными от `_id`.

## Решение проблем, возникающих при переносе данных {#troubleshooting}

Известные проблемы, связанные с использованием эндпоинта {{ MG }}:

* [Размер ключа коллекции превышает 5 МБ](#string-size)
* [Размер объекта в коллекции превышает 16 МБ](#object-size)
* [Не удалось найти ни одной таблицы](#no-tables)
* [Ошибка при трансфере шардированного кластера](#sharded)
* [Ошибка при переносе коллекций timeseries](#timeseries)
* [Не распознается IP-адрес или FQDN внешнего кластера](#cluster-config-issue)
* [Ошибка на стадии копирования](#history-lost)
* [Данные в источнике не подходят для шардирования](#cannot-get-delimiters)
* [Прерывание трансфера с ошибкой cursor.Decode returned error](#invalid-length)

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

### Размер ключа коллекции превышает 5 МБ {#string-size}

Текст ошибки:

```text
Warn(replication): Usage of bulk objects in 'database <имя_БД>'
breaks change event log, transfer is stopping.
Reason: (Location<номер_позиции>) Tried to create string longer than 16MB.
```

Если размер ключа коллекции превышает 5 МБ, трансферы типа _{{ dt-type-repl }}_ прерываются из-за внутренних ограничений {{ MG }} на размер пользовательских объектов.

**Решение:** [исключите](mongodb.md) из трансфера коллекции, превышающие лимиты {{ MG }}, после чего [активируйте](../../transfer.md#activate) трансфер повторно.

### Размер объекта в коллекции превышает 16 МБ {#object-size}

Текст ошибки:

```text
Warn(replication): Usage of bulk objects in 'collection '<имя_БД>.<имя_коллекции>''
breaks change event log, transfer is stopping.
Reason: (BSONObjectTooLarge) BSONObj size: <размер_объекта> (<размер_объекта_в_hex>) is invalid.
Size muse be between 0 and 16793600(16MB).
```

Если размер объекта в коллекции превышает 16 МБ, трансферы типа _{{ dt-type-repl }}_ прерываются из-за внутренних ограничений {{ MG }} на размер пользовательских объектов.

**Решение:** [исключите](mongodb.md) из трансфера коллекции, превышающие лимиты {{ MG }}, после чего [активируйте](../../transfer.md#activate) трансфер повторно.

### Не удалось найти ни одной таблицы {#no-tables}

Текст ошибки:

```text
Unable to find any tables
```

Из базы данных извлечено пустое число коллекций. Ошибка может возникать, если у пользователя нет прав на базу данных, используемую в трансфере.

**Решение:** выдайте пользователю, от имени которого трансфер подключается к источнику, права `readWrite` на базу данных для переноса.

### Ошибка при трансфере шардированного кластера {#sharded}

**Решение**: задайте в [параметре трансфера](../../transfer.md#update) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeRegularSnapshot.snapshot_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.SnapshotSettings.parallel_settings.title }}** количество [воркеров](../../../concepts/index.md#worker), равное количеству переносимых коллекций.

### Ошибка при переносе коллекций timeseries {#timeseries}

Тексты ошибок:

```text
Unable to find any tables
```

```text
Cannot execute mongo activate hook: 
Failed in accordance with configuration: 
some tables from include list are missing in the source database: [<имя_коллекции>]
```

Сервис не поддерживает перенос коллекций `Time Series`.

**Решение:** [исключите](mongodb.md#additional-settings) из трансфера коллекции Time Series, после чего [активируйте](../../transfer.md#activate) трансфер повторно.

### Не распознается IP-адрес или FQDN внешнего кластера {#cluster-config-issue}

Трансфер завершается с ошибкой:

```text
server selection error: server selection timeout, current topology: { Type: ReplicaSetNoPrimary, Servers: [{ Addr: <неразрешающееся_FQDN>, Type: Unknown, Last error: connection() error occurred during connection handshake: dial tcp: lookup <неразрешающееся_FQDN> on <IP-адрес>: no such host }, ] }"
```

Ошибка трансфера связана с конфигурацией кластера {{ MG }} (Managed Service for MongoDB). Например, когда в описании шардов используются внутренние не разрешающиеся имена.

**Решение:** 

Убедитесь, что кластер {{ MG }} сконфигурирован таким образом, чтобы на запросы к нему он возвращал корректно разрешающиеся IP-адреса или FQDN (Fully Qualified Domain Name).

### Ошибка на стадии копирования данных {#history-lost}

Трансфер типа _{{ dt-type-copy-repl }}_ на стадии копирования завершается с ошибкой:

```text
encountered non-recoverable resume token error. Sync cannot be resumed from this state and must be terminated and re-enabled to continue functioning: (ChangeStreamHistoryLost) Resume of change stream was not possible, as the resume point may no longer be in the oplog.
```

Ошибка `ChangeStreamHistoryLost` возникает, когда общее время копирования данных кластера-источника {{ MG }} (Managed Service for MongoDB) превышает размер временного окна журнала операций (oplog). Текущий размер временного окна можно проверить в консоли управления на графике **Oplog window** [страницы мониторинга кластера](../../../../storedoc/operations/monitoring.md).


**Решение:**

* Увеличьте размер oplog (по умолчанию 5 % от размера диска кластера). Чтобы увеличить размер oplog в кластере-источнике {{ mmg-name }}, обратитесь в [техническую поддержку]({{ link-console-support }}). Чтобы изменить размер oplog в случае пользовательской инсталляции источника, см. документацию {{ MG }}.
* Включите [параллельное копирование данных](../../../concepts/sharded.md) для ускорения стадии копирования.
* Ограничьте список объектов для переноса в [настройках трансфера](../../transfer.md#create).

После этого [активируйте](../../transfer.md#activate) трансфер повторно.

### Данные в источнике не подходят для шардирования {#cannot-get-delimiters}

Активация трансфера из источника {{ MG }}/{{ SD }} завершается с ошибкой:

```text
ERROR: Unable to Activate
error: "failed to execute mongo activate hook: Snapshot loading failed: unable to sharded upload tables: unable to sharded upload(main worker) tables: unable to shard tables for operation id_операции: unable to split table, err: cannot get delimiters: there are two or more types of objects in the sharding index"
```

Ошибка `cannot get delimiters: there are two or more types of objects in the sharding index` означает, что на источнике в коллекции в поле `id` встречаются данные разных типов, и поэтому его нельзя использовать для шардирования.

**Решение**:

Укажите в [настройках трансфера](../../transfer.md#update-copy-repl) **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeRegularSnapshot.snapshot_settings.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.SnapshotSettings.parallel_settings.title }}** 1 воркер и 1 поток, чтобы отключить шардирование.

После этого [активируйте](../../transfer.md#activate) трансфер повторно.

### Прерывание трансфера с ошибкой: cursor.Decode returned error {#invalid-length}

Текст ошибки:

```text
cursor.Decode returned error: invalid length
```

Такая ошибка может возникать при использовании типов бинарных данных `unsigned_byte(2) Binary` и `unsigned_byte(3) UUID`, которые в соответствии со [спецификацией BSON](https://bsonspec.org/spec.html) помечены как устаревшие (deprecated).

Пример использования типа `unsigned_byte(2) Binary`:

```text
Binary.createFromBase64('<строка в Base64>', 2)
```

**Решение:** Для корректной работы трансфера используйте бинарный подтип 0 вместо подтипа 2 и бинарный подтип 4 вместо подтипа 3.

Например, после замены выражения выше на `Binary.createFromBase64('<строка в Base64>', 0)` ошибка не возникает.