# Как начать работать с Audit Trails

Audit Trails собирает [аудитные логи](concepts/format.md) ресурсов Yandex Cloud и загружает их в [бакет](../storage/concepts/bucket.md) Object Storage, [лог-группу](../logging/concepts/log-group.md) Cloud Logging, [поток данных](../data-streams/concepts/glossary.md#stream-concepts) Data Streams или [шину](../serverless-integrations/concepts/eventrouter/bus.md) Yandex EventRouter.

Управление аудитными логами внутри Audit Trails осуществляется через [трейлы](concepts/trail.md).

По этой инструкции вы создадите новый трейл, который будет загружать аудитные логи ресурсов вашей организации в бакет Object Storage.

{% note tip %}

Чтобы дополнительно защитить аудитные логи, [зашифруйте](#bucket-encryption) бакет.

{% endnote %}

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь, если вы еще не зарегистрированы.
1. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Убедитесь, что в вашем облаке существует бакет для хранения аудитного лога, при необходимости [создайте новый бакет](../storage/quickstart.md#the-first-bucket) с ограниченным доступом.

1. Назначьте роли сервисному аккаунту:
   
     {% list tabs group=instructions %}
   
     - CLI {#cli}
   
       Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../cli/quickstart.md#install).
   
       По умолчанию используется каталог, указанный при [создании](../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
   
       * Назначьте [роль `audit-trails.viewer`](security/index.md#roles-list) на облако, со всех ресурсов которого будут собираться аудитные логи:
   
         ```bash
         yc resource-manager cloud add-access-binding \
           --role audit-trails.viewer \
           --id <идентификатор_облака> \
           --service-account-id <идентификатор_сервисного_аккаунта>
         ```
   
         Где:
   
         * `--role` — назначаемая роль;
         * `--id` — [идентификатор облака](../resource-manager/operations/cloud/get-id.md), с которого будут собираться аудитные логи;
         * `--service-account-id` — идентификатор сервисного аккаунта.
   
       * Назначьте [роль `storage.uploader`](../storage/security/index.md#storage-uploader) на каталог, в котором будет находиться трейл:
   
         ```bash
         yc resource-manager folder add-access-binding \
           --role storage.uploader \
           --id <идентификатор_каталога> \
           --service-account-id <идентификатор_сервисного_аккаунта>
         ```
   
         Где:
   
         * `--role` — назначаемая роль;
         * `--id` — идентификатор каталога, в котором будет находиться трейл;
         * `--service-account-id` — идентификатор сервисного аккаунта.
   
     {% endlist %}

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роли:
    * `iam.serviceAccounts.user` на сервисный аккаунт;
    * `audit-trails.editor` на каталог, где будет находиться трейл;
    * `audit-trails.viewer` на организацию, с которой будут собираться аудитные логи;
    * `kms.editor` на каталог, в котором будет создан ключ шифрования для бакета;
    * `storage.viewer` на бакет или каталог.

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

## Зашифровать бакет {#bucket-encryption}

Чтобы хранить логи в зашифрованном виде:

1. Создайте [симметричный ключ шифрования](../kms/operations/key.md#create) в сервисе Yandex Key Management Service.
1. [Включите шифрование бакета](../storage/operations/buckets/encrypt.md#add), используя созданный ключ.
1. Назначьте сервисному аккаунту, который вы создали ранее, роль [`kms.keys.encrypter`](../kms/security/index.md#service-roles) на ключ, чтобы загружать логи в зашифрованный бакет:

    ```bash
    yc kms symmetric-key add-access-binding \
        --role kms.keys.encrypter \
        --id <идентификатор_ключа> \
        --service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:
    * `--role` — назначаемая роль;
    * `--id` — идентификатор ключа шифрования;
    * `--service-account-id` — идентификатор сервисного аккаунта.

## Создать трейл {#the-trail-creation}

{% note info %}

При изменении объекта назначения в существующем трейле может произойти потеря событий. Создайте новый трейл, если вам нужно безопасно изменить объект назначения.

{% endnote %}

Чтобы создать первый трейл в Audit Trails и запустить процесс управления аудитными логами уровня конфигурации:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите разместить трейл.
  1. [Перейдите](../console/operations/select-service.md#select-service) в сервис **Audit Trails**.
  1. Нажмите кнопку **Создать трейл**.
  1. В поле **Имя** укажите имя создаваемого трейла.
  1. В поле **Описание** задайте описание трейла, необязательный параметр.
  1. В блоке **Назначение** задайте параметры объекта назначения:

      * **Назначение** — `Object Storage`.
      * **Бакет** — выберите [бакет](../storage/concepts/bucket.md), в который будут загружаться аудитные логи.
      * **Префикс объекта** — необязательный параметр, участвует в [полном имени](concepts/format.md#log-file-name) файла аудитного лога.
      
      {% note info %}
      
      Используйте [префикс](../storage/concepts/object.md#key), если вы храните аудитные логи и сторонние данные в одном и том же бакете. Не используйте одинаковый префикс для логов и других объектов в бакете, так как в этом случае логи и сторонние объекты могут перезаписать друг друга.
      
      {% endnote %}
      * **Ключ шифрования** — если выбранный бакет [зашифрован](../storage/concepts/encryption.md), укажите ключ шифрования.

  1. В блоке **Сервисный аккаунт** выберите [сервисный аккаунт](../iam/concepts/users/service-accounts.md), от имени которого трейл будет загружать файлы аудитного лога в бакет.
  1. В блоке **Сбор событий c уровня конфигурации** задайте параметры сбора аудитных логов уровня конфигурации:

      * **Сбор событий** — выберите `Включено`.
      * **Ресурс** — выберите `Организация`.
      * **Организация** — не требует заполнения, содержит имя текущей организации.
      * **Облако** — оставьте значение по умолчанию `Все`.

  1. (опционально) В блоке **Сбор событий с уровня сервисов** задайте параметры сбора аудитных логов уровня сервисов:
     
       {% note info %}
       
       Сбор некоторых событий [уровня сервисов](concepts/control-plane-vs-data-plane.md#data-plane-events) включен по умолчанию. Подробнее в разделе [Предустановленные события](concepts/trail.md#default).
       
       {% endnote %}
     
       * **Сбор событий** — выберите `Включено`.
       * Выберите [сервисы](concepts/events-data-plane.md), для которых вы хотите собирать аудитные логи.
       * Для каждого выбранного сервиса укажите [область](concepts/trail.md#collecting-area) сбора аудитных логов и тип фильтра событий:
     
           * `Получать все` — чтобы получать все события сервиса.
           * `Выбранные` — чтобы получать только выбранные события. Затем выберите [события](concepts/events-data-plane.md#dns).
           * `Исключить` — чтобы получать все события, кроме выбранных. Затем выберите события.
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../cli/index.md) для создания трейла:

      ```bash
      yc audit-trails trail create --help
      ```

  1. Выполните команду, чтобы создать трейл для сбора аудитных логов [уровня конфигурации](concepts/format.md) в организации:

      ```bash
      yc audit-trails trail create \
        --name <имя_трейла> \
        --description "<описание_трейла>" \
        --service-account-id <идентификатор_сервисного_аккаунта> \
        --destination-bucket <имя_бакета> \
        --destination-bucket-object-prefix <префикс_в_бакете> \
        --filter-from-organisation-id <идентификатор_организации> \
        --filter-some-cloud-ids <список_облаков_в_организации>
      ```

      Где:

      * `--name` — имя создаваемого трейла.
          Требования к формату имени:
      
          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.
      
      * `--description` — описание трейла, которое позволит отличать его от других трейлов. Например `--description "My very first trail"`. Необязательный параметр.
      
      * `--service-account-id` — [идентификатор](../iam/operations/sa/get-id.md) сервисного аккаунта, от имени которого трейл будет загружать файлы аудитного лога в бакет.
      
          В зависимости от [области сбора](concepts/trail.md#collecting-area) аудитных логов, [сервисному аккаунту](../iam/concepts/users/service-accounts.md) должна быть назначена [роль](../iam/concepts/access-control/roles.md) `audit-trails.viewer` на организацию, облако или каталог, в которых трейл будет собирать аудитные логи.

      * `--destination-bucket` — [имя бакета](../storage/concepts/bucket.md#naming), в который будут загружаться аудитные логи.
          Чтобы получить список бакетов в каталоге по умолчанию, выполните команду CLI `yc storage bucket list`.
      
      * `--destination-bucket-object-prefix` — [префикс](../storage/concepts/object.md#folder), который будет присвоен объектам с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](concepts/format.md#log-file-name) файла аудитного лога.
      
          {% note info %}
          
          Используйте [префикс](../storage/concepts/object.md#key), если вы храните аудитные логи и сторонние данные в одном и том же бакете. Не используйте одинаковый префикс для логов и других объектов в бакете, так как в этом случае логи и сторонние объекты могут перезаписать друг друга.
          
          {% endnote %}

      * `--filter-from-organisation-id` — [идентификатор](../organization/operations/organization-get-id.md) организации, которой принадлежит создаваемый трейл и для ресурсов которой будут собираться аудитные логи.
      
          При использовании параметра `--filter-from-organisation-id` необходимо также задать идентификаторы облаков в параметре `--filter-some-cloud-ids`.
      
          Использование параметра `--filter-from-organisation-id` исключает использование параметра `--filter-all-organisation-id`.
      
      * `--filter-some-cloud-ids` — список [идентификаторов облаков](../resource-manager/operations/cloud/get-id.md), для ресурсов которых трейл будет собирать аудитные логи. Используйте этот параметр только в том случае, если задан параметр `--filter-from-organisation-id`.
      
          Указанные в параметре облака должны принадлежать организации, заданной в параметре `--filter-from-organisation-id`.
      
          Если аудитные логи нужно собирать во всех облаках, принадлежащих организации, используйте параметр `--filter-all-organisation-id`.
      
      * `--filter-all-organisation-id` — [идентификатор](../organization/operations/organization-get-id.md) организации, которой принадлежит создаваемый трейл и для всех ресурсов во всех облаках которой будут собираться аудитные логи.
      
          Использование параметра `--filter-all-organisation-id` исключает использование параметра `--filter-from-organisation-id`.

      Результат:

      ```yml
      done (1s)
      id: cnpe0gldjeq0********
      folder_id: b1g9d2k0itu4********
      created_at: "2024-03-31T16:54:56.187Z"
      updated_at: "2024-03-31T16:54:56.187Z"
      name: sample-trail
      description: My very first trail
      destination:
        object_storage:
          bucket_id: at-destination-bucket
          object_prefix: sample-trail-audit-logs
      service_account_id: ajeee339l4m5********
      status: ACTIVE
      filter:
        path_filter:
          root:
            some_filter:
              resource:
                id: bpfaidqca8vd********
                type: organization-manager.organization
              filters:
                - any_filter:
                    resource:
                      id: b1glti4eser3********
                      type: resource-manager.cloud
                - any_filter:
                    resource:
                      id: b1gssd27h7ra********
                      type: resource-manager.cloud
        event_filter: {}
      cloud_id: b1glti4eser3********
      ```

      Подробнее о команде `yc audit-trails trail create` читайте в [справочнике CLI](../cli/cli-ref/audit-trails/cli-ref/trail/create.md).

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры трейла, который будет собирать аудитные события ресурсов организации:

      ```hcl
      resource "yandex_audit_trails_trail" "basic_trail" {
        name = "<имя_трейла>"
        folder_id   = "<идентификатор_каталога>"
        description = "<описание_трейла>"
        
        labels = {
          key = "value"
        }
        
        service_account_id = "<идентификатор_сервисного_аккаунта>"
        
        storage_destination {
          bucket_name   = "<имя_бакета>"
          object_prefix = "<префикс_в_бакете>"
        }
        
        filter {
          path_filter {
            some_filter {
              resource_id   = "<идентификатор_организации>"
              resource_type = "<тип_родительского_ресурса>"
              any_filters {
                  resource_id   = "<идентификатор_облака_1>"
                  resource_type = "<тип_дочернего_ресурса>"
              }
              any_filters {
                  resource_id   = "<идентификатор_облака_2>"
                  resource_type = "<тип_дочернего_ресурса>"
              }
            }
          }
          event_filters {
            service = "<идентификатор_сервиса_1>"
            categories {
              plane = "DATA_PLANE"
              type  = "<тип_действия>"
            }
            path_filter {
              any_filter {
                resource_id = "<идентификатор_организации>"
                resource_type = "<тип_ресурса>"
              }
            }
          }
          event_filters {
            service = "<идентификатор_сервиса_2>"
            categories {
              plane = "DATA_PLANE"
              type  = "<тип_действия>"
            }
            path_filter {
              any_filter {
                resource_id = "<идентификатор_организации>"
                resource_type = "<тип_ресурса>"
              }
            }
          }
        }
      }
      ```

      Где:

      * `name` — имя создаваемого трейла. Требования к формату имени:
      
          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.
      
      * `folder_id` — [идентификатор каталога](../resource-manager/operations/folder/get-id.md), в котором создается трейл.
      * `description` — описание трейла, которое позволит отличать его от других трейлов. Например `My very first trail`. Необязательный параметр.
      * `labels` — список [меток](../resource-manager/concepts/labels.md) в формате `ключ=значение`. Необязательный параметр.
      * `service_account_id` — [идентификатор](../iam/operations/sa/get-id.md) сервисного аккаунта, от имени которого трейл будет загружать файлы аудитного лога в бакет.
      
          В зависимости от [области сбора](concepts/trail.md#collecting-area) аудитных логов, [сервисному аккаунту](../iam/concepts/users/service-accounts.md) должна быть назначена [роль](../iam/concepts/access-control/roles.md) `audit-trails.viewer` на организацию, облако или каталог, в которых трейл будет собирать аудитные логи.

      * `storage_destination` — структура, описывающая целевой бакет.
          * `bucket_name` — [имя бакета](../storage/concepts/bucket.md#naming), в который будут загружаться аудитные логи.
              Чтобы получить список бакетов в каталоге по умолчанию, выполните команду CLI `yc storage bucket list`.
      
          * `object_prefix` — [префикс](../storage/concepts/object.md#folder), который будет присвоен объектам с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](concepts/format.md#log-file-name) файла аудитного лога.
      
              {% note info %}
              
              Используйте [префикс](../storage/concepts/object.md#key), если вы храните аудитные логи и сторонние данные в одном и том же бакете. Не используйте одинаковый префикс для логов и других объектов в бакете, так как в этом случае логи и сторонние объекты могут перезаписать друг друга.
              
              {% endnote %}

      * `filtering_policy` — настройки политики фильтрации, которая определяет, какие события будут собираться и попадут в аудитные логи. Политика состоит из набора фильтров, которые относятся к разным уровням событий. Содержит объекты `management_events_filter` и `data_events_filters`.
      
          * `management_events_filter` — фильтр событий уровня конфигурации.
          * `resource_scopes` — [область сбора логов](concepts/trail.md#collecting-area). Можно комбинировать в одном параметре `resource_scopes` несколько областей, которые принадлежат одной организации. Например, собирать логи из одного облака целиком, а из другого — только из определенных каталогов. Права сервисного аккаунта должны позволять сбор логов из указанных областей.
      
              * `resource_id` — идентификатор ресурса, для ресурсов которого будут собираться аудитные логи. В зависимости от области сбора аудитных логов укажите в этом параметре [идентификатор](../organization/operations/organization-get-id.md) организации или [идентификатор](../resource-manager/operations/cloud/get-id.md) облака.
              * `resource_type` — тип области согласно указанному идентификатору:
      
                  * `organization-manager.organization` — [организация](../organization/concepts/organization.md);
                  * `resource-manager.cloud` — [облако](../resource-manager/concepts/resources-hierarchy.md#cloud);
                  * `resource-manager.folder` — [каталог](../resource-manager/concepts/resources-hierarchy.md#folder).
          * `data_events_filters` — фильтры событий уровня сервисов. Можно настроить несколько фильтров такого типа — по одному для каждого сервиса. Фильтр для одного сервиса имеет следующую структуру:
      
              * `service` — имя сервиса, в котором трейл будет обрабатывать события.  Его можно получить в [справочнике событий уровня сервисов](concepts/events-data-plane.md)).
              * `resource_scopes` — места, откуда собирать события уровня сервисов. Этот параметр настраивается аналогично фильтру событий уровня конфигурации.
              * `included_events` — собирать только указанные события. Необязательный параметр. Если не указать, то будут собираться все события. Вместо `included_events` можно указать `excluded_events` — собирать все события, кроме указанных. Эти параметры — взаимоисключающие.
                  Полный перечень событий можно получить в [справочнике событий уровня сервисов](concepts/events-data-plane.md).

      Более подробную информацию о параметрах ресурса `yandex_audit_trails_trail` в Terraform см. в [документации провайдера](../terraform/resources/audit_trails_trail.md).

  1. Создайте ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.
      
      Terraform создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../cli/index.md):

      ```bash
      yc audit-trails trail get <имя_трейла>
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](api-ref/Trail/create.md) для ресурса [Trail](api-ref/Trail/index.md) или вызовом gRPC API [TrailService/Create](api-ref/grpc/Trail/create.md).

{% endlist %}

## Просмотр аудитных логов {#watch-logs}

При загрузке аудитных логов в бакет Audit Trails формирует файлы аудитных логов приблизительно раз в 5 минут. Трейл запишет все [события](concepts/events.md), которые произошли за это время с ресурсами организации, в один или несколько файлов. Если никакие события за этот период не произойдут, файлы не сформируются.

Удостоверьтесь, что файл аудитного лога существует в бакете, указанном при создании трейла.

### Просмотр файлов аудитных логов {#watch-log-file}

Audit Trails создает файлы логов в формате `JSON`.

Получите доступ к содержимому файла аудитного лога одним из способов:
* [Скачайте объект](../storage/operations/objects/download.md).
* [Получите публичную ссылку на объект](../storage/operations/objects/link-for-download.md).
* Смонтируйте бакет через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)): [s3fs](../storage/tools/s3fs.md) или [goofys](../storage/tools/goofys.md). 

## Экспорт аудитных логов в SIEM {#watch-log-file}

Вы можете [экспортировать](concepts/export-siem.md) файлы аудитных логов в ваше SIEM-решение.

## Что дальше {#whats-next}

* Узнайте больше о [сервисе](concepts/index.md).
* Узнайте о [типах аудитных логов](concepts/control-plane-vs-data-plane.md).