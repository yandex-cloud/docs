# Добавить метку API-шлюзу

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится API-шлюз.
  1. Перейдите в сервис **API Gateway**.
  1. В строке с API-шлюзом нажмите кнопку ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. В поле **Метки** нажмите **Добавить метку**.
  1. Введите ключ и значение и нажмите **Enter**.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы добавить метку API-шлюзу, выполните команду:

  {% note warning %}
  
  Существующий набор меток (`labels`) полностью перезаписывается набором, переданным в запросе.
  
  {% endnote %}

  ```bash
  yc serverless api-gateway update <имя_API-шлюза> \
    --labels <ключ>=<значение>[,<ключ>=<значение>]
  ```
  
  Результат:
  
  ```text
  id: d5de8465hjvo********
  folder_id: b1g681qpemb4********
  created_at: "2024-11-26T20:16:50.785Z"
  name: my-gateway
  labels:
    test: test
    version: beta
  status: ACTIVE
  domain: d5dm1lba80md********.i9******.apigw.yandexcloud.net
  connectivity: {}
  log_options:
    folder_id: b1g681qpemb4********
  execution_timeout: 300s
  ```

  Вы можете указать несколько пар `<ключ>=<значение>` через запятую.

  Убедиться, что метки API-шлюза изменились, можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):
  
  ```bash
  yc serverless api-gateway get <имя_API-шлюза>
  ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы добавить метку API-шлюзу:

  1. В конфигурационном файле Terraform добавьте блок `labels` и перечислите в нем список меток в формате `<ключ>:"<значение>"`.

      Пример описания API-шлюза в конфигурации Terraform:
      
      ```hcl
      resource "yandex_api_gateway" "test-api-gateway" {
        name        = "my-gateway"
        description = "any description"
        labels      = {
          label       = "label"
          empty-label = ""
        }
        spec = <<-EOT
          openapi: 3.0.0
          info:
            title: Sample API
            version: 1.0.0
          paths:
            /:
              get:
                x-yc-apigateway-integration:
                  type: dummy
                  content:
                    '*': Hello, World!
                  http_code: 200
                  http_headers:
                    Content-Type: text/plain
        EOT
      }
      ```
      
      Более подробную информацию о параметрах ресурса `yandex_api_gateway` в Terraform см. в [документации провайдера](../../terraform/resources/api_gateway.md).

  1. Создайте ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
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
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  Убедиться, что метки API-шлюза изменились, можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):
  
  ```bash
  yc serverless api-gateway get <имя_API-шлюза>
  ```

- API {#api}

  Чтобы добавить метку API-шлюзу, воспользуйтесь методом REST API [update](../apigateway/api-ref/ApiGateway/update.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Update](../apigateway/api-ref/grpc/ApiGateway/update.md).

{% endlist %}