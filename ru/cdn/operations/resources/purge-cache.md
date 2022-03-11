# Очистка кеша ресурса

Чтобы [очистить кеш](../../concepts/caching.md) ресурса:

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.

  1. Выберите сервис **{{ cdn-name }}**.

  1. Нажмите на имя необходимого ресурса.

  1. Перейдите на вкладку **Контент**.

  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/basket.svg) **Очистить кеш**.

  1. Выберите тип очистки кеша:

      * `Полная` — для очистки кеша всех файлов.
      * `Выборочная` — для очистки кеша выбранных файлов. Имена нужных файлов укажите в поле **Пути к файлам**.
      
  1. Нажмите кнопку **Очистить кеш**.

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
  
  1. Очистите кеш файлов, используя аргумент `cache purge`:

      ```bash
      yc cdn cache purge --resource-id <идентификатор ресурса> \
        --path <пути к файлам>
      ```
      Если не указать флаг `--path` с путями к файлам, будет очищен кеш всех файлов.

      Подробнее о команде `yc cdn cache purge` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/cdn/cache/purge.md).

{% endlist %}
  
На очистку кеша может потребоваться до 15 минут.