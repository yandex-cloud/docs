# Создать группу

Чтобы создать [группу](../concepts/groups.md), у вас должна быть _минимальная_ [роль](../security/index.md#organization-manager-editor) `organization-manager.groups.editor` на [организацию](../concepts/organization.md).

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).

  1. На панели слева выберите ![groups](../../_assets/console-icons/persons.svg) **Группы**.

  1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../_assets/console-icons/circles-3-plus.svg) **Создать группу**.

  1. Задайте название и описание [группы](../concepts/groups.md).

      Название должно быть уникальным в организации и соответствовать требованиям:

      * длина — от 1 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

  1. Нажмите кнопку **Создать группу**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды создания группы пользователей Yandex Identity Hub:

      ```bash
      yc organization-manager group create --help
      ```
  
  1. Чтобы создать группу пользователей в Yandex Identity Hub, выполните команду:

      ```bash
      yc organization-manager group create \
        --name <имя_группы> \
        --organization-id <идентификатор_организации> \
        --description <описание_группы>
      ```

      Где:

      * `--name` — имя группы пользователей. Обязательный параметр. Название должно быть уникальным в организации и соответствовать требованиям:

        * длина — от 1 до 63 символов;
        * может содержать строчные буквы латинского алфавита, цифры и дефисы;
        * первый символ — буква, последний — не дефис.

      * `--organization-id` — [идентификатор](organization-get-id.md) организации. Необязательный параметр.
      * `--description` — текстовое описание группы пользователей. Необязательный параметр.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры [группы](../concepts/groups.md):

     ```hcl
     resource "yandex_organizationmanager_group" "my-group" {
       name            = "<название_группы>"
       description     = "<описание_группы>"
       organization_id = "<идентификатор_организации>"
     }
     ```

     Где:

     * `name` — название группы. Название должно быть уникальным в организации и соответствовать требованиям:

        * длина — от 1 до 63 символов;
        * может содержать строчные буквы латинского алфавита, цифры и дефисы;
        * первый символ — буква, последний — не дефис.

     * `description` — описание группы. Необязательный параметр.
     * `organization_id` — [идентификатор](organization-get-id.md) организации, к которой нужно присоединить группу.

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

     Terraform создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [интерфейсе Cloud Center](https://center.yandex.cloud/organization) или с помощью команды [CLI](../../cli/index.md):

     ```bash
     yc organization-manager group list \
       --organization-id <идентификатор_организации>
     ```

- API {#api}

    Воспользуйтесь методом REST API [Group.create](../api-ref/Group/create.md) для ресурса [Group](../api-ref/Group/index.md) или вызовом gRPC API [GroupService/Create](../api-ref/grpc/Group/create.md).

{% endlist %}