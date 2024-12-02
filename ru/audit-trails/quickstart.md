# Как начать работать с {{ at-name }}

{{ at-name }} собирает [аудитные логи](./concepts/format.md) ресурсов {{ yandex-cloud }} и загружает их в бакет {{ objstorage-name }}, лог-группу {{ cloud-logging-name }} или поток данных {{ yds-name }}.

Управление аудитными логами внутри {{ at-name }} осуществляется через [трейлы](./concepts/trail.md).

По этой инструкции вы создадите новый трейл, который будет загружать аудитные логи ресурсов вашей организации в бакет {{ objstorage-name }}.

{% include [bucket-encryption-tip](../_includes/audit-trails/bucket-encryption-tip.md) %}

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. На странице [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Убедитесь, что в вашем облаке существует бакет для хранения аудитного лога, при необходимости [создайте новый бакет](../storage/quickstart.md#the-first-bucket) с ограниченным доступом.

1. {% include [add-roles-to-sa](../_includes/audit-trails/add-roles-to-sa.md) %}

1. На странице [Управление доступом]({{ link-console-access-management }}) убедитесь, что у вас есть роли:
    * `iam.serviceAccounts.user` на сервисный аккаунт;
    * `audit-trails.editor` на каталог, где будет находиться трейл;
    * `audit-trails.viewer` на организацию, с которой будут собираться аудитные логи;
    * `kms.editor` на каталог, в котором будет создан ключ шифрования для бакета;
    * `storage.viewer` на бакет или каталог.

{% include [bucket-encryption-section](../_includes/audit-trails/bucket-encryption-section.md) %}

## Создать трейл {#the-trail-creation}

{% include [note-lose-target-when-switch-trail](../_includes/audit-trails/note-lose-target-when-switch-trail.md) %}

Чтобы создать первый трейл в {{ at-name }} и запустить процесс управления аудитными логами уровня конфигурации:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите разместить трейл.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.audit-trails.button_create-trail }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя создаваемого трейла.
  1. В поле **{{ ui-key.yacloud.common.description }}** задайте описание трейла, необязательный параметр.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_destination }}** задайте параметры объекта назначения:

      * **{{ ui-key.yacloud.audit-trails.label_destination }}** — `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`.
      * **{{ ui-key.yacloud.audit-trails.label_bucket }}** — выберите [бакет](../storage/concepts/bucket.md), в который будут загружаться аудитные логи.
      * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}** — необязательный параметр, участвует в [полном имени](./concepts/format.md#log-file-name) файла аудитного лога.
      
      {% include [note-bucket-prefix](../_includes/audit-trails/note-bucket-prefix.md) %}
      * **{{ ui-key.yacloud.audit-trails.title_kms-key }}** — если выбранный бакет [зашифрован](../storage/concepts/encryption.md), укажите ключ шифрования.

  1. В блоке **{{ ui-key.yacloud.audit-trails.label_service-account }}** выберите [сервисный аккаунт](../iam/concepts/users/service-accounts.md), от имени которого трейл будет загружать файлы аудитного лога в бакет.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}** задайте параметры сбора аудитных логов уровня конфигурации:

      * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}** — выберите `{{ ui-key.yacloud.common.enabled }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}** — выберите `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`.
      * **{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}** — не требует заполнения, содержит имя текущей организации.
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}** — оставьте значение по умолчанию `{{ ui-key.yacloud.common.all }}`.

  1. {% include [data-plane-on-console](../_includes/audit-trails/data-plane-on-console.md) %}
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../_includes/cli-install.md) %}

  {% include [default-catalogue](../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../cli/) для создания трейла:

      ```bash
      yc audit-trails trail create --help
      ```

  1. Выполните команду, чтобы создать трейл для сбора аудитных логов [уровня конфигурации](./concepts/format.md) в организации:

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

      {% include [trail-create-cli-descs_part1](../_includes/audit-trails/trail-create-cli-descs-part1.md) %}

      {% include [trail-create-cli-descs_storage](../_includes/audit-trails/trail-create-cli-descs-storage.md) %}

      {% include [trail-create-cli-descs_org](../_includes/audit-trails/trail-create-cli-descs-org.md) %}

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

- {{ TF }} {#tf}

  {% include [terraform-definition](../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../_includes/terraform-install.md) %}

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

      {% include [trail-create-tf-descs_part1](../_includes/audit-trails/trail-create-tf-descs-part1.md) %}

      {% include [trail-create-tf-descs_storage](../_includes/audit-trails/trail-create-tf-descs-storage.md) %}

      {% include [trail-create-tf-descs_part2](../_includes/audit-trails/trail-create-tf-descs-part2.md) %}

      Более подробную информацию о параметрах ресурса `yandex_audit_trails_trail` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/audit_trails_trail).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
      
      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../cli/):

      ```bash
      yc audit-trails trail get <имя_трейла>
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](./api-ref/Trail/create.md) для ресурса [Trail](./api-ref/Trail/index.md) или вызовом gRPC API [TrailService/Create](api-ref/grpc/Trail/create.md).

{% endlist %}

## Просмотр аудитных логов {#watch-logs}

При загрузке аудитных логов в бакет {{ at-name }} формирует файлы аудитных логов приблизительно раз в 5 минут. Трейл запишет все [события](./concepts/events.md), которые произошли за это время с ресурсами организации, в один или несколько файлов. Если никакие события за этот период не произойдут, файлы не сформируются.

Удостоверьтесь, что файл аудитного лога существует в бакете, указанном при создании трейла.

### Просмотр файлов аудитных логов {#watch-log-file}

{{ at-name }} создает файлы логов в формате `JSON`.

Получите доступ к содержимому файла аудитного лога одним из способов:
* [Скачайте объект](../storage/operations/objects/download.md).
* [Получите публичную ссылку на объект](../storage/operations/objects/link-for-download.md).
* Смонтируйте бакет через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)): [s3fs](../storage/tools/s3fs.md) или [goofys](../storage/tools/goofys.md). 

## Экспорт аудитных логов в SIEM {#watch-log-file}

Вы можете [экспортировать](./concepts/export-siem.md) файлы аудитных логов в ваше SIEM-решение.

## Что дальше {#whats-next}

* Узнайте больше о [сервисе](./concepts/index.md).
* Узнайте о [типах аудитных логов](./concepts/control-plane-vs-data-plane.md).
