# Загрузка аудитных логов облака в {{ yds-name }}


По этой инструкции вы создадите новый [трейл](../concepts/trail.md), который будет загружать аудитные логи уровня конфигурации всех ресурсов и (опционально) аудитные логи уровня сервисов выбранных сервисов отдельного облака в поток данных {{ yds-name }}.


## Подготовить окружение {#before-you-begin}

Для экспорта аудитных логов облака:

1. [Создайте](../../data-streams/operations/manage-streams.md#create-data-stream) поток данных для загрузки в него аудитных логов.
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.
1. Назначьте роли сервисному аккаунту:

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      * [`audit-trails.viewer`](../security/index.md#roles-list) на облако, с которого будут собираться аудитные логи:

        ```
        yc resource-manager cloud add-access-binding \
          --role audit-trails.viewer \
          --id <идентификатор_облака> \
          --service-account-id <идентификатор_сервисного_аккаунта>
        ```

        Где:
        * `--role` — назначаемая роль.
        * `--id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md), с которого будут собираться аудитные логи.
        * `--service-account-id` — идентификатор сервисного аккаунта.

      * [`yds.writer`](../../logging/security/index.md#roles-list) на каталог, в котором будет находиться трейл:

        ```
        yc resource-manager folder add-access-binding \
          --role yds.writer \
          --id <идентификатор_каталога> \
          --service-account-id <идентификатор_сервисного_аккаунта>
        ```

        Где:
        * `--role` — назначаемая роль.
        * `--id` — идентификатор каталога, в котором будет находиться трейл.
        * `--service-account-id` — идентификатор сервисного аккаунта.

    {% endlist %}

1. На странице [Права доступа]({{ link-console-access-management }}) убедитесь, что у вас есть роли:
    * `iam.serviceAccounts.user` на сервисный аккаунт;
    * `audit-trails.editor` на каталог, где будет находиться трейл;
    * `audit-trails.viewer` на облако, с которого будут собираться аудитные логи;
    * `yds.viewer` на поток данных {{ yds-name }}.


## Создать трейл {#the-trail-creation}

Чтобы создать трейл, который экспортирует аудитные логи облака:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите разместить трейл.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.audit-trails.button_create-trail }}** и укажите:

      * **{{ ui-key.yacloud.common.name }}** — имя создаваемого трейла.
      * **{{ ui-key.yacloud.common.description }}** — описание трейла, необязательный параметр.

  1. В блоке **{{ ui-key.yacloud.audit-trails.label_destination }}** задайте параметры объекта назначения:

      * **{{ ui-key.yacloud.audit-trails.label_destination }}** — `{{ ui-key.yacloud.audit-trails.label_dataStream }}`.
      * **{{ ui-key.yacloud.audit-trails.label_stream-name }}** — выберите поток данных. Также вы можете создать новый поток данных, для этого нажмите кнопку **{{ ui-key.yacloud.common.create-new }}** и [укажите](../../data-streams/operations/manage-streams.md#create-data-stream) параметры потока данных.

  1. В блоке **{{ ui-key.yacloud.audit-trails.label_service-account }}** выберите сервисный аккаунт, от имени которого трейл будет загружать аудитные логи в поток данных.

  1. В блоке **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}** задайте параметры сбора аудитных логов уровня конфигурации:

      * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}** — выберите `{{ ui-key.yacloud.common.enabled }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}** — выберите `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}** — не требует заполнения, содержит имя облака, в котором будет находиться трейл.
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}** — оставьте значение по умолчанию `{{ ui-key.yacloud.common.all }}`.

  1. {% include [data-plane-on-console](../../_includes/audit-trails/data-plane-on-console.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../cli/) для создания трейла:

      ```bash
      yc audit-trails trail create --help
      ```

  1. Выполните команду, чтобы создать трейл для сбора аудитных логов [уровня конфигурации](../concepts/format.md) в облаке:

      ```bash
      yc audit-trails trail create \
        --name <имя_трейла> \
        --description "<описание_трейла>" \
        --service-account-id <идентификатор_сервисного_аккаунта> \
        --destination-yds-stream <имя_потока_данных> \
        --destination-yds-database-id <идентификатор_БД_YDB> \
        --filter-from-cloud-id <идентификатор_облака> \
        --filter-some-folder-ids <список_каталогов_в_облаке>
      ```

      Где:

      {% include [trail-create-cli-descs_part1](../../_includes/audit-trails/trail-create-cli-descs-part1.md) %}

      {% include [trail-create-cli-descs-yds](../../_includes/audit-trails/trail-create-cli-descs-yds.md) %}

      {% include [trail-create-cli-descs_cloud](../../_includes/audit-trails/trail-create-cli-descs-cloud.md) %}

      {% cut "Результат:" %}

      ```yml
      done (1s)
      id: cnpgt7fgi482********
      folder_id: b1g9d2k0itu4********
      created_at: "2024-04-01T10:37:35.151Z"
      updated_at: "2024-04-01T10:37:35.151Z"
      name: sample-trail
      description: My very first trail
      destination:
        data_stream:
          database_id: etnsamrdlkiv********
          stream_name: sample-stream
      service_account_id: ajeee339l4m5********
      status: ACTIVE
      filter:
        path_filter:
          root:
            some_filter:
              resource:
                id: b1glti4eser3********
                type: resource-manager.cloud
              filters:
                - any_filter:
                    resource:
                      id: b1g9d2k0itu4********
                      type: resource-manager.folder
                - any_filter:
                    resource:
                      id: b1gp73knqj0u********
                      type: resource-manager.folder
        event_filter: {}
      cloud_id: b1glti4eser3********
      ```

      {% endcut %}

  1. Чтобы создать трейл для сбора аудитных логов уровня конфигурации и [уровня сервисов](../concepts/format-data-plane.md), используйте файл с YAML-спецификацией трейла.

      1. Создайте файл конфигурации трейла, например `specification.yaml`:

          {% cut "specification.yaml" %}

          {% include [cli-spec-cloud-yds](../../_includes/audit-trails/cli-spec-cloud-yds.md) %}

          {% endcut %}

          {% cut "Описание спецификации" %}

          {% include [trail-create-clispec-descs-part1](../../_includes/audit-trails/trail-create-clispec-descs-part1.md) %}

          {% include [trail-create-clispec-descs-yds](../../_includes/audit-trails/trail-create-clispec-descs-yds.md) %}

          {% include [trail-create-clispec-descs-part2](../../_includes/audit-trails/trail-create-clispec-descs-part2.md) %}

          {% endcut %}

      1. Выполните команду, указав путь к созданному файлу спецификации трейла:

          ```bash
          yc audit-trails trail create --file <путь_к_файлу_спецификации>
          ```

          {% cut "Результат" %}

          ```yml
          done (1s)
          id: cnplt4audsde********
          folder_id: b1g9d2k0itu4********
          created_at: "2024-04-02T04:18:49.186Z"
          updated_at: "2024-04-02T04:18:49.186Z"
          name: sample-trail
          description: My very first trail
          destination:
            data_stream:
              database_id: etnneuucptkf********
              stream_name: sample-stream
          service_account_id: ajeee339l4m5********
          status: ACTIVE
          filter:
            path_filter:
              root:
                some_filter:
                  resource:
                    id: b1glti4eser3********
                    type: resource-manager.cloud
                  filters:
                    - any_filter:
                        resource:
                          id: b1g9d2k0itu4********
                          type: resource-manager.folder
                    - any_filter:
                        resource:
                          id: b1gp73knqj0u********
                          type: resource-manager.folder
            event_filter:
              filters:
                - service: mdb.postgresql
                  categories:
                    - plane: DATA_PLANE
                      type: WRITE
                  path_filter:
                    root:
                      some_filter:
                        resource:
                          id: b1glti4eser3********
                          type: resource-manager.cloud
                        filters:
                          - any_filter:
                              resource:
                                id: b1g9d2k0itu4********
                                type: resource-manager.folder
                          - any_filter:
                              resource:
                                id: b1gp73knqj0u********
                                type: resource-manager.folder
                - service: dns
                  categories:
                    - plane: DATA_PLANE
                      type: READ
                  path_filter:
                    root:
                      any_filter:
                        resource:
                          id: b1glti4eser3********
                          type: resource-manager.cloud
          cloud_id: b1glti4eser3********
          ```

          {% endcut %}

      Подробнее о команде `yc audit-trails trail create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/audit-trails/trail/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры трейла, который будет собирать аудитные события ресурсов облака:

      ```hcl
      resource "yandex_audit_trails_trail" "basic_trail" {
        name = "<имя_трейла>"
        folder_id   = "<идентификатор_каталога>"
        description = "<описание_трейла>"
        
        labels = {
          key = "value"
        }
        
        service_account_id = "<идентификатор_сервисного_аккаунта>"
        
        data_stream_destination {
          stream_name   = "<имя_потока_данных>"
          database_id = "<идентификатор_БД_YDB>"
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

      {% include [trail-create-tf-descs_part1](../../_includes/audit-trails/trail-create-tf-descs-part1.md) %}

      {% include [trail-create-tf-descs-yds](../../_includes/audit-trails/trail-create-tf-descs-yds.md) %}

      {% include [trail-create-tf-descs_part2](../../_includes/audit-trails/trail-create-tf-descs-part2.md) %}

      Более подробную информацию о параметрах ресурса `yandex_audit_trails_trail` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/audit_trails_trail).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
      
      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

      ```bash
      yc audit-trails trail get <имя_трейла>
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/Trail/create.md) для ресурса [Trail](../api-ref/Trail/index.md) или вызовом gRPC API [TrailService/Create](../api-ref/grpc/trail_service.md#Create).

{% endlist %}

Трейл создастся и начнет загружать аудитные логи в поток данных. 

## Что дальше {#whats-next} 

* Узнайте о [формате аудитных логов](../concepts/format.md).
* Узнайте о порядке [загрузки аудитных логов в SIEM](../concepts/export-siem.md).
* Узнайте о [поиске по аудитным логам в бакете](../tutorials/search-bucket.md).
