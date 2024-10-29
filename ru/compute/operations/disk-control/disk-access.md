---
title: Настроить права доступа к диску {{ compute-name }}
description: Следуя данной инструкции, вы настроите права доступа к диску.
---

# Настроить права доступа к диску

Чтобы предоставить пользователю, группе или [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md) доступ к [диску](../../concepts/disk.md), назначьте на него [роль](../../../iam/concepts/access-control/roles.md).

## Назначить роль {#access-to-user}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит диск.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
  1. Выберите диск из списка.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к диску.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите необходимые [роли](../../security/index.md#roles-list).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для назначения роли на диск:

     ```bash
     yc compute disk add-access-binding --help
     ```

  1. Получите список дисков в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     {% include [compute-disk-list](../../_includes_service/compute-disk-list.md) %}

  1. Посмотрите список ролей, которые уже назначены на ресурс:

     ```bash
     yc compute disk list-access-bindings <идентификатор_диска>
     ```

  1. Назначьте роль с помощью команды:

     * Пользователю:

       ```bash
       yc compute disk add-access-binding <идентификатор_диска> \
         --user-account-id <идентификатор_пользователя> \
         --role <роль>
       ```

       Где:

       * `--user-account-id` — [идентификатор пользователя](../../../iam/operations/users/get.md).
       * `--role` — назначаемая [роль](../../security/index.md#roles-list).

     * Сервисному аккаунту:

       ```bash
       yc compute disk add-access-binding <идентификатор_диска> \
         --service-account-id <идентификатор_сервисного_аккаунта> \
         --role <роль>
       ```

       Где:

       * `--service-account-id` — [идентификатор сервисного аккаунта](../../../iam/operations/sa/get-id.md).
       * `--role` — назначаемая роль.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы назначить роль на диск с помощью {{ TF }}:

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_compute_disk_iam_binding" "sa-access" {
        disk_id = "<идентификатор_диска>"
        role    = "<роль>"
        members = ["<тип_субъекта>:<идентификатор_субъекта>","<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

      Где:

      * `disk_id` — идентификатор диска.
      * `role` — назначаемая [роль](../../security/index.md#roles-list).
      * `members` — список типов и идентификаторов [субъектов](../../../iam/concepts/access-control/index.md#subject), которым назначается роль. Указывается в виде `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

      Более подробную информацию о параметрах ресурса `yandex_compute_disk_iam_binding` см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_disk_iam_binding).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

      ```bash
      yc compute disk list-access-bindings <идентификатор_диска>
      ```

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Disk/updateAccessBindings.md) для ресурса [Disk](../../api-ref/Disk/) или вызовом gRPC API [DiskService/UpdateAccessBindings](../../api-ref/grpc/Disk/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `ADD`, а в свойстве `subject` — тип и идентификатор пользователя.

{% endlist %}

## Назначить несколько ролей {#multiple-roles}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит диск.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
  1. Выберите диск из списка.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к диску.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите необходимые [роли](../../security/index.md#roles-list).
  1. Добавьте еще роль через кнопку **{{ ui-key.yacloud_components.acl.button.add-role }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Вы можете назначить несколько ролей с помощью команды `set-access-bindings`.

  {% include [set-access-bindings](../../../_includes/compute/set-access-bindings-note.md) %}

  1. Убедитесь, что на ресурс не назначены роли, которые вы не хотите потерять:

     ```bash
     yc compute disk list-access-bindings <идентификатор_диска>
     ```

  1. Посмотрите описание команды CLI для назначения ролей на диск:

     ```bash
     yc compute disk set-access-bindings --help
     ```

  1. Назначьте роли:

     ```bash
     yc compute disk set-access-bindings <идентификатор_диска> \
       --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта>
     ```

     Где:

     * `--access-binding` — назначаемая роль:

       * `role` — идентификатор назначаемой роли.
       * `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

     Например, назначьте роли нескольким пользователям и сервисному аккаунту:

     ```bash
     yc compute disk set-access-bindings my-disk \
       --access-binding role=editor,subject=userAccount:gfei8n54hmfh********
       --access-binding role=viewer,subject=userAccount:helj89sfj80a********
       --access-binding role=editor,subject=serviceAccount:ajel6l0jcb9s********
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы назначить несколько ролей на диск с помощью {{ TF }}:

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_compute_disk_iam_binding" "role1" {
        disk_id = "<идентификатор_диска>"
        role    = "<роль_1>"
        members = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }

      resource "yandex_compute_disk_iam_binding" "role2" {
        disk_id = "<идентификатор_диска>"
        role    = "<роль_2>"
        members = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

      Где:

      * `disk_id` — идентификатор диска.
      * `role` — назначаемая [роль](../../security/index.md#roles-list).
      * `members` — список типов и идентификаторов [субъектов](../../../iam/concepts/access-control/index.md#subject), которым назначается роль. Указывается в виде `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

      Более подробную информацию о параметрах ресурса `yandex_compute_disk_iam_binding` см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_disk_iam_binding).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

      ```bash
      yc compute disk list-access-bindings <идентификатор_диска>
      ```

- API {#api}

  Воспользуйтесь методом REST API [setAccessBindings](../../api-ref/Disk/setAccessBindings.md) для ресурса [Disk](../../api-ref/Disk/) или вызовом gRPC API [DiskService/SetAccessBindings](../../api-ref/grpc/Disk/setAccessBindings.md).

{% endlist %}

## Отозвать роль {#revoke-role}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит диск.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
  1. Выберите диск из списка.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. В строке нужного пользователя нажмите значок ![icon-context-menu](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
  1. Нажмите значок ![cross](../../../_assets/console-icons/xmark.svg) рядом с ролью, чтобы удалить ее.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для отзыва роли на диск:

     ```bash
     yc compute disk remove-access-binding --help
     ```

  1. Посмотрите, кому и какие роли назначены на ресурс:

     ```bash
     yc compute disk list-access-bindings <идентификатор_диска>
     ```

  1. Чтобы отозвать права доступа, выполните команду:

     ```bash
     yc compute disk remove-access-binding <идентификатор_диска> \
       --role <идентификатор_роли> \
       --subject <тип_субъекта>:<идентификатор_субъекта>
     ```

     Где:

     * `--role` — идентификатор роли, которую надо отозвать.
     * `--subject` — [субъект](../../../iam/concepts/access-control/index.md#subject), у которого отзывается роль.

     Например, чтобы отозвать роль `{{ roles-viewer }}` у пользователя с идентификатором `ajel6l0jcb9s********` на диск:

     ```bash
     yc compute disk remove-access-binding my-disk \
       --role viewer \
       --subject userAccount:ajel6l0jcb9s********
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы отозвать роль, назначенную на диск с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием роли:

      ```hcl
      resource "yandex_compute_disk_iam_binding" "sa-access" {
        disk_id = "<идентификатор_диска>"
        role    = "<роль>"
        members = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

      ```bash
      yc compute disk list-access-bindings <идентификатор_диска>
      ```

- API {#api}

  Чтобы отозвать роли на диск, воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Disk/updateAccessBindings.md) для ресурса [Disk](../../api-ref/Disk/) или вызовом gRPC API [DiskService/UpdateAccessBindings](../../api-ref/grpc/Disk/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор пользователя.

{% endlist %}
