---
title: Настроить права доступа к кластеру GPU {{ compute-name }}
description: Следуя данной инструкции, вы настроите права доступа к кластеру GPU.
---

# Настроить права доступа к кластеру GPU


Чтобы предоставить пользователю, группе или [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md) доступ к [кластеру GPU](../../concepts/gpus.md), назначьте на него [роль](../../../iam/concepts/access-control/roles.md).

## Назначить роль {#add-access}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен кластер GPU.
  1. Выберите сервис **{{ ui-key.yacloud.compute.label_service }}**.
  1. На панели слева выберите ![image](../../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.gpu-cluster.label_title }}**.
  1. Выберите нужный кластер GPU.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к кластеру GPU.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите необходимую [роль](../../security/index.md#roles-list).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для назначения роли на кластер GPU:

     ```bash
     yc compute gpu-cluster add-access-binding --help
     ```

  1. Получите список кластеров GPU в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc compute gpu-cluster list
     ```

  1. Посмотрите список ролей, которые уже назначены на ресурс:

     ```bash
     yc compute gpu-cluster list-access-bindings <идентификатор_кластера_GPU>
     ```

  1. Назначьте роль с помощью команды:

     * Пользователю:

       ```bash
       yc compute gpu-cluster add-access-binding <идентификатор_кластера_GPU> \
         --user-account-id <идентификатор_пользователя> \
         --role <роль>
       ```

       Где:

       * `--user-account-id` — [идентификатор пользователя](../../../iam/operations/users/get.md). Чтобы назначить роль для всех аутентифицированных пользователей, воспользуйтесь флагом `--all-authenticated-users`.
       * `--role` — назначаемая [роль](../../security/index.md#roles-list).

     * Сервисному аккаунту:

       ```bash
       yc compute gpu-cluster add-access-binding <идентификатор_кластера_GPU> \
         --service-account-id <идентификатор_сервисного_аккаунта> \
         --role <роль>
       ```

       Где:

       * `--service-account-id` — [идентификатор сервисного аккаунта](../../../iam/operations/sa/get-id.md).
       * `--role` — назначаемая [роль](../../security/index.md#roles-list).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы назначить роль на доступ к кластеру GPU с помощью {{ TF }}:

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_compute_gpu_cluster_iam_binding" "sa-access" {
        gpu_cluster_id = "<идентификатор_GPU_кластера>"
        role           = "<роль>"
        members        = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

      Где:

      * `gpu_cluster_id` — идентификатор кластера GPU.
      * `role` — назначаемая [роль](../../security/index.md#roles-list).
      * `members` — список типов и идентификаторов [субъектов](../../../iam/concepts/access-control/index.md#subject), которым назначается роль. Указывается в виде `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

      Более подробную информацию о параметрах ресурса `yandex_compute_gpu_cluster_iam_binding` см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_gpu_cluster_iam_binding).

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

       ```bash
       yc compute gpu-cluster list-access-bindings <идентификатор_кластера_GPU>
       ```


