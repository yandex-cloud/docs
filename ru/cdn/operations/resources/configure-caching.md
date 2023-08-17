# Настройка кеширования ресурса

Чтобы настроить параметры [кеширования](../../concepts/caching.md) для [ресурса](../../concepts/resource.md):

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.

  1. Выберите сервис **{{ cdn-name }}**.

  1. Нажмите на имя необходимого ресурса.

  1. Перейдите на вкладку **Кеширование**.

  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/pencil.svg) **Редактировать**.

  1. Выберите и настройте нужные варианты кеширования:

      * В блоке **CDN**:

          * Включите опцию **Кеширование в CDN**.
          * Выберите тип настроек: `Как у источника` или `Свои настройки`.
          * Выберите время жизни кеша из списка.
          * (Опционально) Для типа настроек `Свои настройки` задайте время жизни кеша для нужных HTTP-кодов ответа.

      * В блоке **Браузер**:
      
          * Включите опцию **Кеширование в браузере**.

  1. (Опционально) В блоке **Дополнительно**:

      * Выберите опцию игнорирования Cookie.
      * Выберите опцию игнорирования Query-параметров.

  1. Нажмите кнопку **Сохранить**.

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

  1. Чтобы изменить время жизни кеша, выполните:
    
      ```bash
      yc cdn resource update <идентификатор ресурса> \
        --cache-expiration-time <время в секундах> \
        --browser-cache-expiration-time <время в секундах> \
        --ignore-cookie true \
        --ignore-query-string
      ```

      Где:

      * `--cache-expiration-time` — время жизни кеша в секундах.
      * `--browser-cache-expiration-time` — время жизни кеша браузера в секундах.
      * `--ignore-cookie` со значением `true` включает игнорирование Cookie.
      * `--ignore-query-string` включает игнорирование Query-параметров.

      Подробнее о команде `yc cdn resource update` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/cdn/resource/update.md).

- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры создаваемого CDN-ресурса `yandex_cdn_resource`:

      
      ```hcl
      terraform {
        required_providers {
          yandex = {
            source  = "yandex-cloud/yandex"
            version = "0.69.0"
          }
        }
      }

      provider "yandex" {
        token     = "<OAuth>"
        cloud_id  = "<идентификатор облака>"
        folder_id = "<идентификатор каталога>"
        zone      = "<зона доступности>"
      }

      resource "yandex_cdn_resource" "my_resource" {
          cname               = "cdn1.yandex-example.ru"
          active              = false
          origin_protocol     = "https"
          secondary_hostnames = ["cdn-example-1.yandex.ru", "cdn-example-2.yandex.ru"]
          origin_group_id     = yandex_cdn_origin_group.my_group.id
          options {
            edge_cache_settings    = "345600"
            browser_cache_settings = "1800"
            ignore_cookie          = true
            ignore_query_params    = false
          }

      }
      ```



      Где:

      * `cname` — основное доменное имя для раздачи контента. Обязательный параметр.
      * `active` — флаг, указывающий на доступ к контенту для конечных пользователей. `True` — контент из CDN будет доступен клиентам. Необязательный параметр, значение по умолчанию: `true`.
      * `origin_protocol` — протокол для источников. Необязательный параметр, значение по умолчанию: `http`.
      * `secondary_hostnames` — дополнительные доменные имена. Необязательный параметр.
      * `origin_group_id` — идентификатор [группы источников](../../concepts/origins.md). Обязательный параметр. Используйте идентификатор из описания группы источников в ресурсе `yandex_cdn_origin_group`.
      * Блок `options` содержит дополнительные параметры CDN-ресурсов:
         * `browser_cache_settings` — время жизни кеша в браузере в секундах. Необязательный параметр, значение по умолчанию: `0`.
         * `edge_cache_settings` — время жизни кеша для кодов ответа в секундах. Необязательный параметр, значение по умолчанию: `345600`.
         * `ignore_query_params` — игнорировать query-параметры. Необязательный параметр, значение по умолчанию: `false`.
         * `ignore_cookie` — игнорировать cookie. Необязательный параметр, значение по умолчанию: `false`.

      Более подробную информацию о параметрах `yandex_cdn_resource` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/cdn_resource).

  1. В командной строке перейдите в папку, где расположен конфигурационный файл {{ TF }}.

  1. Проверьте конфигурацию командой:
     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:
     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение CDN-ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```
     yc cdn resource list
     ```

- API

  Воспользуйтесь методом REST API [update](../../api-ref/Resource/update.md) для ресурса [Resource](../../api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Update](../../api-ref/grpc/resource_service.md#Update).

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}