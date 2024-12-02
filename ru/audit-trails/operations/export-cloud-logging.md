# Загрузка аудитных логов облака в {{ cloud-logging-name }}

По этой инструкции вы создадите новый [трейл](../concepts/trail.md), который будет загружать аудитные логи уровня конфигурации всех ресурсов и (опционально) аудитные логи уровня сервисов выбранных сервисов отдельного облака в лог-группу {{ cloud-logging-name }}.


## Подготовить окружение {#before-you-begin}

Для экспорта аудитных логов облака:

1. [Создайте](../../logging/operations/create-group.md) лог-группу для загрузки в нее аудитных логов.
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.
1. Назначьте роли сервисному аккаунту:

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      * [`audit-trails.viewer`](../security/index.md#roles-list) на облако, с которого будут собираться аудитные логи:

        ```bash
        yc resource-manager cloud add-access-binding \
          --role audit-trails.viewer \
          --id <идентификатор_облака> \
          --service-account-id <идентификатор_сервисного_аккаунта>
        ```

        Где:

        * `--role` — назначаемая роль.
        * `--id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md), с которого будут собираться аудитные логи.
        * `--service-account-id` — идентификатор сервисного аккаунта.

      * [`logging.writer`](../../logging/security/index.md#roles-list) на каталог, в котором будет находиться трейл:

        ```bash
        yc resource-manager folder add-access-binding \
          --role logging.writer \
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
    * `logging.viewer` на лог-группу {{ cloud-logging-name }}.


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

      * **{{ ui-key.yacloud.audit-trails.label_destination }}** — `{{ ui-key.yacloud.audit-trails.label_cloudLogging }}`.
      * **{{ ui-key.yacloud.logging.label_loggroup }}** — выберите лог-группу. Также вы можете создать новую лог-группу, для этого:

          * Нажмите кнопку **{{ ui-key.yacloud.common.label_create-new_female }}** и укажите параметры лог-группы:

              * **{{ ui-key.yacloud.common.name }}** — имя создаваемой группы.
              * **{{ ui-key.yacloud.common.description }}** — описание лог-группы, необязательный параметр..
              * **{{ ui-key.yacloud.logging.label_retention-period }}**.

          * Нажмите кнопку **{{ ui-key.yacloud.logging.button_create-group }}**.

  1. В блоке **{{ ui-key.yacloud.audit-trails.label_service-account }}** выберите сервисный аккаунт, от имени которого трейл будет загружать аудитные логи в лог-группу.

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
        --destination-log-group-id <идентификатор_лог-группы> \
        --filter-from-cloud-id <идентификатор_облака> \
        --filter-some-folder-ids <список_каталогов_в_облаке>
      ```

      Где:

      {% include [trail-create-cli-descs_part1](../../_includes/audit-trails/trail-create-cli-descs-part1.md) %}

      {% include [trail-create-cli-descs_logging](../../_includes/audit-trails/trail-create-cli-descs-logging.md) %}

      {% include [trail-create-cli-descs_cloud](../../_includes/audit-trails/trail-create-cli-descs-cloud.md) %}


      {% cut "Результат:" %}

      ```yml
      done (1s)
      id: cnp0sprpubl0********
      folder_id: b1g9d2k0itu4********
      created_at: "2024-04-01T09:56:07.858Z"
      updated_at: "2024-04-01T09:56:07.858Z"
      name: sample-trail
      description: My very first trail
      destination:
        cloud_logging:
          log_group_id: e23fvhkglsac********
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

  1. Чтобы создать трейл для сбора аудитных логов уровня уровня конфигурации и [уровня сервисов](../concepts/format-data-plane.md), используйте файл с YAML-спецификацией трейла.

      1. Создайте файл конфигурации трейла, например `specification.yaml`:

          {% cut "specification.yaml" %}

          {% include [cli-spec-cloud-logging](../../_includes/audit-trails/cli-spec-cloud-logging.md) %}

          {% endcut %}

          {% cut "Описание спецификации" %}

          {% include [trail-create-clispec-descs-part1](../../_includes/audit-trails/trail-create-clispec-descs-part1.md) %}

          {% include [trail-create-clispec-descs-logging](../../_includes/audit-trails/trail-create-clispec-descs-logging.md) %}

          {% include [trail-create-clispec-descs-part2](../../_includes/audit-trails/trail-create-clispec-descs-part2.md) %}

          {% endcut %}

      1. Выполните команду, указав путь к созданному файлу спецификации трейла:

          ```bash
          yc audit-trails trail create --file <путь_к_файлу_спецификации>
          ```

          {% cut "Результат" %}

          ```yml
          done (1s)
          id: cnp57t5l3hd5********
          folder_id: b1g9d2k0itu4********
          created_at: "2024-04-02T03:54:37.362Z"
          updated_at: "2024-04-02T03:54:37.362Z"
          name: sample-trail
          description: My very first trail
          destination:
            cloud_logging:
              log_group_id: e232pqboot3f********
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

      Подробнее о команде `yc audit-trails trail create` читайте в [справочнике CLI](../../cli/cli-ref/audit-trails/cli-ref/trail/create.md).

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
        
        logging_destination {
          log_group_id = "<идентификатор_лог-группы>"
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

      {% include [trail-create-tf-descs_logging](../../_includes/audit-trails/trail-create-tf-descs-logging.md) %}

      {% include [trail-create-tf-descs_part2](../../_includes/audit-trails/trail-create-tf-descs-part2.md) %}

      Более подробную информацию о параметрах ресурса `yandex_audit_trails_trail` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/audit_trails_trail).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
      
      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

      ```bash
      yc audit-trails trail get <имя_трейла>
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/Trail/create.md) для ресурса [Trail](../api-ref/Trail/index.md) или вызовом gRPC API [TrailService/Create](../api-ref/grpc/Trail/create.md).

{% endlist %}

Трейл создастся и начнет загружать аудитные логи в лог-группу. 

{% include [logging-dublicate-events](../../_includes/audit-trails/logging-dublicate-events.md) %}

## Что дальше {#whats-next} 

* Узнайте о [формате аудитных логов](../concepts/format.md).
* Узнайте о порядке [загрузки аудитных логов в SIEM](../concepts/export-siem.md).
* Узнайте о [поиске по аудитным логам в бакете](../tutorials/search-bucket.md).
