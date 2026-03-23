---
title: Как подготовить спецификацию для создания или изменения трейла
description: Следуя данной инструкции, вы сможете подготовить спецификацию для создания или изменения трейла {{ at-full-name }}.
---

# Подготовка спецификации трейла

Вы можете [создавать](#spec-for-create) и [обновлять](#spec-for-update) трейлы с помощью YAML-спецификации через [CLI](../../cli/). Для создания нового трейла сформируйте спецификацию из вывода команды `get` похожего трейла. Для обновления существующего — возьмите за основу вывод команды `get` этого же трейла.

{% note tip %}

Для создания и управления несколькими трейлами рекомендуем использовать [{{ TF }}](../tf-ref.md)

{% endnote %}

## Подготовить спецификацию для трейла {#spec-for-create}

{% list tabs group=instructions %}

- CLI {#cli}

  1. [Получите](get-info.md) информацию о трейле, который будете изменять, либо использовать как основу для нового:

      ```bash
      yc audit-trails trail get <имя_или_идентификатор_трейла>
      ```

      Результат:

      ```text
      id: cnpmhbf7gsq3********
      folder_id: b1g681qpemb4********
      created_at: "2026-02-13T20:32:52.357Z"
      updated_at: "2026-02-13T20:32:52.357Z"
      name: create-me
      destination:
        object_storage:
          bucket_id: recreate-trails
      service_account_id: ajelprpohp7r********
      status: ACTIVE
      cloud_id: b1gia87mbaom********
      filtering_policy:
        management_events_filter:
          resource_scopes:
            - id: b1g681qpemb4********
              type: resource-manager.folder
        data_events_filters:
          - service: compute
            resource_scopes:
              - id: b1g681qpemb4********
                type: resource-manager.folder
      ```

  1. Сохраните полученную информацию в файл, например `my-trail-spec.yaml`.
  1. При изменении трейла переименуйте поле `id` в `trail_id`.
  1. Удалите поля:
      * `folder_id` (только при изменении трейла)
      * `created_at`
      * `updated_at`
      * `status`
      * `cloud_id`

  1. (Опционально) Удалите устаревшие блоки, если они есть:
      * `filter`
      * `path_filter`
      * `event_filter`

  1. Обновите нужные параметры трейла.

      {% cut "Описание параметров трейла" %}

      {% include [trail-create-cli-yaml-config](../../_includes/audit-trails/trail-create-cli-yaml-config.md) %}

      Где:

      * `name` — имя трейла. Оно должно быть уникальным в рамках каталога.
      * `folder_id` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, в котором будет размещен трейл.

      {% include [spec-params-common](../../_includes/audit-trails/spec-params-common.md) %}

      {% include [trail-create-cli-yaml-desc-filtering](../../_includes/audit-trails/trail-create-cli-yaml-desc-filtering.md) %}

      {% endcut %}

  1. Сохраните изменения в файле.

{% endlist %}