{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to connect a VM.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter a name for the [service account](../../../iam/concepts/users/service-accounts.md). The naming requirements are as follows:

      {% include [name-format](../../name-format.md) %}

  1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `backup.editor` [role](../../../backup/security/index.md#backup-editor).
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../cli-install.md) %}

  {% include [default-catalogue](../../default-catalogue.md) %}

  1. View the description of the command to create a [service account](../../../iam/concepts/users/service-accounts.md):

      ```bash
      yc iam service-account create --help
      ```

  1. Create a service account by running this command:

      ```bash
      yc iam service-account create \
        --name <service_account_name>
      ```

      Result:

      ```text
      id: ajehb3tcdfa1********
      folder_id: b1g86q4m5vej********
      created_at: "2024-07-22T16:05:14.237381531Z"
      name: backup-sa
      ```

      For more information about the `yc iam service-account create` command, see the [CLI reference](../../../cli/cli-ref/iam/cli-ref/service-account/create.md).

  1. View the description of the command to assign a role for a folder:

      ```bash
      yc resource-manager folder add-access-binding --help
      ```

  1. Assign the `backup.editor` [role](../../../backup/security/index.md#backup-editor) for the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to the service account:

      ```bash
      yc resource-manager folder add-access-binding <folder_ID> \
        --role backup.editor \
        --subject serviceAccount:<service_account_ID>
      ```

      Result:

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

      For more information about the `yc resource-manager folder add-access-binding` command, see the [CLI reference](../../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../terraform-install.md) %}

  1. Describe the resource parameters in the configuration file:

      ```hcl
      resource "yandex_iam_service_account" "backup-sa" {
        name        = "<service_account_name>"
        folder_id   = "<folder_ID>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "backup-editor-role" {
        folder_id   = "<folder_ID>"
        role        = "backup.editor"
        member      = "serviceAccount:${yandex_iam_service_account.backup-sa.id}"
      }
      ```

      Where:

      * `yandex_iam_service_account`: [Service account](../../../iam/concepts/users/service-accounts.md) description.
      * `yandex_resourcemanager_folder_iam_member`: Service account access permissions for the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder), where:

          * `role`: [Role](../../../backup/security/index.md#backup-editor).
          * `member`: Subject the role is assigned to.

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}).

  For more information about resource parameters, see the relevant provider documentation:

  * [yandex_iam_service_account]({{ tf-provider-datasources-link }}/iam_service_account)
  * [yandex_resourcemanager_folder_iam_member]({{ tf-provider-datasources-link }}/resourcemanager_folder_iam_member)

- API {#api}

  To create a [service account](../../../iam/concepts/users/service-accounts.md), use the [create](../../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.

  To assign the `backup.editor` [role](../../../backup/security/index.md#backup-editor) for a folder to a service account, use the [setAccessBindings](../../../iam/api-ref/ServiceAccount/setAccessBindings.md) method for the [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md) gRPC API call.

{% endlist %}

For more information, see [{#T}](../../../iam/operations/sa/create.md).