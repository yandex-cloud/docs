---
title: Настроить права доступа к снимку диска {{ compute-name }}
description: Следуя данной инструкции, вы настроите права доступа к снимку диска.
---

# Настроить права доступа к снимку диска

Чтобы предоставить пользователю, группе или [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md) доступ к [снимку диска](../../concepts/snapshot.md), назначьте на него [роль](../../../iam/concepts/access-control/roles.md).

## Назначить роль {#access-to-user}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит снимок диска.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
  1. Выберите снимок диска из списка.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к снимку диска.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите необходимые [роли](../../security/index.md#roles-list).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для назначения роли на снимок диска:

     ```bash
     yc compute snapshot add-access-binding --help
     ```

  1. Получите список снимков в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     {% include [compute-snapshot-list](../../_includes_service/compute-snapshot-list.md) %}

  1. Посмотрите список ролей, которые уже назначены на ресурс:

     ```bash
     yc compute snapshot list-access-bindings <идентификатор_снимка>
     ```

  1. Назначьте роль с помощью команды:

     * Пользователю:

       ```bash
       yc compute snapshot add-access-binding <идентификатор_снимка> \
         --user-account-id <идентификатор_пользователя> \
         --role <роль>
       ```

       Где:

       * `--user-account-id` — [идентификатор пользователя](../../../iam/operations/users/get.md).
       * `--role` — назначаемая [роль](../../security/index.md#roles-list).

     * Сервисному аккаунту:

       ```bash
       yc compute snapshot add-access-binding <идентификатор_снимка> \
         --service-account-id <идентификатор_сервисного_аккаунта> \
         --role <роль>
       ```

       Где:

       * `--service-account-id` — [идентификатор сервисного аккаунта](../../../iam/operations/sa/get-id.md).
       * `--role` — назначаемая роль.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы назначить роль на снимок с помощью {{ TF }}:

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_compute_snapshot_iam_binding" "sa-access" {
        snapshot_id = "<идентификатор_снимка>"
        role        = "<роль>"
        members     = ["<тип_субъекта>:<идентификатор_субъекта>","<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

      Где:

      * `snapshot_id` — идентификатор снимка.
      * `role` — назначаемая [роль](../../security/index.md#roles-list).
      * `members` — список типов и идентификаторов [субъектов](../../../iam/concepts/access-control/index.md#subject), которым назначается роль. Указывается в виде `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

      Более подробную информацию о параметрах ресурса `yandex_compute_snapshot_iam_binding` см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_snapshot_iam_binding).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) и с помощью команды [CLI](../../../cli/):

      ```bash
      yc compute snapshot list-access-bindings <идентификатор_снимка>
      ```

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Snapshot/updateAccessBindings.md) для ресурса [Snapshot](../../api-ref/Snapshot/) или вызовом gRPC API [SnapshotService/UpdateAccessBindings](../../api-ref/grpc/snapshot_service.md#UpdateAccessBindings). В теле запроса в свойстве `action` укажите `ADD`, а в свойстве `subject` — тип и идентификатор пользователя.

{% endlist %}

## Назначить несколько ролей {#multiple-roles}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит снимок диска.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
  1. Выберите снимок диска из списка.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к снимку диска.
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
     yc compute snapshot list-access-bindings <идентификатор_снимка>
     ```

  1. Посмотрите описание команды CLI для назначения ролей на снимок диска:

     ```bash
     yc compute snapshot set-access-bindings --help
     ```

  1. Назначьте роли:

     ```bash
     yc compute snapshot set-access-bindings <идентификатор_снимка> \
       --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта>
     ```

     Где:

     * `--access-binding` — назначаемая роль:

       * `role` — идентификатор назначаемой роли.
       * `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

     Например, назначьте роли нескольким пользователям и сервисному аккаунту:

     ```bash
     yc compute snapshot set-access-bindings my-snapshot \
       --access-binding role=editor,subject=userAccount:gfei8n54hmfh********
       --access-binding role=viewer,subject=userAccount:helj89sfj80a********
       --access-binding role=editor,subject=serviceAccount:ajel6l0jcb9s********
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы назначить несколько ролей на снимок с помощью {{ TF }}:

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_compute_snapshot_iam_binding" "role-1" {
        snapshot_id = "<идентификатор_снимка>"
        role        = "<роль_1>"
        members     = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }

      resource "yandex_compute_snapshot_iam_binding" "role-2" {
        snapshot_id = "<идентификатор_снимка>"
        role        = "<роль_2>"
        members     = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

      Где:

      * `snapshot_id` — идентификатор снимка.
      * `role` — назначаемая [роль](../../security/index.md#roles-list).
      * `members` — список типов и идентификаторов [субъектов](../../../iam/concepts/access-control/index.md#subject), которым назначается роль. Указывается в виде `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

      Более подробную информацию о параметрах ресурса `yandex_compute_snapshot_iam_binding` см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_snapshot_iam_binding).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Проверить изменения можно в [консоли управления]({{ link-console-main }}) и с помощью команды [CLI](../../../cli/):

      ```bash
      yc compute snapshot list-access-bindings <идентификатор_снимка>
      ```

- API {#api}

  Воспользуйтесь методом REST API [setAccessBindings](../../api-ref/Snapshot/setAccessBindings.md) для ресурса [Snapshot](../../api-ref/Snapshot/) или вызовом gRPC API [SnapshotService/SetAccessBindings](../../api-ref/grpc/snapshot_service.md#SetAccessBindings).

{% endlist %}

## Отозвать роль {#revoke-role}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит снимок диска.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/picture.svg) **{{ ui-key.yacloud.compute.switch_snapshots }}**.
  1. Выберите снимок диска из списка.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. В строке нужного пользователя нажмите значок ![icon-context-menu](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
  1. Нажмите значок ![cross](../../../_assets/console-icons/xmark.svg) рядом с ролью, чтобы удалить ее.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для отзыва роли на снимок диска:

     ```bash
     yc compute snapshot remove-access-binding --help
     ```

  1. Посмотрите, кому и какие роли назначены на ресурс:

      ```bash
      yc compute snapshot list-access-bindings <идентификатор_снимка>
      ```

  1. Чтобы отозвать права доступа, выполните команду:

      ```bash
      yc compute snapshot remove-access-binding <идентификатор_снимка> \
        --role <идентификатор_роли> \
        --subject <тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--role` — идентификатор роли, которую надо отозвать.
      * `--subject` — [субъект](../../../iam/concepts/access-control/index.md#subject), у которого отзывается роль.

      Например, чтобы отозвать роль `{{ roles-viewer }}` у пользователя с идентификатором `ajel6l0jcb9s********` на снимок диска:

      ```bash
      yc compute snapshot remove-access-binding my-snapshot \
        --role viewer \
        --subject userAccount:ajel6l0jcb9s********
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы отозвать роль, назначенную на снимок диска с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием роли:

      ```hcl
      resource "yandex_compute_snapshot_iam_binding" "sa-access" {
        snapshot_id = "<идентификатор_снимка>"
        role        = "<роль>"
        members     = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Проверить изменения можно в [консоли управления]({{ link-console-main }}) и с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc compute snapshot list-access-bindings <идентификатор_снимка>
      ```

- API {#api}

  Чтобы отозвать роли на снимок диска, воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/Snapshot/updateAccessBindings.md) для ресурса [Snapshot](../../api-ref/Snapshot/) или вызовом gRPC API [SnapshotService/UpdateAccessBindings](../../api-ref/grpc/snapshot_service.md#UpdateAccessBindings). В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор пользователя.

{% endlist %}
