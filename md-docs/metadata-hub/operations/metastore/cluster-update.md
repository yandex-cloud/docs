[Документация Yandex Cloud](../../../index.md) > [Yandex MetaData Hub](../../index.md) > Apache Hive™ Metastore > Пошаговые инструкции > Изменение кластера

# Изменение кластера Apache Hive™ Metastore

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно изменить кластер.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/database.svg) **Metastore-сервер**.
  1. В строке с нужным кластером нажмите на значок ![options](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **Редактировать**.
  1. В блоке **Базовые параметры**:
  
        1. Измените имя и описание кластера.
        1. Удалите или добавьте новые [метки Yandex Cloud](../../../resource-manager/concepts/labels.md).
        1. Выберите другой [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) или создайте новый с ролью `managed-metastore.integrationProvider`.
        1. Измените версию Apache Hive™ Metastore.

            Доступны версии 3.1, 4.0 и 4.2.
            
            {% note warning %}
            
            Для интеграции кластера Apache Hive™ Metastore с сервисом [Yandex Managed Service for Apache Spark™](../../../managed-spark/index.md) требуется соответствие версий:
            
            * версия Apache Spark™ 3.5.7 работает с версией Apache Hive™ Metastore 3.1;
            * версия Apache Spark™ 4.0.0 работает с версиями Apache Hive™ Metastore 3.1 и выше.
            
            При необходимости версию Apache Hive™ Metastore 3.1 можно повысить последовательно: 3.1 → 4.0 → 4.2, но понизить версию 4.2 до 3.1 невозможно.
            
            {% endnote %}

  1. В блоке **Хранилище данных Hive Metastore** измените параметры бакета:

        * **Имя бакета** — имя бакета Object Storage, который будет использоваться в качестве хранилища данных Apache Hive™ Metastore (warehouse).
        * **Путь внутри бакета** — путь внутри бакета, который будет использоваться как префикс для данных Apache Hive™ Metastore. Опциональный параметр.

  1. В блоке **Сетевые настройки** выберите другую [группу безопасности](configure-security-group.md) или создайте новую.
  1. В блоке **Metastore** измените [конфигурацию кластера](../../concepts/metastore.md#presets).
  1. В блоке **Логирование** включите или выключите запись логов. Если логирование включено:
      * Укажите, в какую лог-группу или каталог будут записываться логи.
      * Выберите минимальный уровень логирования. 
      
      Подробнее читайте в разделе [Передача логов кластера](logging.md).
  1. В блоке **Дополнительные настройки** включите или выключите защиту кластера от удаления.
  1. Нажмите кнопку **Редактировать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить настройки кластера Apache Hive™ Metastore:

  1. Посмотрите описание команды CLI для изменения кластера:
 
      ```bash
      yc managed-metastore cluster update --help
      ```

  1. Передайте список настроек, которые хотите изменить, в команде изменения кластера:

      ```bash
      yc managed-metastore cluster update <имя_или_идентификатор_кластера> \
         --new-name <имя_кластера> \
         --description <описание_кластера> \
         --labels <список_меток> \
         --service-account-id <идентификатор_сервисного_аккаунта> \
         --version <версия_Apache_Hive™_Metastore> \
         --warehouse-bucket <имя_бакета> \
         --warehouse-path <путь_внутри_бакета> \
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

      * `--new-name` — новое имя кластера.

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

      Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "updateMask": "<список_изменяемых_параметров>",
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
          "networkSpec": {
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

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

          {% note warning %}

          При изменении кластера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask`.

          {% endnote %}

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

        * `networkSpec` — сетевые настройки:
          * `securityGroupIds` — список идентификаторов [групп безопасности](../../../vpc/concepts/network.md#security-groups).

        * `maintenanceWindow` — настройки времени технического обслуживания (в т. ч. для выключенных кластеров). В `maintenanceWindow` передайте один из двух параметров:
          
            * `anytime` — техническое обслуживание происходит в произвольное время.
            * `weeklyMaintenanceWindow` — техническое обслуживание происходит раз в неделю, в указанное время:
          
              * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`;
              * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

    1. Воспользуйтесь методом [Cluster.Update](../../api-ref/Cluster/update.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://metastore.api.cloud.yandex.net/managed-metastore/v1/clusters/<идентификатор_кластера>' \
            --data '@body.json'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

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
          "cluster_id": "<идентификатор_кластера>",
          "update_mask": "<список_изменяемых_параметров>",
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
          "network_spec": {
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

          * `cluster_id` — идентификатор кластера. Его можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
          * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

              {% cut "Формат перечисления настроек" %}

              ```yaml
              "update_mask": {
                  "paths": [
                      "<настройка_1>",
                      "<настройка_2>",
                      ...
                      "<настройка_N>"
                  ]
              }
              ```

              {% endcut %}

              {% note warning %}

              При изменении кластера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

              {% endnote %}

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

          * `network_spec` — сетевые настройки:
            * `security_group_ids` — список идентификаторов [групп безопасности](../../../vpc/concepts/network.md#security-groups).

          * `maintenance_window` — настройки времени технического обслуживания (в т. ч. для выключенных кластеров). В `maintenance_window` передайте один из двух параметров:
            
              * `anytime` — техническое обслуживание происходит в произвольное время.
              * `weekly_maintenance_window` — техническое обслуживание происходит раз в неделю, в указанное время:
            
                * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`;
                * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

    1. Воспользуйтесь вызовом [ClusterService.Update](../../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/metastore/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            metastore.api.cloud.yandex.net:443 \
            yandex.cloud.metastore.v1.ClusterService.Update \
            < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

_Apache® и [Apache Hive™](https://hive.apache.org/) являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._