- API {#api}

  Чтобы назначить роль, воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/GpuCluster/updateAccessBindings.md) для ресурса [GpuCluster](../../api-ref/GpuCluster/index.md) или вызовом gRPC API [GpuClusterService/UpdateAccessBindings](../../api-ref/grpc/GpuCluster/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `ADD`, а в свойстве `subject` — тип и идентификатор пользователя.

{% endlist %}

## Назначить несколько ролей {#set-access}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен кластер GPU.
  1. Выберите сервис **{{ ui-key.yacloud.compute.label_service }}**.
  1. На панели слева выберите ![image](../../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.gpu-cluster.label_title }}**.
  1. Выберите нужный кластер GPU.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к кластеру GPU.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите необходимую [роль](../../security/index.md#roles-list).
  1. Добавьте еще роль через кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Вы можете назначить несколько ролей с помощью команды `set-access-bindings`.

  {% include [set-access-bindings](../../../_includes/compute/set-access-bindings-note.md) %}

  1. Убедитесь, что на ресурс не назначены роли, которые вы не хотите потерять:

     ```bash
     yc compute gpu-cluster list-access-bindings <идентификатор_кластера_GPU>
     ```

  1. Посмотрите описание команды CLI для назначения ролей на кластер GPU:

     ```bash
     yc compute gpu-cluster set-access-bindings --help
     ```

  1. Назначьте роли:

     ```bash
     yc compute gpu-cluster set-access-bindings <идентификатор_кластера_GPU> \
       --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта> \
       --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта>
     ```

     Где:

     * `--access-binding` — параметры для установки прав доступа:

       * `role` — назначаемая [роль](../../security/index.md#roles-list).
       * `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

     Например, назначьте роли нескольким пользователям и сервисному аккаунту:

     ```bash
     yc compute gpu-cluster set-access-bindings my-gpu-cluster \
       --access-binding role=editor,subject=userAccount:gfei8n54hmfh********
       --access-binding role=viewer,subject=userAccount:helj89sfj80a********
       --access-binding role=editor,subject=serviceAccount:ajel6l0jcb9s********
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы назначить несколько ролей на файловое хранилище с помощью {{ TF }}:

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_compute_gpu_cluster_iam_binding" "role1" {
        gpu_cluster_id = "<идентификатор_GPU_кластера>"
        role           = "<роль_1>"
        members        = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }
      
      resource "yandex_compute_gpu_cluster_iam_binding" "role2" {
        gpu_cluster_id = "<идентификатор_GPU_кластера>"
        role           = "<роль_2>"
        members        = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

      Где:

      * `gpu_cluster_id` — идентификатор кластера GPU.
      * `role` — назначаемая [роль](../../security/index.md#roles-list).
      * `members` — список типов и идентификаторов [субъектов](../../../iam/concepts/access-control/index.md#subject), которым назначается роль. Указывается в виде `userAccount:<идентификатор_пользователя>` или `serviceAccount:<идентификатор_сервисного_аккаунта>`.

      Более подробную информацию о параметрах ресурса `yandex_compute_gpu_cluster_iam_binding` см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_gpu_cluster_iam_binding).

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

       ```bash
       yc compute gpu-cluster list-access-bindings <идентификатор_кластера_GPU>
       ```


- API {#api}

  Чтобы назначить роли на ресурс, воспользуйтесь методом REST API [setAccessBindings](../../api-ref/GpuCluster/setAccessBindings.md) для ресурса [GpuCluster](../../api-ref/GpuCluster/index.md) или вызовом gRPC API [GpuClusterService/SetAccessBindings](../../api-ref/grpc/GpuCluster/setAccessBindings.md).

  {% note alert %}

  Метод `setAccessBindings` и вызов `GpuClusterService/SetAccessBindings` полностью перезаписывают права доступа к ресурсу. Все текущие роли на ресурс будут удалены.

  {% endnote %}

{% endlist %}

## Отозвать роль {#revoke-role}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен кластер GPU.
  1. Выберите сервис **{{ ui-key.yacloud.compute.label_service }}**.
  1. На панели слева выберите ![image](../../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.gpu-cluster.label_title }}**.
  1. Выберите нужный кластер GPU.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. В строке нужного пользователя нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
  1. Рядом с ролью нажмите значок ![image](../../../_assets/cross.svg).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для отзыва роли на кластер GPU:

     ```bash
     yc compute gpu-cluster remove-access-binding --help
     ```

  1. Посмотрите, кому и какие роли назначены на ресурс:

     ```bash
     yc compute gpu-cluster list-access-bindings <идентификатор_кластера_GPU>
     ```

  1. Чтобы отозвать права доступа, выполните команду:

     ```bash
     yc compute gpu-cluster remove-access-binding <идентификатор_кластера_GPU> \
       --role=<роль> \
       --subject=<тип_субъекта>:<идентификатор_субъекта> \
     ```

     Где:

     * `--role` — идентификатор роли, которую надо отозвать.
     * `--subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

     Например, чтобы отозвать роль `{{ roles-viewer }}` у пользователя с идентификатором `ajel6l0jcb9s********` на кластер GPU:

     ```bash
     yc compute gpu-cluster remove-access-binding my-gpu-cluster \
       --role viewer \
       --subject userAccount:ajel6l0jcb9s********
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы отозвать роль, назначенную на GPU кластер с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием роли:

      ```hcl
      resource "yandex_compute_gpu_cluster_iam_binding" "sa-access" {
        gpu_cluster_id = "<идентификатор_GPU_кластера>"
        role           = "<роль>"
        members        = ["<тип_субъекта>:<идентификатор_субъекта>"]
      }
      ```

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

       ```bash
       yc compute gpu-cluster list-access-bindings <идентификатор_кластера_GPU>
       ```

- API {#api}

  Чтобы отозвать роль, воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/GpuCluster/updateAccessBindings.md) для ресурса [GpuCluster](../../api-ref/GpuCluster/index.md) или вызовом gRPC API [GpuClusterService/UpdateAccessBindings](../../api-ref/grpc/GpuCluster/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор пользователя.

{% endlist %}
