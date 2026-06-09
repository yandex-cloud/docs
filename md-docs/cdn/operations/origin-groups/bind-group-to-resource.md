# Подключение группы источников к ресурсу

Чтобы подключить [группу источников](../../concepts/origins.md#groups) к [ресурсу](../../concepts/resource.md), при [создании](../resources/create-resource.md) или [изменении настроек ресурса](../resources/configure-basics.md) в блоке **{{ ui-key.yacloud.cdn.label_section-content }}** выберите **Группу источников**.

## Подключение группы источников при создании ресурса {#connect-while-creating}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать ресурс.

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud.cdn.button_resource-create }}**.

  1. В блоке **{{ ui-key.yacloud.cdn.label_section-content }}** в поле **{{ ui-key.yacloud.cdn.label_content-query-type }}** выберите `{{ ui-key.yacloud.cdn.value_query-type-group-origin }}`.

  1. Выберите группу источников.

  1. Укажите остальные настройки ресурса. Подробнее см. в разделе [{#T}](../resources/create-resource.md).

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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
       folder_id: b1g86q4m5vej********
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
       folder_id: b1g86q4m5vej********
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
     yc cdn resource create --cname <доменное_имя_ресурса> \
       --origin-group-id <идентификатор_группы_источников> \
       --origin-protocol https
     ```

     Где:

     * `--origin-group-id` — идентификатор группы источников.
     * `--origin-protocol` — протокол для источников.

     Результат:

     ```
     id: bc855oumelrq********
     folder_id: b1g86q4m5vej********
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

     Подробнее о команде `yc cdn resource create` см. в [справочнике CLI](../../../cli/cli-ref/cdn/cli-ref/resource/create.md).

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры ресурса `yandex_cdn_resource`:

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_cdn_resource" "my_resource" {
       cname           = "<доменное_имя_ресурса>"
       active          = true
       origin_protocol = "https"
       origin_group_id = <идентификатор_группы_источников>
     }
     ```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/cdn_origin_group).

  1. Проверьте корректность настроек.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Создайте группу источников.

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.

- API {#api}

  Чтобы подключить группу источников при создании ресурса, воспользуйтесь методом REST API [create](../../api-ref/Resource/create.md) для ресурса [Resource](../../api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Create](../../api-ref/grpc/Resource/create.md).

{% endlist %}

## Подключение группы источников при изменении настроек ресурса {#connect-while-changing}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

  1. Нажмите на имя необходимого ресурса.

  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.

  1. Выберите группу источников.

  1. Если нужно, укажите остальные настройки ресурса. Подробнее см. в разделе [{#T}](../resources/configure-basics.md). 

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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
     - id: bc82xll34xuc********
       folder_id: b1g86q4m5vej********
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
       folder_id: b1g86q4m5vej********
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
       folder_id: b1g86q4m5vej********
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
       --id <идентификатор_ресурса> \
       --origin-group-id <идентификатор_группы_источников>
     ```

     Результат:

     ```
     id: bc8krsk72icw********
     folder_id: b1g86q4m5vej********
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

     Подробнее о команде `yc cdn resource update` см. в [справочнике CLI](../../../cli/cli-ref/cdn/cli-ref/resource/update.md).

- API {#api}

  Чтобы подключить группу источников при изменении настроек ресурса, воспользуйтесь методом REST API [update](../../api-ref/Resource/update.md) для ресурса [Resource](../../api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Update](../../api-ref/grpc/Resource/update.md).

{% endlist %}

Чтобы новые настройки существующего ресурса применились к CDN-серверам, может потребоваться до 15 минут. После этого рекомендуется [очистить кеш ресурса](../resources/purge-cache.md).