# Удалить SSH-ключ

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.

      При необходимости [переключитесь](manage-organizations.md#switch-to-another-org) на нужную организацию или федерацию.

  1. На панели слева выберите ![icon-users](../../_assets/console-icons/person.svg) **Пользователи**.
 
  1. В списке выберите пользователя, у которого вы хотите удалить SSH-ключ.
  
      При необходимости воспользуйтесь фильтром или поиском.

  1. Перейдите на вкладку **SSH-ключи**.
  1. В строке с нужным SSH-ключом нажмите кнопку ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. В открывшемся окне подтвердите удаление SSH-ключа.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для загрузки SSH-ключа в профиль пользователя или сервисного аккаунта:

      ```bash
      yc organization-manager oslogin user-ssh-key delete --help
      ```

  1. Получите идентификатор нужной организации:

      ```bash
      yc organization-manager organization list
      ```

      Результат:

      ```text
      +----------------------+-------------------------+-------------------------+
      |          ID          |          NAME           |          TITLE          |
      +----------------------+-------------------------+-------------------------+
      | bpf1smsil5q0******** | sample-organization-1   | My organization         |
      | bpf2c65rqcl8******** | sample-organization-new | New organization        |
      +----------------------+-------------------------+-------------------------+
      ```

  1. Получите идентификатор нужного SSH-ключа, указав полученный ранее идентификатор организации:

      ```bash
      yc organization-manager user-ssh-key list \
        --organization-id <идентификатор_организации>
      ```

      Результат:

     ```text
     +--------------------+-----------------------+----------------------+---------------------+-------------------------------------------+---------------------+---------------------+
     |         ID         |          NAME         |   ORGANIZATION ID    |      SUBJECT ID     |                FINGERPRINT                |      CREATED AT     |      EXPIRES AT     |
     +--------------------+-----------------------+----------------------+---------------------+-------------------------------------------+---------------------+---------------------+
     | bpfh4714g6******** | ssh-key-1756108465588 | bpf2c65rqcl8******** | aje0j5m02ta******** | SHA256:fUKV93PA7HYMZ3Jk6YaVaiK9i+******** | 2025-08-25 07:55:27 |                     |
     | bpf6big3s4******** | My key5               | bpf2c65r3ghy******** | ajei2a73kl3******** | SHA256:EJQdhwWDFj4TebYQzx9CmKZHr5******** | 2024-03-12 18:48:17 | 2024-03-10 21:48:17 |
     +--------------------+-----------------------+----------------------+---------------------+-------------------------------------------+---------------------+---------------------+
     ```

  1. Удалите SSH-ключ пользователя или сервисного аккаунта:

      ```bash
      yc organization-manager oslogin user-ssh-key delete <идентификатор_SSH-ключа>
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле инфраструктуру, удалив нужный SSH-ключ:

      ```hcl
      resource "yandex_organizationmanager_user_ssh_key" "my_user_ssh_key" {
        organization_id = "<идентификатор_организации>"
        subject_id      = "<идентификатор_пользователя>"
        data            = "<публичный_SSH-ключ>"
        name            = "<имя_ключа>"
        expires_at      = "<срок_действия_ключа>"
      }
      ```

      Где:

      * `organization_id` — [идентификатор](organization-get-id.md) организации.
      * `subject_id` — идентификатор [пользователя](users-get.md) или [сервисного аккаунта](../../iam/operations/sa/get-id.md), из которого удаляется SSH-ключ.
      * `data` — содержимое публичного SSH-ключа.
      * `name` — имя удаляемого ключа.
      * `expires_at` — срок действия удаляемого ключа.

  1. Удалите ресурсы:

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

     Terraform удалит все требуемые ресурсы. Проверить наличие ресурсов можно в [интерфейсе Cloud Center](https://center.yandex.cloud/organization) или с помощью команды [CLI](../../cli/index.md):

      ```bash
      yc organization-manager user-ssh-key list \
        --organization-id <идентификатор_организации>
      ```

- API {#api}

  Воспользуйтесь методом REST API [delete](../api-ref/UserSshKey/delete.md) для ресурса [UserSshKey](../api-ref/UserSshKey/index.md) или вызовом gRPC API [UserSshKeyService/Delete](../api-ref/grpc/UserSshKey/delete.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [Добавить SSH-ключ](add-ssh.md)
* [Включить доступ по OS Login](os-login-access.md)
* [Создать профиль OS Login](os-login-profile-create.md)
* [Подключиться к виртуальной машине по OS Login](../../compute/operations/vm-connect/os-login.md)