---
title: Как управлять трейлом {{ at-name }}
description: Следуя данной инструкции, вы сможете изменить или удалить трейл {{ at-full-name }}.
---

# Управление трейлом


Вы можете изменять [объект назначения](../concepts/trail.md#target), [уровни](../concepts/control-plane-vs-data-plane.md) собираемых событий, [области сбора](../concepts/trail.md#collecting-area) аудитных логов и [другие настройки](../concepts/trail.md#trail-settings) трейла, а также [удалять](#delete-trail) его.

## Изменить трейл {#update-trail}

В фильтры событий уровня сервисов можно добавить [условия по значениям полей](../concepts/trail.md#field-filters) через CLI, {{ TF }} или API. При изменении политики фильтрации передавайте ее целиком, сохраняя остальные нужные фильтры.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить трейл:

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится трейл.
  1. [Перейдите]({{ link-console-main }}/link/audit-trails) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. В строке с нужным трейлом нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Измените параметры трейла. Список настроек трейла, которые можно изменить, приведен в разделе [{#T}](../concepts/trail.md#trail-settings).
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Посмотрите описание команды CLI для изменения трейла:

  ```bash
  yc audit-trails trail update --help
  ```

  Трейл можно изменить, указав его параметры одним из двух способов:

  {% cut "В YAML-спецификации" %}

  Создайте YAML-спецификацию, содержащую обновленные параметры трейла, и укажите этот файл в команде для изменения трейла.
  
  Этот способ упрощает работу с параметрами трейла и снижает вероятность ошибки. Кроме того, настроить регистрацию [событий уровня сервисов](../concepts/control-plane-vs-data-plane.md#data-plane-events) можно только с помощью YAML-спецификации.

  1. [Подготовьте YAML-спецификацию](prepare-spec.md) на основе текущих настроек трейла и измените нужные параметры.
  1. {% include [field-filter-cli](../../_includes/audit-trails/field-filter-cli.md) %}
  1. Чтобы изменить трейл, выполните команду:

      ```bash
      yc audit-trails trail update --file <путь_к_файлу>
      ```

  {% endcut %}

  {% cut "В параметрах команды" %}

  Используйте этот способ, если конфигурация трейла простая и содержит небольшое количество параметров.
  
  {% note info %}

  Настроить регистрацию [событий уровня сервисов](../concepts/control-plane-vs-data-plane.md#data-plane-events) можно только с помощью YAML-спецификации.

  {% endnote %}

  Укажите в команде только те параметры, которые хотите изменить. Например, чтобы изменить имя трейла, выполните команду:

  ```bash
  yc audit-trails trail update \
    --name <имя_трейла> \
    --new-name <новое_имя_трейла>
  ```

  Параметры команды:

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

      Подробнее о параметрах ресурса `yandex_audit_trails_trail` в [документации провайдера]({{ tf-provider-resources-link }}/audit_trails_trail).

  1. {% include [field-filter-tf](../../_includes/audit-trails/field-filter-tf.md) %}

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Проверьте настройки трейла в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

     ```bash
     yc audit-trails trail get <имя_трейла>
     ```

- API {#api}

    1. [Аутентифицируйтесь](../api-ref/authentication.md) в API и получите настройки трейла методом REST API [get](../api-ref/Trail/get.md) или вызовом gRPC API [TrailService/Get](../api-ref/grpc/Trail/get.md).
    1. Измените нужные параметры трейла.
    1. {% include [field-filter-api](../../_includes/audit-trails/field-filter-api.md) %}
    1. Обновите трейл методом REST API [update](../api-ref/Trail/update.md) для ресурса [Trail](../api-ref/Trail/index.md) или вызовом gRPC API [TrailService/Update](../api-ref/grpc/Trail/update.md). Передайте идентификатор трейла, обновленные параметры и маску изменений.

        Если меняете политику фильтрации, включите `filteringPolicy` в `updateMask` для REST API или `filtering_policy` в `update_mask.paths` для gRPC API.

{% endlist %}

Примеры фильтров из [инструкции по созданию трейла](create-trail.md#filter-examples) подходят и для изменения трейла.

## Удалить трейл {#delete-trail}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы удалить трейл:

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится трейл.
  1. [Перейдите]({{ link-console-main }}/link/audit-trails) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. В строке с нужным трейлом нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
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
