# Удаление сервисного аккаунта

{% note warning %}

Удаление [сервисного аккаунта](../../concepts/users/service-accounts.md) — неотменяемая операция. Восстановить удаленный сервисный аккаунт невозможно, только [создать его заново](create.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. На панели слева нажмите ![image](../../../_assets/console-icons/dots-9.svg) и выберите **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
  1. В строке с нужным сервисным аккаунтом нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды удаления сервисного аккаунта:

      ```bash
      yc iam service-account delete --help
      ```

  1. Выберите сервисный аккаунт, например `my-robot`:

      ```bash
      yc iam service-account list
      ```

      Результат:

      ```text
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2******** | my-robot         |                               |
      | aje9sda1ufvq******** | account_name     | account_description           |
      +----------------------+------------------+-------------------------------+
      ```

  1. Удалите сервисный аккаунт:

      ```bash
      yc iam service-account delete my-robot
      ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить сервисный аккаунт:

  1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием сервисного аккаунта. 
     Пример описания сервисного аккаунта в конфигурации Terraform:

     ```hcl
     ...
     resource "yandex_iam_service_account" "sa" {
       name        = "my-robot"
       description = "this is my favorite service account"
      }
     ...
     ```

  1. В командной строке перейдите в папку, где расположен файл конфигурации Terraform.
  
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

     Проверить, что сервисный аккаунт удален можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
     yc iam service-account list
     ```

- API {#api}

  Чтобы удалить сервисный аккаунт, воспользуйтесь методом REST API [delete](../../api-ref/ServiceAccount/delete.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Delete](../../api-ref/grpc/ServiceAccount/delete.md).

{% endlist %}

Сервисный аккаунт нельзя удалить, пока он связан с некоторыми [ресурсами](../../../overview/roles-and-resources.md#resources) облака. Сначала измените сервисный аккаунт в настройках ресурса или удалите ресурс, а затем удалите сервисный аккаунт. Например, если ваш сервисный аккаунт привязан к ВМ, то сначала [удалите](../../../compute/operations/vm-control/vm-delete.md) ВМ, и далее удалите сервисный аккаунт.