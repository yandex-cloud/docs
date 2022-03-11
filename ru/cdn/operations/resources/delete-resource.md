# Удаление ресурса

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.
  
  1. Выберите сервис **{{ cdn-name }}**.
  
  1. Нажмите на имя необходимого ресурса.
  
  1. В правом верхнем углу нажмите кнопку ![image](../../../_assets/basket.svg) **Удалить** и подтвердите удаление.

- CLI
  
  {% include [include](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для удаления ресурсов:
  
      ```bash
      yc cdn resource delete --help
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
  
  1. Удалите ресурс:

      ```bash
      yc cdn resource delete <идентификатор ресурса>
      ```
      
      Подробнее о команде `yc cdn resource delete`  см. в [справочнике CLI](../../../cli/cli-ref/managed-services/cdn/resource/delete.md).
  
  1. Убедитесь, что удаление прошло успешно. Для этого снова посмотрите список ресурсов в каталоге:

      ```bash
      yc cdn resource list
      ```

- Terraform

  Если у вас ещё нет Terraform, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить CDN-ресурс, созданный с помощью Terraform:

  1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием ресурса.

     {% cut "Пример описания CDN-ресурса в конфигурации Terraform" %}

     ```hcl
     resource "yandex_cdn_resource" "my_resource" {
         cname               = "cdn1.yandex-example.ru"
         active              = false
         origin_protocol     = "https"
         secondary_hostnames = ["cdn-example-1.yandex.ru", "cdn-example-2.yandex.ru"]
         origin_group_id     = yandex_cdn_origin_group.my_group.id
         ...
         options {
           edge_cache_settings = "345600"
           ignore_cookie       = true
           ...
         }
     }
     ```

     {% endcut %}

  1. В командной строке перейдите в папку, где расположен конфигурационный файл Terraform.

  1. Проверьте конфигурацию командой:
     ```bash
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:
     ```bash
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:
     ```bash
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить удаление CDN-ресурса можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```
     yc cdn resource list
     ```
{% endlist %}