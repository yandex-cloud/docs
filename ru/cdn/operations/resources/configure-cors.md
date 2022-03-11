# Настройка CORS при ответах клиентам

Чтобы настроить для [ресурса](../../concepts/resource.md) кросс-доменные запросы по механизму [CORS](../../concepts/cors.md):

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.

  1. Выберите сервис **{{ cdn-name }}**.

  1. Нажмите на имя необходимого ресурса.

  1. Перейдите на вкладку **HTTP-заголовки и методы**.

  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/pencil.svg) **Редактировать**.
  
  1. В блоке **CORS при ответе клиенту**:

      * В поле **Заголовок Access-Control-Allow-Origin** укажите, нужно ли добавлять этот заголовок к ответам.
      * При добавлении заголовка выберите, при каких значениях заголовка `Origin` разрешен доступ к контенту. Чтобы разрешить доступ только определенным источникам, выберите `Как в Origin, если входит в список`, укажите доменные имена источников и нажмите кнопку **Добавить доменное имя**.

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

  1. Чтобы включить добавление заголовка `Access-Control-Allow-Origin`, используйте флаг `--cors`:

      ```bash
      yc cdn resource update <идентификатор ресурса> --cors <значение CORS>
      ```
      Значения `*` и `"$http_origin"` разрешают доступ к контенту при любом значении заголовка `Origin`. Чтобы разрешить доступ только определенным источникам, укажите `"$http_origin"` и доменные имена источников: `["domain.com", "second.dom.com"]`.

      Подробнее о команде `yc cdn resource update` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/cdn/resource/update.md).

- Terraform

  Если у вас ещё нет Terraform, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры создаваемого CDN-ресурса:

      * `cname` — основное доменное имя для раздачи контента. Обязательный параметр.
      * `active` — флаг, указывающий на доступ к контенту для конечных пользователей. `True` — контент из CDN будет доступен клиентам. Необязательный параметр, значение по умолчанию: `true`.
      * `origin_protocol` — протокол для источников. Необязательный параметр, значение по умолчанию: `http`.
      * `secondary_hostnames` — дополнительные доменные имена. Необязательный параметр.
      * `origin_group_id` — идентификатор [группы источников](../../concepts/origins.md). Обязательный параметр. Используйте идентификатор из описания группы источников в ресурсе `yandex_cdn_origin_group`.
      * Блок `options` содержит дополнительные параметры CDN-ресурсов:
         * `cors` — значение, которое CDN отправит в заголовке `Access-Control-Allow-Origin` в ответ на [CORS-запрос](../../concepts/cors.md).
         * `allowed_http_methods` — HTTP-методы, разрешенные для вашего контента CDN. По умолчанию разрешены следующие методы: `GET`, `HEAD`, `POST`, `PUT`, `PATCH`, `DELETE`, `OPTIONS`. В случае, если некоторые методы запрещены пользователю, он получит ответ `405` (Method Not Allowed). Если метод не поддерживается, пользователь получает ответ `501` (Not Implemented). Необязательный параметр, значения по умолчанию: `GET`, `HEAD`, `POST`,`OPTIONS`.

      Пример структуры конфигурационного файла:


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
            allowed_http_methods = ["GET","PUT"]
            cors                 = ["*"]
          }

      }
      ```

      Более подробную информацию о параметрах `yandex_cdn_resource` в Terraform см. в [документации провайдера](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/cdn_resource).

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

     Проверить изменение CDN-ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```
     yc cdn resource list
     ```
     
{% endlist %}

{% include [after-changes-tip](../../../_includes/cdn/after-changes-tip.md) %}
