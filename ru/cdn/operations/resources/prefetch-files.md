# Предварительная загрузка файлов на CDN-серверы

Чтобы [предзагрузить контент](../../concepts/caching.md#prefetch) из [источников](../../concepts/origins.md) на серверы CDN:

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен [ресурс](../../concepts/resource.md).

  1. Выберите сервис **{{ cdn-name }}**.
  
  1. Нажмите на имя необходимого ресурса.
  
  1. Перейдите на вкладку **Контент**.
  
  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/horizontal-ellipsis.svg) и выберите **Предзагрузить контент**.
  
  1. В поле **Пути к файлам** укажите имена нужных файлов.
  
  1. Нажмите кнопку **Предзагрузить контент**.

- CLI
  
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

      ```bash
      id: someidkfjqjfl325fw
      folder_id: somefolder7p3l5eobbd
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
      yc cdn cache prefetch --resource-id <идентификатор ресурса> \
        --path <пути к файлам>
      ```
      
      Подробнее о команде `yc cdn cache prefetch` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/cdn/cache/prefetch.md).

- API

  Воспользуйтесь методом REST API [prefetch](../../api-ref/Cache/prefetch.md) для ресурса [Cache](../../api-ref/Cache/index.md) или вызовом gRPC API [CacheService/Prefetch](../../api-ref/grpc/cache_service.md#Prefetch).

{% endlist %}
  