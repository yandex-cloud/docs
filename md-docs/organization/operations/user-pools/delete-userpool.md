# Удалить пул пользователей


{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![userpool](../../../_assets/organization/userpool.svg) **Пулы пользователей**.
  1. В строке с нужным [пулом пользователей](../../concepts/user-pools.md) нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. В открывшемся окне подтвердите удаление пула пользователей.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления [пула пользователей](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool delete --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp userpool delete <идентификатор_пула>
     ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Откройте конфигурационный файл Terraform и удалите фрагмент с описанием [пула пользователей](../../concepts/user-pools.md):

     ```hcl
     resource "yandex_organizationmanager_idp_userpool" "example_userpool" {
       organization_id   = "<идентификатор_организации>"
       name              = "<название_пула>"
       description       = "<описание_пула>"
       default_subdomain = "<домен_по_умолчанию>"
       labels            = {
         <ключ> = "<значение>"
       }
     }
     ```

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_userpool` см. в [документации провайдера](../../../terraform/resources/organizationmanager_idp_userpool.md).

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

     Terraform удалит все требуемые ресурсы. Проверить удаление ресурсов можно в [интерфейсе Cloud Center](https://center.yandex.cloud/organization) или с помощью команды [CLI](../../../cli/index.md):

     ```bash
     yc organization-manager idp userpool list --organization-id <идентификатор_организации>
     ```

- API {#api}

  Воспользуйтесь методом REST API [Userpool.Delete](../../idp/api-ref/Userpool/delete.md) для ресурса [Userpool](../../idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/Delete](../../idp/api-ref/grpc/Userpool/delete.md).

{% endlist %}