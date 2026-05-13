# Создание подключения


Вы можете создать подключения следующих типов:
* [к кластеру с управляемой базой данных](#mdb-connection):
  * [Managed Service for PostgreSQL](#mdb-postgresql)
  * [Managed Service for ClickHouse®](#mdb-clickhouse)
  * [Managed Service for MySQL®](#mdb-mysql)
  * [Yandex Managed Service for Valkey™](#mdb-valkey)
  * [Managed Service for OpenSearch](#mdb-opensearch)
  * [Yandex StoreDoc](#mdb-mongodb)
  * [Managed Service for Apache Kafka®](#mdb-kafka)
  * [Yandex MPP Analytics for PostgreSQL](#mdb-greenplum)
* [к пользовательской инсталляции базы данных](#on-premise-connection):
  * [PostgreSQL](#postgresql-on-premise)
  * [ClickHouse®](#clickhouse-on-premise)
  * [MySQL®](#mysql-on-premise)
  * [Redis](#valkey-on-premise)
  * [Valkey™](#valkey-on-premise)
  * [Trino](#trino-on-premise)
  * [OpenSearch](#opensearch-on-premise)
  * [MongoDB](#mongodb-on-premise)
  * [Apache Kafka®](#kafka-on-premise)
  * [Greenplum®](#greenplum-on-premise)

## Подключение к кластеру с управляемой базой данных {#mdb-connection}

### Managed Service for PostgreSQL {#mdb-postgresql}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
  1. Нажмите кнопку **Создать подключение**.
  1. Укажите имя подключения.
  1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
  1. Выберите **Тип подключения**.
  1. В разделе **Подключение к PostgreSQL** выберите **Кластер Managed Service for PostgreSQL** в качестве типа подключения и укажите нужный кластер.
  1. В разделе **Аутентификация**:
      1. Укажите **Имя пользователя**, от лица которого будете подключаться к кластеру.
      1. Выберите способ задания пароля:
          * **Ввести вручную** — вы сами задаете пароль.
          * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [Lockbox](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
  1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. Подключиться можно только к существующим в этом кластере базам данных. У вас должен быть [настроен доступ к ним](../../managed-postgresql/security/index.md).
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `--secret-folder-id` укажите идентификатор этого каталога (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. 


  Чтобы создать подключение к кластеру Managed Service for PostgreSQL:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc metadata-hub connection-manager connection create postgresql --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection create postgresql \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --managed-cluster-id <идентификатор_кластера> \
        --databases <список_БД>
      ```

      Где:

      * `--name` — имя подключения.

      * `--description` — описание подключения.

      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.

      * `--user` — имя пользователя для подключения к кластеру.

      * `--password` — пароль пользователя.
      
      * `--managed-cluster-id` — идентификатор кластера.

        Идентификатор кластера можно получить со [списком кластеров](../../managed-postgresql/operations/cluster-list.md#list-clusters) в каталоге.
      
      * `--databases` — список баз данных, через запятую. Убедитесь, что у пользователя есть [необходимые права](../../managed-postgresql/security/index.md) на доступ к ним.


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать подключение к кластеру Managed Service for PostgreSQL:

  1. Опишите в конфигурационном файле создаваемый ресурс.
  
      Пример структуры конфигурационного файла:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
        name        = "<имя_подключения>"
        description = "<описание_подключения>"
        
        labels = {
          "<ключ_1>" = "<значение_1>"
          "<ключ_2>" = "<значение_2>"
          ...
          "<ключ_N>" = "<значение_N>"
        }
        
        params = {
          postgresql = {
            managed_cluster_id = "<идентификатор_кластера>"
            
            databases = [
              "<база_данных_1>",
              "<база_данных_2>",
              ...
              "<база_данных_N>"
            ]

            auth = {
              user_password = {
                user     = "<имя_пользователя>"
                password = {
                  raw = "<пароль>"
                }
              }
            }
          }
        }
      }
      ```

      Где:

      * `name` — имя подключения

      * `description` — описание подключения.

      * `labels` — набор меток в формате `"<ключ>" = "<значение>"`.

      * `params.postgresql` — параметры подключения к кластеру Managed Service for PostgreSQL:

        * `managed_cluster_id` — идентификатор кластера.

          Идентификатор кластера можно получить со [списком кластеров](../../managed-postgresql/operations/cluster-list.md#list-clusters) в каталоге.

        * `databases` — список баз данных. Убедитесь, что у пользователя есть [необходимые права](../../managed-postgresql/security/index.md) на доступ к ним.

        * `auth.user_password.user` — имя пользователя для подключения к кластеру.

        * `auth.user_password.password.raw` — пароль пользователя.


  1. (Опционально) Задайте в параметре `lockbox_secret_spec` идентификатор каталога для создания секрета (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Оба каталога, для подключения и секрета, должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. Если параметр не задан, секрет будет создан в том же каталоге, что и подключение.    

  1. Проверьте корректность настроек.
  
      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.
  
  1. Подтвердите изменение ресурсов.
  
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
  
  Подробнее см. в [документации провайдера Terraform](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  Чтобы создать подключение к кластеру Managed Service for PostgreSQL, воспользуйтесь методом REST API [Connection.Create](../connection-manager/api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md) для ресурса [Connection](../connection-manager/api-ref/grpc/Connection/index.md).

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `lockboxSecretSpec` укажите идентификатор этого каталога (потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. 
 
  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.PostgreSQLConnection) и [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.PostgreSQLConnection).

{% endlist %}

### Managed Service for ClickHouse® {#mdb-clickhouse}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
    1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
    1. Нажмите кнопку **Создать подключение**.
    1. Укажите имя подключения.
    1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
    1. Выберите **Тип подключения**.
    1. В разделе **Подключение к ClickHouse®** выберите **Кластер Managed Service for ClickHouse®** в качестве типа подключения и укажите нужный кластер.
    1. В разделе **Аутентификация**:
        1. Укажите **Имя пользователя**, от лица которого будете подключаться к кластеру.
        1. Выберите способ задания пароля:
            * **Ввести вручную** — вы сами задаете пароль.
            * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [Lockbox](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
    1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
    1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `--secret-folder-id` укажите идентификатор этого каталога (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр.


  Чтобы создать подключение к кластеру Managed Service for ClickHouse®:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc metadata-hub connection-manager connection create clickhouse --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection create clickhouse \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --managed-cluster-id <идентификатор_кластера> \
        --databases <список_БД>
      ```

      Где:

      * `--name` — имя подключения.

      * `--description` — описание подключения.

      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.

      * `--user` — имя пользователя для подключения к кластеру.

      * `--password` — пароль пользователя.
      
      * `--managed-cluster-id` — идентификатор кластера.

        Идентификатор кластера можно получить со [списком кластеров](../../managed-clickhouse/operations/cluster-list.md#list-clusters) в каталоге.
      
      * `--databases` — список баз данных, через запятую. Убедитесь, что у пользователя есть [необходимые права](../../managed-clickhouse/security.md) на доступ к ним.


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать подключение к кластеру Managed Service for ClickHouse®:

  1. Опишите в конфигурационном файле создаваемый ресурс.
  
      Пример структуры конфигурационного файла:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
        name        = "<имя_подключения>"
        description = "<описание_подключения>"
        
        labels = {
          "<ключ_1>" = "<значение_1>"
          "<ключ_2>" = "<значение_2>"
          ...
          "<ключ_N>" = "<значение_N>"
        }
        
        params = {
          clickhouse = {
            managed_cluster_id = "<идентификатор_кластера>"
            
            databases = [
              "<база_данных_1>",
              "<база_данных_2>",
              ...
              "<база_данных_N>"
            ]

            auth = {
              user_password = {
                user     = "<имя_пользователя>"
                password = {
                  raw = "<пароль>"
                }
              }
            }
          }
        }
      }
      ```

      Где:

      * `name` — имя подключения

      * `description` — описание подключения.

      * `labels` — набор меток в формате `"<ключ>" = "<значение>"`.

      * `params.clickhouse` — параметры подключения к кластеру Managed Service for ClickHouse®:

        * `managed_cluster_id` — идентификатор кластера.

          Идентификатор кластера можно получить со [списком кластеров](../../managed-clickhouse/operations/cluster-list.md#list-clusters) в каталоге.

        * `databases` — список баз данных. Убедитесь, что у пользователя есть [необходимые права](../../managed-clickhouse/security.md) на доступ к ним.

        * `auth.user_password.user` — имя пользователя для подключения к кластеру.

        * `auth.user_password.password.raw` — пароль пользователя.


  1. (Опционально) Задайте в параметре `lockbox_secret_spec` идентификатор каталога для создания секрета (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Оба каталога, для подключения и секрета, должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. Если параметр не задан, секрет будет создан в том же каталоге, что и подключение.  

  1. Проверьте корректность настроек.
  
      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.
  
  1. Подтвердите изменение ресурсов.
  
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
  
  Подробнее см. в [документации провайдера Terraform](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  Чтобы создать подключение к кластеру Managed Service for ClickHouse®, воспользуйтесь методом REST API [Connection.Create](../connection-manager/api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md).

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `lockboxSecretSpec` укажите идентификатор этого каталога (потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр.  

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.ClickHouseConnection) и [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.ClickHouseConnection).

{% endlist %}

### Managed Service for MySQL® {#mdb-mysql}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
   1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
   1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
   1. Нажмите кнопку **Создать подключение**.
   1. Укажите имя подключения.
   1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
   1. Выберите **Тип подключения**.
   1. В разделе **Подключение к MySQL®** выберите **Кластер Managed Service for MySQL®** в качестве типа подключения и укажите нужный кластер.
   1. В разделе **Аутентификация**:
        1. Укажите **Имя пользователя**, от лица которого будете подключаться к кластеру.
        1. Выберите способ задания пароля:
            * **Ввести вручную** — вы сами задаете пароль.
            * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [Lockbox](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
   1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. Подключиться можно только к существующим в этом кластере базам данных. У вас должен быть [настроен доступ к ним](../../managed-mysql/security/index.md).
   1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `--secret-folder-id` укажите идентификатор этого каталога (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр.

  Чтобы создать подключение к кластеру Managed Service for MySQL®:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc metadata-hub connection-manager connection create mysql --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection create mysql \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --managed-cluster-id <идентификатор_кластера> \
        --databases <список_БД>
      ```

      Где:

      * `--name` — имя подключения.

      * `--description` — описание подключения.

      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.

      * `--user` — имя пользователя для подключения к кластеру.

      * `--password` — пароль пользователя.
      
      * `--managed-cluster-id` — идентификатор кластера.

        Идентификатор кластера можно получить со [списком кластеров](../../managed-mysql/operations/cluster-list.md#list-clusters) в каталоге.
      
      * `--databases` — список баз данных, через запятую. Убедитесь, что у пользователя есть [необходимые права](../../managed-mysql/security/index.md) на доступ к ним.


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать подключение к кластеру Managed Service for MySQL®:

  1. Опишите в конфигурационном файле создаваемый ресурс.
  
      Пример структуры конфигурационного файла:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
        name        = "<имя_подключения>"
        description = "<описание_подключения>"
        
        labels = {
          "<ключ_1>" = "<значение_1>"
          "<ключ_2>" = "<значение_2>"
          ...
          "<ключ_N>" = "<значение_N>"
        }
        
        params = {
          mysql = {
            managed_cluster_id = "<идентификатор_кластера>"
            
            databases = [
              "<база_данных_1>",
              "<база_данных_2>",
              ...
              "<база_данных_N>"
            ]

            auth = {
              user_password = {
                user     = "<имя_пользователя>"
                password = {
                  raw = "<пароль>"
                }
              }
            }
          }
        }
      }
      ```

      Где:

      * `name` — имя подключения

      * `description` — описание подключения.

      * `labels` — набор меток в формате `"<ключ>" = "<значение>"`.

      * `params.mysql` — параметры подключения к кластеру Managed Service for MySQL®:

        * `managed_cluster_id` — идентификатор кластера.

          Идентификатор кластера можно получить со [списком кластеров](../../managed-mysql/operations/cluster-list.md#list-clusters) в каталоге.

        * `databases` — список баз данных. Убедитесь, что у пользователя есть [необходимые права](../../managed-mysql/security/index.md) на доступ к ним.

        * `auth.user_password.user` — имя пользователя для подключения к кластеру.

        * `auth.user_password.password.raw` — пароль пользователя.


  1. (Опционально) Задайте в параметре `lockbox_secret_spec` идентификатор каталога для создания секрета (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Оба каталога, для подключения и секрета, должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. Если параметр не задан, секрет будет создан в том же каталоге, что и подключение.  

  1. Проверьте корректность настроек.
  
      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.
  
  1. Подтвердите изменение ресурсов.
  
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
  
  Подробнее см. в [документации провайдера Terraform](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  Чтобы создать подключение к кластеру Managed Service for MySQL®, воспользуйтесь методом REST API [Connection.Create](../connection-manager/api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md).

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `lockboxSecretSpec` укажите идентификатор этого каталога (потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. 

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.MySQLConnection) и [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.MySQLConnection).

{% endlist %}

### Yandex Managed Service for Valkey™ {#mdb-valkey}

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
    1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
    1. Нажмите кнопку **Создать подключение**.
    1. Укажите имя подключения.
    1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
    1. В списке **Тип подключения** выберите **Valkey™**.
    1. В разделе **Подключение к Valkey™** выберите **Кластер Yandex Managed Service for Valkey™** в качестве типа подключения и укажите нужный кластер.
    1. В разделе **Аутентификация** выберите способ задания пароля:
         * **Ввести вручную** — введите значение пароля.
         * **Сгенерировать** — укажите опции для создания автоматически сгенерированного пароля [Lockbox](../../lockbox/quickstart.md).
    1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
    1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `--secret-folder-id` укажите идентификатор этого каталога (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр.

  Чтобы создать подключение к кластеру Yandex Managed Service for Valkey™:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc metadata-hub connection-manager connection create valkey --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection create valkey \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --managed-cluster-id <идентификатор_кластера> \
        --databases <список_БД>
      ```

      Где:

      * `--name` — имя подключения.

      * `--description` — описание подключения.

      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.

      * `--user` — имя пользователя для подключения к кластеру.

      * `--password` — пароль пользователя.
      
      * `--managed-cluster-id` — идентификатор кластера.

        Идентификатор кластера можно получить со [списком кластеров](../../managed-valkey/operations/cluster-list.md#list-clusters) в каталоге.
      
      * `--databases` — список баз данных, через запятую. Убедитесь, что у пользователя есть [необходимые права](../../managed-valkey/security/index.md) на доступ к ним.


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать подключение к кластеру Yandex Managed Service for Valkey™:

  1. Опишите в конфигурационном файле создаваемый ресурс.
  
      Пример структуры конфигурационного файла:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
        name        = "<имя_подключения>"
        description = "<описание_подключения>"
        
        labels = {
          "<ключ_1>" = "<значение_1>"
          "<ключ_2>" = "<значение_2>"
          ...
          "<ключ_N>" = "<значение_N>"
        }
        
        params = {
          valkey = {
            managed_cluster_id = "<идентификатор_кластера>"
            
            databases = [
              "<база_данных_1>",
              "<база_данных_2>",
              ...
              "<база_данных_N>"
            ]

            auth = {
              user_password = {
                user     = "<имя_пользователя>"
                password = {
                  raw = "<пароль>"
                }
              }
            }
          }
        }
      }
      ```

      Где:

      * `name` — имя подключения

      * `description` — описание подключения.

      * `labels` — набор меток в формате `"<ключ>" = "<значение>"`.

      * `params.valkey` — параметры подключения к кластеру Yandex Managed Service for Valkey™:

        * `managed_cluster_id` — идентификатор кластера.

          Идентификатор кластера можно получить со [списком кластеров](../../managed-valkey/operations/cluster-list.md#list-clusters) в каталоге.

        * `databases` — список баз данных. Убедитесь, что у пользователя есть [необходимые права](../../managed-valkey/security/index.md) на доступ к ним.

        * `auth.user_password.user` — имя пользователя для подключения к кластеру.

        * `auth.user_password.password.raw` — пароль пользователя.


  1. (Опционально) Задайте в параметре `lockbox_secret_spec` идентификатор каталога для создания секрета (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Оба каталога, для подключения и секрета, должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. Если параметр не задан, секрет будет создан в том же каталоге, что и подключение.  

  1. Проверьте корректность настроек.
  
      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.
  
  1. Подтвердите изменение ресурсов.
  
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
  
  Подробнее см. в [документации провайдера Terraform](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  Чтобы создать подключение к кластеру Yandex Managed Service for Valkey™, воспользуйтесь методом REST API [Connection.Create](../connection-manager/api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md).

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `lockboxSecretSpec` укажите идентификатор этого каталога (потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. 

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.ValkeyConnection) и [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.ValkeyConnection).

{% endlist %}

### Managed Service for OpenSearch {#mdb-opensearch}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
   1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
   1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
   1. Нажмите кнопку **Создать подключение**.
   1. Укажите имя подключения.
   1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
   1. Выберите **Тип подключения**.
   1. В разделе **Подключение к OpenSearch** выберите **Кластер Managed Service for OpenSearch** в качестве типа подключения и укажите нужный кластер.
   1. В разделе **Аутентификация**:
        1. Укажите **Имя пользователя**, от лица которого будете подключаться к кластеру.
        1. Выберите способ задания пароля:
            * **Ввести вручную** — вы сами задаете пароль.
            * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [Lockbox](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
   1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. Подключиться можно только к существующим в этом кластере базам данных. У вас должен быть [настроен доступ к ним](../../managed-opensearch/security/index.md).
   1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `--secret-folder-id` укажите идентификатор этого каталога (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр.

  Чтобы создать подключение к кластеру Managed Service for OpenSearch:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc metadata-hub connection-manager connection create opensearch --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection create opensearch \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --managed-cluster-id <идентификатор_кластера>
      ```

      Где:

      * `--name` — имя подключения.

      * `--description` — описание подключения.

      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.

      * `--user` — имя пользователя для подключения к кластеру.

      * `--password` — пароль пользователя.
      
      * `--managed-cluster-id` — идентификатор кластера.

        Идентификатор кластера можно получить со [списком кластеров](../../managed-opensearch/operations/cluster-list.md#list-clusters) в каталоге.


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать подключение к кластеру Managed Service for OpenSearch:

  1. Опишите в конфигурационном файле создаваемый ресурс.
  
      Пример структуры конфигурационного файла:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
        name        = "<имя_подключения>"
        description = "<описание_подключения>"
        
        labels = {
          "<ключ_1>" = "<значение_1>"
          "<ключ_2>" = "<значение_2>"
          ...
          "<ключ_N>" = "<значение_N>"
        }
        
        params = {
          opensearch = {
            managed_cluster_id = "<идентификатор_кластера>"

            auth = {
              user_password = {
                user     = "<имя_пользователя>"
                password = {
                  raw = "<пароль>"
                }
              }
            }
          }
        }
      }
      ```

      Где:

      * `name` — имя подключения

      * `description` — описание подключения.

      * `labels` — набор меток в формате `"<ключ>" = "<значение>"`.

      * `params.opensearch` — параметры подключения к кластеру Managed Service for OpenSearch:

        * `managed_cluster_id` — идентификатор кластера.

          Идентификатор кластера можно получить со [списком кластеров](../../managed-opensearch/operations/cluster-list.md#list-clusters) в каталоге.

        * `auth.user_password.user` — имя пользователя для подключения к кластеру.

        * `auth.user_password.password.raw` — пароль пользователя.


  1. (Опционально) Задайте в параметре `lockbox_secret_spec` идентификатор каталога для создания секрета (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Оба каталога, для подключения и секрета, должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. Если параметр не задан, секрет будет создан в том же каталоге, что и подключение.  

  1. Проверьте корректность настроек.
  
      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.
  
  1. Подтвердите изменение ресурсов.
  
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
  
  Подробнее см. в [документации провайдера Terraform](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  Чтобы создать подключение к кластеру Managed Service for OpenSearch, воспользуйтесь методом REST API [Connection.Create](../connection-manager/api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md).

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `lockboxSecretSpec` укажите идентификатор этого каталога (потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. 

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.OpenSearchConnection) и [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.OpenSearchConnection).

{% endlist %}

### Yandex StoreDoc {#mdb-mongodb}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
   1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
   1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
   1. Нажмите кнопку **Создать подключение**.
   1. Укажите имя подключения.
   1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
   1. Выберите **Тип подключения**.
   1. В разделе **Подключение к MongoDB** выберите **Кластер Yandex StoreDoc** в качестве типа подключения и укажите нужный кластер.
   1. В разделе **Аутентификация**:
        1. Укажите **Имя пользователя**, от лица которого будете подключаться к кластеру.
        1. Выберите способ задания пароля:
            * **Ввести вручную** — вы сами задаете пароль.
            * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [Lockbox](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
   1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. Подключиться можно только к существующим в этом кластере базам данных. У вас должен быть [настроен доступ к ним](../../storedoc/security/index.md).
   1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `--secret-folder-id` укажите идентификатор этого каталога (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр.

  Чтобы создать подключение к кластеру Yandex StoreDoc:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc metadata-hub connection-manager connection create mongodb --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection create mongodb \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --managed-cluster-id <идентификатор_кластера> \
        --databases <список_БД>
      ```

      Где:

      * `--name` — имя подключения.

      * `--description` — описание подключения.

      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.

      * `--user` — имя пользователя для подключения к кластеру.

      * `--password` — пароль пользователя.
      
      * `--managed-cluster-id` — идентификатор кластера.

        Идентификатор кластера можно получить со [списком кластеров](../../storedoc/operations/cluster-list.md#list-clusters) в каталоге.
      
      * `--databases` — список баз данных, через запятую. Убедитесь, что у пользователя есть [необходимые права](../../storedoc/security/index.md) на доступ к ним.


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать подключение к кластеру Yandex StoreDoc:

  1. Опишите в конфигурационном файле создаваемый ресурс.
  
      Пример структуры конфигурационного файла:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
        name        = "<имя_подключения>"
        description = "<описание_подключения>"
        
        labels = {
          "<ключ_1>" = "<значение_1>"
          "<ключ_2>" = "<значение_2>"
          ...
          "<ключ_N>" = "<значение_N>"
        }
        
        params = {
          mongodb = {
            managed_cluster_id = "<идентификатор_кластера>"
            
            databases = [
              "<база_данных_1>",
              "<база_данных_2>",
              ...
              "<база_данных_N>"
            ]

            auth = {
              user_password = {
                user     = "<имя_пользователя>"
                password = {
                  raw = "<пароль>"
                }
              }
            }
          }
        }
      }
      ```

      Где:

      * `name` — имя подключения

      * `description` — описание подключения.

      * `labels` — набор меток в формате `"<ключ>" = "<значение>"`.

      * `params.mongodb` — параметры подключения к кластеру Yandex StoreDoc:

        * `managed_cluster_id` — идентификатор кластера.

          Идентификатор кластера можно получить со [списком кластеров](../../storedoc/operations/cluster-list.md#list-clusters) в каталоге.

        * `databases` — список баз данных. Убедитесь, что у пользователя есть [необходимые права](../../storedoc/security/index.md) на доступ к ним.

        * `auth.user_password.user` — имя пользователя для подключения к кластеру.

        * `auth.user_password.password.raw` — пароль пользователя.


  1. (Опционально) Задайте в параметре `lockbox_secret_spec` идентификатор каталога для создания секрета (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Оба каталога, для подключения и секрета, должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. Если параметр не задан, секрет будет создан в том же каталоге, что и подключение.  

  1. Проверьте корректность настроек.
  
      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.
  
  1. Подтвердите изменение ресурсов.
  
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
  
  Подробнее см. в [документации провайдера Terraform](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  Чтобы создать подключение к кластеру Yandex StoreDoc, воспользуйтесь методом REST API [Connection.Create](../connection-manager/api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md).

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `lockboxSecretSpec` укажите идентификатор этого каталога (потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. 

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.MongoDBConnection) и [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.MongoDBConnection).

{% endlist %}

### Managed Service for Apache Kafka® {#mdb-kafka}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
   1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
   1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
   1. Нажмите кнопку **Создать подключение**.
   1. Укажите имя подключения.
   1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
   1. Выберите **Тип подключения**.
   1. В разделе **Подключение к Apache Kafka®** выберите **Кластер Managed Service for Kafka** в качестве типа подключения и укажите нужный кластер.
   1. При использовании аутентификации:

       * Укажите **Имя пользователя** для подключения.
       * Задайте пароль одним из способов:
         
         * **Ввести вручную** — пароль вводится в соответствующее поле.
         * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [Lockbox](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
       
       * (Опционально) В списке **Механизмы аутентификации** выберите нужные опции:
         
         * `PLAIN` — аутентификация с передачей логина и пароля в открытом виде.
         * `SCRAM_SHA256` — аутентификация с хэшированием SHA-256.
         * `SCRAM_SHA512` — аутентификация с хэшированием SHA-512.

         [Подробнее о механизмах и протоколах SASL](../../glossary/sasl.md#mechanisms-and-protocols).
         
   1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `--secret-folder-id` укажите идентификатор этого каталога (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр.

  Чтобы создать подключение к кластеру Managed Service for Apache Kafka®:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc metadata-hub connection-manager connection create kafka --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection create kafka \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --supported-mechanisms <список_механизмов_аутентификации> \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --managed-cluster-id <идентификатор_кластера>
      ```

      Где:

      * `--name` — имя подключения.

      * `--description` — описание подключения.

      * `--supported-mechanisms` — список механизмов аутентификации. Возможные значения:
        
        * `PLAIN` — аутентификация с передачей логина и пароля в открытом виде.
        * `SCRAM_SHA256` — аутентификация с хэшированием SHA-256.
        * `SCRAM_SHA512` — аутентификация с хэшированием SHA-512.

        [Подробнее о механизмах и протоколах SASL](../../glossary/sasl.md#mechanisms-and-protocols).

      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.

      * `--user` — имя пользователя для подключения к кластеру.

      * `--password` — пароль пользователя.
      
      * `--managed-cluster-id` — идентификатор кластера.

        Идентификатор кластера можно получить со [списком кластеров](../../managed-kafka/operations/cluster-list.md#list-clusters) в каталоге.


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать подключение к кластеру Managed Service for Apache Kafka®:

  1. Опишите в конфигурационном файле создаваемый ресурс.
  
      Пример структуры конфигурационного файла:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
        name        = "<имя_подключения>"
        description = "<описание_подключения>"
        
        labels = {
          "<ключ_1>" = "<значение_1>"
          "<ключ_2>" = "<значение_2>"
          ...
          "<ключ_N>" = "<значение_N>"
        }
        
        params = {
          kafka = {
            managed_cluster_id = "<идентификатор_кластера>"

            auth = {
              sasl = {
                user     = "<имя_пользователя>"
                password = { 
                  raw = "<пароль>"
                }
                supported_mechanisms = [
                  <список_механизмов_аутентификации>
                ]
              }
            }
          }
        }
      }
      ```

      Где:

      * `name` — имя подключения

      * `description` — описание подключения.

      * `labels` — набор меток в формате `"<ключ>" = "<значение>"`.

      * `params.kafka` — параметры подключения к кластеру Managed Service for Apache Kafka®:

        * `managed_cluster_id` — идентификатор кластера.

          Идентификатор кластера можно [получить со списком кластеров в каталоге](../../managed-kafka/operations/cluster-list.md#list-clusters).

        * `auth` — параметры аутентификации. Укажите один из блоков:

          * `sasl` — параметры SASL-аутентификации:
            
            * `user` — имя пользователя для подключения к кластеру.
            * `password.raw` — пароль пользователя.
            * `supported_mechanisms` — список механизмов аутентификации. Возможные значения:
              
              * `PLAIN` — аутентификация с передачей логина и пароля в открытом виде.
              * `SCRAM_SHA256` — аутентификация с хэшированием SHA-256.
              * `SCRAM_SHA512` — аутентификация с хэшированием SHA-512.

              [Подробнее о механизмах и протоколах SASL](../../glossary/sasl.md#mechanisms-and-protocols).
          
          * `disabled` — отключает аутентификацию.


  1. (Опционально) Задайте в параметре `lockbox_secret_spec` идентификатор каталога для создания секрета (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Оба каталога, для подключения и секрета, должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. Если параметр не задан, секрет будет создан в том же каталоге, что и подключение.  

  1. Проверьте корректность настроек.
  
      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.
  
  1. Подтвердите изменение ресурсов.
  
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
  
  Подробнее см. в [документации провайдера Terraform](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  Чтобы создать подключение к кластеру Managed Service for Apache Kafka®, воспользуйтесь методом REST API [Connection.Create](../connection-manager/api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md) для ресурса [Connection](../connection-manager/api-ref/grpc/Connection/index.md).

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `lockboxSecretSpec` укажите идентификатор этого каталога (потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр.  

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.KafkaConnection) и [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.KafkaConnection).

{% endlist %}

{% endlist %}

### Yandex MPP Analytics for PostgreSQL {#mdb-greenplum}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
  1. Нажмите кнопку **Создать подключение**.
  1. Укажите имя подключения.
  1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
  1. Выберите **Тип подключения**.
  1. В разделе **Подключение к Greenplum** выберите **Кластер Yandex MPP Analytics for PostgreSQL** в качестве типа подключения и укажите нужный кластер.
  1. В разделе **Аутентификация**:
      1. Укажите **Имя пользователя** для подключения.
      1. Выберите способ задания пароля:
          * **Ввести вручную** — пароль вводится в соответствующее поле.
          * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [Lockbox](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
  1. Перечислите базы данных, подключениями к которым вы хотите управлять. Подключиться можно только к существующим в этом кластере базам данных. Убедитесь, что у пользователя есть [необходимые права](../../managed-greenplum/security/index.md) на доступ к ним.
  
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `--secret-folder-id` укажите идентификатор этого каталога (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр.

  Чтобы создать подключение к кластеру Yandex MPP Analytics for PostgreSQL:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc metadata-hub connection-manager connection create greenplum --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection create greenplum \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --managed-cluster-id <идентификатор_кластера> \
        --databases <список_БД>
      ```

      Где:

      * `--name` — имя подключения.

      * `--description` — описание подключения.

      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.

      * `--user` — имя пользователя для подключения к кластеру.

      * `--password` — пароль пользователя.
      
      * `--managed-cluster-id` — идентификатор кластера.

        Идентификатор кластера можно получить со [списком кластеров](../../managed-greenplum/operations/cluster-list.md#list-clusters) в каталоге.
      
      * `--databases` — список баз данных, через запятую. Убедитесь, что у пользователя есть [необходимые права](../../managed-greenplum/security/index.md) на доступ к ним.


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать подключение к кластеру Yandex MPP Analytics for PostgreSQL:

  1. Опишите в конфигурационном файле создаваемый ресурс.
  
      Пример структуры конфигурационного файла:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
        name        = "<имя_подключения>"
        description = "<описание_подключения>"
        
        labels = {
          "<ключ_1>" = "<значение_1>"
          "<ключ_2>" = "<значение_2>"
          ...
          "<ключ_N>" = "<значение_N>"
        }
        
        params = {
          greenplum = {
            managed_cluster_id = "<идентификатор_кластера>"
            
            databases = [
              "<база_данных_1>",
              "<база_данных_2>",
              ...
              "<база_данных_N>"
            ]

            auth = {
              user_password = {
                user     = "<имя_пользователя>"
                password = {
                  raw = "<пароль>"
                }
              }
            }
          }
        }
      }
      ```

      Где:

      * `name` — имя подключения

      * `description` — описание подключения.

      * `labels` — набор меток в формате `"<ключ>" = "<значение>"`.

      * `params.greenplum` — параметры подключения к кластеру Yandex MPP Analytics for PostgreSQL:

        * `managed_cluster_id` — идентификатор кластера.

          Идентификатор кластера можно получить со [списком кластеров](../../managed-greenplum/operations/cluster-list.md#list-clusters) в каталоге.

        * `databases` — список баз данных. Убедитесь, что у пользователя есть [необходимые права](../../managed-greenplum/security/index.md) на доступ к ним.

        * `auth.user_password.user` — имя пользователя для подключения к кластеру.

        * `auth.user_password.password.raw` — пароль пользователя.


  1. (Опционально) Задайте в параметре `lockbox_secret_spec` идентификатор каталога для создания секрета (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Оба каталога, для подключения и секрета, должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. Если параметр не задан, секрет будет создан в том же каталоге, что и подключение.  

  1. Проверьте корректность настроек.
  
      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.
  
  1. Подтвердите изменение ресурсов.
  
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
  
  Подробнее см. в [документации провайдера Terraform](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  Чтобы создать подключение к кластеру Yandex MPP Analytics for PostgreSQL, воспользуйтесь методом REST API [Connection.Create](../connection-manager/api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md) для ресурса [Connection](../connection-manager/api-ref/grpc/Connection/index.md).

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `lockboxSecretSpec` укажите идентификатор этого каталога (потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. 

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.GreenplumConnection) и [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.GreenplumConnection).

{% endlist %}

## Подключение к пользовательской инсталляции базы данных {#on-premise-connection}

### PostgreSQL {#postgresql-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
  1. Нажмите кнопку **Создать подключение**.
  1. Укажите имя подключения.
  1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
  1. Выберите **Тип подключения**.
  1. В разделе **Подключение к PostgreSQL** укажите параметры подключения:
      1. В поле **Тип подключения** выберите **Пользовательская инсталляция**.
      1. В поле **Хосты** укажите адрес хоста c базой данных и номер порта для подключения.

          Если вы создаете подключение к пользовательской инсталляции базы данных для использования с [Yandex DataLens](../../datalens/concepts/index.md), укажите внешний адрес хоста.

      1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
          Если в вашей компании есть [центр сертификации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.
          
  1. В разделе **Аутентификация**:
      1. Укажите **Имя пользователя**, от лица которого будете подключаться к базе данных.
      1. Выберите способ задания пароля:
          * **Ввести вручную** — вы сами задаете пароль.
          * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [Lockbox](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
  1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `--secret-folder-id` укажите идентификатор этого каталога (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр.

  Чтобы создать подключение к пользовательской инсталляции PostgreSQL:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc metadata-hub connection-manager connection create postgresql --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection create postgresql \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --hosts <список_хостов> \
        --databases <список_БД> \
        --ca-certificate <путь_к_сертификату>
      ```

      Где:

      * `--name` — имя подключения.
      
      * `--description` — описание подключения.
      
      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.
      
      * `--user` — имя пользователя для подключения к базе данных.
      
      * `--password` — пароль пользователя.
            
      * `--hosts` — список хостов в формате `<хост>:<порт>`, через запятую.
            
      * `--databases` — список баз данных, через запятую.
      
        Убедитесь, что у пользователя есть необходимые права на доступ к ним.
            
      * `--ca-certificate` — путь к файлу CA-сертификата для TLS.
            
        По умолчанию [TLS](../../glossary/tls.md) включен. Чтобы отключить его, используйте флаг `--tls-disabled`.


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать подключение к пользовательской инсталляции PostgreSQL:

  1. Опишите в конфигурационном файле создаваемый ресурс.
  
      Пример структуры конфигурационного файла:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
        name        = "<имя_подключения>"
        description = "<описание_подключения>"
        
        labels = {
          "<ключ_1>" = "<значение_1>"
          "<ключ_2>" = "<значение_2>"
          ...
          "<ключ_N>" = "<значение_N>"
        }
        
        params = {
          postgresql = {
            cluster = {
              hosts = [
                {
                  host = "<хост_1>"
                  port = <порт_1>
                },
                {
                  host = "<хост_2>"
                  port = <порт_2>
                },
                ...
                {
                  host = "<хост_N>"
                  port = <порт_N>
                }
              ]
              
              tls_params = {
                tls {
                  ca_certificate = "<путь_к_сертификату>"
                }
              }
            }

            databases = [
              "<база_данных_1>",
              "<база_данных_2>",
              ...
              "<база_данных_N>"
            ]

            auth = {
              user_password = {
                user     = "<имя_пользователя>"
                password = {
                  raw = "<пароль>"
                }
              }
            }
          }
        }
      }
      ```

      Где:

      * `name` — имя подключения

      * `description` — описание подключения.

      * `labels` — набор меток в формате `"<ключ>" = "<значение>"`.

      * `params.postgresql` — параметры подключения к пользовательской инсталляции PostgreSQL:
        
        * `cluster.hosts` — список хостов. Для каждого хоста укажите параметры `host` и `port`.

        * `cluster.tls_params` — параметры [TLS](../../glossary/tls.md). Укажите один из блоков:
        
          * `tls.ca_certificate` — путь к файлу CA-сертификата для TLS.
          * `disabled` — отключает TLS. По умолчанию TLS включен.

        * `databases` — список баз данных. Убедитесь, что у пользователя есть необходимые права доступа к ним.

        * `auth.user_password.user` — имя пользователя для подключения к базе данных.

        * `auth.user_password.password.raw` — пароль пользователя.


  1. (Опционально) Задайте в параметре `lockbox_secret_spec` идентификатор каталога для создания секрета (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Оба каталога, для подключения и секрета, должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. Если параметр не задан, секрет будет создан в том же каталоге, что и подключение.  

  1. Проверьте корректность настроек.
  
      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.
  
  1. Подтвердите изменение ресурсов.
  
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
  
  Подробнее см. в [документации провайдера Terraform](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  Чтобы создать подключение к пользовательской инсталляции PostgreSQL, воспользуйтесь методом REST API [Connection.Create](../connection-manager/api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md).

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `lockboxSecretSpec` укажите идентификатор этого каталога (потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр.  

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.PostgreSQLCluster) и [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.PostgreSQLCluster).

{% endlist %}

### ClickHouse® {#clickhouse-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
    1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
    1. Нажмите кнопку **Создать подключение**.
    1. Укажите имя подключения.
    1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
    1. Выберите **Тип подключения**.
    1. В разделе **Подключение к ClickHouse®** укажите параметры подключения:
        1. В поле **Тип подключения** выберите **Пользовательская инсталляция**.
        1. В поле **Хосты** укажите [FQDN](../../glossary/fqdn.md) или IP-адреса хостов, входящих в шард, номер HTTP- или TCP-порта для подключения и имя [шарда](../../managed-clickhouse/operations/shards.md#list-shards).

            Если вы создаете подключение к пользовательской инсталляции базы данных для использования с [Yandex DataLens](../../datalens/concepts/index.md), укажите внешние IP-адреса хостов.

        1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
            Если в вашей компании есть [центр сертификации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.
    1. В разделе **Аутентификация**:
        1. Укажите **Имя пользователя**, от лица которого будете подключаться к базе данных.
        1. Выберите способ задания пароля:
            * **Ввести вручную** — вы сами задаете пароль.
            * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [Lockbox](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
    1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
    1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `--secret-folder-id` укажите идентификатор этого каталога (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр.

  Чтобы создать подключение к пользовательской инсталляции ClickHouse®:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc metadata-hub connection-manager connection create clickhouse --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection create clickhouse \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --hosts <список_хостов> \
        --databases <список_БД> \
        --ca-certificate <путь_к_сертификату>
      ```

      Где:

      * `--name` — имя подключения.
      
      * `--description` — описание подключения.
      
      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.
      
      * `--user` — имя пользователя для подключения к базе данных.
      
      * `--password` — пароль пользователя.
      
      * `--hosts` — список хостов в формате `<хост>:<http_порт>:<tcp_порт>:<имя_шарда>`, через запятую.
      
      * `--databases` — список баз данных, через запятую.
      
        Убедитесь, что у пользователя есть необходимые права на доступ к ним.
        
      * `--ca-certificate` — путь к файлу CA-сертификата для TLS.
        
        По умолчанию [TLS](../../glossary/tls.md) включен. Чтобы отключить его, используйте флаг `--tls-disabled`.


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать подключение к пользовательской инсталляции ClickHouse®:

  1. Опишите в конфигурационном файле создаваемый ресурс.
  
      Пример структуры конфигурационного файла:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
        name        = "<имя_подключения>"
        description = "<описание_подключения>"
        
        labels = {
          "<ключ_1>" = "<значение_1>"
          "<ключ_2>" = "<значение_2>"
          ...
          "<ключ_N>" = "<значение_N>"
        }
        
        params = {
          clickhouse = {
            cluster = {
              hosts = [
                {
                  host       = "<хост_1>"
                  http_port  = <http_порт_1>
                  shard_name = "<имя_шарда_1>"
                  tcp_port   = <tcp_порт_1>
                },
                {
                  host       = "<хост_2>"
                  http_port  = <http_порт_2>
                  shard_name = "<имя_шарда_2>"
                  tcp_port   = <tcp_порт_2>
                },
                ...
                {
                  host       = "<хост_N>"
                  http_port  = <http_порт_N>
                  shard_name = "<имя_шарда_N>"
                  tcp_port   = <tcp_порт_N>
                }
              ]
              
              tls_params = {
                tls {
                  ca_certificate = "<путь_к_сертификату>"
                }
              }
            }

            databases = [
              "<база_данных_1>",
              "<база_данных_2>",
              ...
              "<база_данных_N>"
            ]

            auth = {
              user_password = {
                user     = "<имя_пользователя>"
                password = {
                  raw = "<пароль>"
                }
              }
            }
          }
        }
      }
      ```

      Где:

      * `name` — имя подключения

      * `description` — описание подключения.

      * `labels` — набор меток в формате `"<ключ>" = "<значение>"`.

      * `params.clickhouse` — параметры подключения к пользовательской инсталляции ClickHouse®:
        
        * `cluster.hosts` — список хостов. Для каждого хоста укажите параметры `host`, `http_port`, `shard_name` и `tcp_port`.

        * `cluster.tls_params` — параметры [TLS](../../glossary/tls.md). Укажите один из блоков:
        
          * `tls.ca_certificate` — путь к файлу CA-сертификата для TLS.
          * `disabled` — отключает TLS. По умолчанию TLS включен.

        * `databases` — список баз данных. Убедитесь, что у пользователя есть необходимые права доступа к ним.

        * `auth.user_password.user` — имя пользователя для подключения к базе данных.

        * `auth.user_password.password.raw` — пароль пользователя.


  1. (Опционально) Задайте в параметре `lockbox_secret_spec` идентификатор каталога для создания секрета (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Оба каталога, для подключения и секрета, должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. Если параметр не задан, секрет будет создан в том же каталоге, что и подключение.  

  1. Проверьте корректность настроек.
  
      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.
  
  1. Подтвердите изменение ресурсов.
  
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
  
  Подробнее см. в [документации провайдера Terraform](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  Чтобы создать подключение к пользовательской инсталляции ClickHouse®, воспользуйтесь методом REST API [Connection.Create](../connection-manager/api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md).

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `lockboxSecretSpec` укажите идентификатор этого каталога (потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. 

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.ClickHouseCluster) и [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.ClickHouseCluster).

{% endlist %}

### MySQL® {#mysql-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
   1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
   1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
   1. Нажмите кнопку **Создать подключение**.
   1. Укажите имя подключения.
   1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
   1. Выберите **Тип подключения**.
   1. В разделе **Подключение к MySQL®** укажите параметры подключения:
       1. В поле **Тип подключения** выберите **Пользовательская инсталляция**.
       1. В поле **Хосты** укажите адрес хоста c базой данных и номер порта для подключения.

           Если вы создаете подключение к пользовательской инсталляции базы данных для использования с [Yandex DataLens](../../datalens/concepts/index.md), укажите внешний адрес хоста.

       1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
           Если в вашей компании есть [центр сертификации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.
           
   1. В разделе **Аутентификация**:
       1. Укажите **Имя пользователя**, от лица которого будете подключаться к базе данных.
       1. Выберите способ задания пароля:
           * **Ввести вручную** — вы сами задаете пароль.
           * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [Lockbox](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
   1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
   1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `--secret-folder-id` укажите идентификатор этого каталога (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр.

  Чтобы создать подключение к пользовательской инсталляции MySQL®:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc metadata-hub connection-manager connection create mysql --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection create mysql \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --hosts <список_хостов> \
        --databases <список_БД> \
        --ca-certificate <путь_к_сертификату>
      ```

      Где:

      * `--name` — имя подключения.
      
      * `--description` — описание подключения.
      
      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.
      
      * `--user` — имя пользователя для подключения к базе данных.
      
      * `--password` — пароль пользователя.
            
      * `--hosts` — список хостов в формате `<хост>:<порт>`, через запятую.
            
      * `--databases` — список баз данных, через запятую.
      
        Убедитесь, что у пользователя есть необходимые права на доступ к ним.
            
      * `--ca-certificate` — путь к файлу CA-сертификата для TLS.
            
        По умолчанию [TLS](../../glossary/tls.md) включен. Чтобы отключить его, используйте флаг `--tls-disabled`.


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать подключение к пользовательской инсталляции MySQL®:

  1. Опишите в конфигурационном файле создаваемый ресурс.
  
      Пример структуры конфигурационного файла:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
        name        = "<имя_подключения>"
        description = "<описание_подключения>"
        
        labels = {
          "<ключ_1>" = "<значение_1>"
          "<ключ_2>" = "<значение_2>"
          ...
          "<ключ_N>" = "<значение_N>"
        }
        
        params = {
          mysql = {
            cluster = {
              hosts = [
                {
                  host = "<хост_1>"
                  port = <порт_1>
                },
                {
                  host = "<хост_2>"
                  port = <порт_2>
                },
                ...
                {
                  host = "<хост_N>"
                  port = <порт_N>
                }
              ]
              
              tls_params = {
                tls {
                  ca_certificate = "<путь_к_сертификату>"
                }
              }
            }

            databases = [
              "<база_данных_1>",
              "<база_данных_2>",
              ...
              "<база_данных_N>"
            ]

            auth = {
              user_password = {
                user     = "<имя_пользователя>"
                password = {
                  raw = "<пароль>"
                }
              }
            }
          }
        }
      }
      ```

      Где:

      * `name` — имя подключения

      * `description` — описание подключения.

      * `labels` — набор меток в формате `"<ключ>" = "<значение>"`.

      * `params.mysql` — параметры подключения к пользовательской инсталляции MySQL®:
        
        * `cluster.hosts` — список хостов. Для каждого хоста укажите параметры `host` и `port`.

        * `cluster.tls_params` — параметры [TLS](../../glossary/tls.md). Укажите один из блоков:
        
          * `tls.ca_certificate` — путь к файлу CA-сертификата для TLS.
          * `disabled` — отключает TLS. По умолчанию TLS включен.

        * `databases` — список баз данных. Убедитесь, что у пользователя есть необходимые права доступа к ним.

        * `auth.user_password.user` — имя пользователя для подключения к базе данных.

        * `auth.user_password.password.raw` — пароль пользователя.


  1. (Опционально) Задайте в параметре `lockbox_secret_spec` идентификатор каталога для создания секрета (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Оба каталога, для подключения и секрета, должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. Если параметр не задан, секрет будет создан в том же каталоге, что и подключение.  

  1. Проверьте корректность настроек.
  
      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.
  
  1. Подтвердите изменение ресурсов.
  
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
  
  Подробнее см. в [документации провайдера Terraform](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  Чтобы создать подключение к пользовательской инсталляции MySQL®, воспользуйтесь методом REST API [Connection.Create](../connection-manager/api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md).

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `lockboxSecretSpec` укажите идентификатор этого каталога (потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. 

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.MySQLCluster) и [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.MySQLCluster).

{% endlist %}

### Redis {#valkey-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
    1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
    1. Нажмите кнопку **Создать подключение**.
    1. Укажите имя подключения.
    1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
    1. В списке **Тип подключения** выберите **Redis**.
    1. В разделе **Подключение к Redis** укажите параметры подключения:
       1. В поле **Тип подключения** выберите **Пользовательская инсталляция**.
       1. В поле **Хосты** укажите [FQDN](../../glossary/fqdn.md) или IP-адреса хостов, входящих в шард, номер HTTP- или TCP-порта для подключения и имя шарда.
       1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
    1. В разделе **Аутентификация** укажите имя пользователя и выберите способ задания пароля: 
        * **Ввести вручную** — введите значение пароля.
        * **Сгенерировать** — укажите опции для создания автоматически сгенерированного пароля [Lockbox](../../lockbox/quickstart.md).
    1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
    1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `--secret-folder-id` укажите идентификатор этого каталога (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр.

  Чтобы создать подключение к пользовательской инсталляции Redis:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc metadata-hub connection-manager connection create redis --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection create redis \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --hosts <список_хостов> \
        --databases <список_БД> \
        --ca-certificate <путь_к_сертификату>
      ```

      Где:

      * `--name` — имя подключения.
      
      * `--description` — описание подключения.
      
      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.
      
      * `--user` — имя пользователя для подключения к базе данных.
      
      * `--password` — пароль пользователя.
      
      * `--hosts` — список хостов в формате `<хост>:<порт>:<имя_шарда>`, через запятую.
      
      * `--databases` — список баз данных, через запятую.
      
        Убедитесь, что у пользователя есть необходимые права на доступ к ним.
        
      * `--ca-certificate` — путь к файлу CA-сертификата для TLS.
      
        По умолчанию [TLS](../../glossary/tls.md) включен. Чтобы отключить его, используйте флаг `--tls-disabled`.


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать подключение к пользовательской инсталляции Redis:

  1. Опишите в конфигурационном файле создаваемый ресурс.
  
      Пример структуры конфигурационного файла:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
        name        = "<имя_подключения>"
        description = "<описание_подключения>"
        
        labels = {
          "<ключ_1>" = "<значение_1>"
          "<ключ_2>" = "<значение_2>"
          ...
          "<ключ_N>" = "<значение_N>"
        }
        
        params = {
          redis = {
            cluster = {
              hosts = [
                {
                  host       = "<хост_1>"
                  port       = <порт_1>
                  shard_name = "<имя_шарда_1>"
                },
                {
                  host       = "<хост_2>"
                  port       = <порт_2>
                  shard_name = "<имя_шарда_2>"
                },
                ...
                {
                  host       = "<хост_N>"
                  port       = <порт_N>
                  shard_name = "<имя_шарда_N>"
                }
              ]
              
              tls_params = {
                tls {
                  ca_certificate = "<путь_к_сертификату>"
                }
              }
            }

            databases = [
              "<база_данных_1>",
              "<база_данных_2>",
              ...
              "<база_данных_N>"
            ]

            auth = {
              user_password = {
                user     = "<имя_пользователя>"
                password = {
                  raw = "<пароль>"
                }
              }
            }
          }
        }
      }
      ```

      Где:

      * `name` — имя подключения

      * `description` — описание подключения.

      * `labels` — набор меток в формате `"<ключ>" = "<значение>"`.

      * `params.redis` — параметры подключения к пользовательской инсталляции Redis:
        
        * `cluster.hosts` — список хостов. Для каждого хоста укажите параметры `host`, `port` и `shard_name`.

        * `cluster.tls_params` — параметры [TLS](../../glossary/tls.md). Укажите один из блоков:
        
          * `tls.ca_certificate` — путь к файлу CA-сертификата для TLS.
          * `disabled` — отключает TLS. По умолчанию TLS включен.

        * `databases` — список баз данных. Убедитесь, что у пользователя есть необходимые права доступа к ним.

        * `auth.user_password.user` — имя пользователя для подключения к базе данных.

        * `auth.user_password.password.raw` — пароль пользователя.


  1. (Опционально) Задайте в параметре `lockbox_secret_spec` идентификатор каталога для создания секрета (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Оба каталога, для подключения и секрета, должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. Если параметр не задан, секрет будет создан в том же каталоге, что и подключение.  

  1. Проверьте корректность настроек.
  
      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.
  
  1. Подтвердите изменение ресурсов.
  
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
  
  Подробнее см. в [документации провайдера Terraform](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  Чтобы создать подключение к пользовательской инсталляции Redis, воспользуйтесь методом REST API [Connection.Create](../connection-manager/api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md).

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `lockboxSecretSpec` укажите идентификатор этого каталога (потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. 

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.RedisCluster) и [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.RedisCluster).

{% endlist %}

### Valkey™ {#valkey-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
    1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
    1. Нажмите кнопку **Создать подключение**.
    1. Укажите имя подключения.
    1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
    1. В списке **Тип подключения** выберите **Valkey™**.
    1. В разделе **Подключение к Valkey™** укажите параметры подключения:
       1. В поле **Тип подключения** выберите **Пользовательская инсталляция**.
       1. В поле **Хосты** укажите [FQDN](../../glossary/fqdn.md) или IP-адреса хостов, входящих в шард, номер HTTP- или TCP-порта для подключения и имя [шарда](../../managed-valkey/operations/connect/sharded-code-examples.md).

           Если вы создаете подключение к пользовательской инсталляции базы данных для использования с [Yandex DataLens](../../datalens/concepts/index.md), укажите внешние IP-адреса хостов.

       1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
    1. В разделе **Аутентификация** укажите имя пользователя и выберите способ задания пароля: 
        * **Ввести вручную** — введите значение пароля.
        * **Сгенерировать** — укажите опции для создания автоматически сгенерированного пароля [Lockbox](../../lockbox/quickstart.md).
    1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
    1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `--secret-folder-id` укажите идентификатор этого каталога (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр.

  Чтобы создать подключение к пользовательской инсталляции Valkey™:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc metadata-hub connection-manager connection create valkey --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection create valkey \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --hosts <список_хостов> \
        --databases <список_БД> \
        --ca-certificate <путь_к_сертификату>
      ```

      Где:

      * `--name` — имя подключения.
      
      * `--description` — описание подключения.
      
      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.
      
      * `--user` — имя пользователя для подключения к базе данных.
      
      * `--password` — пароль пользователя.
            
      * `--hosts` — список хостов в формате `<хост>:<порт>`, через запятую.
            
      * `--databases` — список баз данных, через запятую.
      
        Убедитесь, что у пользователя есть необходимые права на доступ к ним.
            
      * `--ca-certificate` — путь к файлу CA-сертификата для TLS.
            
        По умолчанию [TLS](../../glossary/tls.md) включен. Чтобы отключить его, используйте флаг `--tls-disabled`.


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать подключение к пользовательской инсталляции Valkey™:

  1. Опишите в конфигурационном файле создаваемый ресурс.
  
      Пример структуры конфигурационного файла:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
        name        = "<имя_подключения>"
        description = "<описание_подключения>"
        
        labels = {
          "<ключ_1>" = "<значение_1>"
          "<ключ_2>" = "<значение_2>"
          ...
          "<ключ_N>" = "<значение_N>"
        }
        
        params = {
          valkey = {
            cluster = {
              hosts = [
                {
                  host = "<хост_1>"
                  port = <порт_1>
                },
                {
                  host = "<хост_2>"
                  port = <порт_2>
                },
                ...
                {
                  host = "<хост_N>"
                  port = <порт_N>
                }
              ]
              
              tls_params = {
                tls {
                  ca_certificate = "<путь_к_сертификату>"
                }
              }
            }

            databases = [
              "<база_данных_1>",
              "<база_данных_2>",
              ...
              "<база_данных_N>"
            ]

            auth = {
              user_password = {
                user     = "<имя_пользователя>"
                password = {
                  raw = "<пароль>"
                }
              }
            }
          }
        }
      }
      ```

      Где:

      * `name` — имя подключения

      * `description` — описание подключения.

      * `labels` — набор меток в формате `"<ключ>" = "<значение>"`.

      * `params.valkey` — параметры подключения к пользовательской инсталляции Valkey™:
        
        * `cluster.hosts` — список хостов. Для каждого хоста укажите параметры `host` и `port`.

        * `cluster.tls_params` — параметры [TLS](../../glossary/tls.md). Укажите один из блоков:
        
          * `tls.ca_certificate` — путь к файлу CA-сертификата для TLS.
          * `disabled` — отключает TLS. По умолчанию TLS включен.

        * `databases` — список баз данных. Убедитесь, что у пользователя есть необходимые права доступа к ним.

        * `auth.user_password.user` — имя пользователя для подключения к базе данных.

        * `auth.user_password.password.raw` — пароль пользователя.


  1. (Опционально) Задайте в параметре `lockbox_secret_spec` идентификатор каталога для создания секрета (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Оба каталога, для подключения и секрета, должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. Если параметр не задан, секрет будет создан в том же каталоге, что и подключение.  

  1. Проверьте корректность настроек.
  
      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.
  
  1. Подтвердите изменение ресурсов.
  
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
  
  Подробнее см. в [документации провайдера Terraform](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  Чтобы создать подключение к пользовательской инсталляции Valkey™, воспользуйтесь методом REST API [Connection.Create](../connection-manager/api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md).

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `lockboxSecretSpec` укажите идентификатор этого каталога (потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. 

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.ValkeyCluster) и [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.ValkeyCluster).

{% endlist %}

### Trino {#trino-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
  1. Нажмите кнопку **Создать подключение**.
  1. Укажите имя подключения.
  1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
  1. Выберите **Тип подключения**.
  1. В разделе **Подключение к Trino** укажите параметры подключения:
      1. В поле **Координатор** укажите адрес хоста [координатора](https://trino.io/docs/current/overview/concepts.html#coordinator) и номер порта для подключения. 
      1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
          Если в вашей компании есть [центр сертификации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.
  1. В разделе **Аутентификация**:
      1. Укажите **Имя пользователя**, от лица которого будете подключаться к базе данных.
      1. Выберите способ задания пароля:
          * **Ввести вручную** — вы сами задаете пароль.
          * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [Lockbox](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `--secret-folder-id` укажите идентификатор этого каталога (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр.

  Чтобы создать подключение к пользовательской инсталляции Trino:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc metadata-hub connection-manager connection create trino --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection create trino \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --coordinator <параметры_координатора> \
        --ca-certificate <путь_к_сертификату>
      ```

      Где:

      * `--name` — имя подключения.
      
      * `--description` — описание подключения.
      
      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.
      
      * `--user` — имя пользователя для подключения к базе данных.
      
      * `--password` — пароль пользователя.
      
      * `--coordinator` — параметры координатора в формате `<хост>:<порт>`.
      
      * `--ca-certificate` — путь к файлу CA-сертификата для TLS.
      
        По умолчанию [TLS](../../glossary/tls.md) включен. Чтобы отключить его, используйте флаг `--tls-disabled`.


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать подключение к пользовательской инсталляции Trino:

  1. Опишите в конфигурационном файле создаваемый ресурс.
  
      Пример структуры конфигурационного файла:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
        name        = "<имя_подключения>"
        description = "<описание_подключения>"
        
        labels = {
          "<ключ_1>" = "<значение_1>"
          "<ключ_2>" = "<значение_2>"
          ...
          "<ключ_N>" = "<значение_N>"
        }
        
        params = {
          trino = {
            cluster = {
              coordinator = {
                  host = "<хост>"
                  port = <порт>
              }
              
              tls_params = {
                tls {
                  ca_certificate = "<путь_к_сертификату>"
                }
              }
            }

            auth = {
              user_password = {
                user     = "<имя_пользователя>"
                password = {
                  raw = "<пароль>"
                }
              }
            }
          }
        }
      }
      ```

      Где:

      * `name` — имя подключения

      * `description` — описание подключения.

      * `labels` — набор меток в формате `"<ключ>" = "<значение>"`.

      * `params.trino` — параметры подключения к пользовательской инсталляции Trino:
        
        * `cluster.coordinator` — параметры координатора: `host` и `port`.

        * `cluster.tls_params` — параметры [TLS](../../glossary/tls.md). Укажите один из блоков:
        
          * `tls.ca_certificate` — путь к файлу CA-сертификата для TLS.
          * `disabled` — отключает TLS. По умолчанию TLS включен.

        * `auth.user_password.user` — имя пользователя для подключения к базе данных.

        * `auth.user_password.password.raw` — пароль пользователя.


  1. (Опционально) Задайте в параметре `lockbox_secret_spec` идентификатор каталога для создания секрета (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Оба каталога, для подключения и секрета, должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. Если параметр не задан, секрет будет создан в том же каталоге, что и подключение.  

  1. Проверьте корректность настроек.
  
      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.
  
  1. Подтвердите изменение ресурсов.
  
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
  
  Подробнее см. в [документации провайдера Terraform](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  Чтобы создать подключение к пользовательской инсталляции Trino, воспользуйтесь методом REST API [Connection.Create](../connection-manager/api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md).

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `lockboxSecretSpec` укажите идентификатор этого каталога (потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр.  

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.TrinoCluster) и [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.TrinoCluster).

{% endlist %}

### OpenSearch {#opensearch-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
   1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
   1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
   1. Нажмите кнопку **Создать подключение**.
   1. Укажите имя подключения.
   1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
   1. Выберите **Тип подключения**.
   1. В разделе **Подключение к OpenSearch** укажите параметры подключения:
       1. В поле **Тип подключения** выберите **Пользовательская инсталляция**.
       1. В поле **Хосты** укажите адрес хоста с базой данных и номер порта для подключения.
       1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
           Если в вашей компании есть [центр сертификации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.
   1. В разделе **Аутентификация**:
       1. Укажите **Имя пользователя**, от лица которого будете подключаться к базе данных.
       1. Выберите способ задания пароля:
           * **Ввести вручную** — вы сами задаете пароль.
           * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [Lockbox](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
   1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
   1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `--secret-folder-id` укажите идентификатор этого каталога (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр.

  Чтобы создать подключение к пользовательской инсталляции OpenSearch:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc metadata-hub connection-manager connection create opensearch --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection create opensearch \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --hosts <список_хостов> \
        --ca-certificate <путь_к_сертификату>
      ```

      Где:

      * `--name` — имя подключения.
      
      * `--description` — описание подключения.
      
      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.
      
      * `--user` — имя пользователя для подключения к базе данных.
      
      * `--password` — пароль пользователя.
      
      * `--hosts` — список хостов в формате `<хост>:<порт>`, через запятую.
      
      * `--ca-certificate` — путь к файлу CA-сертификата для TLS.
      
        По умолчанию [TLS](../../glossary/tls.md) включен. Чтобы отключить его, используйте флаг `--tls-disabled`.


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать подключение к пользовательской инсталляции OpenSearch:

  1. Опишите в конфигурационном файле создаваемый ресурс.
  
      Пример структуры конфигурационного файла:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
        name        = "<имя_подключения>"
        description = "<описание_подключения>"
        
        labels = {
          "<ключ_1>" = "<значение_1>"
          "<ключ_2>" = "<значение_2>"
          ...
          "<ключ_N>" = "<значение_N>"
        }
        
        params = {
          opensearch = {
            cluster = {
              hosts = [
                {
                  host = "<хост_1>"
                  port = <порт_1>
                },
                {
                  host = "<хост_2>"
                  port = <порт_2>
                },
                ...
                {
                  host = "<хост_N>"
                  port = <порт_N>
                }
              ]
              
              tls_params = {
                tls {
                  ca_certificate = "<путь_к_сертификату>"
                }
              }
            }

            auth = {
              user_password = {
                user     = "<имя_пользователя>"
                password = {
                  raw = "<пароль>"
                }
              }
            }
          }
        }
      }
      ```

      Где:

      * `name` — имя подключения

      * `description` — описание подключения.

      * `labels` — набор меток в формате `"<ключ>" = "<значение>"`.

      * `params.opensearch` — параметры подключения к пользовательской инсталляции OpenSearch:
        
        * `cluster.hosts` — список хостов. Для каждого хоста укажите параметры `host` и `port`.

        * `cluster.tls_params` — параметры [TLS](../../glossary/tls.md). Укажите один из блоков:
        
          * `tls.ca_certificate` — путь к файлу CA-сертификата для TLS.
          * `disabled` — отключает TLS. По умолчанию TLS включен.

        * `auth.user_password.user` — имя пользователя для подключения к базе данных.

        * `auth.user_password.password.raw` — пароль пользователя.


  1. (Опционально) Задайте в параметре `lockbox_secret_spec` идентификатор каталога для создания секрета (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Оба каталога, для подключения и секрета, должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. Если параметр не задан, секрет будет создан в том же каталоге, что и подключение.  

  1. Проверьте корректность настроек.
  
      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.
  
  1. Подтвердите изменение ресурсов.
  
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
  
  Подробнее см. в [документации провайдера Terraform](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  Чтобы создать подключение к пользовательской инсталляции OpenSearch, воспользуйтесь методом REST API [Connection.Create](../connection-manager/api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md).

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `lockboxSecretSpec` укажите идентификатор этого каталога (потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. 

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.OpenSearchCluster) и [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.OpenSearchCluster).

{% endlist %}

### MongoDB {#mongodb-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
   1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
   1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
   1. Нажмите кнопку **Создать подключение**.
   1. Укажите имя подключения.
   1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
   1. Выберите **Тип подключения**.
   1. В разделе **Подключение к MongoDB** укажите параметры подключения:
       1. В поле **Тип подключения** выберите **Пользовательская инсталляция**.
       1. В поле **Хосты** укажите адрес хоста с базой данных и номер порта для подключения.
       1. (Опционально) Включите использование [TLS](../../glossary/tls.md). 
           Если в вашей компании есть [центр сертификации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.
   1. В разделе **Аутентификация**:
       1. Укажите **Имя пользователя**, от лица которого будете подключаться к базе данных.
       1. Выберите способ задания пароля:
           * **Ввести вручную** — вы сами задаете пароль.
           * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [Lockbox](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
   1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
   1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `--secret-folder-id` укажите идентификатор этого каталога (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр.

  Чтобы создать подключение к пользовательской инсталляции MongoDB:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc metadata-hub connection-manager connection create mongodb --help
      ```
      
  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection create mongodb \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --hosts <список_хостов> \
        --databases <список_БД> \
        --ca-certificate <путь_к_сертификату>
      ```

      Где:

      * `--name` — имя подключения.
      
      * `--description` — описание подключения.
      
      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.
      
      * `--user` — имя пользователя для подключения к базе данных.
      
      * `--password` — пароль пользователя.
            
      * `--hosts` — список хостов в формате `<хост>:<порт>`, через запятую.
            
      * `--databases` — список баз данных, через запятую.
      
        Убедитесь, что у пользователя есть необходимые права на доступ к ним.
            
      * `--ca-certificate` — путь к файлу CA-сертификата для TLS.
            
        По умолчанию [TLS](../../glossary/tls.md) включен. Чтобы отключить его, используйте флаг `--tls-disabled`.


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать подключение к пользовательской инсталляции MongoDB:

  1. Опишите в конфигурационном файле создаваемый ресурс.
  
      Пример структуры конфигурационного файла:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
        name        = "<имя_подключения>"
        description = "<описание_подключения>"
        
        labels = {
          "<ключ_1>" = "<значение_1>"
          "<ключ_2>" = "<значение_2>"
          ...
          "<ключ_N>" = "<значение_N>"
        }
        
        params = {
          mongodb = {
            cluster = {
              hosts = [
                {
                  host = "<хост_1>"
                  port = <порт_1>
                },
                {
                  host = "<хост_2>"
                  port = <порт_2>
                },
                ...
                {
                  host = "<хост_N>"
                  port = <порт_N>
                }
              ]
              
              tls_params = {
                tls {
                  ca_certificate = "<путь_к_сертификату>"
                }
              }
            }

            databases = [
              "<база_данных_1>",
              "<база_данных_2>",
              ...
              "<база_данных_N>"
            ]

            auth = {
              user_password = {
                user     = "<имя_пользователя>"
                password = {
                  raw = "<пароль>"
                }
              }
            }
          }
        }
      }
      ```

      Где:

      * `name` — имя подключения

      * `description` — описание подключения.

      * `labels` — набор меток в формате `"<ключ>" = "<значение>"`.

      * `params.mongodb` — параметры подключения к пользовательской инсталляции MongoDB:
        
        * `cluster.hosts` — список хостов. Для каждого хоста укажите параметры `host` и `port`.

        * `cluster.tls_params` — параметры [TLS](../../glossary/tls.md). Укажите один из блоков:
        
          * `tls.ca_certificate` — путь к файлу CA-сертификата для TLS.
          * `disabled` — отключает TLS. По умолчанию TLS включен.

        * `databases` — список баз данных. Убедитесь, что у пользователя есть необходимые права доступа к ним.

        * `auth.user_password.user` — имя пользователя для подключения к базе данных.

        * `auth.user_password.password.raw` — пароль пользователя.


  1. (Опционально) Задайте в параметре `lockbox_secret_spec` идентификатор каталога для создания секрета (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Оба каталога, для подключения и секрета, должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. Если параметр не задан, секрет будет создан в том же каталоге, что и подключение.  

  1. Проверьте корректность настроек.
  
      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.
  
  1. Подтвердите изменение ресурсов.
  
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
  
  Подробнее см. в [документации провайдера Terraform](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  Чтобы создать подключение к пользовательской инсталляции MongoDB, воспользуйтесь методом REST API [Connection.Create](../connection-manager/api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md).

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `lockboxSecretSpec` укажите идентификатор этого каталога (потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. 

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.MongoDBCluster) и [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.MongoDBCluste).

{% endlist %}

### Apache Kafka® {#kafka-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
   1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
   1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
   1. Нажмите кнопку **Создать подключение**.
   1. Укажите имя подключения.
   1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
   1. Выберите **Тип подключения**.
   1. В разделе **Подключение к Apache Kafka®** укажите параметры подключения:
       
       * В списке **Тип подключения** выберите **Пользовательская инсталляция**.
       * В поле **Хосты** укажите адрес хоста и порт для подключения.
       * (Опционально) Включите использование [TLS](../../glossary/tls.md).
           
           Если в вашей компании есть [центр сертификации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.
   
   1. При использовании аутентификации:

       * Укажите **Имя пользователя** для подключения.
       * Задайте пароль одним из способов:
         
         * **Ввести вручную** — пароль вводится в соответствующее поле.
         * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [Lockbox](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
       
       * (Опционально) В списке **Механизмы аутентификации** выберите нужные опции:
         
         * `PLAIN` — аутентификация с передачей логина и пароля в открытом виде.
         * `SCRAM_SHA256` — аутентификация с хэшированием SHA-256.
         * `SCRAM_SHA512` — аутентификация с хэшированием SHA-512.

         [Подробнее о механизмах и протоколах SASL](../../glossary/sasl.md#mechanisms-and-protocols).

   1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `--secret-folder-id` укажите идентификатор этого каталога (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр.

  Чтобы создать подключение к пользовательской инсталляции Apache Kafka®:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc metadata-hub connection-manager connection create kafka --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection create kafka \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --supported-mechanisms <список_механизмов_аутентификации> \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --hosts <список_хостов> \
        --ca-certificate <путь_к_сертификату>
      ```

      Где:

      * `--name` — имя подключения.

      * `--description` — описание подключения.

      * `--supported-mechanisms` — список механизмов аутентификации. Возможные значения:
        
        * `PLAIN` — аутентификация с передачей логина и пароля в открытом виде.
        * `SCRAM_SHA256` — аутентификация с хэшированием SHA-256.
        * `SCRAM_SHA512` — аутентификация с хэшированием SHA-512.

        [Подробнее о механизмах и протоколах SASL](../../glossary/sasl.md#mechanisms-and-protocols).

      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.

      * `--user` — имя пользователя для подключения к кластеру.

      * `--password` — пароль пользователя.
      
      * `--hosts` — список хостов в формате `<хост>:<порт>`, через запятую.
      
      * `--ca-certificate` — путь к файлу CA-сертификата для TLS.
        
        По умолчанию [TLS](../../glossary/tls.md) включен. Чтобы отключить его, используйте флаг `--tls-disabled`.


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать подключение к пользовательской инсталляции Apache Kafka®:

  1. Опишите в конфигурационном файле создаваемый ресурс.
  
      Пример структуры конфигурационного файла:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
        name        = "<имя_подключения>"
        description = "<описание_подключения>"
        
        labels = {
          "<ключ_1>" = "<значение_1>"
          "<ключ_2>" = "<значение_2>"
          ...
          "<ключ_N>" = "<значение_N>"
        }
        
        params = {
          kafka = {
            cluster = {
              hosts = [
                {
                  host = "<хост_1>"
                  port = <порт_1>
                },
                {
                  host = "<хост_2>"
                  port = <порт_2>
                },
                ...
                {
                  host = "<хост_N>"
                  port = <порт_N>
                }
              ]
              
              tls_params = {
                tls {
                  ca_certificate = "<путь_к_сертификату>"
                }
              }
            }

            auth = {
              sasl = {
                user     = "<имя_пользователя>"
                password = { 
                  raw = "<пароль>"
                }
                supported_mechanisms = [
                  <список_механизмов_аутентификации>
                ]
              }
            }
          }
        }
      }
      ```

      Где:

      * `name` — имя подключения

      * `description` — описание подключения.

      * `labels` — набор меток в формате `"<ключ>" = "<значение>"`.

      * `params.kafka` — параметры подключения к пользовательской инсталляции Apache Kafka®:
        
        * `cluster.hosts` — список хостов. Для каждого хоста укажите параметры `host` и `port`.

        * `cluster.tls_params` — параметры [TLS](../../glossary/tls.md). Укажите один из блоков:
        
          * `tls.ca_certificate` — путь к файлу CA-сертификата для TLS.
          * `disabled` — отключает TLS. По умолчанию TLS включен.

        * `auth` — параметры аутентификации. Укажите один из блоков:

          * `sasl` — параметры SASL-аутентификации:
            
            * `user` — имя пользователя для подключения к кластеру.
            * `password.raw` — пароль пользователя.
            * `supported_mechanisms` — список механизмов аутентификации. Возможные значения:
              
              * `PLAIN` — аутентификация с передачей логина и пароля в открытом виде.
              * `SCRAM_SHA256` — аутентификация с хэшированием SHA-256.
              * `SCRAM_SHA512` — аутентификация с хэшированием SHA-512.

              [Подробнее о механизмах и протоколах SASL](../../glossary/sasl.md#mechanisms-and-protocols).
          
          * `disabled` — отключает аутентификацию.


  1. (Опционально) Задайте в параметре `lockbox_secret_spec` идентификатор каталога для создания секрета (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Оба каталога, для подключения и секрета, должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. Если параметр не задан, секрет будет создан в том же каталоге, что и подключение.  

  1. Проверьте корректность настроек.
  
      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.
  
  1. Подтвердите изменение ресурсов.
  
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
  
  Подробнее см. в [документации провайдера Terraform](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  Чтобы создать подключение к пользовательской инсталляции Apache Kafka®, воспользуйтесь методом REST API [Connection.Create](../connection-manager/api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md).

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `lockboxSecretSpec` укажите идентификатор этого каталога (потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. 

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.KafkaCluster) и [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.KafkaCluster).

{% endlist %}

### Greenplum® {#greenplum-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
  1. Нажмите кнопку **Создать подключение**.
  1. Укажите имя подключения.
  1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
  1. Выберите **Тип подключения**.
  1. В разделе **Подключение к Greenplum** укажите параметры подключения:
      1. В поле **Тип подключения** выберите **Пользовательская инсталляция**.
      1. В поле **Хосты** укажите адрес хоста с базой данных и номер порта для подключения.

          Если вы создаете подключение к пользовательской инсталляции базы данных для использования с [Yandex DataLens](../../datalens/concepts/index.md), укажите внешний адрес хоста.

      1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
          
          Если в вашей компании есть [центр сертификации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.
          
  1. В разделе **Аутентификация**:
      1. Укажите **Имя пользователя** для подключения.
      1. Выберите способ задания пароля:
          * **Ввести вручную** — пароль вводится в соответствующее поле.
          * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [Lockbox](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
  1. Перечислите базы данных, подключениями к которым вы хотите управлять. Убедитесь, что у пользователя есть необходимые права на доступ к ним.
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `--secret-folder-id` укажите идентификатор этого каталога (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр.

  Чтобы создать подключение к пользовательской инсталляции Greenplum®:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc metadata-hub connection-manager connection create greenplum --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection create greenplum \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --hosts <список_хостов> \
        --databases <список_БД> \
        --ca-certificate <путь_к_сертификату>
      ```

      Где:

      * `--name` — имя подключения.
      
      * `--description` — описание подключения.
      
      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.
      
      * `--user` — имя пользователя для подключения к базе данных.
      
      * `--password` — пароль пользователя.
            
      * `--hosts` — список хостов в формате `<хост>:<порт>`, через запятую.
            
      * `--databases` — список баз данных, через запятую.
      
        Убедитесь, что у пользователя есть необходимые права на доступ к ним.
            
      * `--ca-certificate` — путь к файлу CA-сертификата для TLS.
            
        По умолчанию [TLS](../../glossary/tls.md) включен. Чтобы отключить его, используйте флаг `--tls-disabled`.


- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать подключение к пользовательской инсталляции Greenplum®:

  1. Опишите в конфигурационном файле создаваемый ресурс.
  
      Пример структуры конфигурационного файла:
  
      ```hcl
      resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
        name        = "<имя_подключения>"
        description = "<описание_подключения>"
        
        labels = {
          "<ключ_1>" = "<значение_1>"
          "<ключ_2>" = "<значение_2>"
          ...
          "<ключ_N>" = "<значение_N>"
        }
        
        params = {
          greenplum = {
            cluster = {
              hosts = [
                {
                  host = "<хост_1>"
                  port = <порт_1>
                },
                {
                  host = "<хост_2>"
                  port = <порт_2>
                },
                ...
                {
                  host = "<хост_N>"
                  port = <порт_N>
                }
              ]
              
              tls_params = {
                tls {
                  ca_certificate = "<путь_к_сертификату>"
                }
              }
            }

            databases = [
              "<база_данных_1>",
              "<база_данных_2>",
              ...
              "<база_данных_N>"
            ]

            auth = {
              user_password = {
                user     = "<имя_пользователя>"
                password = {
                  raw = "<пароль>"
                }
              }
            }
          }
        }
      }
      ```

      Где:

      * `name` — имя подключения

      * `description` — описание подключения.

      * `labels` — набор меток в формате `"<ключ>" = "<значение>"`.

      * `params.greenplum` — параметры подключения к пользовательской инсталляции Greenplum®:
        
        * `cluster.hosts` — список хостов. Для каждого хоста укажите параметры `host` и `port`.

        * `cluster.tls_params` — параметры [TLS](../../glossary/tls.md). Укажите один из блоков:
        
          * `tls.ca_certificate` — путь к файлу CA-сертификата для TLS.
          * `disabled` — отключает TLS. По умолчанию TLS включен.

        * `databases` — список баз данных. Убедитесь, что у пользователя есть необходимые права доступа к ним.

        * `auth.user_password.user` — имя пользователя для подключения к базе данных.

        * `auth.user_password.password.raw` — пароль пользователя.


  1. (Опционально) Задайте в параметре `lockbox_secret_spec` идентификатор каталога для создания секрета (для этого вам потребуется роль `resource-manager.user` на целевой каталог). Оба каталога, для подключения и секрета, должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. Если параметр не задан, секрет будет создан в том же каталоге, что и подключение.  

  1. Проверьте корректность настроек.
  
      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.
  
  1. Подтвердите изменение ресурсов.
  
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
  
  Подробнее см. в [документации провайдера Terraform](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).


- API {#api}

  Чтобы создать подключение к пользовательской инсталляции MongoDB, воспользуйтесь методом REST API [Connection.Create](../connection-manager/api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../connection-manager/api-ref/grpc/Connection/create.md).

  По умолчанию секреты создаются в том же каталоге, что и подключения. Чтобы создать секрет в другом каталоге, в параметре `lockboxSecretSpec` укажите идентификатор этого каталога (потребуется роль `resource-manager.user` на целевой каталог). Каталоги для подключения и секрета должны находиться в одном облаке. После создания подключения вы не сможете изменить этот параметр. 

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../connection-manager/api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.GreenplumCluster) и [gRPC API](../connection-manager/api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.GreenplumCluster).

{% endlist %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._