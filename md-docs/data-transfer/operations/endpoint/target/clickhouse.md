# Передача данных в эндпоинт-приемник {{ CH }}

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные в базу {{ CH }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте один из поддерживаемых источников данных](#supported-sources).
1. [Подготовьте базу данных {{ CH }}](#prepare) к трансферу.
1. [Настройте эндпоинт-приемник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. Выполняйте необходимые действия по работе с базой и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных в {{ CH }} {#scenarios}

1. Миграция — перенос данных из одного хранилища в другое. Часто это перенос базы из устаревших локальных баз в управляемые облачные.
    * [Миграция кластера {{ CH }}](../../../tutorials/managed-clickhouse.md);
    * [{#T}](../../../tutorials/opensearch-to-clickhouse.md)

1. Поставка данных — процесс доставки произвольных данных в целевые хранилища. Процесс поставки включает извлечение данных из очереди и их десериализацию с последующей трансформацией данных в формат целевого хранилища.
    * [Поставка данных из {{ KF }} в {{ CH }}](../../../tutorials/mkf-to-mch.md);
    * [Поставка данных из {{ DS }} в {{ CH }}](../../../tutorials/yds-to-clickhouse.md).

1. Загрузка данных в витрины — процесс трансфера подготовленных данных в хранилища с целью последующей визуализации.
    * [Загрузка данных {{ GP }} в {{ CH }}](../../../tutorials/greenplum-to-clickhouse.md);
    * [Загрузка данных {{ MY }} в {{ CH }}](../../../tutorials/mysql-to-clickhouse.md);
    * [Загрузка данных {{ metrika }} в {{ CH }}](../../../tutorials/metrika-to-clickhouse.md);
    * [Загрузка данных {{ yandex-direct }} в {{ CH }}](../../../tutorials/direct-to-mch.md);

    * [Загрузка данных {{ PG }} в {{ CH }}](../../../tutorials/rdbms-to-clickhouse.md);
    * [Загрузка данных из {{ objstorage-name }} в {{ CH }}](../../../tutorials/object-storage-to-clickhouse.md);
    * [Загрузка данных из {{ ydb-short-name }} в витрину {{ CH }}](../../../tutorials/ydb-to-clickhouse.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} читайте в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [{{ PG }}](../source/postgresql.md);
* [{{ MY }}](../source/mysql.md);
* [{{ CH }}](../source/clickhouse.md);
* [{{ GP }}](../source/greenplum.md);
* [{{ KF }}](../source/kafka.md);
* [{{ AB }}](../../../transfer-matrix.md#airbyte);
* [{{ metrika }}](../source/metrika.md);
* [{{ DS }}](../source/data-streams.md);
* [{{ objstorage-full-name }}](../source/object-storage.md);
* [{{ ytsaurus-name }}](../source/yt.md);
* [Oracle](../source/oracle.md);
* [{{ OS }}](../source/opensearch.md).

Полный список поддерживаемых источников и приемников в {{ data-transfer-full-name }} читайте в разделе [Доступные трансферы](../../../transfer-matrix.md).

{% note info %}

В {{ CH }} есть ограничения на диапазон дат. Наличие в базе-источнике неподдерживаемых дат может привести к [ошибке](#date-range) и остановке трансфера.

{% endnote %}

## Подготовка базы данных приемника {#prepare}

{% list tabs %}

- {{ mch-name }}

    1. [Создайте базу-приемник](../../../../managed-clickhouse/operations/databases.md#add-db).

       Если нужно перенести несколько баз данных, создайте для каждой из них отдельный трансфер.

    1. [Создайте пользователя](../../../../managed-clickhouse/operations/cluster-users.md#adduser) с доступом к базе приемника.

       После старта трансфер подключится к приемнику от имени этого пользователя.

    1. Если в кластере включено [управление пользователями через SQL](../../../../managed-clickhouse/operations/cluster-users.md#sql-user-management), выдайте созданному пользователю права:

        ```sql
        GRANT CLUSTER ON *.* TO <имя_пользователя>
        GRANT SELECT, INSERT, ALTER DELETE, CREATE TABLE, CREATE VIEW, DROP TABLE, TRUNCATE, dictGet ON <имя_базы_данных>.* TO <имя_пользователя>
        GRANT SELECT(macro, substitution) ON system.macros TO <имя_пользователя>
        ``` 

       Если управление пользователями через SQL выключено, [права назначаются](../../../../managed-clickhouse/operations/cluster-users.md) через консоль управления и CLI.

    1. [Создайте группу безопасности](../../../../vpc/operations/security-group-create.md) и [настройте ее](../../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).

    1. Назначьте кластеру {{ mch-name }} созданную группу безопасности.

- {{ CH }}

    1. Если вы не планируете использовать для подключения к внешнему кластеру [сервис {{ interconnect-name }}](../../../../interconnect/concepts/index.md) или [VPN](../../../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом {{ data-transfer-name }}](../../../../overview/concepts/public-ips.md#virtual-private-cloud}).
       
       Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../../../concepts/network.md#source-external).

    1. Создайте базу-приемник. Ее имя должно совпадать с именем базы-источника. Если нужно перенести несколько баз данных, создайте для каждой из них отдельный трансфер.

    1. Создайте пользователя с доступом к базе приемника.

       После старта трансфер подключится к приемнику от имени этого пользователя.

    1. Выдайте созданному пользователю права:

        ```sql
        GRANT CLUSTER ON *.* TO <имя_пользователя>
        GRANT SELECT, INSERT, ALTER DELETE, CREATE TABLE, CREATE VIEW, DROP TABLE, TRUNCATE, dictGet ON <имя_базы_данных>.* TO <имя_пользователя>
        GRANT SELECT(macro, substitution) ON system.macros TO <имя_пользователя>
        ```

{% endlist %}

## Настройка эндпоинта-приемника {{ CH }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mch-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

См. также [рекомендации по настройке эндпоинта](#recommended-settings-queue) при [поставке данных в {{ CH }} из очередей](#scenarios).

### Кластер {{ mch-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.mch.viewer }}`](../../../../managed-clickhouse/security.md#managed-clickhouse-viewer) или примитивная [роль `viewer`](../../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение к БД с указанием кластера в {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите вариант подключения к базе данных:
    
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}** — позволяет задать настройки подключения вручную.
    
        Выберите тип инсталляции **Кластер Managed Service for ClickHouse** и задайте настройки:
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}** — выберите кластер, к которому необходимо подключиться.
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.shard_group.title }}** — укажите группу шардов, в которую будут передаваться данные. Если значение не указано, данные передаются во все шарды.
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.database.title }}** — укажите имя базы данных в выбранном кластере.
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.password.title }}** — укажите пароль пользователя для доступа к базе данных.
    
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}** — позволяет подключиться к кластеру через [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):
    
        * Выберите каталог, в котором находится кластер {{ mch-name }}.
        * Выберите тип инсталляции **Кластер управляемой БД** и задайте настройки:
    
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.mdb_cluster_id.title }}** — выберите кластер, к которому необходимо подключиться.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}** — выберите подключение в {{ connection-manager-name }} или создайте его.
    
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.database.title }}** — укажите имя базы данных в выбранном кластере.
    
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.shard_group.title }}** — укажите группу шардов, в которую будут передаваться данные. Если значение не указано, данные передаются во все шарды.
    
        {% note warning %}
        
        Чтобы использовать подключение из {{ connection-manager-name }}, у пользователя должны быть [права доступа](../../../../metadata-hub/operations/connection-access.md) не ниже `connection-manager.user` к этому подключению.
        
        {% endnote %}
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика. Это позволит применить указанные правила групп безопасности к ВМ и кластерам в выбранной сети без изменения их настроек. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
    
      Убедитесь, что выбранные группы безопасности [настроены](../../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).

