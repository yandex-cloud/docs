# Подключить сервисный аккаунт к ВМ

Для автоматизации работы с Yandex Cloud изнутри ВМ рекомендуется использовать [сервисные аккаунты](../../../iam/concepts/users/service-accounts.md). Это безопаснее — вам не надо сохранять свой [OAuth-токен](../../../iam/concepts/authorization/oauth-token.md) на ВМ и вы можете ограничить права доступа для сервисного аккаунта.

Если у вас еще нет сервисного аккаунта, [создайте его](../../../iam/operations/sa/create.md) и [настройте права доступа для него](../../../iam/operations/sa/assign-role-for-sa.md).

{% note info %}

К виртуальной машине можно привязать только один сервисный аккаунт.

{% endnote %}

Чтобы привязать сервисный аккаунт к ВМ, необходимо иметь разрешение на использование этого сервисного аккаунта. Это разрешение входит в роли [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user), [editor](../../../iam/roles-reference.md#editor) и выше.

### К существующей ВМ {#link-with-exist-instance}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит ВМ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. Нажмите на имя нужной ВМ.
  1. В правом верхнем углу страницы нажмите ![image](../../../_assets/console-icons/pencil.svg) **Изменить ВМ**.
  1. В блоке **Дополнительно** выберите один из существующих сервисных аккаунтов или создайте новый.
  1. Нажмите **Сохранить изменения**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Обновите параметры ВМ, указав сервисный аккаунт с помощью опции `--service-account-name` или `--service-account-id`:

  ```bash
  yc compute instance update my-instance --service-account-name test
  ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).
  
  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Откройте конфигурационный файл Terraform, в котором описана ВМ, к которой вы хотите подключить сервисный аккаунт. См. [пример конфигурационного файла ВМ](../vm-create/create-linux-vm.md#tf_1).
  1. В блок с описанием ресурса `yandex_compute_instance` добавьте параметр `service_account_id` и укажите идентификатор сервисного аккаунта:

      ```hcl
      resource "yandex_compute_instance" "vm-1" {
        ...
        service_account_id = "<идентификатор_сервисного_аккаунта>"
        ...
      }
      ```

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

     Terraform изменит все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления](https://console.yandex.cloud).

  Более подробную информацию о параметрах ресурса `yandex_compute_instance` см. в [документации провайдера](../../../terraform/data-sources/compute_instance.md).

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Update](../../api-ref/grpc/Instance/update.md). В запросе укажите идентификатор сервисного аккаунта.

{% endlist %}

### К создаваемой ВМ {#link-with-new-instance}

{% list tabs group=instructions %}

- Консоль управления {#console}

  В консоли управления вы можете привязать к виртуальной машине сервисный аккаунт, расположенный в том же [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается ВМ. Если сервисный аккаунт расположен в другом каталоге, воспользуйтесь CLI или API.

  Чтобы привязать сервисный аккаунт к ВМ, выберите его в блоке **Дополнительно**  в поле **Сервисный аккаунт** при [создании ВМ](../index.md#vm-create). Вы можете выбрать один из существующих сервисных аккаунтов или создать новый.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Создайте ВМ, указав сервисный аккаунт с помощью опции `--service-account-name` или `--service-account-id`:

  ```bash
  yc compute instance create \
    --name my-instance \
    --network-interface subnet-name=default,nat-ip-version=ipv4 \
    --ssh-key ~/.ssh/id_ed25519.pub \
    --service-account-name my-robot
  ```

- Terraform {#tf}

  1. Откройте конфигурационный файл Terraform, в котором описана ВМ, к которой вы хотите подключить сервисный аккаунт. См. [пример конфигурационного файла ВМ](../vm-create/create-linux-vm.md#tf_1).
  1. В блок с описанием ресурса `yandex_compute_instance` добавьте параметр `service_account_id` и укажите идентификатор сервисного аккаунта:

      ```hcl
      resource "yandex_compute_instance" "vm-1" {
        ...
        service_account_id = "<идентификатор_сервисного_аккаунта>"
        ...
      }
      ```

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

     Terraform создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления](https://console.yandex.cloud).

  Более подробную информацию о параметрах ресурса `yandex_compute_instance` см. в [документации провайдера](../../../terraform/data-sources/compute_instance.md).

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/Instance/create.md). В запросе укажите идентификатор сервисного аккаунта.

{% endlist %}