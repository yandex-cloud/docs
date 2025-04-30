{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно подключить ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md). Требования к имени:

      {% include [name-format](../../name-format.md) %}

  1. Нажмите ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите [роль](../../../backup/security/index.md#backup-editor) `backup.editor`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../cli-install.md) %}

  {% include [default-catalogue](../../default-catalogue.md) %}

  1. Посмотрите описание команды для создания [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md):

      ```bash
      yc iam service-account create --help
      ```

  1. Создайте сервисный аккаунт, выполнив команду:

      ```bash
      yc iam service-account create \
        --name <имя_сервисного_аккаунта>
      ```

      Результат:

      ```text
      id: ajehb3tcdfa1********
      folder_id: b1g86q4m5vej********
      created_at: "2024-07-22T16:05:14.237381531Z"
      name: backup-sa
      ```

      Подробнее о команде `yc iam service-account create` см. в [справочнике CLI](../../../cli/cli-ref/iam/cli-ref/service-account/create.md).

  1. Посмотрите описание команды для назначения роли на каталог:

      ```bash
      yc resource-manager folder add-access-binding --help
      ```

  1. Назначьте сервисному аккаунту [роль](../../../backup/security/index.md#backup-editor) `backup.editor` на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role backup.editor \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Результат:

      ```text
      done (3s)
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: backup.editor
            subject:
              id: ajehb3tcdfa1********
              type: serviceAccount
      ```

      Подробнее о команде `yc resource-manager folder add-access-binding` см. в [справочнике CLI](../../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов:

      ```hcl
      resource "yandex_iam_service_account" "backup-sa" {
        name        = "<имя_сервисного_аккаунта>"
        folder_id   = "<идентификатор_каталога>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "backup-editor-role" {
        folder_id   = "<идентификатор_каталога>"
        role        = "backup.editor"
        member      = "serviceAccount:${yandex_iam_service_account.backup-sa.id}"
      }
      ```

      Где:

      * `yandex_iam_service_account` — описание [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).
      * `yandex_resourcemanager_folder_iam_member` — описание прав доступа сервисного аккаунта к [каталогу](../../../resource-manager/concepts/resources-hierarchy.md#folder), где:

          * `role` — назначаемая [роль](../../../backup/security/index.md#backup-editor).
          * `member` — субъект, которому назначается роль.

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}).

  Более подробную информацию о параметрах ресурсов см. в документации провайдера:

  * [yandex_iam_service_account]({{ tf-provider-datasources-link }}/iam_service_account)
  * [yandex_resourcemanager_folder_iam_member]({{ tf-provider-datasources-link }}/resourcemanager_folder_iam_member)

- API {#api}

  Чтобы создать [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), воспользуйтесь методом REST API [create](../../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../../iam/api-ref/grpc/ServiceAccount/create.md).

  Чтобы назначить сервисному аккаунту [роль](../../../backup/security/index.md#backup-editor) `backup.editor` на каталог, воспользуйтесь методом [setAccessBindings](../../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

{% endlist %}

Подробности см. в разделе [{#T}](../../../iam/operations/sa/create.md).