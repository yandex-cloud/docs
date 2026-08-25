{% list tabs group=instructions %}

- Management console {#console}

  1. Log in to the [management console]({{ link-console-main }}) with the cloud administrator or owner account.
  1. On the left side of the screen, click the line with the name of the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) or [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) for which you want to assign a role to a user group.
  1. At the top of the screen, go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab and click **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**. In the window that opens:

      1. Go to the **{{ ui-key.yacloud_org.pages.groups }}** tab and select the [group](../../organization/concepts/groups.md) you need or search by group name.

          You can also assign a role to one of the [system](../../iam/concepts/access-control/system-group.md) groups:

          * `All users in organization X`: The group includes all users in organization `X`.
          * `All users in federation N`: The group includes all users in federation `N`.

      1. Click ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the [role](../../iam/concepts/access-control/roles.md) you want to assign to the group for the cloud or folder you selected earlier. You can assign multiple roles.
      1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  1. Select a [role](../../iam/concepts/access-control/roles.md) from the [{{ yandex-cloud }} role reference](../../iam/roles-reference.md).
  1. Assign a role using this command:

     ```bash
     yc <service_name> <resource> add-access-binding <resource_name_or_ID> \
       --role <role_ID> \
       --subject group:<group_ID>
     ```

     Where:

     * `--role`: Role ID, e.g., `{{ roles-cloud-owner }}`.
     * `--subject`: [Subject](../../iam/concepts/access-control/index.md#subject) getting the role.

        {% cut "Subject designations" %}

        {% include [subjects-designations-cli](../iam/subjects-designations-cli.md) %}

        {% endcut %}

     For example, assign the `resource-manager.viewer` role for the `my-cloud` [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).

     ```bash
     yc resource-manager cloud add-access-binding mycloud \
       --role resource-manager.viewer \
       --subject group:aje6o61dvog2********
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../terraform-install.md) %}

  1. Add the resource parameters to the configuration file and specify the required [role](../../iam/concepts/access-control/roles.md) and [group](../../organization/concepts/groups.md):

     ```hcl
     resource "yandex_resourcemanager_cloud_iam_member" "admin" {
       cloud_id = "<cloud_ID>"
       role     = "<role_ID>"
       member   = "group:<group_ID>"
     }
     ```

     Where:

     * `cloud_id`: [Cloud ID](../../resource-manager/operations/cloud/get-id.md). To assign a role for a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), use the `yandex_resourcemanager_folder_iam_member` resource and specify `folder_id`.
     * `role`: Role to assign. This is a required setting.
     * `member`: [Subject](../../iam/concepts/access-control/index.md#subject) getting the role. This is a required setting.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../iam/subjects-designations-terraform.md) %}

          {% endcut %}

     For more on the properties of the `yandex_resourcemanager_cloud_iam_member` and `yandex_resourcemanager_folder_iam_member` resources, see the relevant provider guide for the [cloud]({{ tf-provider-resources-link }}/resourcemanager_cloud_iam_member) and [folder]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     With this done, the specified access permissions will be assigned. You can check the role assignment using the [management console]({{ link-console-main }}) or this CLI command:

     ```bash
     yc resource-manager <cloud_or_folder> list-access-bindings <name_or_ID_of_cloud_or_folder>
     ```

- API {#api}

  To assign a role for a cloud to a group of users, use the [updateAccessBindings](../../resource-manager/api-ref/Cloud/updateAccessBindings.md) REST API method for the [Cloud](../../resource-manager/api-ref/Cloud/index.md) resource or the [CloudService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Cloud/updateAccessBindings.md) gRPC API call.

  To assign a role for a folder to a group of users, use the [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md) gRPC API call.

  Provide the following in the request:

  * `ADD` value in the `accessBindingDeltas[].action` parameter to add a role.
  * Role in the `accessBindingDeltas[].accessBinding.roleId` parameter.
  * ID of the [subject](../../iam/concepts/access-control/index.md#subject) getting the role in the `accessBindingDeltas[].accessBinding.subject.id` parameter.
  * Type of the subject getting the role in the `accessBindingDeltas[].accessBinding.subject.type` parameter.

      {% cut "Subject designations" %}

      {% include [subjects-designations-api](../iam/subjects-designations-api.md) %}

      {% endcut %}


  To learn how to assign a role for the respective resource, see:

  * [{#T}](../../iam/operations/sa/set-access-bindings.md).
  * [{#T}](../../resource-manager/operations/cloud/set-access-bindings.md).
  * [{#T}](../../resource-manager/operations/folder/set-access-bindings.md).

{% endlist %}