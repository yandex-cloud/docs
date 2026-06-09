# Удалить метку API-шлюза

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится API-шлюз.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. В строке с API-шлюзом нажмите кнопку ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
    1. В поле **{{ ui-key.yacloud.component.label-set.label_labels }}** выберите нужную метку и нажмите ![cross](../../_assets/console-icons/xmark.svg) справа от ее имени.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы удалить метку API-шлюза, обновите набор его меток, удалив ненужные. Выполните команду:

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
  domain: {{ api-host-apigw }}
  connectivity: {}
  log_options:
    folder_id: b1g681qpemb4********
  execution_timeout: 300s
  ```

  Чтобы удалить все метки API-шлюза, задайте пустое значение:

  ```bash
  yc serverless api-gateway update <имя_API-шлюза> --labels ""
  ```

  Убедиться, что метки API-шлюза изменились, можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/index.md):
  
  ```bash
  yc serverless api-gateway get <имя_API-шлюза>
  ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы удалить метку API-шлюза:

  1. Откройте файл конфигурации {{ TF }} и в блоке `labels` удалите ненужную метку.

      Пример описания API-шлюза в конфигурации {{ TF }}:
      
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
      
      Более подробную информацию о параметрах ресурса `yandex_api_gateway` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/api_gateway).

  1. Обновите ресурсы:

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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  Убедиться, что метки API-шлюза изменились, можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/index.md):
  
  ```bash
  yc serverless api-gateway get <имя_API-шлюза>
  ```

- API {#api}

  Чтобы удалить метку API-шлюза, воспользуйтесь методом REST API [update](../apigateway/api-ref/ApiGateway/update.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Update](../apigateway/api-ref/grpc/ApiGateway/update.md).

{% endlist %}