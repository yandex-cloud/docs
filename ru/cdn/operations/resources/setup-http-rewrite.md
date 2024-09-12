---
title: "Как настроить перенаправление запросов к контенту"
description: "Следуя данной инструкции, вы сможете настроить перенаправление запросов от CDN-ресурса к источнику с помощью правила Rewrite."
---

# Настройка перенаправления запросов

С помощью [перенаправления запросов](../../concepts/http-rewrite.md) вы можете перенастроить пути запросов к вашему контенту. Это может быть полезно при изменении структуры файлов и папок на [источнике](../../concepts/origins.md). Кроме того, перенаправление запросов можно использовать, если при переезде ресурса на новый адрес вы хотите сохранить ранжирование вашего контента в поисковых системах.

Чтобы включить перенаправление запросов на CDN-ресурсе:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.

  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

  1. Нажмите на имя нужного CDN-ресурса.

  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.

  1. Включите опцию **{{ ui-key.yacloud.cdn.field_rewrite-rule-redirect }}**.

  1. В поле **{{ ui-key.yacloud.cdn.field_rewrite-rule-body }}** задайте правило. Например: `/(.*) /new-folder/$1`.

      {% include [rewrite-rule-description](../../../_includes/cdn/rewrite-rule-description.md) %}

  1. В поле **{{ ui-key.yacloud.cdn.field_rewrite-rule-flag }}** задайте нужный [флаг](../../concepts/http-rewrite.md#flag):

      {% include [rewrite-flag-list](../../../_includes/cdn/rewrite-flag-list.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для редактирования ресурсов:

      ```bash
      yc cdn resource update --help
      ```

  1. Получите список всех ресурсов в каталоге по умолчанию:

      ```bash
      yc cdn resource list --format yaml
      ```

      Результат:

      ```text
      - id: bc8ceo77zu7h********
        folder_id: b1gt6g8ht345********
        cname: cdn.example.com
        created_at: "2024-09-10T19:15:16.305043Z"
        updated_at: "2024-09-11T17:19:50.622628Z"
        active: true
        options:
          edge_cache_settings:
            enabled: true
            default_value: "345600"
          query_params_options:
            ignore_query_string:
              enabled: true
              value: true
          slice:
            enabled: true
            value: true
          host_options:
            host:
              enabled: true
              value: cdn-source-sample-bucket.{{ s3-storage-host }}
          stale:
            enabled: true
            value:
              - error
              - updating
          ignore_cookie:
            enabled: true
            value: true
        origin_group_id: "328146"
        origin_group_name: Origins for cdn.example.com (225300)
        origin_protocol: HTTPS
        ssl_certificate:
          type: CM
          status: READY
          data:
            cm:
              id: fpquvh0em4no********
      ```

      Сохраните значение идентификатора CDN-ресурса (поле `id` в начале вывода), оно понадобится на следующем шаге.

  1. Включите перенаправление запросов, указав идентификатор CDN-ресурса, сохраненный на предыдущем шаге:

      ```bash
      yc cdn resource update <идентификатор_ресурса> \
        --rewrite-body '<правило_Rewrite>' \
        --rewrite-flag <флаг>
      ```

      Где:
      * `--rewrite-body` – правило Rewrite. Например: `--rewrite-body '/(.*) /new-folder/$1'`.

          {% include [rewrite-rule-description](../../../_includes/cdn/rewrite-rule-description.md) %}
      * `--rewrite-flag` – [флаг](../../concepts/http-rewrite.md#flag). Возможные значения:

          {% include [rewrite-flag-list](../../../_includes/cdn/rewrite-flag-list.md) %}

      {% cut "Результат" %}

      ```text
      id: bc8ceo77zu7h********
      folder_id: b1gt6g8ht345********
      cname: cdn.example.com
      created_at: "2024-09-10T19:15:16.305043Z"
      updated_at: "2024-09-11T17:55:21.100567Z"
      active: true
      options:
        edge_cache_settings:
          enabled: true
          default_value: "345600"
        query_params_options:
          ignore_query_string:
            enabled: true
            value: true
        slice:
          enabled: true
          value: true
        host_options:
          host:
            enabled: true
            value: cdn-source-sample-bucket.{{ s3-storage-host }}
        stale:
          enabled: true
          value:
            - error
            - updating
        ignore_cookie:
          enabled: true
          value: true
        rewrite:
          enabled: true
          body: /(.*) /new-folder/$1
          flag: BREAK
      origin_group_id: "328146"
      origin_group_name: Origins for cdn.example.com (225300)
      origin_protocol: HTTPS
      ssl_certificate:
        type: CM
        status: READY
        data:
          cm:
            id: fpquvh0em4no********
      ```

      {% endcut %}

     Чтобы отключить для CDN-ресурса перенаправление запросов, выполните команду, указав идентификатор нужного CDN-ресурса:

      ```bash
      yc cdn resource update <идентификатор_ресурса> --clear-rewrite
      ```

      Подробнее о команде `yc cdn resource update` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/cdn/resource/update.md).

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Resource/update.md) для ресурса [Resource](../../api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Update](../../api-ref/grpc/resource_service.md#Update).

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}

#### См. также {#see-also}

* [{#T}](../../concepts/http-rewrite.md)