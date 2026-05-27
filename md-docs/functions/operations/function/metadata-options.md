# Настроить параметры сервиса метаданных функции

Настроить параметры сервиса метаданных вы можете при [создании версии функции](version-manage.md).

Доступны следующие опции:

* `awsV1HttpEndpoint` — обеспечивает доступ к метаданным с использованием формата AWS (IMDSv1). Возможные значения: `enabled`, `disabled`. Если для опции задано значение `disabled`, то запрос к метаданным завершится ошибкой `404 Not Found`. Значение по умолчанию: `enabled`.

    {% note info %}

    По умолчанию параметр `awsV1HttpEndpoint` включен (`enabled`), но мы советуем выключить его. Формат IMDSv1 имеет ряд недостатков со стороны безопасности. Наиболее критичный — повышенный риск реализации некоторых атак, например [SSRF](https://portswigger.net/web-security/ssrf) (подробнее в [официальном блоге AWS](https://aws.amazon.com/blogs/security/defense-in-depth-open-firewalls-reverse-proxies-ssrf-vulnerabilities-ec2-instance-metadata-service/)).

    {% endnote %}

* `gceHttpEndpoint` — обеспечивает доступ к метаданным с использованием формата Google Compute Engine. Возможные значения: `enabled`, `disabled`. Если для опции задано значение `disabled`, то запрос к метаданным завершится ошибкой `404 Not Found`. Значение по умолчанию: `enabled`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [функция](../../concepts/function.md).
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**.
  1. Выберите функцию.
  1. Перейдите на вкладку **Редактор**.
  1. Разверните блок **Дополнительные настройки**.
  1. В блоке **Параметры сервиса метаданных** настройте параметры сервиса метаданных функции — `Доступ к метаданным с использованием формата Google Compute Engine` и `Доступ к метаданным с использованием формата AWS (IMDSv1)`.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

  Чтобы настроить параметры сервиса метаданных функции, выполните команду:

  ```bash
  yc serverless function version create \
    --function-id=<идентификатор_функции> \
    --runtime <среда_выполнения> \
    --entrypoint <точка_входа> \
    --source-version-id <идентификатор_версии> \
    --metadata-options <опция>=<enable_или_disabled>
  ```

  Где:

  * `--function-id` — идентификатор функции, новую версию которой вы хотите создать. Чтобы узнать идентификатор, [получите список функций](function-list.md) в каталоге.
  * `--runtime` — среда выполнения.
  * `--entrypoint` — точка входа, указывается в формате `<имя_файла_с_функцией>.<имя_обработчика>`.
  * `--source-version-id` — идентификатор версии функции, код которой вы хотите скопировать. Чтобы узнать идентификатор, [получите список версий функции](version-list.md).
  * `--metadata-options` — настройки параметров сервиса метаданных, например `aws-v1-http-endpoint=disabled`.

- Terraform {#tf}

    [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
    
    Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
    
    Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

    Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

    Чтобы настроить параметры сервиса метаданных функции:

    1. Откройте файл конфигурации Terraform и добавьте к описанию функции блок `metadata_options`:
      
        ```hcl
        resource "yandex_function" "metadata_function" {
          name               = "<имя_функции>"
          user_hash          = "<хеш_функции>"
          runtime            = "<среда_выполнения>"
          entrypoint         = "<точка_входа>"
          memory             = "<объем_RAM>"
          execution_timeout  = "<максимальное_время_выполнения>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
          content {
            zip_filename = "<путь_к_ZIP-архиву>"
          }

          metadata_options {
            metadata_options.0.gce_http_endpoint = "0_или_1_или_2"
            metadata_options.0.aws_v1_http_endpoint = "0_или_1_или_2"
          }
        }
        ```

        Где:

        * `metadata_options` — настройки параметров сервиса метаданных, например `metadata_options.0.gce_http_endpoint = "1"`. Укажите:
            * `0` — если хотите оставить значение по молчанию.
            * `1` — чтобы включить параметр.
            * `2` — чтобы выключить параметр.

        Более подробную информацию о параметрах ресурса `yandex_function` см. в [документации провайдера](../../../terraform/resources/function.md).

   1. Примените изменения:

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

   Проверить, что функция и ее настройки изменились, можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

   ```bash
   yc serverless function version get <идентификатор_версии_функции>
   ```

- API {#api}

  Чтобы настроить параметры сервиса метаданных функции, воспользуйтесь методом REST API [createVersion](../../functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/api-ref/grpc/Function/createVersion.md).

{% endlist %}