# Вызвать контейнер асинхронно

{% note info %}

Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

## Настройте асинхронный вызов {#async}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [контейнер](../concepts/container.md).
  1. Перейдите в сервис **Serverless Containers**.
  1. Выберите контейнер, [ревизию](../concepts/container.md#revision) которого хотите создать.
  1. Перейдите на вкладку **Редактор**.
  1. В блоке **Асинхронный вызов**:

      1. Включите асинхронный вызов.
      1. Укажите сервисный аккаунт для асинхронного вызова, у которого есть [роль](../security/index.md#serverless-containers-containerinvoker) `serverless-containers.containerInvoker`.

  1. Нажмите **Создать ревизию**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы настроить асинхронный вызов, выполните команду:

    ```bash
    yc serverless container revision deploy \
      --container-name <имя_контейнера> \
      --image <URL_Docker-образа> \
      --service-account-id <идентификатор_сервисного_аккаунта> \
      --async-service-account-id <идентификатор_сервисного_аккаунта_для_асинхронного_вызова>
    ```


    Где:

    * `--service-account-id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md), у которого есть [роль](../security/index.md#serverless-containers-editor) `serverless-containers.editor` или выше.
    * `--async-service-account-id` — идентификатор сервисного аккаунта для асинхронного вызова, у которого есть [роль](../security/index.md#serverless-containers-containerinvoker) `serverless-containers.containerInvoker`.

    Результат:

    ```text
    done (6s)
    id: bba1r76l8f73********
    container_id: bbado1g2mtqj********
    created_at: "2025-09-08T12:03:32.797Z"
    image:
      image_url: cr.yandex/crpmfvcgnl26********/ubuntu:hello
      image_digest: sha256:96ab2d89a82fcfc63e24b9ef26de8b3b11ed1043cec41d4359a8de8b********
    resources:
      memory: "134217728"
      cores: "1"
      core_fraction: "100"
    execution_timeout: 3s
    concurrency: "1"
    service_account_id: ajelprpohp7r********
    status: ACTIVE
    log_options:
      folder_id: b1g681qpemb4********
    runtime:
      http: {}
    async_invocation_config:
      service_account_id: ajeaim70pe1u********
    ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы настроить асинхронный вызов:

  1. Откройте файл конфигурации Terraform и добавьте к описанию контейнера блок `async_invocation`:

      ```hcl
      resource "yandex_serverless_container" "test-container" {
        name               = "<имя_контейнера>"
        memory             = "<объем_RAM>"
        execution_timeout  = "<максимальное_время_выполнения>"
        service_account_id = "<идентификатор_сервисного_аккаунта>"

        image {
          url = <путь_к_образу_контейнера>
        }

        async_invocation {
          service_account_id = "<идентификатор_сервисного_аккаунта>"
        }
      }
      ```

      Где:

      * `async_invocation` — параметры асинхронного вызова:

          * `service_account_id` — сервисный аккаунт, у которого есть [роль](../security/index.md#serverless-containers-containerinvoker) `serverless-containers.containerInvoker`.

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

  Проверить изменение контейнера и его настройки можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

  ```bash
  yc serverless serverless-container revision get <идентификатор_ревизии_контейнера>
  ```

- API {#api}

  Чтобы настроить асинхронный вызов, воспользуйтесь методом REST API [deployRevision](../containers/api-ref/Container/deployRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md).

{% endlist %}


## Вызовите контейнер {#invoke}

[Вызовите](invoke.md) контейнер по HTTP, указав при вызове заголовок `X-Ycf-Container-Integration-Type: async`.


## Полезные ссылки {#see-also}

* [Асинхронный вызов контейнера](../concepts/invoke-async.md)