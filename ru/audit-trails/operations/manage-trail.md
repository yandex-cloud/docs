---
title: Как управлять трейлом {{ at-name }}
description: Следуя данной инструкции, вы сможете изменить или удалить трейл {{ at-full-name }}.
---

# Управление трейлом


Вы можете изменять [объект назначения](../concepts/trail.md#target), [типы](../concepts/control-plane-vs-data-plane.md) собираемых событий, [области сбора](../concepts/trail.md#collecting-area) аудитных логов и [другие настройки](../concepts/trail.md#trail-settings) трейла, а также [удалять](#delete-trail) его.

## Изменить трейл {#update-trail}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить трейл:

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится трейл.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. В строке с нужным трейлом нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Измените параметры трейла. Список настроек трейла, которые можно изменить, см. в разделе [{#T}](../concepts/trail.md#trail-settings).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Посмотрите описание команды [CLI](../../cli/) для изменения трейла, чтобы получить подробную информацию о доступных аргументах:

  ```bash
  yc audit-trails trail update --help
  ```

  Трейл можно изменить, указав его параметры одним из двух способов:

  {% cut "В YAML-спецификации:" %}

  Создайте YAML-спецификацию, содержащую обновленные параметры трейла, и укажите этот файл в команде для создания трейла.
  
  Этот способ упрощает работу с параметрами трейла и снижает вероятность ошибки. Кроме того, настроить регистрацию [событий уровня сервисов](../concepts/control-plane-vs-data-plane.md#data-plane-events) можно только с помощью YAML-спецификации.

  1. Создайте YAML-файл с обновленной конфигурацией трейла:

      {% include [trail-create-cli-yaml-config](../../_includes/audit-trails/trail-create-cli-yaml-config.md) %}

      Где:

      * `name` — имя трейла. Оно должно быть уникальным в рамках каталога.
      * `folder_id` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, в котором будет размещен трейл.
      * `destination` — настройки выбранного места назначения, куда будут загружаться аудитные логи.

          {% note warning %}

          Настройки мест назначения — взаимоисключающие. Использование одних настроек делает невозможным использование других.

          {% endnote %}

          * `object_storage` — загружать логи в [бакет](../../storage/concepts/bucket.md#naming) {{ objstorage-full-name }}:

              * `bucket_id` — [имя](../../storage/concepts/bucket.md#naming) бакета.

                  Имя бакета можно запросить со списком бакетов в каталоге (используется каталог по умолчанию):

                  ```bash
                  yc storage bucket list
                  ```
              * `object_prefix` — [префикс](../../storage/concepts/object.md#folder), который будет присвоен объектам с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](../../audit-trails/concepts/format.md#log-file-name) файла аудитного лога.

                  {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}

          * `cloud_logging` — загружать логи в [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }}.

              В параметре `log_group_id` укажите идентификатор лог-группы. Идентификатор можно запросить со [списком лог-групп в каталоге](../../logging/operations/list.md).
          * `data_stream` — загружать логи в [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-full-name }}:

              * `stream_name` — имя потока данных. Имя можно запросить со [списком потоков данных в каталоге](../../data-streams/operations/manage-streams.md#list-data-streams).
              * `database_id` — идентификатор базы данных {{ ydb-short-name }}, которая используется потоком данных {{ yds-name }}. Идентификатор можно запросить со [списком баз данных {{ ydb-short-name }} в каталоге](../../ydb/operations/manage-databases.md#list-db).
      * `service_account_id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта.

      {% include [trail-create-cli-yaml-desc-filtering](../../_includes/audit-trails/trail-create-cli-yaml-desc-filtering.md) %}

  1. Чтобы изменить трейл, выполните команду:

      ```bash
      yc audit-trails trail update --file <путь_к_файлу>
      ```

  {% endcut %}

  {% cut "В аргументах команды:" %}

  Используйте этот способ, если конфигурация трейла простая и содержит небольшое количество параметров.
  
  {% note info %}

  Настроить регистрацию [событий уровня сервисов](../concepts/control-plane-vs-data-plane.md#data-plane-events) можно только с помощью YAML-спецификации.

  {% endnote %}

  Чтобы изменить трейл, выполните команду:

  ```bash
  yc audit-trails trail update \
    --name <имя_трейла> \
    --new-name <новое_имя_трейла> \
    --description <описание_трейла> \
    --labels <список_меток> \
    --service-account-id <идентификатор_сервисного_аккаунта> \
    --destination-bucket <имя_бакета> \
    --destination-bucket-object-prefix <префикс_для_объектов> \
    --destination-log-group-id <идентификатор_лог_группы> \
    --destination-yds-stream <имя_потока_данных_YDS> \
    --destination-yds-database-id <идентификатор_базы_данных_YDS> \
    --filter-all-folder-id <идентификатор_каталога> \
    --filter-all-cloud-id <идентификатор_облака> \
    --filter-all-organisation-id <идентификатор_организации> \
    --filter-some-folder-ids <список_каталогов_в_облаке> \
    --filter-from-cloud-id <идентификатор_облака_с_выбранными_каталогами> \
    --filter-some-cloud-ids <список_облаков_в_организации> \
    --filter-from-organisation-id <идентификатор_организации_с_выбранными_облаками>
    ```

    Где:
    * `--name` — имя трейла, который требуется изменить. Вместо имени можно передать идентификатор трейла в параметре `--id`.
    * `--new-name` — новое имя трейла. Имя должно быть уникальным в рамках каталога. Необязательный параметр.

    {% include [trail-cli-flag-desc](../../_includes/audit-trails/trail-cli-flag-desc.md) %}

  {% endcut %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Чтобы изменить трейл, созданный с помощью {{ TF }}, откройте файл конфигурации {{ TF }} и измените фрагмент с описанием трейла:

      {% include [trail-tf-manifest](../../_includes/audit-trails/trail-tf-manifest.md) %}

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

  Чтобы изменить трейл, воспользуйтесь методом REST API [update](../api-ref/Trail/update.md) для ресурса [Trail](../api-ref/Trail/index.md) или вызовом gRPC API [TrailService/Update](../api-ref/grpc/Trail/update.md).

{% endlist %}

## Удалить трейл {#delete-trail}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы удалить трейл:

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится трейл.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. В строке с нужным трейлом нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите удаление.

- CLI {#cli}

  Чтобы удалить трейл, выполните команду:

  ```bash
  yc audit-trails trail delete <имя_или_идентификатор_трейла>
  ```

  Чтобы узнать имена и идентификаторы доступных трейлов, воспользуйтесь [инструкцией](./get-list.md).

- {{ TF }} {#tf}

  Чтобы удалить трейл, созданный с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите секцию с описанием трейла.

      Пример описания трейла в конфигурации {{ TF }}:

      {% include [trail-tf-manifest](../../_includes/audit-trails/trail-tf-manifest.md) %}

  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.
  1. Проверьте конфигурацию командой:

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

     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Примените изменения конфигурации:

     ```bash
     terraform apply
     ```
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.
  1. Чтобы убедиться в том, что трейл был удален, воспользуйтесь [инструкцией](./get-list.md).

- API {#api}

  Чтобы удалить трейл, воспользуйтесь методом REST API [delete](../api-ref/Trail/delete.md) для ресурса [Trail](../api-ref/Trail/index.md) или вызовом gRPC API [TrailService/Delete](../api-ref/grpc/Trail/delete.md).

{% endlist %}