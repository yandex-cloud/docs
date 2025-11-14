---
title: Как очистить кеш ресурса в {{ cdn-full-name }}
description: Следуя данной инструкции, вы сможете очистить кеш ресурса.
---

# Очистка кеша ресурса

Чтобы [очистить кеш](../../concepts/caching.md) ресурса:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.

  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

  1. Нажмите на имя необходимого ресурса.

  1. Перейдите на вкладку **{{ ui-key.yacloud.cdn.label_resource-content }}**.

  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.cdn.button_resource-content-purge-cache }}**.

  1. Выберите тип очистки кеша:

      * `{{ ui-key.yacloud.cdn.label_resource-content-purging-cache-type-full }}` — для очистки кеша всех файлов.
      * `{{ ui-key.yacloud.cdn.label_resource-content-purging-cache-type-selective }}` — для очистки кеша выбранных файлов. Пути к нужным файлам укажите через запятую в поле **{{ ui-key.yacloud.cdn.label_resource-content-purging-cache-paths }}**.

          {% include [wildcard-paths-purging-specifics](../../../_includes/cdn/wildcard-paths-purging-specifics.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.cdn.button_resource-content-purge-cache }}**.

- CLI {#cli}

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для редактирования ресурсов:

      ```bash
      yc cdn resource update --help
      ```

  1. Получите список всех [CDN-ресурсов](../../concepts/resource.md) в каталоге по умолчанию:

      ```bash
      yc cdn resource list --format yaml
      ```

      Результат:

      ```text
      id: s0me1dkfjq********
      folder_id: s0mef01der7p********
      cname: testexample.com
      created_at: "2022-01-19T09:23:57.921365Z"
      updated_at: "2022-01-19T10:55:30.305141Z"
      active: true
      options:
        edge_cache_settings:
          enabled: true
          default value: "345600"
        cache_http_headers:
          enabled: true
          value:
          - content-type
          - content-length
          - connection
          - server
          - date
          - test
        stale:
          enabled: true
          value:
          - error
          - updating
        allowed_http_methods:
          value:
          - GET
          - POST
          - HEAD
          - OPTIONS
      origin_group_id: "89783"
      origin_group_name: My origins group
      origin_protocol: HTTP
      ssl_certificate:
        type: DONT_USE
        status: READY
      ```

  1. Очистите кеш файлов:

      ```bash
      yc cdn cache purge \
        --resource-id <идентификатор_ресурса> \
        --path <путь_к_файлам_1>,<путь_к_файлам_2>,...,<путь_к_файлам_n>
      ```

      Где:
      * `--resource-id` — идентификатор CDN-ресурса, в котором необходимо очистить кеш.
      * `--path` — список путей к файлам CDN-ресурса, кеш для которых необходимо очистить.

          {% include [wildcard-paths-purging-specifics](../../../_includes/cdn/wildcard-paths-purging-specifics.md) %}

          {% include [the-vary-headers-purge-warning](../../../_includes/cdn/the-vary-headers-purge-warning.md) %}

          Если не указать параметр `--path` с путями к файлам, кеш будет очищен для всех файлов ресурса. Подробнее см. в разделе [{#T}](../../concepts/caching.md#purge).

      Подробнее о команде `yc cdn cache purge` см. в [справочнике CLI](../../../cli/cli-ref/cdn/cli-ref/cache/purge.md).

- API {#api}

  Воспользуйтесь методом REST API [purge](../../api-ref/Cache/purge.md) для ресурса [Cache](../../api-ref/Cache/index.md) или вызовом gRPC API [CacheService/Purge](../../api-ref/grpc/Cache/purge.md).

{% endlist %}
  
На очистку кеша может потребоваться до 15 минут.