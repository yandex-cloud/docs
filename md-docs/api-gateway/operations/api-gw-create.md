# Создание API-шлюза

Перед началом работы подготовьте файл спецификации API по стандарту [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification).

{% cut "Пример файла спецификации `hello-world.yaml`" %}

```yaml
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
          description: User name to appear in greetings.
          required: false
          schema:
            type: string
            default: 'world'
      responses:
        '200':
          description: Greeting.
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
```

{% endcut %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором необходимо создать [API-шлюз](../concepts/index.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** введите название API-шлюза.
  1. (Опционально) В поле **{{ ui-key.yacloud.common.description }}** введите описание API-шлюза.
  1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.label_execution-timeout }}** задайте таймаут обработки запроса. Значение не должно превышать установленный [лимит](../concepts/limits.md#api-gw-limits).
  1. В блок **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** добавьте текст [спецификаций OpenAPI](https://ru.wikipedia.org/wiki/OpenAPI_(спецификация)).

      Чтобы добавить [расширение x-yc-apigateway-integration](../concepts/extensions/index.md#integration) в спецификацию, вы можете воспользоваться [конструктором спецификаций](spec-constructor/index.md).

  1. При необходимости задайте дополнительные настройки API-шлюза.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы создать [API-шлюз](../concepts/index.md):
  1. Посмотрите описание команды CLI для создания API-шлюза:

     ```bash
     {{ yc-serverless }} api-gateway create --help
     ```

  1. Укажите параметры API-шлюза в команде создания (в примере приведены не все доступные параметры):

     ```bash
     {{ yc-serverless }} api-gateway create \
       --name <имя_API-шлюза> \
       --execution-timeout <таймаут_обработки_запроса> \
       --spec=<путь_к_файлу_спецификации>
     ```

     Где:
     * `--name` — имя API-шлюза:

         * длина — от 3 до 63 символов;
         * может содержать строчные буквы латинского алфавита, цифры и дефисы;
         * первый символ — буква, последний — не дефис.
     * `--execution-timeout` — таймаут обработки запроса. Значение задается в секундах и не должно превышать установленный [лимит](../concepts/limits.md#api-gw-limits). Необязательный параметр. Значение по умолчанию – `300` сек.
     * `--spec` — путь к созданному ранее файлу со спецификацией.

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы создать API-шлюз:
  
  1. Опишите в конфигурационном файле параметры ресурса `yandex_api_gateway`:
  
     * `name` — имя API-шлюза. Формат имени:
  
        * длина — от 3 до 63 символов;
        * может содержать строчные буквы латинского алфавита, цифры и дефисы;
        * первый символ — буква, последний — не дефис.
  
     * `description` — описание API-шлюза.
     * `labels` — [метки](../../resource-manager/concepts/labels.md) для API-шлюза. Укажите пару ключ-значение.
     * `execution_timeout` — таймаут обработки запроса. Значение задается в секундах и не должно превышать установленный [лимит](../concepts/limits.md#api-gw-limits). Необязательный параметр. Значение по умолчанию – `300` сек.
     * `spec` — спецификация API-шлюза.
  
     Пример структуры конфигурационного файла:
  
     ```hcl
     resource "yandex_api_gateway" "test-api-gateway" {
       name        = "<имя_API-шлюза>"
       description = "<описание_API-шлюза>"
       labels      = {
         label       = "label"
         empty-label = ""
       }
       execution_timeout = "<таймаут_обработки_запроса>"
       spec              = <<-EOT
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
        yc serverless api-gateway get <имя_API-шлюза>
        ```

- API {#api}

  Чтобы создать [API-шлюз](../concepts/index.md), воспользуйтесь методом REST API [create](../apigateway/api-ref/ApiGateway/create.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Create](../apigateway/api-ref/grpc/ApiGateway/create.md).


{% endlist %}