# Принудительная загрузка файлов в кеш CDN-серверов

В настройках [CDN-ресурса](../../concepts/resource.md) вы можете включить [кеширование контента](../../concepts/caching.md) — временное хранение копий файлов из [источников](../../concepts/origins.md) на [CDN-серверах](../../concepts/points-of-presence.md).

При этом вы можете [принудительно загрузить](../../concepts/caching.md#prefetch) файлы из источников в кеш CDN-серверов. Вручную в кеш рекомендуется загружать большие файлы размером от 200 МБ.

Чтобы принудительно загрузить контент CDN-ресурса в кеш CDN-серверов:

{% note warning %}

Принудительно загрузить в кеш можно только контент, которого еще нет на CDN-серверах. Чтобы обновить в кеше уже имеющиеся там файлы, необходимо предварительно [очистить кеш](../../concepts/caching.md#purge).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором расположен [ресурс](../../concepts/resource.md).
  1. Перейдите в сервис **Cloud CDN**.
  1. Нажмите на имя необходимого ресурса.
  1. Перейдите на вкладку **Контент**.
  1. В правом верхнем углу экрана нажмите кнопку ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Предзагрузить контент**.
  1. В поле **Пути к файлам** укажите имена нужных файлов.
  1. Нажмите кнопку **Предзагрузить контент**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

      Подробнее о команде `yc cdn cache prefetch` в [справочнике CLI](../../../cli/cli-ref/cdn/cli-ref/cache/prefetch.md).

- API {#api}

  Воспользуйтесь методом REST API [prefetch](../../api-ref/Cache/prefetch.md) для ресурса [Cache](../../api-ref/Cache/index.md) или вызовом gRPC API [CacheService/Prefetch](../../api-ref/grpc/Cache/prefetch.md).

{% endlist %}