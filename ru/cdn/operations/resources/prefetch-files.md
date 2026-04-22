---
title: Как принудительно загрузить файлы в кеш CDN-серверов в {{ cdn-full-name }}
description: Следуя данной инструкции, вы сможете принудительно загрузить контент в кеш CDN-серверов.
---

# Принудительная загрузка файлов в кеш CDN-серверов

В настройках [CDN-ресурса](../../concepts/resource.md) вы можете включить [кеширование контента](../../concepts/caching.md) — временное хранение копий файлов из [источников](../../concepts/origins.md) на [CDN-серверах](../../concepts/points-of-presence.md).

При этом вы можете [принудительно загрузить](../../concepts/caching.md#prefetch) файлы из источников в кеш CDN-серверов. Вручную в кеш рекомендуется загружать большие файлы размером от 200 МБ.

Чтобы принудительно загрузить контент CDN-ресурса в кеш CDN-серверов:

{% note warning %}

{% include [purge-before-prefetch-notice](../../../_includes/cdn/purge-before-prefetch-notice.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен [ресурс](../../concepts/resource.md).
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Нажмите на имя необходимого ресурса.
  1. Перейдите на вкладку **{{ ui-key.yacloud.cdn.label_resource-content }}**.
  1. В правом верхнем углу экрана нажмите кнопку ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.cdn.button_resource-content-prefetch-cache }}**.
  1. В поле **{{ ui-key.yacloud.cdn.label_resource-content-prefetch-cache-paths }}** укажите имена нужных файлов.
  1. Нажмите кнопку **{{ ui-key.yacloud.cdn.button_resource-content-prefetch-cache }}**.

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
  1. Укажите через запятую без пробелов пути к файлам, которые хотите загрузить в кеш CDN-серверов:

      ```bash
      yc cdn cache prefetch --resource-id <идентификатор_ресурса> \
        --path <пути_к_файлам>
      ```

      Подробнее о команде `yc cdn cache prefetch` см. в [справочнике CLI](../../../cli/cli-ref/cdn/cli-ref/cache/prefetch.md).

- API {#api}

  Воспользуйтесь методом REST API [prefetch](../../api-ref/Cache/prefetch.md) для ресурса [Cache](../../api-ref/Cache/index.md) или вызовом gRPC API [CacheService/Prefetch](../../api-ref/grpc/Cache/prefetch.md).

{% endlist %}