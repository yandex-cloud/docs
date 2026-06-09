# Передача данных в эндпоинт-приемник {{ MG }}/{{ SD }} (Managed Service for MongoDB)


С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные в базу {{ MG }}/{{ SD }} (Managed Service for MongoDB) и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте один из поддерживаемых источников данных](#supported-sources).
1. [Подготовьте базу данных {{ MG }}/{{ SD }} (Managed Service for MongoDB)](#prepare) к трансферу.
1. [Настройте эндпоинт-приемник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. [Выполняйте необходимые действия по работе с базой](#db-actions) и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных в {{ MG }}/{{ SD }} (Managed Service for MongoDB) {#scenarios}

1. Миграция — перенос данных из одного хранилища в другое. Часто это перенос базы из устаревших локальных баз в управляемые облачные.
    
    * [Миграция кластера {{ MG }}](../../../tutorials/storedoc.md);
    * [Миграция кластера {{ SD }} (Managed Service for MongoDB) с версии 4.4 на 6.0](../../../tutorials/storedoc-versions.md).

1. Поставка данных — процесс доставки произвольных данных в целевые хранилища. Процесс поставки включает извлечение данных из очереди и их десериализацию с последующей трансформацией данных в формат целевого хранилища.
    
    * [Поставка данных из {{ KF }} в {{ SD }} (Managed Service for MongoDB)](../../../tutorials/mkf-to-mmg.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} читайте в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [{{ MG }}/{{ SD }}](../source/mongodb.md);
* [{{ AB }}](../../../transfer-matrix.md#airbyte);
* [{{ DS }}](../source/data-streams.md);
* [{{ KF }}](../source/kafka.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} читайте в разделе [Доступные трансферы](../../../transfer-matrix.md).

## Подготовка базы данных приемника {#prepare}

{% list tabs %}

- {{ mmg-name }} (Managed Service for MongoDB)
    
    1. [Создайте базу данных](../../../../storedoc/operations/databases.md#add-db).
    1. [Создайте пользователя](../../../../storedoc/operations/cluster-users.md#adduser) с ролью [`readWrite`](../../../../storedoc/concepts/users-and-roles.md#readWrite) на созданную базу.
    1. Чтобы шардировать переносимые коллекции в кластере-приемнике {{ mmg-full-name }}:
        1. Следуя [инструкции](../../../../storedoc/tutorials/sharding.md), создайте и настройте в базе-приемнике пустые шардированные коллекции.
        
           Сервис {{ data-transfer-name }} не шардирует переносимые коллекции автоматически. Шардирование больших коллекций может занять продолжительное время и снизить скорость трансфера.
        
        1. Если шардирование происходит по ключу, отличному от `_id` (используется по умолчанию), [назначьте пользователю роль](../../../../storedoc/operations/cluster-users.md#updateuser) `mdbShardingManager`.
        
        1. При [создании эндпоинта для приемника](mongodb.md) выберите политику очистки `DISABLED` или `TRUNCATE`.
        
           Выбор политики `DROP` приведет к тому, что при активации трансфера сервис удалит из базы-приемника все данные, в т. ч. шардированные коллекции, и создаст вместо них новые, нешардированные.


- {{ MG }}
    
    1. Если вы не планируете использовать для подключения к внешнему кластеру [сервис {{ interconnect-name }}](../../../../interconnect/concepts/index.md) или [VPN](../../../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом {{ data-transfer-name }}](../../../../overview/concepts/public-ips.md#virtual-private-cloud}).
       
       Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../../../concepts/network.md#source-external).
    
    1. Убедитесь, что версия {{ MG }} на приемнике не ниже, чем на источнике.
    
    1. Убедитесь, что кластер {{ MG }} сконфигурирован таким образом, чтобы на запросы к нему он возвращал корректно разрешающиеся IP-адреса или FQDN (Fully Qualified Domain Name).
    
    1. Настройте кластер-приемник, чтобы к нему можно было подключиться из интернета:
        
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
    
    1. Если кластер-приемник не использует репликацию, включите ее:
        
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
    
    1. Подключитесь к кластеру и создайте базу-приемник:
    
        ```javascript
        use <имя_базы>
        ```
    
    1. Создайте пользователя с правами `readWrite` на базу-приемник:
    
        ```javascript
        use admin;
        db.createUser({
            user: "<имя_пользователя>",
            pwd: "<пароль>",
            mechanisms: ["SCRAM-SHA-1"],
            roles: [
                {
                    db: "<имя_базы-приемника>",
                    role: "readWrite"
                }
            ]
        });
        ```
    
       После старта трансфер подключится к приемнику от имени этого пользователя.
    
    1. Чтобы шардировать переносимые коллекции в кластере-приемнике:
        
        1. Подготовьте базу данных и создайте в ней пустые коллекции с теми же именами, что и на источнике.
        
           Сервис {{ data-transfer-name }} не шардирует переносимые коллекции автоматически. Шардирование больших коллекций может занять продолжительное время и снизить скорость трансфера.
        
        1. Включите шардирование для базы-приемника:
        
            ```javascript
            sh.enableSharding("<имя_базы-приемника>")
            ```
        
        1. Задайте шардирование для каждой коллекции с учетом ее пространства имен:
        
            ```javascript
            sh.shardCollection("<имя_базы-приемника>.<имя_коллекции>", { <имя_поля>: <1|"hashed">, ... });
            ```
           
        
        1. Чтобы убедиться в том, что шардирование настроено и включено, получите список доступных шардов:
        
            ```javascript
            sh.status()
            ```
        
        1. Если для шардирования используется ключ, отличный от `_id` (значение по умолчанию), назначьте системную роль `clusterManager` пользователю, от имени которого сервис {{ data-transfer-name }} будет подключаться к кластеру-приемнику:
        
            ```javascript
            use admin;
            db.grantRolesToUser("<имя_пользователя>", ["clusterManager"]);
            ```
        
        1. При [создании эндпоинта для приемника](mongodb.md) выберите политику очистки `DISABLED` или `TRUNCATE`.
        
           Выбор политики `DROP` приведет к тому, что при активации трансфера сервис удалит из базы-приемника все данные, в т. ч. шардированные коллекции, и создаст вместо них новые, нешардированные.


{% endlist %}

## Настройка эндпоинта-приемника {{ MG }}/{{ SD }} (Managed Service for MongoDB) {#endpoint-settings}

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

    * Тип эндпоинта — `mongo-target`.

    * `--cluster-id` — идентификатор кластера, к которому необходимо подключиться.
    * `--database` — имя базы данных.
    * `--user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    * `--security-group` — группы безопасности для сетевого трафика, правила которых применятся к ВМ и кластерам без изменения их настроек. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
    
    * Чтобы задать пароль пользователя для доступа к базе данных, используйте один из параметров:
    
        * `--raw-password` — пароль в текстовом виде.
        * `--password-file` — путь к файлу с паролем.

- {{ TF }} {#tf}

    * Тип эндпоинта — `mongo_target`.

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
        mongo_target {
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

Подключение к БД с явным указанием сетевых адресов и портов.

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

    * Тип эндпоинта — `mongo-target`.

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

    * Тип эндпоинта — `mongo_target`.

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
        mongo_target {
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

### Дополнительные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.database.title }}** — укажите имя базы данных. Если значение не указывать, будет использовано имя базы данных источника.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.cleanup_policy.title }}** — выберите способ очистки данных в базе-приемнике перед переносом:
      
      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}` — выберите эту опцию, если будет производиться только репликация без копирования данных.
      
      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}` — полное удаление таблиц, участвующих в трансфере (вариант по умолчанию).
      
          Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия схемы таблиц из источника.
      
      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}` — удалить только данные из таблиц, участвующих в трансфере, но оставить схему.
      
          Используйте эту опцию, если схема в базе-приемнике отличается от той, которая была бы перенесена из источника при трансфере.

- CLI {#cli}

    `--target-database` — укажите имя базы данных, если хотите создать коллекции в базе данных с именем, отличным от имени базы-источника.

- {{ TF }} {#tf}

    * `database` — укажите имя базы данных, если хотите создать коллекции в базе данных с именем, отличным от имени базы-источника.

    * `cleanup_policy` — укажите способ очистки данных в базе-приемнике перед переносом:
      
      * `DISABLED` — не очищать (вариант по умолчанию).
      
          Выберите эту опцию, если будет производиться только репликация без копирования данных.
      
      * `DROP` — полное удаление коллекций, участвующих в трансфере.
      
          Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия коллекции из источника.
      
      * `TRUNCATE` — удалить только данные из коллекций, участвующих в трансфере, но оставить сами коллекции.
      
          Используйте эту опцию, если структура коллекций в базе-приемнике отличается от той, которая была бы перенесена из источника при трансфере.

- API {#api}

    * `database` — укажите имя базы данных, если хотите создать коллекции в базе данных с именем, отличным от имени базы-источника.

    * `cleanupPolicy` — укажите способ очистки данных в базе-приемнике перед переносом:
      
      * `DISABLED` — не очищать (вариант по умолчанию).
      
          Выберите эту опцию, если будет производиться только репликация без копирования данных.
      
      * `DROP` — полное удаление коллекций, участвующих в трансфере.
      
          Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия коллекции из источника.
      
      * `TRUNCATE` — удалить только данные из коллекций, участвующих в трансфере, но оставить сами коллекции.
      
          Используйте эту опцию, если структура коллекций в базе-приемнике отличается от той, которая была бы перенесена из источника при трансфере.

{% endlist %}

{% note warning %}

По умолчанию сервис {{ data-transfer-name }} переносит коллекции без шардирования. Если вы переносите данные в шардированный кластер-приемник и хотите, чтобы коллекции шардировались:

1. [Подготовьте кластер-приемник](../../prepare.md#target-mg) для шардирования коллекций.
1. Выберите политику очистки `DISABLED` или `TRUNCATE`.

Выбор политики `DROP` приведет к тому, что при активации трансфера сервис удалит из базы-приемника все данные, в т. ч. шардированные коллекции, и создаст вместо них новые, нешардированные.

{% endnote %}

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

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

### Размер ключа коллекции превышает 5 МБ {#string-size}

Текст ошибки:

```text
Warn(replication): Usage of bulk objects in 'database <имя_БД>'
breaks change event log, transfer is stopping.
Reason: (Location<номер_позиции>) Tried to create string longer than 16MB.
```

Если размер ключа коллекции превышает 5 МБ, трансферы типа _{{ dt-type-repl }}_ прерываются из-за внутренних ограничений {{ MG }} на размер пользовательских объектов.

**Решение:** [исключите](../source/mongodb.md) из трансфера коллекции, превышающие лимиты {{ MG }}, после чего [активируйте](../../transfer.md#activate) трансфер повторно.

### Размер объекта в коллекции превышает 16 МБ {#object-size}

Текст ошибки:

```text
Warn(replication): Usage of bulk objects in 'collection '<имя_БД>.<имя_коллекции>''
breaks change event log, transfer is stopping.
Reason: (BSONObjectTooLarge) BSONObj size: <размер_объекта> (<размер_объекта_в_hex>) is invalid.
Size muse be between 0 and 16793600(16MB).
```

Если размер объекта в коллекции превышает 16 МБ, трансферы типа _{{ dt-type-repl }}_ прерываются из-за внутренних ограничений {{ MG }} на размер пользовательских объектов.

**Решение:** [исключите](../source/mongodb.md) из трансфера коллекции, превышающие лимиты {{ MG }}, после чего [активируйте](../../transfer.md#activate) трансфер повторно.

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

**Решение:** [исключите](../source/mongodb.md#additional-settings) из трансфера коллекции Time Series, после чего [активируйте](../../transfer.md#activate) трансфер повторно.

### Не распознается IP-адрес или FQDN внешнего кластера {#cluster-config-issue}

Трансфер завершается с ошибкой:

```text
server selection error: server selection timeout, current topology: { Type: ReplicaSetNoPrimary, Servers: [{ Addr: <неразрешающееся_FQDN>, Type: Unknown, Last error: connection() error occurred during connection handshake: dial tcp: lookup <неразрешающееся_FQDN> on <IP-адрес>: no such host }, ] }"
```

Ошибка трансфера связана с конфигурацией кластера {{ MG }} (Managed Service for MongoDB). Например, когда в описании шардов используются внутренние не разрешающиеся имена.

**Решение:** 

Убедитесь, что кластер {{ MG }} сконфигурирован таким образом, чтобы на запросы к нему он возвращал корректно разрешающиеся IP-адреса или FQDN (Fully Qualified Domain Name).