# Настроить переменные

Сервис API Gateway поддерживает использование [переменных в спецификации OpenAPI](../concepts/extensions/parametrization.md).

{% cut "Пример файла спецификации с переменной" %}

```yaml
openapi: 3.0.0
info:
  title: Sample API
  version: 1.0.0

x-yc-apigateway:
  variables:
    environment:
      default: "prod"
      enum:
        - "prod"
        - "testing"
        - "dev"
      description: "API Gateway installation."

paths:
  /env/info:
    get:
      x-yc-apigateway-integration:
        type: dummy
        content:
          '*': It is ${var.environment} environment!
        http_code: 200
        http_headers:
          Content-Type: text/plain
```

{% endcut %}

По умолчанию переменные принимают значения, которые указаны в поле `default` в [спецификации OpenAPI](https://ru.wikipedia.org/wiki/OpenAPI_(спецификация)). Вы можете переопределить их, передав другие значения при настройке [API-шлюза](../concepts/index.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором необходимо изменить API-шлюз.
  1. Перейдите в сервис **API Gateway**.
  1. В строке с API-шлюзом нажмите кнопку ![image](../../_assets/options.svg) и выберите ![image](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. В блоке **Управление переменными** перечислите все объявленные в спецификации переменные и их значения.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы настроить переменные:
  1. При необходимости внесите изменения в файл спецификации OpenAPI или подготовьте новый файл.
  1. Посмотрите описание команды CLI для изменения API-шлюза:

     ```bash
     yc serverless api-gateway update --help
     ```

  1. Укажите в команде идентификатор или имя API-шлюза, а также список всех объявленных в спецификации переменных в формате `ключ=значение`:

     ```bash
     yc serverless api-gateway update \
       --id <идентификатор_API-шлюза> \
       --variables <список_переменных>
     ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы передать значения переменных, объявленных в спецификации API-шлюза:
  1. Откройте файл конфигурации Terraform и добавьте в него блок `variables`:

     ```hcl
     resource "yandex_api_gateway" "<имя_API-шлюза>" {
       ...
       variables = {
         <список_переменных>
       }
       ...
     }
     ```

     Список переменных задается в формате `ключ = значение`, например:

     ```hcl
     resource "yandex_api_gateway" "<имя_API-шлюза>" {
       ...
       variables = {
         environment = "testing"
       }
       ...
     }
     ```

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

     Проверить, что API-шлюз изменился, можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):

     ```bash
     yc serverless api-gateway get <имя_API-шлюза>
     ```

- API {#api}

  Чтобы настроить переменные для спецификации API-шлюза, воспользуйтесь методом REST API [update](../apigateway/api-ref/ApiGateway/update.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Update](../apigateway/api-ref/grpc/ApiGateway/update.md).

{% endlist %}

## Полезные ссылки {#see-also}

* [Как работает параметризация спецификации](../concepts/extensions/parametrization.md).
* [Как изменить спецификацию API-шлюза](api-gw-update.md).