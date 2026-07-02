[Документация Yandex Cloud](../../index.md) > [Yandex Serverless Containers](../index.md) > [Пошаговые инструкции](index.md) > Получение информации о контейнере > Настроить параметры сервиса метаданных

# Настроить параметры сервиса метаданных контейнера

Настроить параметры сервиса метаданных вы можете при [создании ревизии контейнера](manage-revision.md).

Доступны следующие опции:

* `awsV1HttpEndpoint` — обеспечивает доступ к метаданным с использованием формата AWS (IMDSv1). Возможные значения: `enabled`, `disabled`. Если для опции задано значение `disabled`, то запрос к метаданным завершится ошибкой `404 Not Found`. Значение по умолчанию: `disabled`.

    {% note info %}

    По умолчанию параметр `awsV1HttpEndpoint` выключен (`disabled`), и мы не советуем включать его. Формат IMDSv1 имеет ряд недостатков со стороны безопасности. Наиболее критичный — повышенный риск реализации некоторых атак, например [SSRF](https://portswigger.net/web-security/ssrf) (подробнее в [официальном блоге AWS](https://aws.amazon.com/blogs/security/defense-in-depth-open-firewalls-reverse-proxies-ssrf-vulnerabilities-ec2-instance-metadata-service/)).

    {% endnote %}

* `gceHttpEndpoint` — обеспечивает доступ к метаданным с использованием формата Google Compute Engine. Возможные значения: `enabled`, `disabled`. Если для опции задано значение `disabled`, то запрос к метаданным завершится ошибкой `404 Not Found`. Значение по умолчанию: `enabled`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [контейнер](../concepts/container.md).
  1. Перейдите в сервис **Serverless Containers**.
  1. Выберите контейнер.
  1. Перейдите на вкладку **Редактор**.
  1. Разверните блок **Параметры сервиса метаданных**.
  1. Настройте параметры сервиса метаданных контейнера — `Доступ к метаданным с использованием формата Google Compute Engine` и `Доступ к метаданным с использованием формата AWS (IMDSv1)`.п
  1. Нажмите кнопку **Создать ревизию**.

- CLI {#cli}

    Чтобы настроить параметры сервиса метаданных контейнера, выполните команду:

    ```bash
    yc serverless container revision deploy \
      --container-id <идентификатор_контейнера> \
      --image <URL_Docker-образа> \
      --service-account-id <идентификатор_сервисного_аккаунта>
      --metadata-options <опция>=<enabled_или_disabled>
    ```

    Где:
    * `--container-id` — идентификатор контейнера. Чтобы узнать идентификатор, [получите](list.md) список контейнеров.
    * `--image` — URL Docker-образа из Yandex Container Registry.
    * `--service-account-id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md), у которого есть права на скачивание Docker-образа.
    * `--metadata-options` — настройки параметров сервиса метаданных, например `aws-v1-http-endpoint=disabled`.

- Terraform {#tf}

    [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
    
    Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
    
    Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

    Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    
    
    Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

    Чтобы настроить параметры сервиса метаданных контейнера:

    1. Откройте файл конфигурации Terraform и добавьте к описанию контейнера блок `metadata_options`:
      
        ```hcl
        resource "yandex_serverless_container" "metadata_container" {
          name               = "<имя_контейнера>"
          memory             = "<объем_RAM>"
          execution_timeout  = "<максимальное_время_выполнения>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
          content {
            zip_filename = "<путь_к_ZIP-архиву>"
          }

          image {
            url = <путь_к_образу_контейнера>
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

        Подробнее о параметрах ресурса `yandex_serverless_container` в [документации провайдера](../../terraform/resources/serverless_container.md).

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

   Проверить, что контейнер и его настройки изменились, можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

   ```bash
   yc serverless container revision get <идентификатор_ревизии_контейнера>
   ```

- API {#api}

    Чтобы настроить параметры сервиса метаданных контейнера, воспользуйтесь методом REST API [deployRevision](../containers/api-ref/Container/deployRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md).

{% endlist %}