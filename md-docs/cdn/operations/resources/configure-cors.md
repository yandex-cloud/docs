[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud CDN](../../index.md) > [Пошаговые инструкции](../index.md) > Ресурсы > Настроить CORS при ответах клиентам

# Настройка CORS при ответах клиентам

{% note info %}

Чтобы кросс-доменные запросы работали корректно, дополнительно настройте CORS на источнике, если источник поддерживает этот механизм. Например, настройка CORS потребуется для [бакетов Object Storage](../../../storage/operations/buckets/cors.md).

{% endnote %}

Чтобы настроить для [ресурса](../../concepts/resource.md) кросс-доменные запросы по механизму [CORS](../../concepts/cors.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором расположен ресурс.

  1. Перейдите в сервис **Cloud CDN**.

  1. Нажмите на имя необходимого ресурса.

  1. Перейдите на вкладку **HTTP-заголовки и методы**.

  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **Редактировать**.

  1. В блоке **CORS при ответе клиенту**:

      * В поле **Заголовок Access-Control-Allow-Origin** укажите, нужно ли добавлять этот заголовок к ответам.
      * При добавлении заголовка выберите, при каких значениях заголовка `Origin` разрешен доступ к контенту. Чтобы разрешить доступ только определенным источникам, выберите `Как в Origin, если входит в список`, укажите доменные имена источников и нажмите кнопку **Добавить доменное имя**.

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

  1. Чтобы включить добавление заголовка `Access-Control-Allow-Origin`, используйте параметр `--cors`:

      ```bash
      yc cdn resource update <идентификатор_ресурса> --cors <значение_CORS>
      ```
      Значения `*` и `"$http_origin"` разрешают доступ к контенту при любом значении заголовка `Origin`. Чтобы разрешить доступ только определенным источникам, укажите `"$http_origin"` и доменные имена источников: `["domain.com", "second.dom.com"]`.

      Подробнее о команде `yc cdn resource update` в [справочнике CLI](../../../cli/cli-ref/cdn/cli-ref/resource/update.md).

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры создаваемого CDN-ресурса:

      ```hcl
      resource "yandex_cdn_resource" "my_resource" {
        cname               = "cdn1.yandex-example.ru"
        active              = false
        origin_protocol     = "https"
        secondary_hostnames = ["cdn-example-1.yandex.ru", "cdn-example-2.yandex.ru"]
        origin_group_id     = yandex_cdn_origin_group.my_group.id
        options {
          allowed_http_methods = ["GET","PUT"]
          cors                 = ["*"]
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
         * `cors` — значение, которое CDN отправит в заголовке `Access-Control-Allow-Origin` в ответ на [CORS-запрос](../../concepts/cors.md).
         * `allowed_http_methods` — HTTP-методы, разрешенные для вашего контента CDN. По умолчанию разрешены следующие методы: `GET`, `HEAD`, `POST`, `PUT`, `PATCH`, `DELETE`, `OPTIONS`. В случае, если некоторые методы запрещены пользователю, он получит ответ `405` (Method Not Allowed). Если метод не поддерживается, пользователь получает ответ `501` (Not Implemented). Необязательный параметр, значения по умолчанию: `GET`, `HEAD`, `POST`,`OPTIONS`.

      Подробнее о параметрах `yandex_cdn_resource` в Terraform в [документации провайдера](../../../terraform/resources/cdn_resource.md).

  1. В командной строке перейдите в папку, где расположен конфигурационный файл Terraform.

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

     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение CDN-ресурса можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```
     yc cdn resource list
     ```

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Resource/update.md) для ресурса [Resource](../../api-ref/Resource/index.md) или вызовом gRPC API [ResourceService/Update](../../api-ref/grpc/Resource/update.md).

{% endlist %}

Чтобы новые настройки существующего ресурса применились к CDN-серверам, может потребоваться до 15 минут. После этого рекомендуется [очистить кеш ресурса](purge-cache.md).