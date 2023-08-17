# Подключение группы источников к ресурсу

Чтобы подключить [группу источников](../../concepts/origins.md#groups) к [ресурсу](../../concepts/resource.md), при [создании](../resources/create-resource.md) или [изменении настроек ресурса](../resources/configure-basics.md) в блоке **Контент** выберите **Группу источников**.

## Подключение группы источников при создании ресурса {#connect-while-creating}

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать ресурс.

  1. Выберите сервис **{{ cdn-name }}**.

  1. Нажмите кнопку **Создать ресурс**.

  1. В блоке **Контент** в поле **Запрос контента** выберите `Из группы источников`.

  1. Выберите группу источников.

  1. Укажите остальные настройки ресурса. Подробнее см. в разделе [{#T}](../resources/create-resource.md).

  1. Нажмите кнопку **Создать**.

- CLI

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания ресурса:

     ```
     yc cdn resource create --help
     ```
  
  1. Получите список всех групп источников в каталоге по умолчанию:

     ```
     yc cdn origin-group list --format yaml
     ```

     Результат:

     ```
     - id: "90209"
       folder_id: b1g86q4m5vej8lkljme5
       name: test-group-1
       use_next: true
       origins:
       - id: "561547"
         origin_group_id: "90209"
         source: www.example2.com
         enabled: true
         backup: true
       - id: "561546"
         origin_group_id: "90209"
         source: www.example1.com
         enabled: true
     - id: "90208"
       folder_id: b1g86q4m5vej8lkljme5
       name: test-group
       use_next: true
       origins:
       - id: "561545"
         origin_group_id: "90208"
         source: www.a2.com
         enabled: true
         backup: true
       - id: "561544"
         origin_group_id: "90208"
         source: www.a1.com
         enabled: true
     ```
  
  1. Создайте ресурс с подключенной группой источников:

     ```
     yc cdn resource create --cname <доменное имя ресурса> \
       --origin-group-id <идентификатор группы источников> \
       --origin-protocol https
     ```

     Где:

     * `origin-group-id` — идентификатор группы источников.
     * `origin-protocol` — протокол для источников.

     Результат:

     ```
     id: bc855oumelrqw3ceywih
     folder_id: b1g86q4m5vej8lkljme5
     cname: res1.example.com
     created_at: "2022-01-15T15:13:42.827643Z"
     updated_at: "2022-01-15T15:13:42.827671Z"
     active: true
     options:
       edge_cache_settings:
         enabled: true
         default_value: "345600"
       cache_http_headers:
         value:
         - accept-ranges
         - cache-control
         - connection
         - content-encoding
         - content-length
         - content-type
         - date
         - etag
         - expires
         - keep-alive
         - last-modified
         - server
         - vary
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
     origin_group_id: "90208"
     origin_group_name: test-group-22
     origin_protocol: HTTPS
     ssl_certificate:
       type: DONT_USE
       status: READY
     ```

     Подробнее о команде `yc cdn resource create` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/cdn/resource/create.md).

- {{ TF }}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры ресурса `yandex_cdn_resource`:

     Пример структуры конфигурационного файла:

     
     ```
     provider "yandex" {
       token     = "<OAuth>"
       cloud_id  = "<идентификатор облака>"
       folder_id = "<идентификатор каталога>"
       zone      = "<зона доступности по умолчанию>"
     }

     resource "yandex_cdn_resource" "my_resource" {
       cname = "<доменное имя ресурса>"
       active = true
       origin_protocol = "https"
	    origin_group_id = <идентификатор группы источников>
     }
     ```


     
     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/cdn_origin_group).

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Создайте группу источников.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

- API

  Чтобы подключить группу источников при создании ресурса, воспользуйтесь методом REST API [create](../../api-ref/Resource/create.md) для ресурса [Resource](../../api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Create](../../api-ref/grpc/resource_service.md#Create).

{% endlist %}

## Подключение группы источников при изменении настроек ресурса {#connect-while-changing}

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.

  1. Выберите сервис **{{ cdn-name }}**.

  1. Нажмите на имя необходимого ресурса.

  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/pencil.svg) **Редактировать**.

  1. Выберите группу источников.

  1. Если нужно, укажите остальные настройки ресурса. Подробнее см. в разделе [{#T}](../resources/configure-basics.md). 

  1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения ресурса:

     ```
     yc cdn resource update --help
     ```

  1. Получите список всех ресурсов в каталоге по умолчанию:

     ```
     yc cdn resource list --format yaml
     ```

     Результат:

     ```
     - id: bc82xll34xuc4kymnpqq
       folder_id: b1g86q4m5vej8lkljme5
       cname: res1.example.com
       created_at: "2022-01-21T08:17:48.850086Z"
       updated_at: "2022-01-21T08:17:48.850125Z"
       active: true
       options:
         edge_cache_settings:
           enabled: true
           default_value: "345600"
         cache_http_headers:
           value:
           - accept-ranges
           - cache-control
           - connection
           - content-encoding
           - content-length
           - content-type
           - date
           - etag
           - expires
           - keep-alive
           - last-modified
           - server
           - vary
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
       origin_group_id: "90208"
       origin_group_name: test-group
       origin_protocol: HTTPS
       ssl_certificate:
         type: DONT_USE
         status: READY
     ```
  
  1. Получите список всех групп источников в каталоге по умолчанию и выберите идентификатор (`ID`) нужной группы:

     ```
     yc cdn origin-group list --format yaml
     ```

     Результат:

     ```
     - id: "90209"
       folder_id: b1g86q4m5vej8lkljme5
       name: test-group-1
       use_next: true
       origins:
       - id: "561547"
         origin_group_id: "90209"
         source: www.example2.com
         enabled: true
         backup: true
       - id: "561546"
         origin_group_id: "90209"
         source: www.example1.com
         enabled: true
     - id: "90208"
       folder_id: b1g86q4m5vej8lkljme5
       name: test-group
       use_next: true
       origins:
       - id: "561545"
         origin_group_id: "90208"
         source: www.a2.com
         enabled: true
         backup: true
       - id: "561544"
         origin_group_id: "90208"
         source: www.a1.com
         enabled: true
     ```

  1. Измените настройки ресурса, указав идентификатор нужной группы источников:

     ```
     yc cdn resource update \
       --id <идентификатор ресурса> \
       --origin-group-id <идентификатор группы источников>
     ```

     Результат:

     ```
     id: bc8krsk72icwnvyvs6c3
     folder_id: b1g86q4m5vej8lkljme5
     cname: res2.example.com
     created_at: "2022-01-15T15:29:19.103653Z"
     updated_at: "2022-01-15T15:33:22.819916Z"
     active: true
     options:
       edge_cache_settings:
         enabled: true
         default_value: "345600"
       cache_http_headers:
         value:
         - accept-ranges
         - cache-control
         - connection
         - content-encoding
         - content-length
         - content-type
         - date
         - etag
         - expires
         - keep-alive
         - last-modified
         - server
         - vary
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
     origin_group_id: "90209"
     origin_group_name: test-group-1
     origin_protocol: HTTPS
     ssl_certificate:
       type: DONT_USE
       status: READY
     ```

     Подробнее о команде `yc cdn resource update` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/cdn/resource/update.md).

- API

  Чтобы подключить группу источников при изменении настроек ресурса, воспользуйтесь методом REST API [update](../../api-ref/Resource/update.md) для ресурса [Resource](../../api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Update](../../api-ref/grpc/resource_service.md#Update).

{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}
