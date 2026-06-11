# Создание кластера Apache Hive™ Metastore

Подробнее о кластерах Apache Hive™ Metastore в сервисе Yandex MetaData Hub читайте в разделе [Кластеры Apache Hive™ Metastore](../../concepts/metastore.md).

## Перед началом работы {#before-you-begin}

1. Для привязки [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) к кластеру Apache Hive™ Metastore [убедитесь](../../../iam/operations/roles/get-assigned-roles.md), что вашему аккаунту в Yandex Cloud назначена роль [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user) или выше.
1. [Настройте NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) в подсети, к которой будет подключен кластер. Это необходимо, чтобы кластер мог взаимодействовать с сервисами Yandex Cloud.
1. [Настройте группу безопасности](configure-security-group.md).
1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md).
1. [Назначьте сервисному аккаунту](../../../iam/operations/sa/assign-role-for-sa.md) роль `managed-metastore.integrationProvider`. Она позволяет кластеру от имени сервисного аккаунта [взаимодействовать с сервисами](../../concepts/metastore-impersonation.md) Yandex Cloud, например с Yandex Cloud Logging и Yandex Monitoring.
   
    Для использования Object Storage дополнительно назначьте сервисному аккаунту кластера [роль](../../../storage/security/index.md#storage-editor) `storage.editor`.

    Вы можете добавить дополнительные роли. Их набор зависит от сценария работы. Сервисные роли приведены в [разделе для Apache Hive™ Metastore](../../security/metastore-roles.md), все доступные роли — в [справочнике](../../../iam/roles-reference.md).

1. Если вы хотите сохранять логи кластера в пользовательскую лог-группу, [создайте ее](../../../logging/operations/create-group.md).

    Подробнее в разделе [Передача логов кластера](logging.md).

## Создание кластера {#create-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать сервер.
    1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
    1. На панели слева выберите ![image](../../../_assets/console-icons/database.svg) **Metastore-сервер**.
    1. Нажмите кнопку **Создать кластер**.
    1. Введите имя кластера. Оно должно быть уникальным в рамках каталога.
    1. (Опционально) Введите описание кластера.
    1. (Опционально) Добавьте [метки Yandex Cloud](../../../resource-manager/concepts/labels.md) для разделения ресурсов на логические группы.
    1. Укажите сервисный аккаунт, созданный ранее.
    1. Выберите версию Apache Hive™ Metastore.

        Доступны версии 3.1, 4.0 и 4.2.
        
        {% note warning %}
        
        Для интеграции кластера Apache Hive™ Metastore с сервисом [Yandex Managed Service for Apache Spark™](../../../managed-spark/index.md) требуется соответствие версий:
        
        * версия Apache Spark™ 3.5.7 работает с версией Apache Hive™ Metastore 3.1;
        * версия Apache Spark™ 4.0.0 работает с версиями Apache Hive™ Metastore 3.1 и выше.
        
        При необходимости версию Apache Hive™ Metastore 3.1 можно повысить последовательно: 3.1 → 4.0 → 4.2, но понизить версию 4.2 до 3.1 невозможно.
        
        {% endnote %}

    1. В блоке **Хранилище данных Hive Metastore** укажите параметры бакета для хранения данных таблиц:

        * **Имя бакета** — имя бакета Object Storage, который будет использоваться в качестве хранилища данных Apache Hive™ Metastore (warehouse).
        * **Путь внутри бакета** — путь внутри бакета, который будет использоваться как префикс для данных Apache Hive™ Metastore. Опциональный параметр.

    1. В блоке **Сетевые настройки** выберите сеть и подсеть, в которых будет размещен кластер Apache Hive™ Metastore. Укажите заранее настроенную группу безопасности.
    1. В блоке **Metastore** выберите [конфигурацию кластера](../../concepts/metastore.md#presets).
    1. (Опционально) Задайте настройки логирования:

        1. Включите опцию **Запись логов**.
        1. Выберите, куда записывать логи кластера:

            * В лог-группу по умолчанию — выберите значение **Каталог** в поле **Назначение** и укажите нужный каталог. Логи будут храниться в лог-группе, которая действует по умолчанию в выбранном каталоге.
            * В пользовательскую лог-группу — выберите значение **Лог-группа** в поле **Назначение** и укажите заранее созданную лог-группу.

        1. Выберите минимальный уровень логирования.

            В журнал выполнения записываются логи указанного уровня и выше. Доступные уровни — `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`. Уровень по умолчанию — `INFO`.
    1. При необходимости включите защиту кластера от непреднамеренного удаления пользователем.

        Включенная защита кластера от удаления не помешает подключиться к нему вручную и удалить данные.

    1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы создать кластер Apache Hive™ Metastore:

  1. Посмотрите описание команды CLI для создания кластера:
 
      ```bash
      yc managed-metastore cluster create --help
      ```

  1. Укажите параметры кластера в команде создания:

      ```bash
      yc managed-metastore cluster create \
         --name <имя_кластера> \
         --description <описание_кластера> \
         --labels <список_меток> \
         --service-account-id <идентификатор_сервисного_аккаунта> \
         --version <версия_Apache_Hive™_Metastore> \
         --warehouse-bucket <имя_бакета> \
         --warehouse-path <путь_внутри_бакета> \
         --subnet-ids <идентификаторы_подсетей> \
         --security-group-ids <идентификаторы_групп_безопасности> \
         --resource-preset-id <идентификатор_вычислительных_ресурсов> \
         --maintenance-window type=<тип_технического_обслуживания>,`
                              `day=<день_недели>,`
                              `hour=<час_дня> \
         --deletion-protection \
         --log-enabled \
         --log-folder-id <идентификатор_каталога> \
         --log-min-level <уровень_логирования>
      ```

      Где:

      * `--name` — имя кластера.

      * `--description` — описание кластера.
      * `--labels` — список [меток](../../../resource-manager/concepts/labels.md). Метки задаются в формате `<ключ>=<значение>`.
      * `--service-account-id` — идентификатор [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).
      * `--version` — версия Apache Hive™ Metastore.
      
        Доступны версии 3.1, 4.0 и 4.2.
        
        {% note warning %}
        
        Для интеграции кластера Apache Hive™ Metastore с сервисом [Yandex Managed Service for Apache Spark™](../../../managed-spark/index.md) требуется соответствие версий:
        
        * версия Apache Spark™ 3.5.7 работает с версией Apache Hive™ Metastore 3.1;
        * версия Apache Spark™ 4.0.0 работает с версиями Apache Hive™ Metastore 3.1 и выше.
        
        При необходимости версию Apache Hive™ Metastore 3.1 можно повысить последовательно: 3.1 → 4.0 → 4.2, но понизить версию 4.2 до 3.1 невозможно.
        
        {% endnote %}
      
      * `--warehouse-bucket` — имя бакета Object Storage, который будет использован в качестве хранилища данных Apache Hive™ Metastore (warehouse).
      * `--warehouse-path` — путь внутри бакета, который будет использоваться как префикс для данных Apache Hive™ Metastore. Опциональный параметр.

      * `--subnet-ids` — список идентификаторов подсетей.

      * `--security-group-ids` — список идентификаторов [групп безопасности](configure-security-group.md).
      * `--resource-preset-id` — [конфигурация вычислительных ресурсов](../../concepts/metastore.md#presets).
      * `--maintenance-window` — настройки времени технического обслуживания (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:
      
          * `anytime` (по умолчанию) — в любое время.
          * `weekly` — по расписанию. Для этого значения дополнительно укажите:
              * `day` — день недели: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
              * `hour` — порядковый номер часового интервала по UTC: от `1` до `24`.
          
                > Например, `1` соответствует интервалу с `00:00` до `01:00`, `5` — с `04:00` до `05:00`.
      
      * `--deletion-protection` — включает защиту кластера от непреднамеренного удаления.
      * Параметры логирования:
      
          * `--log-enabled` — включает логирование. Логи, сгенерированные компонентами Apache Hive™ Metastore, будут отправляться в Yandex Cloud Logging.
          * `--log-folder-id` — идентификатор каталога. Логи будут записываться в [лог-группу](../../../logging/concepts/log-group.md) по умолчанию для этого каталога.
          * `--log-group-id` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.
      
            Укажите один из двух параметров: `--log-folder-id` либо `--log-group-id`.
      
          * `--log-min-level` — минимальный уровень логирования. Возможные значения: `TRACE`, `DEBUG`, `INFO` (значение по умолчанию), `WARN`, `ERROR` и `FATAL`.


- Terraform {#tf}

    [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
    
    Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
    
    Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

    Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    
    
    Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

    Чтобы создать кластер Apache Hive™ Metastore:

    1. Опишите в конфигурационном файле создаваемые ресурсы:

        * Кластер Apache Hive™ Metastore — описание кластера.

        * Сеть — описание [облачной сети](../../../vpc/concepts/network.md#network), в которой будет расположен кластер. Если подходящая сеть у вас уже есть, описывать ее повторно не нужно.

        * Подсети — описание [подсетей](../../../vpc/concepts/network.md#subnet), к которым будут подключены хосты кластера. Если подходящие подсети у вас уже есть, описывать их повторно не нужно.

        Пример структуры конфигурационного файла:

        ```hcl

        resource "yandex_metastore_cluster" "<имя_кластера>" {
          name                = "<имя_кластера>"
          subnet_ids          = [yandex_vpc_subnet.<имя_подсети>.id]
          security_group_ids  = [<список_идентификаторов_групп_безопасности>]
          service_account_id  = "<идентификатор_сервисного_аккаунта>"
          deletion_protection = <защитить_кластер_от_удаления>
          version             = "<версия>"

          cluster_config = {
            resource_preset_id = "<класс_вычислительных_ресурсов>"
            warehouse_config = {
              s3 = {
                bucket = "<имя_бакета>"
                path   = "<путь_внутри_бакета>"
              }
            }
          }

          maintenance_window = {
            type = "<тип_технического_обслуживания>"
            day  = "<день_недели>"
            hour = <час_дня>
          }

          logging = {
            enabled   = <включить_логирование>
            folder_id = "<идентификатор_каталога>"
            min_level = "<уровень_логирования>"
          }
        }

        resource "yandex_vpc_network" "<имя_сети>" { name = "<имя_сети>" }

        resource "yandex_vpc_subnet" "<имя_подсети>" {
          name           = "<имя_подсети>"
          zone           = "<зона_доступности>"
          network_id     = "<идентификатор_сети>"
          v4_cidr_blocks = ["<диапазон>"]
        }
        ```

        Где:

        * `name` — имя кластера.
        * `subnet_ids` — список идентификаторов подсетей.
        * `security_group_ids` — список идентификаторов [групп безопасности](configure-security-group.md).
        * `service_account_id` — идентификатор [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).
        * `deletion_protection` — позволяет включить защиту кластера от непреднамеренного удаления. Возможные значения: `true` или `false`.
        * `version` — версия Apache Hive™ Metastore.

            Доступны версии 3.1, 4.0 и 4.2.
            
            {% note warning %}
            
            Для интеграции кластера Apache Hive™ Metastore с сервисом [Yandex Managed Service for Apache Spark™](../../../managed-spark/index.md) требуется соответствие версий:
            
            * версия Apache Spark™ 3.5.7 работает с версией Apache Hive™ Metastore 3.1;
            * версия Apache Spark™ 4.0.0 работает с версиями Apache Hive™ Metastore 3.1 и выше.
            
            При необходимости версию Apache Hive™ Metastore 3.1 можно повысить последовательно: 3.1 → 4.0 → 4.2, но понизить версию 4.2 до 3.1 невозможно.
            
            {% endnote %}

        * `cluster_config.resource_preset_id` — [конфигурация вычислительных ресурсов](../../concepts/metastore.md#presets).
        * `cluster_config.warehouse_config.s3` — параметры хранилища данных Apache Hive™ Metastore:
           * `bucket` — имя бакета Object Storage.
           * `path` — путь внутри бакета, который будет использоваться как префикс для данных Apache Hive™ Metastore.
        * `maintenance_window` — настройки времени технического обслуживания (в т. ч. для выключенных кластеров). 
          
          * `type` — тип технического обслуживания. Принимает значения:
              * `ANYTIME` — в любое время.
              * `WEEKLY` — по расписанию.
          * `day` — день недели для типа `WEEKLY`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
          * `hour` — час дня по UTC для типа `WEEKLY`: от `1` до `24`.
        * `logging` — параметры логирования:

            * `enable` — позволяет включить логирование. Логи, сгенерированные компонентами Apache Hive™ Metastore, будут отправляться в Yandex Cloud Logging. Возможные значения: `true` или `false`.
            * `folder_id` — идентификатор каталога. Логи будут записываться в [лог-группу](../../../logging/concepts/log-group.md) по умолчанию для этого каталога.
            * `group_id` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.

                Укажите один из двух параметров: `folder_id` либо `group_id`.

            * `min_level` — минимальный уровень логирования. Возможные значения: `TRACE`, `DEBUG`, `INFO` (значение по умолчанию), `WARN`, `ERROR` и `FATAL`.

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

    Подробная информация о ресурсах, которые вы можете создать с помощью Terraform, в [документации провайдера](../../../terraform/resources/metastore_cluster.md).


- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "folderId": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "labels": { "<список_меток>" },
          "deletionProtection": <защита_от_удаления>,
          "version": "<версия_Apache_Hive™_Metastore>",
          "configSpec": {
            "resources": {
            "resourcePresetId": "<идентификатор_конфигурации_ресурсов>"
            },
            "warehouse": {
              "s3": {
                "bucket": "<имя_бакета>",
                "path": "<путь_внутри_бакета>"
              }
            }
          },
          "serviceAccountId": "<идентификатор_сервисного_аккаунта>",
          "logging": {
            "enabled": <использование_логирования>,
            "folderId": "<идентификатор_каталога>",
            "minLevel": "<уровень_логирования>"
          },
          "network": {
            "subnetIds": [ "<список_идентификаторов_подсетей>" ],
            "securityGroupIds": [ "<список_идентификаторов_групп_безопасности>" ]
          },
          "maintenanceWindow": {
            "weeklyMaintenanceWindow": {
            "day": "<день_недели>",
            "hour": "<час>"
            }
          }
        }
        ```
        Где:

        * `folderId` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../../resource-manager/operations/folder/get-id.md).

        * `name` — имя кластера.
        * `description` — описание кластера.
        * `labels` — список меток. Метки задаются в формате `"<ключ>": "<значение>"`.
        * `deletionProtection` — позволяет включить защиту кластера от непреднамеренного удаления. Возможные значения: `true` или `false`.
        * `version` — версия Apache Hive™ Metastore.
        
          Доступны версии 3.1, 4.0 и 4.2.
          
          {% note warning %}
          
          Для интеграции кластера Apache Hive™ Metastore с сервисом [Yandex Managed Service for Apache Spark™](../../../managed-spark/index.md) требуется соответствие версий:
          
          * версия Apache Spark™ 3.5.7 работает с версией Apache Hive™ Metastore 3.1;
          * версия Apache Spark™ 4.0.0 работает с версиями Apache Hive™ Metastore 3.1 и выше.
          
          При необходимости версию Apache Hive™ Metastore 3.1 можно повысить последовательно: 3.1 → 4.0 → 4.2, но понизить версию 4.2 до 3.1 невозможно.
          
          {% endnote %}
        
        * `configSpec.resources.resourcePresetId` — [конфигурация вычислительных ресурсов](../../concepts/metastore.md#presets).
        * `configSpec.warehouse.s3` — параметры хранилища данных Apache Hive™ Metastore:
        
          * `bucket` — имя бакета Object Storage, который будет использоваться в качестве хранилища данных Apache Hive™ Metastore (warehouse).
          * `path` — путь внутри бакета, который будет использоваться как префикс для данных Apache Hive™ Metastore. Опциональный параметр.
        
        * `serviceAccountId` — идентификатор [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).
        * `logging` — параметры логирования:
        
          * `enabled` — позволяет включить логирование. Логи, сгенерированные компонентами Apache Hive™ Metastore, будут отправляться в Yandex Cloud Logging. Возможные значения: `true` или `false`.
          * `folderId` — идентификатор каталога. Логи будут записываться в [лог-группу](../../../logging/concepts/log-group.md) по умолчанию для этого каталога.
          * `logGroupId` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.
        
              Укажите один из двух параметров: `folderId` либо `logGroupId`.
        
          * `minLevel` — минимальный уровень логирования. Возможные значения: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`.

        * `network` — сетевые настройки:
          * `subnetIds` — список идентификаторов подсетей.
          * `securityGroupIds` — список идентификаторов [групп безопасности](../../../vpc/concepts/network.md#security-groups).

        * `maintenanceWindow` — настройки времени технического обслуживания (в т. ч. для выключенных кластеров). В `maintenanceWindow` передайте один из двух параметров:
          
            * `anytime` — техническое обслуживание происходит в произвольное время.
            * `weeklyMaintenanceWindow` — техническое обслуживание происходит раз в неделю, в указанное время:
          
              * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`;
              * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

    1. Воспользуйтесь методом [Cluster.Create](../../api-ref/Cluster/create.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://metastore.api.cloud.yandex.net/managed-metastore/v1/clusters' \
            --data '@body.json'
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Cluster/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "folder_id": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "labels": "{ <список_меток> }",
          "deletion_protection": <защита_от_удаления>,
          "version": "<версия_Apache_Hive™_Metastore>",
          "config_spec": {
            "resources": {
              "resource_preset_id": "<идентификатор_конфигурации_ресурсов>"
            },
            "warehouse": {
              "s3": {
                "bucket": "<имя_бакета>",
                "path": "<путь_внутри_бакета>"
              }
            }
          },
          "service_account_id": "<идентификатор_сервисного_аккаунта>",
          "logging": {
            "enabled": <использование_логирования>,
            "folder_id": "<идентификатор_каталога>",
            "min_level": "<уровень_логирования>"
          },
          "network": {
            "subnet_ids": [ "<список_идентификаторов_подсетей>" ],
            "security_group_ids": [ "<список_идентификаторов_групп_безопасности>" ]
          },
          "maintenance_window": {
            "weekly_maintenance_window": {
              "day": "<день_недели>",
              "hour": "<час>"
            }
          }
        }
        ```

        Где:

        * `folder_id` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../../resource-manager/operations/folder/get-id.md).

        * `name` — имя кластера.
        * `description` — описание кластера.
        * `labels` — список меток. Метки задаются в формате `"<ключ>": "<значение>"`.
        * `deletion_protection` — позволяет включить защиту кластера от непреднамеренного удаления. Возможные значения: `true` или `false`.
        * `version` — версия Apache Hive™ Metastore.
        
          Доступны версии 3.1, 4.0 и 4.2.
          
          {% note warning %}
          
          Для интеграции кластера Apache Hive™ Metastore с сервисом [Yandex Managed Service for Apache Spark™](../../../managed-spark/index.md) требуется соответствие версий:
          
          * версия Apache Spark™ 3.5.7 работает с версией Apache Hive™ Metastore 3.1;
          * версия Apache Spark™ 4.0.0 работает с версиями Apache Hive™ Metastore 3.1 и выше.
          
          При необходимости версию Apache Hive™ Metastore 3.1 можно повысить последовательно: 3.1 → 4.0 → 4.2, но понизить версию 4.2 до 3.1 невозможно.
          
          {% endnote %}
        
        * `config_spec.resources.resource_preset_id` — [конфигурация вычислительных ресурсов](../../concepts/metastore.md#presets).
        * `config_spec.warehouse.s3` — параметры хранилища данных Apache Hive™ Metastore:
        
          * `bucket` — имя бакета Object Storage, который будет использоваться в качестве хранилища данных Apache Hive™ Metastore (warehouse).
          * `path` — путь внутри бакета, который будет использоваться как префикс для данных Apache Hive™ Metastore. Опциональный параметр.
        
        * `service_account_id` — идентификатор [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).
        * `logging` — параметры логирования:
        
          * `enabled` — позволяет включить логирование. Логи, сгенерированные компонентами Apache Hive™ Metastore, будут отправляться в Yandex Cloud Logging. Возможные значения: `true` или `false`.
          * `folder_id` — идентификатор каталога. Логи будут записываться в [лог-группу](../../../logging/concepts/log-group.md) по умолчанию для этого каталога.
          * `log_group_id` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.
        
              Укажите один из двух параметров: `folder_id` либо `log_group_id`.
        
          * `min_level` — минимальный уровень логирования. Возможные значения: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`.

        * `network` — сетевые настройки:
            * `subnet_ids` — список идентификаторов подсетей.
            * `security_group_ids` — список идентификаторов [групп безопасности](../../../vpc/concepts/network.md#security-groups).

        * `maintenance_window` — настройки времени технического обслуживания (в т. ч. для выключенных кластеров). В `maintenance_window` передайте один из двух параметров:
          
            * `anytime` — техническое обслуживание происходит в произвольное время.
            * `weekly_maintenance_window` — техническое обслуживание происходит раз в неделю, в указанное время:
          
              * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`;
              * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

    1. Воспользуйтесь вызовом [ClusterService.Create](../../api-ref/grpc/Cluster/create.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/metastore/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            metastore.api.cloud.yandex.net:443 \
            yandex.cloud.metastore.v1.ClusterService.Create \
            < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

_Apache® и [Apache Hive™](https://hive.apache.org/) являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._