- CLI {#cli}

    * Тип эндпоинта — `clickhouse-target`.

    * `--cluster-id` — идентификатор кластера, к которому необходимо подключиться.
    * `--cluster-name` — группа шардов, в которую будут передаваться данные. Если параметр не указан, данные будут размещены во всех шардах.
    * `--database` — имя базы данных.
    * `--user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    * `--security-group` — группы безопасности для сетевого трафика, правила которых применятся к ВМ и кластерам без изменения их настроек. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
    
        Убедитесь, что указанные группы безопасности [настроены](../../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).
    
    
    * Чтобы задать пароль пользователя для доступа к базе данных, используйте один из параметров:
    
        * `--raw-password` — пароль в текстовом виде.
        * `--password-file` — путь к файлу с паролем.

- {{ TF }} {#tf}

    * Тип эндпоинта — `clickhouse_target`.

    * `connection.connection_options.mdb_cluster_id` — идентификатор кластера, к которому необходимо подключиться.
    * `clickhouse_cluster_name` — группа шардов, в которую будут передаваться данные. Если параметр не указан, данные будут размещены во всех шардах.
    * `subnet_id` — идентификатор [подсети](../../../../vpc/concepts/network.md#subnet), в которой находится кластер. Трансфер будет использовать эту подсеть для доступа к кластеру. Если идентификатор не указан, то кластер должен быть доступен из интернета.
      
      Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.
    * `security_groups` — [группы безопасности](../../../../vpc/concepts/security-groups.md) для сетевого трафика.
      
      Правила групп безопасности применяются к трансферу. Они позволяют открыть сетевой доступ с ВМ трансфера к кластеру. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
      
      Группы безопасности и подсеть `subnet_id`, если она указана, должны принадлежать той же сети, в которой размещен кластер.
      
      {% note info %}
      
      В {{ TF }} сеть для групп безопасности задавать не нужно.
      
      {% endnote %}
    
       Убедитесь, что указанные группы безопасности [настроены](../../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).
    
    * `connection.connection_options.database` — имя базы данных.
    * `connection.connection_options.user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    * `connection.connection_options.password.raw` — пароль в текстовом виде.

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        clickhouse_target {
          clickhouse_cluster_name="<группа_шардов>"
          security_groups = ["<список_идентификаторов_групп_безопасности>"]
          subnet_id       = "<идентификатор_подсети>"
          connection {
            connection_options {
              mdb_cluster_id = "<идентификатор_кластера>"
              database       = "<имя_переносимой_базы_данных>"
              user           = "<имя_пользователя_для_подключения>"
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
    
       Убедитесь, что указанные группы безопасности [настроены](../../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).
    
    * `mdbClusterId` — идентификатор кластера, к которому необходимо подключиться.
    * `clickhouseClusterName` — группа шардов, в которую будут передаваться данные. Если параметр не указан, данные будут размещены во всех шардах.
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
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseOnPremise.shards.title }}**
          
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShard.shard_name.title }}** — укажите строку, которая позволит сервису отличать шарды друг от друга. Если в пользовательской инсталляции шардирование выключено, укажите произвольное имя.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShard.hosts.title }}** — укажите FQDN или IP-адреса хостов, входящих в шард.
        * **Кластер** — укажите имя кластера, из которого будут передаваться данные. Если параметр не указан, будут передаваться данные из кластера по умолчанию (макрос `{cluster}`).
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseOnPremise.http_port.title }}** — укажите номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения.
          
          При подключении через HTTP-порт:
          
          * Для необязательных полей используются значения по умолчанию, если они заданы.
          * Поддерживается запись сложных типов (`array`, `tuple` и т. д.).
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseOnPremise.native_port.title }}** — укажите номер нативного порта, который сервис {{ data-transfer-name }} будет использовать для подключения.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseOnPremise.ssl_enabled.title }}** — включите, если кластер поддерживает только шифрованные соединения.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseOnPremise.pem_file_content.title }}** — если требуется шифрование передаваемых данных, например для соответствия требованиям PCI DSS, загрузите файл [сертификата](../../../../managed-clickhouse/operations/connect/index.md#get-ssl-cert) или добавьте его содержимое в текстовом виде.
          
          {% note warning %}
          
          Если не добавить сертификат, трансфер может [завершиться ошибкой](../../../troubleshooting/index.md#failed-to-connect).
          
          {% endnote %}
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.database.title }}** — укажите имя базы данных в выбранном кластере.
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseOnPremise.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md). Трансфер будет использовать эту подсеть для доступа к кластеру.
    
          Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.password.title }}** — укажите пароль пользователя для доступа к базе данных.
    
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}** — позволяет подключиться к базе данных через [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):
    
        * Выберите каталог, в котором создано подключение {{ connection-manager-name }}.
        * Выберите тип инсталляции **Пользовательская инсталляция** и задайте настройки:
    
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}** — выберите подключение в {{ connection-manager-name }} или создайте его.
    
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.database.title }}** — укажите имя базы данных в выбранном кластере.
    
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseOnPremise.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md). Трансфер будет использовать эту подсеть для доступа к кластеру.
    
            Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.
    
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.shard_group.title }}** — укажите группу шардов, в которую будут передаваться данные. Если значение не указано, данные передаются во все шарды.
    
        {% note warning %}
        
        Чтобы использовать подключение из {{ connection-manager-name }}, у пользователя должны быть [права доступа](../../../../metadata-hub/operations/connection-access.md) не ниже `connection-manager.user` к этому подключению.
        
        {% endnote %}
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.
    
      Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).

