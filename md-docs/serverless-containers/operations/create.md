# Создать контейнер

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать [контейнер](../concepts/container.md).
  1. Перейдите в сервис **Serverless Containers**.
  1. Нажмите кнопку **Создать контейнер**.
  1. Введите имя и описание контейнера. Формат имени:

     * длина — от 3 до 63 символов;
     * может содержать строчные буквы латинского алфавита, цифры и дефисы;
     * первый символ — буква, последний — не дефис.

  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы создать [контейнер](../concepts/container.md), выполните команду:

  ```bash
  yc serverless container create --name <имя_контейнера>
  ```

  Результат:

  ```text
  id: bba3fva6ka5g********
  folder_id: b1gqvft7kjk3********
  created_at: "2021-07-09T14:49:00.891Z"
  name: my-beta-container
  url: https://bba3fva6ka5g********.containers.yandexcloud.net/
  status: ACTIVE
  ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы создать [контейнер](../concepts/container.md) и его [ревизию](manage-revision.md):

  {% note info %}

  Если [реестр](../../container-registry/concepts/registry.md) или [репозиторий](../../container-registry/concepts/repository.md) с Docker-образом не являются [публичными](../../container-registry/qa/index.md#public-registry), необходимо указать в настройках ревизии [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), у которого [есть права](../../iam/operations/sa/assign-role-for-sa.md) на скачивание Docker-образа. Например, роль `container-registry.images.puller` на каталог или реестр, в которых находится Docker-образ.
  
  Если в настройках ревизии указан сервисный аккаунт, у пользователя или сервисного аккаунта, от имени которого создается ревизия, должна быть роль `iam.serviceAccounts.user`. Она подтверждает права на использование сервисного аккаунта.

  {% endnote %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:
     * `name` — имя контейнера. Обязательный параметр. Требования к имени:

       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.

     * `memory` — объем памяти в МБ, выделенный контейнеру. По умолчанию — 128 МБ.
     * `service_account_id` — идентификатор [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).
     * `url` — URL [Docker-образа](../../container-registry/concepts/docker-image.md) в [Yandex Container Registry](../../container-registry/index.md).

     >Пример структуры конфигурационного файла:
     >
     >```hcl
     >resource "yandex_serverless_container" "test-container" {
     >  name               = "<имя_контейнера>"
     >  memory             = <объем_памяти>
     >  service_account_id = "<идентификатор_сервисного_аккаунта>"
     >  image {
     >    url = "<URL_Docker-образа>"
     >  }
     >}
     >```

     Подробнее о параметрах ресурса `yandex_serverless_container` в [документации провайдера](../../terraform/resources/serverless_container.md).
  1. Проверьте корректность конфигурационных файлов.
     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Разверните облачные ресурсы.
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):

        ```bash
        yc serverless container list 
        ```

- API {#api}

  Чтобы создать [контейнер](../concepts/container.md), воспользуйтесь методом REST API [create](../containers/api-ref/Container/create.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/Create](../containers/api-ref/grpc/Container/create.md).

{% endlist %}