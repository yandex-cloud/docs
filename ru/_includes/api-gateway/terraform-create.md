Чтобы создать API-шлюз:

1. Опишите в конфигурационном файле параметры ресурса `yandex_api_gateway`:

   * `name` — имя API-шлюза. Формат имени:

      {% include [name-format](../../_includes/name-format.md) %}

   * `description` — описание API-шлюза.
   * `labels` — [метки](../../resource-manager/concepts/labels.md) для API-шлюза. Укажите пару ключ-значение.
   * `spec` — спецификация API-шлюза.

   Пример структуры конфигурационного файла:

   ```hcl
   resource "yandex_api_gateway" "test-api-gateway" {
     name        = "<имя API-шлюза>"
     description = "<описание API-шлюза>"
     labels      = {
       label       = "label"
       empty-label = ""
     }
     spec = <<-EOT
       openapi: "3.0.0"
       info:
         version: 1.0.0
         title: Test API
       paths:
         /hello:
           get:
             summary: Say hello
             operationId: hello
             parameters:
               - name: user
                 in: query
                 description: User name to appear in greetings
                 required: false
                 schema:
                   type: string
                   default: 'world'
             responses:
               '200':
                 description: Greeting
                 content:
                   'text/plain':
                     schema:
                       type: "string"
             x-yc-apigateway-integration:
               type: dummy
               http_code: 200
               http_headers:
                 'Content-Type': "text/plain"
               content:
                 'text/plain': "Hello, {user}!\n"
     EOT
   }
   ```

   Более подробную информацию о параметрах ресурсов в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/api_gateway).

1. Проверьте корректность конфигурационных файлов.

   1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
   1. Выполните проверку с помощью команды:

      ```
      terraform plan
      ```

   Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

1. Разверните облачные ресурсы.

   1. Если в конфигурации нет ошибок, выполните команду:

      ```
      terraform apply
      ```

   1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

      После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команд [CLI](../../cli/quickstart.md):

      ```
      yc serverless api-gateway get <имя API-шлюза>
      ```