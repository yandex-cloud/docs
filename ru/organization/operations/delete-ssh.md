---
title: Как удалить SSH-ключ пользователя
description: Следуя данной инструкции, вы сможете удалить SSH-ключ пользователя.
---

# Удалить SSH-ключ

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.

      При необходимости [переключитесь](./manage-organizations.md#switch-to-another-org) на нужную организацию или федерацию.

  1. На панели слева выберите ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.
 
  1. В списке выберите пользователя, у которого вы хотите удалить SSH-ключ.
  
      При необходимости воспользуйтесь фильтром или поиском.

  1. Перейдите на вкладку **{{ ui-key.yacloud_org.user.title_ssh-keys }}**.
  1. В строке с нужным SSH-ключом нажмите кнопку ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.actions.delete }}**.
  1. В открывшемся окне подтвердите удаление SSH-ключа.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

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

      * `organization_id` — [идентификатор](./organization-get-id.md) организации.
      * `subject_id` — идентификатор [пользователя](./users-get.md) или [сервисного аккаунта](../../iam/operations/sa/get-id.md), из которого удаляется SSH-ключ.
      * `data` — содержимое публичного SSH-ключа.
      * `name` — имя удаляемого ключа.
      * `expires_at` — срок действия удаляемого ключа.

  1. Удалите ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} удалит все требуемые ресурсы. Проверить наличие ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

      ```bash
      yc organization-manager user-ssh-key list \
        --organization-id <идентификатор_организации>
      ```

- API {#api}

  Воспользуйтесь методом REST API [delete](../../organization/api-ref/UserSshKey/delete.md) для ресурса [UserSshKey](../../organization/api-ref/UserSshKey/index.md) или вызовом gRPC API [UserSshKeyService/Delete](../../organization/api-ref/grpc/UserSshKey/delete.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](../operations/add-ssh.md)
* [{#T}](../operations/os-login-access.md)
* [{#T}](../operations/os-login-profile-create.md)
* [{#T}](../../compute/operations/vm-connect/os-login.md)