- CLI {#cli}

    * Тип эндпоинта — `clickhouse-target`.

    * `--cluster-name` — имя кластера, в который будут передаваться данные.
    * `--host` — список IP-адресов или FQDN хостов, к которым необходимо подключиться, в формате `{имя_шарда}:{IP-адрес_или_FQDN_хоста}`. Если в пользовательской инсталляции шардирование выключено, укажите произвольное имя шарда.
    * `http-port` — номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения по HTTP.
    * `native-port` — номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения к нативному интерфейсу {{ CH }}.
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

    * Тип эндпоинта — `clickhouse_target`.

    * Настройки шардов:
      
      * `connection.connection_options.on_premise.shards.name` — имя шарда, с помощью которого сервис сможет отличать шарды друг от друга. Если в пользовательской инсталляции шардирование выключено, укажите произвольное имя.
      * `connection.connection_options.on_premise.shards.hosts` — укажите FQDN или IP-адреса хостов, входящих в шард.
    * `connection.connection_options.on_premise.http_port` — номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения по HTTP.
    * `connection.connection_options.on_premise.native_port` — номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения к нативному интерфейсу {{ CH }}.
    * `connection.connection_options.on_premise.tls_mode.enabled.ca_certificate` — сертификат CA, если требуется шифрование передаваемых данных, например, для соответствия требованиям PCI DSS.
      
      {% note warning %}
      
      Если не добавить сертификат, трансфер может [завершиться ошибкой](../../../troubleshooting/index.md#failed-to-connect).
      
      {% endnote %}
    * `clickhouse_cluster_name` — имя кластера, в который будут передаваться данные.
    * `subnet_id` — идентификатор [подсети](../../../../vpc/concepts/network.md#subnet), в которой находится кластер. Трансфер будет использовать эту подсеть для доступа к кластеру. Если идентификатор не указан, то кластер должен быть доступен из интернета.
      
      Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.
    * `security_groups` — [группы безопасности](../../../../vpc/concepts/security-groups.md) для сетевого трафика.
      
      Правила групп безопасности применяются к трансферу. Они позволяют открыть сетевой доступ с ВМ трансфера к ВМ с базой данных. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
      
      Группы безопасности должны принадлежать той же сети, что и подсеть `subnet_id`, если она указана.
      
      {% note info %}
      
      В {{ TF }} сеть для групп безопасности задавать не нужно.
      
      {% endnote %}
    * `connection.connection_options.database` — имя базы данных.
    * `connection.connection_options.user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    * `connection.connection_options.password.raw` — пароль в текстовом виде.

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        clickhouse_target {
          clickhouse_cluster_name="<имя_кластера>"
          security_groups = ["<список_идентификаторов_групп_безопасности>"]
          subnet_id       = "<идентификатор_подсети>"
          connection {
            connection_options {
              on_premise {
                http_port   = "<порт_для_подключения_по_HTTP>"
                native_port = "<порт_для_подключения_к_нативному_интерфейсу>"
                shards {
                  name  = "<имя_шарда>"
                  hosts = [ "список IP-адресов или FQDN хостов шарда" ]
                }
                tls_mode {
                  enabled {
                    ca_certificate = "<сертификат_в_формате_PEM>"
                  }
                }
              }
              database = "<имя_переносимой_базы_данных>"
              user     = "<имя_пользователя_для_подключения>"
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
        * `shards` – настройки шардов:
          
          * `name` — имя шарда, с помощью которого сервис сможет отличать шарды друг от друга. Если в пользовательской инсталляции шардирование выключено, укажите произвольное имя.
          * `hosts` — укажите FQDN или IP-адреса хостов, входящих в шард.
        * `httpPort` — номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения по HTTP.
        * `nativePort` — номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения к нативному интерфейсу {{ CH }}.
        * `tlsMode` — параметры шифрования передаваемых данных, если оно требуется, например для соответствия требованиям PCI DSS.
            * `disabled` — отключено.
            * `enabled` — включено
                * `caCertificate` — сертификат CA.
          
                  {% note warning %}
                  
                  Если не добавить сертификат, трансфер может [завершиться ошибкой](../../../troubleshooting/index.md#failed-to-connect).
                  
                  {% endnote %}
        * `subnetId` — идентификатор подсети, в которой находится хост. Трансфер будет использовать эту подсеть для доступа к хосту.
    * `clickhouseClusterName` — имя кластера, в который будут передаваться данные.
    * `securityGroups` — группы безопасности для сетевого трафика, правила которых применятся к ВМ и кластерам без изменения их настроек. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
    * `database` — имя базы данных.
    * `user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    * `password.raw` — пароль пользователя для доступа к базе данных (в текстовом виде).

{% endlist %}

### Дополнительные настройки {#additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.cleanup_policy.title }}** — выберите способ очистки данных в базе-приемнике перед переносом:
      
      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}` — выберите эту опцию, если будет производиться только репликация без копирования данных.
      
      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}` — полное удаление таблиц, участвующих в трансфере (вариант по умолчанию).
      
          Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия схемы таблиц из источника.
      
      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}` — удалить только данные из таблиц, участвующих в трансфере, но оставить схему.
      
          Используйте эту опцию, если схема в базе-приемнике отличается от той, которая была бы перенесена из источника при трансфере.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.sharding_settings.title }}** — задайте настройки для [шардирования](../../../../managed-clickhouse/concepts/sharding.md):
      
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.no_sharding.title }}** — шардирование не используется.
      
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.sharding_by_column.title }}** — имя колонки в таблицах, по которой следует шардировать данные. Равномерное распределение по шардам будет определяться хешем значения этой колонки. Укажите имя колонки для шардирования в соответствующем поле.
      
          Для шардирования по конкретным значениям колонки укажите их в поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingByTransferID.transfer_to_shard.array_item_label }}**. Это поле определяет соответствие значений колонки и индекса шарда (порядковый номер шарда в отсортированном по именам списке шардов) для шардирования по конкретным значениям данных.
      
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.sharding_by_transfer_id.title }}** — данные по шардам будут распределяться на основе значения идентификатора трансфера. При этом трансфер игнорирует настройку **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingByTransferID.transfer_to_shard.title }}** и шардирует данные только по идентификатору трансфера.
      
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseShardingSettingsOneof.sharding_by_round_robin.title }}** — данные по шардам будут распределяться случайным образом (количество данных на каждом шарде будет примерно одинаковым).
      
        {% note warning %}
      
        Для трансферов из {{ CH }} в {{ CH }} шардирование не поддерживается.
      
        Возможное обходное решение: создайте на кластере-приемнике распределенную таблицу и выполните трансфер в нее, выбрав политику очистки `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}` или `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}`.
      
        {% endnote %}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.advanced_settings.title }}** — задайте расширенные настройки:
      
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTargetAdvancedSettings.alt_names.title }}** — при необходимости задайте настройки переименования таблиц при трансфере.
      
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTargetAdvancedSettings.flush_interval.title }}** — укажите задержку, с которой данные должны поступать в кластер-приемник. Увеличьте значение в этом поле, если {{ CH }} не успевает делать слияние кусков данных.
      
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTargetAdvancedSettings.retry_failed_toasts_in_batch_as_sequential_upserts.title }}** — выберите для трансферов из {{ ydb-name }} с режимом [потока изменений](https://ydb.tech/docs/en/concepts/cdc) `UPDATES` и для трансферов типа `Increment Only`, которые переносят события по документам, не находящимся в приемнике {{ CH }}. Используйте только при необходимости, так как последовательная вставка `UPSERT` ведет к ухудшению производительности.
      
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTargetAdvancedSettings.is_schema_migration_disabled.title }}** — выберите, чтобы не изменять схему данных на приемнике при изменении ее на источнике. По умолчанию при изменении схемы на источнике трансфер будет автоматически применять изменения схемы в приемнике: создавать новые таблицы, добавлять новые колонки, добавлять новые перечисляемые значения и перечисляемые типы. По умолчанию не применяются такие изменения, как удаление таблиц или колонок.

- CLI {#cli}

    * `--alt-name` — правила переименования таблиц базы-источника при переносе в базу-приемник. Значения указываются в формате `<имя_таблицы_в_источнике>:<имя_таблицы_в_приемнике>`.

    * Настройки [шардирования](../../../../managed-clickhouse/concepts/sharding.md) данных:

        * `--shard-by-column-hash` — имя колонки в таблицах, по которой следует шардировать данные. Равномерное распределение по шардам будет определяться хешем значения этой колонки.

        * `--custom-sharding-column-name`— имя колонки в таблицах, по которой следует шардировать данные. Шардирование выполняется по значениям колонки, заданным с помощью настройки `--custom-sharding-mapping-string`.

        * `--custom-sharding-mapping-string` — сопоставление значений колонки, указанной в настройке `--custom-sharding-column-name`, и шардов. Значения настройки указываются в формате `<значение_колонки>:<имя_шарда>`.

        * `--shard-by-transfer-id` — Данные по шардам будут распределяться на основе значения идентификатора трансфера. Параметр не содержит значения.

        Вы можете указать только один из вариантов шардирования:

        * `--shard-by-column-hash`;
        * `--custom-sharding-column-name` и `--custom-sharding-mapping-string`;
        * `--shard-by-transfer-id`.

- {{ TF }} {#tf}

    * `cleanup_policy` — способ очистки данных в базе-приемнике перед переносом:
      
      * `CLICKHOUSE_CLEANUP_POLICY_DISABLED` — не очищать (вариант по умолчанию).
      
          Выберите эту опцию, если будет производиться только репликация без копирования данных.
      
      * `CLICKHOUSE_CLEANUP_POLICY_DROP` — полное удаление таблиц, участвующих в трансфере.
      
          Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия схемы таблиц из источника.
      
      * `CLICKHOUSE_CLEANUP_POLICY_TRUNCATE` — удалить только данные из таблиц, участвующих в трансфере, но оставить схему.
      
          Используйте эту опцию, если схема в базе-приемнике отличается от той, которая была бы перенесена из источника при трансфере.

    * `alt_names` — правила переименования таблиц базы-источника при переносе в базу-приемник:
      
      * `from_name` — имя таблицы в источнике.
      * `to_name` — имя таблицы в приемнике.

    * Настройки [шардирования](../../../../managed-clickhouse/concepts/sharding.md) данных:

        * `sharding.column_value_hash.column_name` — имя колонки в таблицах, по которой следует шардировать данные. Равномерное распределение по шардам будет определяться хешем значения этой колонки.

        * `sharding.transfer_id` — данные по шардам распределяются на основе значения идентификатора трансфера. Блок `transfer_id` не содержит параметров.

        * `sharding.custom_mapping` — шардирование по значению колонки:
          
          * `column_name` — имя колонки в таблицах, по которой следует шардировать данные.
          
          * `mapping` — сопоставление значений колонки и шардов:
          
              * `column_value.string_value` — значение колонки.
              * `shard_name` — имя шарда.

        * `sharding.round_robin` — данные по шардам будут распределяться случайным образом (количество данных на каждом шарде будет примерно одинаковым). Блок `round_robin` не содержит параметров.

        Вы можете указать только один из вариантов шардирования: `sharding.column_value_hash.column_name`, `sharding.transfer_id`, `sharding.custom_mapping` или `sharding.round_robin`. Если вариант шардирования не указан, то все данные переносятся в один шард.

    * `is_schema_migration_disabled` — установите значение `true`, чтобы не изменять схему данных на приемнике при изменении ее на источнике. По умолчанию при изменении схемы на источнике трансфер будет автоматически применять изменения схемы в приемнике: создавать новые таблицы, добавлять новые колонки, добавлять новые перечисляемые значения и перечисляемые типы. По умолчанию не применяются такие изменения, как удаление таблиц или колонок.

- API {#api}

    * `altNames` — правила переименования таблиц базы-источника при переносе в базу-приемник.
      
      * `fromName` — имя таблицы в источнике.
      * `toName` — имя таблицы в приемнике.

    * `cleanupPolicy` — способ очистки данных в базе-приемнике перед переносом:
      
      * `CLICKHOUSE_CLEANUP_POLICY_DISABLED` — не очищать (вариант по умолчанию).
      
          Выберите эту опцию, если будет производиться только репликация без копирования данных.
      
      * `CLICKHOUSE_CLEANUP_POLICY_DROP` — полное удаление таблиц, участвующих в трансфере.
      
          Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия схемы таблиц из источника.
      
      * `CLICKHOUSE_CLEANUP_POLICY_TRUNCATE` — удалить только данные из таблиц, участвующих в трансфере, но оставить схему.
      
          Используйте эту опцию, если схема в базе-приемнике отличается от той, которая была бы перенесена из источника при трансфере.

    * `sharding` — настройки для [шардирования](../../../../managed-clickhouse/concepts/sharding.md) данных. Вы можете указать только один из вариантов шардирования:
      
      * `columnValueHash.columnName` — имя колонки в таблицах, по которой следует шардировать данные. Равномерное распределение по шардам будет определяться хешем значения этой колонки.
      
      * `customMapping` — шардирование по значению колонки:
      
          * `columnName` — имя колонки в таблицах, по которой следует шардировать данные.
      
          * `mapping` — сопоставление значений колонки и шардов:
      
              * `columnValue.stringValue` — значение колонки.
              * `shardName` — имя шарда.
      
      * `transferId` — данные по шардам будут распределяться на основе значения идентификатора трансфера. Параметр не содержит значения.
      
      * `roundRobin` — данные по шардам будут распределяться случайным образом (количество данных на каждом шарде будет примерно одинаковым). Параметр не содержит значения.
      
      Если вариант шардирования не указан, то все данные переносятся в один шард.

{% endlist %}

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Рекомендации по настройке эндпоинтов {#recommended-settings-queue}

Для ускорения поставки большого объема данных в {{ CH }} из очередей {{ yds-name }} или {{ mkf-name }} укажите специальные настройки эндпоинтов:

{% list tabs group=instructions %}

- Консоль управления {#console}

    * Если в кластере-приемнике {{ CH }} включено шардирование и перенос выполняется в шардированную таблицу, используйте для записи данных [нижележащую таблицу](../../../../managed-clickhouse/tutorials/sharding.md) на движке `ReplicatedMergeTree`, а не распределенную таблицу на движке `Distributed`. При этом выполняйте выборку перенесенных данных в приемнике из распределенной таблицы. Чтобы переопределить таблицу для записи, укажите ее в настройке приемника **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTargetAdvancedSettings.alt_names.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.AltName.to_name.title }}**.
    * Если в источнике вы выбрали формат JSON в опции **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceAdvancedSettings.converter.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.format.title }}**, то в схеме данных для строковых типов указывайте `UTF-8` вместо `STRING`.
    * При выборе опции **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.add_rest_column.title }}** учитывайте, что это может привести к снижению скорости трансфера.
    * Если нужно перенести несколько топиков, укажите в настройке приемника **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTargetAdvancedSettings.alt_names.title }}** для всех имен топиков источника одинаковое имя таблицы {{ CH }}.

- CLI {#cli}

    * Если в кластере-приемнике {{ CH }} включено шардирование и перенос выполняется в шардированную таблицу, используйте для записи данных [нижележащую таблицу](../../../../managed-clickhouse/tutorials/sharding.md) на движке `ReplicatedMergeTree`, а не распределенную таблицу на движке `Distributed`. При этом выполняйте выборку перенесенных данных в приемнике из распределенной таблицы. Чтобы переопределить таблицу для записи, укажите ее в настройке приемника `--alt-name`.
    * Если нужно перенести несколько топиков, укажите в атрибуте `--alt-name` эндпоинта-приемника для всех топиков источника одно и то же имя таблицы {{ CH }} приемника.

- {{ TF }} {#tf}

    * Если в кластере-приемнике {{ CH }} включено шардирование и перенос выполняется в шардированную таблицу, используйте для записи данных [нижележащую таблицу](../../../../managed-clickhouse/tutorials/sharding.md) на движке `ReplicatedMergeTree`, а не распределенную таблицу на движке `Distributed`. При этом выполняйте выборку перенесенных данных в приемнике из распределенной таблицы. Чтобы переопределить таблицу для записи, укажите ее в настройке приемника `alt_names.to_name`.
    * Если в источнике вы выбрали формат JSON в блоке `parser.json_parser`:
      * В схеме данных `parser.json_parser.data_schema` для строковых типов указывайте `UTF-8` вместо `STRING`.
      * В случае атрибута `parser.json_parser.add_rest_column=true` скорость трансфера может снизиться.
    * Если нужно перенести несколько топиков, укажите в атрибуте `alt_names` эндпоинта-приемника для всех топиков в `alt_names.from_name` одно и то же имя таблицы {{ CH }} в `alt_names.to_name`.

- API {#api}

    * Если в кластере-приемнике {{ CH }} включено шардирование и перенос выполняется в шардированную таблицу, используйте для записи данных [нижележащую таблицу](../../../../managed-clickhouse/tutorials/sharding.md) на движке `ReplicatedMergeTree`, а не распределенную таблицу на движке `Distributed`. При этом выполняйте выборку перенесенных данных в приемнике из распределенной таблицы. Чтобы переопределить таблицу для записи, укажите ее в настройке приемника `altNames.toName`.
    * Если в источнике вы выбрали формат JSON в блоке `parser.jsonParser`:
      * В схеме данных `parser.jsonParser.dataSchema` для строковых типов указывайте `UTF-8` вместо `STRING`.
      * В случае параметра `parser.jsonParser.addRestColumn=true` скорость трансфера может снизиться.
    * Если нужно перенести несколько топиков, укажите в параметре `altNames` эндпоинта-приемника для всех топиков в `altNames.fromName` одно и то же имя таблицы {{ CH }} в `altNames.toName`.

{% endlist %}

## Решение проблем, возникающих при переносе данных {#troubleshooting}

* [Не добавляются новые таблицы](#no-new-tables)
* [Не переносятся данные](#no-transfer)
* [Неподдерживаемый диапазон дат](#date-range)
* [Нехватка ресурсов или растущая задержка передачи данных](#pod-restarted)
* [Превышение количества блоков данных](#partition-blocks)

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

### Не добавляются новые таблицы {#no-new-tables}

​В трансфер типа _{{ dt-type-copy-repl }}_ не добавляются новые таблицы.

**Решение:**

1. Создайте таблицы в базе-приемнике вручную. Чтобы трансфер работал, при создании таблицы:

    1. Добавьте в нее служебные поля трансфера:

        ```sql
        __data_transfer_commit_time timestamp,
        __data_transfer_delete_time timestamp
        ```

    1. Используйте движок `ReplacingMergeTree`:
        
        ```sql
        ENGINE = ReplacingMergeTree
        ```

1. [Создайте](../../transfer.md#create) отдельный трансфер типа _{{ dt-type-copy-repl }}_ и добавьте в список объектов для переноса только новые таблицы. При этом исходный трансфер типа _{{ dt-type-copy-repl }}_ можно не деактивировать. [Активируйте](../../transfer.md#activate) новый трансфер, а после перехода в статус {{ dt-status-repl }} [деактивируйте](../../transfer.md#deactivate) его.

   Чтобы добавить другие таблицы, замените ими список объектов для переноса в созданном отдельном трансфере, вновь активируйте его, а после перехода в статус {{ dt-status-repl }} деактивируйте.

   {% note info %}

   Так как два трансфера одновременно переносили данные, то в новых таблицах на приемнике присутствуют дубликаты записей. Чтобы скрыть их, выполните запрос `SELECT * from TABLE <имя_таблицы> FINAL`, а чтобы удалить — запрос `OPTIMIZE TABLE <имя_таблицы>`.

   {% endnote %}

### Неподдерживаемый диапазон дат {#date-range}

Если в переносимых данных есть даты вне поддерживаемых диапазонов, {{ CH }} возвращает ошибку:

```text
TYPE_ERROR [target]: failed to run (abstract1 source): failed to push items from 0 to 1 in batch:
Push failed: failed to push 1 rows to ClickHouse shard 0:
ClickHouse Push failed: Unable to exec changeItem: clickhouse:
dateTime <имя_поля> must be between 1900-01-01 00:00:00 and 2262-04-11 23:47:16
```

Поддерживаемые диапазоны дат в {{ CH }}:

* Для полей с типом `DateTime64` — с 1900-01-01 по 2299-12-31. Подробнее в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/sql-reference/data-types/datetime64).
* Для полей с типом `DateTime` — с 1970-01-01 по 2106-02-07. Подробнее в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/sql-reference/data-types/datetime).

**Решение:** используйте один из вариантов:

* Приведите все даты в базе-источнике к поддерживаемому в {{ CH }} диапазону.
* В [параметрах эндпоинта-источника](../index.md#update) исключите таблицу с некорректными датами из трансфера.
* В [параметрах трансфера](../../transfer.md#update) укажите трансформер [{{ ui-key.yc-data-transfer.data-transfer.transfer.transfer.Transformer.convert_to_string.title }}](../../../concepts/data-transformation.md#convert-to-string). В этом случае при трансфере изменится тип поля.

### Нехватка ресурсов или растущая задержка передачи данных {#pod-restarted}

При переносе данных в приемник {{ CH }} могут возникнуть следующие проблемы:

1. Трансфер прерывается с ошибкой. Текст ошибки:

    ```text
    pod instance restarted
    ```

1. В [мониторинге состояния трансфера](../../monitoring.md) наблюдается растущая задержка передачи данных (разница между временем появления записей на приемнике и временем их появления на источнике).

Возможная причина:

Слишком большой интервал записи в настройках эндпоинта-приемника, что вызывает нехватку оперативной памяти (OOM) на ВМ трансфера.

**Решение:**

Установите в консоли управления значение настройки эндпоинта-приемника **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTargetAdvancedSettings.flush_interval.title }}** равным 10 секунд или меньше.

Дополнительно в случае трансфера типа {{ dt-type-copy }} [активируйте](../../transfer.md#activate) его повторно. Трансферы других типов перезапустятся автоматически.

### Превышение количества блоков данных {#partition-blocks}

При переносе данных в приемник {{ CH }} трансфер прерывается с ошибкой. Текст ошибки:

```text
ERROR Unable to Activate ... 
unable to upload tables: unable to upload data objects: unable upload part <имя таблицы> (): 
unable to start \*clickhouse.HTTPSource event source: failed to push events to destination: 
unable to push http batch: <имя таблицы>: failed: INSERT INTO ...
```

Дополнительно может выводиться ошибка:

```text
pod instance restarted
```

Ошибки возникают при попытке вставить в базу-приемник {{ CH }} больше блоков данных, чем позволяет настройка `max_partitions_per_insert_block`.

**Решение:** увеличьте параметр `max_partitions_per_insert_block` для учетной записи, под которой трансфер подключается к приемнику. Для приемника {{ mch-name }} параметр можно изменить в [настройках пользователя](../../../../managed-clickhouse/concepts/settings-list.md#setting-partitions-per-insert-block). Для пользовательской инсталляции {{ CH }} можно создать профиль настроек и назначить его учетной записи:

```sql
CREATE SETTINGS PROFILE max_partitions
SETTINGS max_partitions_per_insert_block = <значение_настройки>

ALTER USER <имя_пользователя> PROFILE 'max_partitions'
```

_{{ CH }} является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._