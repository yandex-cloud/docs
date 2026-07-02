[Документация Yandex Cloud](../../index.md) > [Yandex API Gateway](../index.md) > [Пошаговые инструкции](index.md) > Управление API-шлюзом > Изменить API-шлюз и его спецификацию

# Изменить API-шлюз

После создания [API-шлюза](../concepts/index.md) вы можете изменить любые его параметры и [спецификацию OpenAPI](https://ru.wikipedia.org/wiki/OpenAPI_(спецификация)).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором необходимо изменить API-шлюз.
  1. Перейдите в сервис **API Gateway**.
  1. В строке с API-шлюзом нажмите кнопку ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. Отредактируйте параметры API-шлюза или спецификацию OpenAPI при необходимости.

      Чтобы добавить [расширение x-yc-apigateway-integration](../concepts/extensions/index.md#integration) в спецификацию, вы можете воспользоваться [конструктором спецификаций](spec-constructor/index.md).

  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить API-шлюз:
  1. При необходимости внесите изменения в файл спецификации OpenAPI или подготовьте новый файл.
  1. Посмотрите описание команды CLI для изменения API-шлюза:

     ```bash
     yc serverless api-gateway update --help
     ```

  1. Укажите в команде изменения идентификатор или имя API-шлюза, а также параметры, которые необходимо изменить (в примере приведены не все доступные параметры):

     ```bash
     yc serverless api-gateway update \
       --id <идентификатор_API-шлюза> \
       --new-name <новое_имя_API-шлюза> \
       --execution-timeout <таймаут_обработки_запроса> \
       --spec=<путь_к_новому_файлу_спецификации>
     ```

     Где:
     * `--id` — идентификатор API-шлюза, который требуется изменить.
     * `--new-name` — новое имя API-шлюза. Необязательный параметр. Требования к имени:

         * длина — от 3 до 63 символов;
         * может содержать строчные буквы латинского алфавита, цифры и дефисы;
         * первый символ — буква, последний — не дефис.
     * `--execution-timeout` — таймаут обработки запроса. Значение задается в секундах и не должно превышать установленный [лимит](../concepts/limits.md#api-gw-limits). Необязательный параметр. Значение по умолчанию – `300` сек.
     * `--spec` — путь к файлу с обновленной спецификацией API-шлюза.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы изменить имя, описание или спецификацию API-шлюза:
  1. Откройте файл конфигурации Terraform и измените параметры `name`, `description`, `execution_timeout` или `spec` соответственно.

     Пример структуры конфигурационного файла:

     ```hcl
     ...
     resource "yandex_api_gateway" "test-api-gateway" {
       name        = "some_name"
       description = "any description"
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
                   'text/plain': "Hello again, {user}!\n"
       EOT
     }
     ...
     ```

     Подробнее о параметрах ресурса `yandex_api_gateway` в Terraform в [документации провайдера](../../terraform/resources/api_gateway.md).
  1. Проверьте конфигурацию командой:

     ```bash
     terraform validate
     ```

     Если конфигурация является корректной, появится сообщение:

     ```text
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

     Проверить изменение API-шлюза можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):

     ```bash
     yc serverless api-gateway get <имя_API-шлюза>
     ```

- API {#api}

  Чтобы изменить имя, описание или спецификацию API-шлюза, воспользуйтесь методом REST API [update](../apigateway/api-ref/ApiGateway/update.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Update](../apigateway/api-ref/grpc/ApiGateway/update.md).


{% endlist %}