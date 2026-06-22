# Настройка перенаправления запросов

С помощью [перенаправления запросов](../../concepts/http-rewrite.md) вы можете перенастроить пути запросов к вашему контенту. Это может быть полезно при изменении структуры файлов и папок на [источнике](../../concepts/origins.md). Кроме того, перенаправление запросов можно использовать, если при переезде ресурса на новый адрес вы хотите сохранить ранжирование вашего контента в поисковых системах.

Чтобы включить перенаправление запросов на CDN-ресурсе:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором расположен ресурс.

  1. Перейдите в сервис **Cloud CDN**.

  1. Нажмите на имя нужного CDN-ресурса.

  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **Редактировать**.

  1. Включите опцию **Перенаправление запросов**.

  1. В поле **Правило Rewrite** задайте правило. Например: `/(.*) /new-folder/$1`.

      Правило Rewrite должно содержать две разделенные пробелом директивы: исходный путь, который требуется заменить, и измененный путь — то, на что меняется исходный путь.
      
      В правиле вы можете использовать регулярные выражения. 
      
      Подробнее в разделе [Правило Rewrite](../../concepts/http-rewrite.md#rewrite-rule).

  1. В поле **Флаг** задайте нужный [флаг](../../concepts/http-rewrite.md#flag):

      * `break` — завершает обработку текущего набора директив.
      * `last` — завершает обработку текущего набора директив и начинает поиск нового CDN-сервера, соответствующего новому URI.
      * `redirect` — возвращает пользователю временный `redirect` с кодом `302`. Флаг используется, если заменяющая строка не начинается с `http://`, `https://` или `$scheme`.
      * `permanent` — возвращает пользователю постоянный `redirect` с кодом `301`.

  1. Нажмите кнопку **Сохранить**.

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
              value: cdn-source-sample-bucket.storage.yandexcloud.net
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

          Правило Rewrite должно содержать две разделенные пробелом директивы: исходный путь, который требуется заменить, и измененный путь — то, на что меняется исходный путь.
          
          В правиле вы можете использовать регулярные выражения. 
          
          Подробнее в разделе [Правило Rewrite](../../concepts/http-rewrite.md#rewrite-rule).
      * `--rewrite-flag` – [флаг](../../concepts/http-rewrite.md#flag). Возможные значения:

          * `break` — завершает обработку текущего набора директив.
          * `last` — завершает обработку текущего набора директив и начинает поиск нового CDN-сервера, соответствующего новому URI.
          * `redirect` — возвращает пользователю временный `redirect` с кодом `302`. Флаг используется, если заменяющая строка не начинается с `http://`, `https://` или `$scheme`.
          * `permanent` — возвращает пользователю постоянный `redirect` с кодом `301`.

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
            value: cdn-source-sample-bucket.storage.yandexcloud.net
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

      Подробнее о команде `yc cdn resource update` в [справочнике CLI](../../../cli/cli-ref/cdn/cli-ref/resource/update.md).

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Resource/update.md) для ресурса [Resource](../../api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Update](../../api-ref/grpc/Resource/update.md).

{% endlist %}

Чтобы новые настройки существующего ресурса применились к CDN-серверам, может потребоваться до 15 минут. После этого рекомендуется [очистить кеш ресурса](purge-cache.md).

#### Полезные ссылки {#see-also}

* [Перенаправление запросов](../../concepts/http-rewrite.md)