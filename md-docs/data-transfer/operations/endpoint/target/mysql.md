# Передача данных в эндпоинт-приемник {{ MY }}

С помощью сервиса {{ data-transfer-full-name }} вы можете переносить данные в базу {{ MY }} и реализовывать различные сценарии переноса, обработки и трансформации данных. Для реализации трансфера:

1. [Ознакомьтесь с возможными сценариями передачи данных](#scenarios).
1. [Настройте один из поддерживаемых источников данных](#supported-sources).
1. [Подготовьте базу данных {{ MY }}](#prepare) к трансферу.
1. [Настройте эндпоинт-приемник](#endpoint-settings) в {{ data-transfer-full-name }}.
1. [Создайте](../../transfer.md#create) и [запустите](../../transfer.md#activate) трансфер.
1. [Выполняйте необходимые действия по работе с базой](#db-actions) и [контролируйте трансфер](../../monitoring.md).
1. При возникновении проблем, [воспользуйтесь готовыми решениями](#troubleshooting) по их устранению.

## Сценарии передачи данных в {{ MY }} {#scenarios}

1. Миграция — перенос данных из одного хранилища в другое. Часто это перенос базы из устаревших локальных баз в управляемые облачные.
  
   * [Миграция кластера {{ MY }}](../../../tutorials/managed-mysql-to-mysql.md);
   * [Миграция со сменой хранилища: {{ PG }} в {{ MY }}](../../../tutorials/mpg-to-mmy.md).
   * [Миграция со сменой хранилища: {{ objstorage-name }} в {{ MY }}](../../../tutorials/objs-mmy-migration.md).

1. Поставка данных — процесс доставки произвольных данных в целевые хранилища. Процесс поставки включает извлечение данных из очереди и их десериализацию с последующей трансформацией данных в формат целевого хранилища.
  
   * [Поставка данных из {{ KF }} в {{ MY }}](../../../tutorials/mkf-to-mmy.md).

Подробное описание возможных сценариев передачи данных в {{ data-transfer-full-name }} читайте в разделе [Практические руководства](../../../tutorials/index.md).

## Настройка источника данных {#supported-sources}

Настройте один из поддерживаемых источников данных:

* [{{ PG }}](../source/postgresql.md);
* [{{ MY }}](../source/mysql.md);
* [{{ KF }}](../source/kafka.md);
* [{{ AB }}](../../../transfer-matrix.md#airbyte);
* [{{ DS }}](../source/data-streams.md);
* [{{ objstorage-full-name }}](../source/object-storage.md);
* [{{ ydb-name }}](../source/ydb.md).

## Подготовка базы данных приемника {#prepare}

{% list tabs %}

- {{ mmy-name }}
    
    1. Убедитесь, что мажорная версия {{ MY }} на приемнике не ниже версии на источнике.
    
    1. [Установите SQL Mode](../../../../managed-mysql/operations/update.md#change-mysql-config), который совпадает с источником.
    
    1. [Создайте пользователя](../../../../managed-mysql/operations/cluster-users.md#adduser) для подключения к приемнику.
        
        1. [Назначьте пользователю роль](../../../../managed-mysql/operations/grant.md#grant-role) `ALL_PRIVILEGES` для базы-приемника.

- {{ MY }}
    
    1. Если вы не планируете использовать для подключения к внешнему кластеру [сервис {{ interconnect-name }}](../../../../interconnect/concepts/index.md) или [VPN](../../../../glossary/vpn.md), разрешите подключения к такому кластеру из интернета с [IP-адресов, используемых сервисом {{ data-transfer-name }}](../../../../overview/concepts/public-ips.md#virtual-private-cloud}).
       
       Подробнее о настройке сети для работы с внешними ресурсами читайте в [концепции](../../../concepts/network.md#source-external).
    
    1. Убедитесь, что мажорная версия {{ MY }} на приемнике не ниже версии на источнике.
    
    1. Убедитесь, что приемник использует подсистему хранения данных низкого уровня MyISAM или InnoDB.
    
    1. [Установите SQL Mode](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting), который совпадает с источником.
    
    1. Создайте пользователя для подключения к приемнику и выдайте ему необходимые привилегии:
    
        ```sql
        CREATE USER '<имя_пользователя>'@'%' IDENTIFIED BY '<пароль>';
        GRANT ALL PRIVILEGES ON <имя_базы>.* TO '<имя_пользователя>'@'%';
        ```

{% endlist %}

## Настройка эндпоинта-приемника {{ MY }} {#endpoint-settings}

При [создании](../index.md#create) или [изменении](../index.md#update) эндпоинта вы можете задать:

* Настройки подключения к [кластеру {{ mmy-full-name }}](#managed-service) или [пользовательской инсталляции](#on-premise), в т. ч. на базе виртуальных машин {{ compute-full-name }}. Эти параметры обязательные.
* [Дополнительные параметры](#additional-settings).

### Кластер {{ mmy-name }} {#managed-service}


{% note warning %}

Для создания или редактирования эндпоинта управляемой базы данных вам потребуется [роль `{{ roles.mmy.viewer }}`](../../../../managed-mysql/security/index.md#mmy-viewer) или примитивная [роль `viewer`](../../../../iam/roles-reference.md#viewer), выданная на каталог кластера этой управляемой базы данных.

{% endnote %}


Подключение к БД с указанием кластера в {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите вариант подключения к базе данных:
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}** — позволяет задать настройки подключения вручную.
    
            Выберите тип инсталляции **Кластер Managed Service for MySQL** и задайте настройки:
    
            * **Кластер управляемой БД** — выберите кластер, к которому необходимо подключиться.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — укажите имя базы данных в выбранном кластере.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.password.title }}** — укажите пароль пользователя для доступа к базе данных.
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}** — позволяет использовать управляемое подключение к базе данных через [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):
    
            * Выберите каталог, в котором находится кластер {{ mmy-name }}.
            * Выберите тип инсталляции **Кластер управляемой БД** и задайте настройки:
    
                * **Кластер управляемой БД** — выберите кластер, к которому необходимо подключиться.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}** — укажите идентификатор управляемого подключения в {{ connection-manager-name }}.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — укажите имя базы данных в выбранном кластере.
    
            {% note warning %}
            
            Чтобы использовать подключение из {{ connection-manager-name }}, у пользователя должны быть [права доступа](../../../../metadata-hub/operations/connection-access.md) не ниже `connection-manager.user` к этому подключению.
            
            {% endnote %}
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.
      
      Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).

- CLI {#cli}

    * Тип эндпоинта — `mysql-target`.

    * `--cluster-id` — идентификатор кластера, к которому необходимо подключиться.
    * `--database` — имя базы данных. Оставьте поле пустым, если хотите создать таблицы в базах данных с теми же именами, что и на источнике. В этом случае явно задайте схему БД для служебных таблиц в [дополнительных настройках](mysql.md#additional-settings).
    * `--user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    
    * Чтобы задать пароль пользователя для доступа к базе данных, используйте один из параметров:
    
        * `--raw-password` — пароль в текстовом виде.
        * `--password-file` — путь к файлу с паролем.

- {{ TF }} {#tf}

    * Тип эндпоинта — `mysql_target`.

    * `security_groups` — [группы безопасности](../../../../vpc/concepts/security-groups.md) для сетевого трафика.
      
      Правила групп безопасности применяются к трансферу. Они позволяют открыть сетевой доступ с ВМ трансфера к кластеру. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
      
      Группы безопасности должны принадлежать той же сети, в которой размещен кластер.
      
      {% note info %}
      
      В {{ TF }} сеть для групп безопасности задавать не нужно.
      
      {% endnote %}
    * `connection.mdb_cluster_id` — идентификатор кластера, к которому необходимо подключиться.
    * `database` — имя базы данных. Оставьте поле пустым, если хотите создать таблицы в базах данных с теми же именами, что и на источнике. В этом случае явно задайте схему БД для служебных таблиц в [дополнительных настройках](mysql.md#additional-settings).
    * `user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    * `password.raw` — пароль в текстовом виде.

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        mysql_target {
          security_groups = ["<список_идентификаторов_групп_безопасности>"]
          connection {
            mdb_cluster_id = "<идентификатор_кластера>"
          }
          database = "<имя_переносимой_базы_данных>"
          user     = "<имя_пользователя_для_подключения>"
          password {
            raw = "<пароль_пользователя>"
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
    * `database` — имя базы данных. Оставьте поле пустым, если хотите создать таблицы в базах данных с теми же именами, что и на источнике. В этом случае явно задайте схему БД для служебных таблиц в [дополнительных настройках](mysql.md#additional-settings).
    * `user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    * `password.raw` — пароль пользователя для доступа к базе данных (в текстовом виде).

{% endlist %}

### Пользовательская инсталляция {#on-premise}

Для случая OnPremise все поля заполняются вручную.

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите вариант подключения к базе данных:
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}** — позволяет задать настройки подключения вручную.
    
            Выберите тип инсталляции **Пользовательская инсталляция** и задайте настройки:
    
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.OnPremiseMysql.host.title }}** — укажите IP-адрес или FQDN хоста, к которому необходимо подключиться.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.OnPremiseMysql.port.title }}** — укажите номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — укажите имя базы данных в пользовательской инсталляции.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.password.title }}** — укажите пароль пользователя для доступа к базе данных.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.OnPremiseMysql.ca_certificate.title }}** — загрузите файл [сертификата](../../../../managed-mysql/operations/connect/index.md#get-ssl-cert) или добавьте его содержимое в текстовом виде, если требуется шифрование передаваемых данных, например, для соответствия требованиям PCI DSS.
              
              {% note warning %}
              
              Если не добавить сертификат, трансфер может [завершиться ошибкой](../../../troubleshooting/index.md#failed-to-connect).
              
              {% endnote %}
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.OnPremiseMysql.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md). Трансфер будет использовать эту подсеть для доступа к источнику.
              
              Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.
    
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}** — позволяет использовать управляемое подключение к базе данных через [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):
    
            * Выберите каталог, в котором создано управляемое подключение {{ connection-manager-name }}.
            * Выберите тип инсталляции **Пользовательская инсталляция** и задайте настройки:
    
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}** — укажите идентификатор управляемого подключения в {{ connection-manager-name }}.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — укажите имя базы данных в пользовательской инсталляции.
                * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.OnPremiseMysql.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md). Трансфер будет использовать эту подсеть для доступа к источнику.
                  
                  Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.
    
            {% note warning %}
            
            Чтобы использовать подключение из {{ connection-manager-name }}, у пользователя должны быть [права доступа](../../../../metadata-hub/operations/connection-access.md) не ниже `connection-manager.user` к этому подключению.
            
            {% endnote %}
    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.
      
      Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).

- CLI {#cli}

    * Тип эндпоинта — `mysql-target`.

    * `--host` — IP-адрес или FQDN хоста-мастера, к которому необходимо подключиться.
    * `--port` — номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения.
    * `--ca-certificate` — сертификат CA, если требуется шифрование передаваемых данных, например для соответствия требованиям PCI DSS.
      
      {% note warning %}
      
      Если не добавить сертификат, трансфер может [завершиться ошибкой](../../../troubleshooting/index.md#failed-to-connect).
      
      {% endnote %}
    * `--subnet-id` — идентификатор подсети, в которой находится хост. Трансфер будет использовать эту подсеть для доступа к хосту.
    * `--database` — имя базы данных. Оставьте поле пустым, если хотите создать таблицы в базах данных с теми же именами, что и на источнике. В этом случае явно задайте схему БД для служебных таблиц в [дополнительных настройках](mysql.md#additional-settings).
    * `--user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    
    * Чтобы задать пароль пользователя для доступа к базе данных, используйте один из параметров:
    
        * `--raw-password` — пароль в текстовом виде.
        * `--password-file` — путь к файлу с паролем.

- {{ TF }} {#tf}

    * Тип эндпоинта — `mysql_target`.

    * `security_groups` — [группы безопасности](../../../../vpc/concepts/security-groups.md) для сетевого трафика.
      
      Правила групп безопасности применяются к трансферу. Они позволяют открыть сетевой доступ с ВМ трансфера к ВМ с базой данных. Подробнее читайте в разделе [{#T}](../../../concepts/network.md).
      
      Группы безопасности должны принадлежать той же сети, что и подсеть `subnet_id`, если она указана.
      
      {% note info %}
      
      В {{ TF }} сеть для групп безопасности задавать не нужно.
      
      {% endnote %}
    * `on_premise.hosts` — список IP-адресов или FQDN хостов, к которым необходимо подключиться. Так как поддерживается только список из одного элемента, укажите адрес хоста-мастера.
    * `on_premise.port` — номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения.
    * `on_premise.tls_mode.enabled.ca_certificate` — сертификат CA, если требуется шифрование передаваемых данных, например для соответствия требованиям PCI DSS.
      
      {% note warning %}
      
      Если не добавить сертификат, трансфер может [завершиться ошибкой](../../../troubleshooting/index.md#failed-to-connect).
      
      {% endnote %}
    * `on_premise.subnet_id` — идентификатор [подсети](../../../../vpc/concepts/network.md#subnet), в которой находится хост. Трансфер будет использовать эту подсеть для доступа к хосту.
    * `database` — имя базы данных. Оставьте поле пустым, если хотите создать таблицы в базах данных с теми же именами, что и на источнике. В этом случае явно задайте схему БД для служебных таблиц в [дополнительных настройках](mysql.md#additional-settings).
    * `user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    * `password.raw` — пароль в текстовом виде.

    Пример структуры конфигурационного файла:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<имя_эндпоинта_в_{{ TF }}>" {
      name = "<имя_эндпоинта>"
      settings {
        mysql_target {
          security_groups = ["<список_идентификаторов_групп_безопасности>"]
          connection {
            on_premise {
              hosts = ["<список_хостов>"]
              port  = <порт_для_подключения>
            }
          }
          database = "<имя_переносимой_базы_данных>"
          user     = "<имя_пользователя_для_подключения>"
          password {
            raw = "<пароль_пользователя>"
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
    * `database` — имя базы данных. Оставьте поле пустым, если хотите создать таблицы в базах данных с теми же именами, что и на источнике. В этом случае явно задайте схему БД для служебных таблиц в [дополнительных настройках](mysql.md#additional-settings).
    * `user` — имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.
    * `password.raw` — пароль пользователя для доступа к базе данных (в текстовом виде).

{% endlist %}

### Дополнительные настройки {#additional-settings}

{% note warning %}

Настройки **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTarget.cleanup_policy.title }}** и **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTargetAdvancedSettings.service_database.title }}** можно задать только через Консоль управления.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTarget.cleanup_policy.title }}** — выберите способ очистки данных в базе-приемнике перед переносом:

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}` — выберите эту опцию, если будет производиться только репликация без копирования данных.

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}` — полное удаление таблиц, участвующих в трансфере (вариант по умолчанию).

          Используйте эту опцию, чтобы при любой активации трансфера в базу-приемник всегда передавалась самая последняя версия схемы таблиц из источника.

      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}` — удалить только данные из таблиц, участвующих в трансфере, но оставить схему.

          Используйте эту опцию, если схема в базе-приемнике отличается от той, которая была бы перенесена из источника при трансфере.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.advanced_settings.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTargetAdvancedSettings.timezone.title }}** — укажите идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется локальная таймзона сервера.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTargetAdvancedSettings.sql_mode.title }}** — укажите настройки, переопределяющие [стандартное поведение {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html).

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTargetAdvancedSettings.skip_constraint_checks.title }}** — используется для ускорения репликации: настройки `FOREIGN_KEY_CHECKS` и `UNIQUE_CHECKS` устанавливаются в значение `0` (проверки не производятся).

            {% note warning %}
            
            Отключение проверки ограничений ускорит репликацию, но может привести к нарушению целостности данных при использовании каскадных операций.
            
            {% endnote %}

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlTargetAdvancedSettings.service_database.title }}** — укажите имя схемы, в которой будут созданы служебные таблицы, необходимые для обеспечения работы трансфера.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTargetAdvancedSettings.is_schema_migration_disabled.title }}** — выберите, чтобы не изменять схему данных на приемнике при изменении ее на источнике. По умолчанию при изменении схемы на источнике трансфер будет автоматически применять изменения схемы в приемнике: создавать новые таблицы, добавлять новые колонки, добавлять новые перечисляемые значения и перечисляемые типы. По умолчанию не применяются такие изменения, как удаление таблиц или колонок.

- CLI {#cli}

    * `--sql-mode` — укажите настройки, переопределяющие [стандартное поведение {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html)

    * `--skip-constraint-checks` — используется для ускорения репликации: настройки `FOREIGN_KEY_CHECKS` и `UNIQUE_CHECKS` устанавливаются в значение `0` (проверки не производятся).

        {% note warning %}
        
        Отключение проверки ограничений ускорит репликацию, но может привести к нарушению целостности данных при использовании каскадных операций.
        
        {% endnote %}

    * `--timezone` — укажите идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется UTC+0.

- {{ TF }} {#tf}

    * `sql_mode` — укажите настройки, переопределяющие [стандартное поведение {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html). По умолчанию используется список `NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION`.

    * `skip_constraint_checks` — используется для ускорения репликации: настройки `FOREIGN_KEY_CHECKS` и `UNIQUE_CHECKS` устанавливаются в значение `0` (проверки не производятся).

        {% note warning %}
        
        Отключение проверки ограничений ускорит репликацию, но может привести к нарушению целостности данных при использовании каскадных операций.
        
        {% endnote %}

    * `timezone` — укажите идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется UTC+0.

    Подробнее в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

    * `is_schema_migration_disabled` — установите значение `true`, чтобы не изменять схему данных на приемнике при изменении ее на источнике. По умолчанию при изменении схемы на источнике трансфер будет автоматически применять изменения схемы в приемнике: создавать новые таблицы, добавлять новые колонки, добавлять новые перечисляемые значения и перечисляемые типы. По умолчанию не применяются такие изменения, как удаление таблиц или колонок.

- API {#api}

    * `sqlMode` — укажите настройки, переопределяющие [стандартное поведение {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html)

    * `skipConstraintChecks` — используется для ускорения репликации: настройки `FOREIGN_KEY_CHECKS` и `UNIQUE_CHECKS` устанавливаются в значение `0` (проверки не производятся).

        {% note warning %}
        
        Отключение проверки ограничений ускорит репликацию, но может привести к нарушению целостности данных при использовании каскадных операций.
        
        {% endnote %}

    * `timezone` — укажите идентификатор [IANA Time Zone Database](https://www.iana.org/time-zones). По умолчанию используется UTC+0.

{% endlist %}

После настройки источника и приемника данных [создайте и запустите трансфер](../../transfer.md#create).

## Действия с базой данных во время трансфера {#db-actions}

* Для трансферов в статусе {{ dt-status-copy }} любые изменения схемы данных (`ALTER`) на источнике или приемнике прервут трансфер.

* Для трансферов в статусе {{ dt-status-repl }} схему данных на источнике можно изменять. Все операции `ALTER`, попавшие в бинарный лог (binlog) на источнике, автоматически применятся на приемнике. Этот процесс занимает некоторое время, поэтому трансфер может замедлиться.

## Решение проблем, возникающих при переносе данных {#troubleshooting}

Известные проблемы, связанные с использованием эндпоинта {{ MY }}:

* [Размер лога одной транзакции превышает 4 ГБ](#binlog-size)
* [Не добавляются новые таблицы](#no-new-tables)
* [Ошибка при трансфере из AWS RDS for {{ MY }}](#aws-binlog-time)
* [Ошибка трансфера при переносе таблиц без первичных ключей](#primary-keys)
* [Ошибка обращения к бинарному логу](#binlog-bytes)
* [Не удается получить позицию в бинарном логе](#binlog-position)
* [Ошибка удаления таблицы при политике очистки Drop](#drop-table-error)
* [Сдвиг времени в типе данных DATETIME при трансфере в {{ CH }}](#timeshift)

См. полный список рекомендаций в разделе [Решение проблем](../../../troubleshooting/index.md).

### Размер лога одной транзакции превышает 4 ГБ {#binlog-size}

Текст ошибки:

```text
Last binlog file <имя_файла>:<размер_файла> is more than 4GB
```

Если размер лога одной транзакции превышает 4 ГБ, активация трансферов _{{ dt-type-repl }}_ или _{{ dt-type-copy-repl }}_ завершается ошибкой из-за [внутренних ограничений](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_max_binlog_cache_size) {{ MY }} на размер лога одной транзакции.

**Решение:** [активируйте](../../transfer.md#activate) трансфер повторно.

### Не добавляются новые таблицы {#no-new-tables}

​В трансфер типа _{{ dt-type-copy-repl }}_ не добавляются новые таблицы.

**Решение:**

* [Деактивируйте](../../transfer.md#deactivate) и [активируйте](../../transfer.md#activate) трансфер повторно.
* Создайте таблицы в базе-приемнике вручную.
* [Создайте](../../transfer.md#create) отдельный трансфер типа _{{ dt-type-copy }}_ и добавьте в него только вновь созданные таблицы. При этом исходный трансфер типа _{{ dt-type-copy-repl }}_ можно не деактивировать.

### Ошибка при трансфере из AWS RDS for {{ MY }} {#aws-binlog-time}

В трансферах типа _{{ dt-type-copy-repl }}_ и _{{ dt-type-repl }}_ из источника [Amazon RDS for {{ MY }}](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html) может возникнуть ошибка загрузки таблиц.

Пример ошибки:

```text
Failed to execute LoadSnapshot: 
Cannot load table "name": unable to read rows and push by chunks: 
unable to push changes: unable to execute per table push: 
error: err: sql: transaction has already been committed or rolled back 
rollback err: sql: transaction has already been committed or rolled back
```

Ошибка вызвана коротким временем хранения файлов бинарного лога {{ MY }} в Amazon RDS.

**Решение:**

Увеличьте время хранения бинарного лога с помощью команды:

```sql
call mysql.rds_set_configuration('binlog retention hours', <количество_часов>);
```

Максимальное значение времени хранения — 168 ч (7 дней). Значение по умолчанию — `NULL` (файлы бинарного лога не сохраняются). Подробнее в [документации Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/mysql_rds_set_configuration.html).

### Ошибка трансфера при переносе таблиц без первичных ключей {#primary-keys}

Текст ошибки:

```text
Primary key check failed: 14 Tables errors: Table no key columns found
```

Для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ таблицы без первичных ключей не переносятся.

**Решение:** подготовьте источник в соответствии с разделом [Подготовка к трансферу](../../prepare.md).

### Ошибка обращения к бинарному логу {#binlog-bytes}

В трансферах типа _{{ dt-type-copy-repl }}_ может возникнуть ошибка:

```text
Warn(replication): failed to run (abstract1 source):
failed to run canal: failed to start binlog sync:
failed to get canal event: ERROR 1236 (HY000): Could not find first log file name in binary log index file
```

Ошибка возникает, если необходимые для репликации файлы бинарного лога недоступны. Обычно это связано с добавлением в бинарный лог новых изменений, из-за чего размер файла превышает допустимый. В этом случае часть старых данных лога удаляется.

**Решение:**

[Увеличьте](../../../../managed-mysql/operations/update.md#change-mysql-config) допустимый размер файлов бинарного лога в настройках {{ MY }} с помощью параметра [Mdb preserve binlog bytes](../../../../managed-mysql/concepts/settings-list.md#setting-mdb-preserve-binlog-bytes).

Минимальное значение — `1073741824` (1 ГБайт), максимальное значение — `107374182400` (100 ГБайт), по умолчанию — `1073741824` (1 ГБайт).

### Не удается получить позицию в бинарном логе {#binlog-position}

Текст ошибки:

```text
unable to get binlog position: Storage <адрес_источника> is not master
```

Ошибка может возникнуть при активации трансферов с типами _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_, если источником данных является пользовательская инсталляция {{ MY }} и в ней неправильно настроена репликация на основе позиции в бинарном лог-файле.

**Решение:**

Выполните проверки в {{ MY }}:

* Убедитесь, что в качестве источника репликации используется мастер.

* Убедитесь, что для параметра [log_bin]({{ my.docs }}/refman/8.0/en/replication-options-binary-log.html#option_mysqld_log-bin) указан правильный путь к расположению бинарного лог-файла.

* Выведите информацию о бинарном логе с помощью запроса [SHOW MASTER STATUS]({{ my.docs }}/refman/8.0/en/show-master-status.html) (для версий {{ MY }} 5.7 и 8.0) или [SHOW BINARY LOG STATUS]({{ my.docs }}/refman/8.4/en/show-binary-log-status.html) (для версии {{ MY }} 8.4). Запрос должен возвращать строку с информацией, а не пустой ответ.

### Ошибка удаления таблицы при политике очистки Drop {#drop-table-error}

Текст ошибки:

```text
ERROR: cannot drop table <имя_таблицы> because other objects depend on it (SQLSTATE 2BP01)
```

При политике очистки `Drop` трансфер удаляет таблицы в несколько итераций:

1. Трансфер последовательно пытается удалить все таблицы. Каскадное удаление не используется, так как может привести к удалению таблиц, не участвующих в трансфере. Если таблицу невозможно удалить, например, из-за связанности внешними ключами, возникает ошибка, но трансфер продолжит удаление таблиц.
1. Во время следующей итерации трансфер пытается удалить оставшиеся таблицы. Если блокирующие дочерние таблицы были удалены в предыдущей итерации, таблица со связанностью внешними ключами удаляется. В этом случае ошибка устраняется в процессе работы {{ data-transfer-name }}, дополнительных действий не требуется.
1. Если во время очередной итерации трансфер не удалил ни одной таблицы, процесс удаления таблиц завершается. При этом:

    * Трансфер продолжит работу, если все таблицы были удалены.
    * Трансфер прервется с ошибкой, если остались неудаленные таблицы.

**Решение:**

* Если дочерние таблицы не участвуют в других трансферах и их перенос не противоречит целям трансфера, добавьте эти таблицы:

    * В список включенных таблиц в параметрах эндпоинта-источника.
    * В список объектов для переноса в параметрах трансфера.

* Удалите блокирующие дочерние таблицы в базе-приемнике вручную.
* Используйте политику очистки `Truncate`.
* Пересоздайте базу в приемнике.

    {% note warning %}

    Это приведет к потере всех данных в базе.

    {% endnote %}

### Сдвиг времени в типе данных DATETIME при трансфере в {{ CH }} {#timeshift}

Сдвиг времени наблюдается, так как эндпоинт-источник применяет часовой пояс UTC+0 для данных с типом `DATETIME`. Подробнее читайте в разделе [{#T}](../source/mysql.md#known-limitations).

**Решение:** Примените нужный часовой пояс на уровне приемника вручную.

_{{ CH }} является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._