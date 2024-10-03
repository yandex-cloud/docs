---
title: Как сделать предварительную загрузку файлов на CDN-серверы в {{ cdn-full-name }}
description: Следуя данной инструкции, вы сможете сделать предварительную загрузку файлов на CDN-серверы.
---

# Предварительная загрузка файлов на CDN-серверы

Чтобы [предзагрузить контент](../../concepts/caching.md#prefetch) из [источников](../../concepts/origins.md) на серверы CDN:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен [ресурс](../../concepts/resource.md).

  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

  1. Нажмите на имя необходимого ресурса.

  1. Перейдите на вкладку **{{ ui-key.yacloud.cdn.label_resource-content }}**.

  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.cdn.button_resource-content-prefetch-cache }}**.

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

  1. Укажите через запятую без пробелов пути к файлам, которые хотите предзагрузить:

      ```bash
      yc cdn cache prefetch --resource-id <идентификатор_ресурса> \
        --path <пути_к_файлам>
      ```

      Подробнее о команде `yc cdn cache prefetch` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/cdn/cache/prefetch.md).

- API {#api}

  Воспользуйтесь методом REST API [prefetch](../../api-ref/Cache/prefetch.md) для ресурса [Cache](../../api-ref/Cache/index.md) или вызовом gRPC API [CacheService/Prefetch](../../api-ref/grpc/cache_service.md#Prefetch).

{% endlist %}
  