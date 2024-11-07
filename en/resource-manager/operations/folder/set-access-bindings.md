# Setting up folder access permissions

To grant a user access to [folder](../../concepts/resources-hierarchy.md#folder) resources, assign the user a [role](../../../iam/concepts/access-control/roles.md) for the folder.

## Assigning a role for a folder {#access-to-user}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [set-access-binding](../../../_includes/resource-manager/set-access-binding-user-acc-abstract-console.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. View the description of the command to assign a role for a folder:

      ```bash
      yc resource-manager folder add-access-binding --help
      ```

  1. Select a folder, e.g., `my-folder`:

      ```bash
      yc resource-manager folder list
      ```

      Result:

      ```
      +----------------------+-----------+--------+--------+
      |          ID          |   NAME    | LABELS | STATUS |
      +----------------------+-----------+--------+--------+
      | b1gd129pp9ha******** | my-folder |        | ACTIVE |
      +----------------------+-----------+--------+--------+
      ```

  1. Choose the [role](../../../iam/concepts/access-control/roles.md).

      ```bash
      yc iam role list
      ```

      Result:


      ```
      +--------------------------------+-------------+
      |               ID               | DESCRIPTION |
      +--------------------------------+-------------+
      | admin                          |             |
      | compute.images.user            |             |
      | editor                         |             |
      | ...                            |             |
      +--------------------------------+-------------+
      ```

  1. Find out the user ID from the login or email address.

      ```bash
      yc iam user-account get test-user
      ```

      Result:

      ```text
      id: gfei8n54hmfh********
      yandex_passport_user_account:
        login: test-user
        default_email: test-user@yandex.ru
      ```

  1. Assign the `editor` role to `test-user` for `my-folder`. In the subject, specify the `userAccount` type and user ID:

      ```bash
      yc resource-manager folder add-access-binding my-folder \
        --role editor \
        --subject userAccount:gfei8n54hmfh********
      ```

  To assign a role to a [service account](../../../iam/concepts/users/service-accounts.md), [user group](../../../organization/concepts/groups.md), or [system group](../../../iam/concepts/access-control/system-group.md) instead of a user, see [these examples](../../../iam/operations/roles/grant.md#cloud-or-folder).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  {% note alert %}

  Do not create the resource along with `yandex_resourcemanager_folder_iam_policy`, since this may cause conflicts.

  {% endnote %}

  To assign a role to a folder created using {{ TF }}:

  1. Describe the parameters of the folder role in a configuration file:

     * `folder_id`: [ID of the folder](get-id.md) to grant permissions for. This is a required parameter.
     * `role`: Role you want to assign. This is a required parameter.

       {% note info %}

       For each role, you can only use one `yandex_resourcemanager_folder_iam_member` resource.

       {% endnote %}

     * `member`: User to assign the role to. This is a required parameter. It may have one of the following values:
       * `userAccount:<user_ID>`: [User ID](../../../iam/operations/users/get.md).
       * `serviceAccount:<service_account_ID>`: [Service account ID](../../../iam/operations/sa/get-id.md).
       * `federatedUser:<user_account_ID>`: [User account ID](../../../organization/operations/users-get.md).
       * `system:group:organization:<organization_ID>:users`: [Organization](../../../organization/quickstart.md) ID to assign a role to the `All users in organization X` [system group](../../../iam/concepts/access-control/system-group.md#allOrganizationUsers).
       * `system:group:federation:<federation_ID>:users`: [Identity federation](../../../organization/concepts/add-federation.md) ID to assign a role to the `All users in federation N` [system group](../../../iam/concepts/access-control/system-group.md#allFederationUsers).

     {% cut "Example of assigning roles to a folder using {{ TF }}" %}


     ```hcl
     ...
     data "yandex_resourcemanager_folder" "project1" {
       folder_id = "<folder_ID>"
     }

     resource "yandex_resourcemanager_folder_iam_member" "editor" {
       folder_id = "${data.yandex_resourcemanager_folder_iam_member.project1.id}"
       role      = "editor"
       member    = "userAccount:<login@yandex.ru>"
     }
     ...
     ```


     {% endcut %}

     For more information about the `yandex_resourcemanager_folder_iam_member` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).

  1. Check the configuration using this command:
     ```
     terraform validate
     ```

     If the configuration is correct, you will get this message:

     ```
     Success! The configuration is valid.
     ```

  1. Run this command:
     ```
     terraform plan
     ```

     The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

  1. Apply the configuration changes:
     ```
     terraform apply
     ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     You can check the folder update using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

     ```
     yc resource-manager folder list-access-bindings <folder_name_or_ID>
     ```

- API {#api}

  Use the [updateAccessBindings](../../api-ref/Folder/updateAccessBindings.md) REST API method for the [Folder](../../api-ref/Folder/index.md) resource or the [FolderService/UpdateAccessBindings](../../api-ref/grpc/Folder/updateAccessBindings.md) gRPC API call. You will need the folder ID and the ID of the user to whom you want to assign the role for the folder.

  1. Find out the folder ID using the [list](../../api-ref/Folder/list.md) REST API method:
      ```bash
      curl \
        --header "Authorization: Bearer <IAM_token>" \
        https://resource-manager.{{ api-host }}/resource-manager/v1/folders?cloudId=b1gg8sgd16g7********
      ```

      Result:

      ```json
      {
       "folders": [
        {
         "id": "b1g66mft1vop********",
         "cloudId": "b1gd129pp9ha********",
         "createdAt": "2018-10-17T12:44:31Z",
         "name": "my-folder",
         "status": "ACTIVE"
        }
       ]
      }
      ```
  1. Find out the user ID from the login using the [getByLogin](../../../iam/api-ref/YandexPassportUserAccount/getByLogin.md) REST API method:
      ```bash
      curl \
        --header "Authorization: Bearer <IAM_token>" \
        https://iam.{{ api-host }}/iam/v1/yandexPassportUserAccounts:byLogin?login=test-user
      ```

      Result:

      ```json
      {
       "id": "gfei8n54hmfh********",
       "yandexPassportUserAccount": {
        "login": "test-user",
        "defaultEmail": "test-user@yandex.ru"
       }
      }
      ```
  1. Assign the `editor` role to the user for `my-folder`. Set the `action` property to `ADD` and specify the `userAccount` type and user ID in the `subject` property:

      ```bash
      curl \
        --request POST \
        --header 'Content-Type: application/json' \
        --header "Authorization: Bearer <IAM_token>" \
        --data '{
        "accessBindingDeltas": [{
            "action": "ADD",
            "accessBinding": {
                "roleId": "editor",
                "subject": {
                    "id": "gfei8n54hmfh********",
                    "type": "userAccount"
        }}}]}' \
        https://resource-manager.{{ api-host }}/resource-manager/v1/folders/b1gd129pp9ha********:updateAccessBindings
      ```


{% endlist %}


## Assigning multiple roles {#multiple-roles}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [set-access-binding](../../../_includes/resource-manager/set-access-binding-multiple-users-console.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  The `add-access-binding` command allows you to add only one role. You can assign multiple roles using the `set-access-binding` command.

  {% note alert %}

  The `set-access-binding` method completely rewrites access permissions for the resource. All current resource roles will be deleted.

  {% endnote %}

  1. Make sure the resource has no roles assigned that you would not want to lose:
      ```bash
      yc resource-manager folder list-access-bindings my-folder
      ```
  1. For example, assign a role to multiple users:

      ```bash
      yc resource-manager folder set-access-bindings my-folder \
        --access-binding role=editor,subject=userAccount:gfei8n54hmfh********
        --access-binding role=viewer,subject=userAccount:helj89sfj80a********
      ```

  To assign a role to a [service account](../../../iam/concepts/users/service-accounts.md), [user group](../../../organization/concepts/groups.md), or [system group](../../../iam/concepts/access-control/system-group.md) instead of a user, see [these examples](../../../iam/operations/roles/grant.md#multiple-roles).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  {% note alert %}

  Do not create the resource along with `yandex_resourcemanager_folder_iam_policy`, since this may cause conflicts.

  {% endnote %}

  To assign several roles to a folder created with {{ TF }}:

  1. Describe the parameters of the folder role in a configuration file:

     * `folder_id`: [ID of the folder](get-id.md) to grant permissions for. This is a required parameter.
     * `role`: Role you want to assign. This is a required parameter.

       {% note info %}

       For each role, you can only use one `yandex_resourcemanager_folder_iam_member` resource.

       {% endnote %}

     * `member`: User to assign the role to. To add a user to the list, create an entry in this format: `userAccount:<user_ID>`, where `<user_ID>` is the email address of a Yandex account, e.g., `ivan@yandex.ru`. This is a required parameter.

     {% cut "Example of assigning roles to a folder using {{ TF }}" %}


     ```hcl
     ...
     data "yandex_resourcemanager_folder" "project1" {
       folder_id = "<folder_ID>"
     }

     resource "yandex_resourcemanager_folder_iam_member" "editor" {
       folder_id = "${data.yandex_resourcemanager_folder.project1.id}"
       role      = "editor"
       member    = "userAccount:<login1@yandex.ru>"
     }
     resource "yandex_resourcemanager_folder_iam_member" "operator" {
       folder_id = "${data.yandex_resourcemanager_folder.project1.id}"
       role      = "operator"
       member    = "userAccount:<login1@yandex.ru>"
     }
     ...
     ```


     {% endcut %}

     For more information about the `yandex_resourcemanager_folder_iam_member` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).

  1. Check the configuration using this command:
     ```
     terraform validate
     ```

     If the configuration is correct, you will get this message:

     ```
     Success! The configuration is valid.
     ```

  1. Run this command:
     ```
     terraform plan
     ```

     The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

  1. Apply the configuration changes:
     ```
     terraform apply
     ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     You can check the folder update using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

     ```
     yc resource-manager folder list-access-bindings <folder_name_or_ID>
     ```

- API {#api}

  Assign the `editor` role to one user and the `viewer` role to another:

  ```bash
  curl \
    --request POST \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer <IAM_token>" \
    --data '{
    "accessBindingDeltas": [{
        "action": "ADD",
        "accessBinding": {
            "roleId": "editor",
            "subject": {
                "id": "gfei8n54hmfh********",
                "type": "userAccount"
            }
        }
    },{
        "action": "ADD",
        "accessBinding": {
            "roleId": "viewer",
            "subject": {
                "id": "helj89sfj80a********",
                "type": "userAccount"
    }}}]}' \
    https://resource-manager.{{ api-host }}/resource-manager/v1/folders/b1gd129pp9ha********:updateAccessBindings
  ```

  You can also assign roles using the [setAccessBindings](../../api-ref/Folder/setAccessBindings.md) REST API method for the [Folder](../../api-ref/Folder/index.md) resource or the [FolderService/SetAccessBindings](../../api-ref/grpc/Folder/setAccessBindings.md) gRPC API call.

  {% note alert %}

  The `setAccessBindings` method completely rewrites access permissions for the resource. All current resource roles will be deleted.

  {% endnote %}


  ```bash
  curl \
    --request POST \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer <IAM_token>" \
    --data '{
    "accessBindings": [{
        "roleId": "editor",
        "subject": { "id": "ajei8n54hmfh********", "type": "userAccount" }
    },{
        "roleId": "viewer",
        "subject": { "id": "helj89sfj80a********", "type": "userAccount" }
    }]}' \
    https://resource-manager.{{ api-host }}/resource-manager/v1/folders/b1gd129pp9ha********:setAccessBindings
  ```


{% endlist %}


## Folder access for a service account {#access-to-sa}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [grant-role-console-sa](../../../_includes/grant-role-console-sa.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [grant-role-for-sa-to-folder-via-cli](../../../_includes/iam/grant-role-for-sa-to-folder-via-cli.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  {% note alert %}

  Do not create the resource along with `yandex_resourcemanager_folder_iam_policy`, since this may cause conflicts.

  {% endnote %}

  To assign a service account a role to a folder created with {{ TF }}:

  1. Describe the parameters of the folder role in a configuration file:

     * `folder_id`: [ID of the folder](get-id.md) to grant permissions for. This is a required parameter.
     * `role`: Role you want to assign. This is a required parameter.

       {% note info %}

       For each role, you can only use one `yandex_resourcemanager_folder_iam_member` resource.

       {% endnote %}

     * `member`: User to assign the role to. To add a user to the list, create a record in this format: `serviceAccount:<service_account_ID>`, where `<service_account_ID>` is the [service account ID](../../../iam/operations/sa/get-id.md). You can list several service accounts. This is a required parameter.

     {% cut "Example of assigning roles to a folder using {{ TF }}" %}

     ```hcl
     ...
     data "yandex_resourcemanager_folder" "project1" {
       folder_id = "<folder_ID>"
     }

     resource "yandex_resourcemanager_folder_iam_member" "editor" {
       folder_id = "${data.yandex_resourcemanager_folder.project1.id}"
       role      = "editor"
       member   = "serviceAccount:<service_account_ID>"
     }
     ...
     ```

     {% endcut %}

     For more information about the `yandex_resourcemanager_folder_iam_member` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).

  1. Check the configuration using this command:
     ```
     terraform validate
     ```

     If the configuration is correct, you will get this message:

     ```
     Success! The configuration is valid.
     ```

  1. Run this command:
     ```
     terraform plan
     ```

     The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

  1. Apply the configuration changes:
     ```
     terraform apply
     ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     You can check the folder update using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

     ```
     yc resource-manager folder list-access-bindings <folder_name_or_ID>
     ```

- API {#api}

  {% include [grant-role-for-sa-to-folder-via-api](../../../_includes/iam/grant-role-for-sa-to-folder-via-api.md) %}

{% endlist %}


## Folder access for a federated user {#access-to-federated-user}

{% list tabs group=instructions %}

- Management console {#console}

  The role assignment procedure is the same as for a user with a Yandex account. The user's federation name is shown next to the username.

  {% include [set-access-binding](../../../_includes/resource-manager/set-access-binding-user-acc-abstract-console.md) %}

- CLI {#cli}

  1. Select a role from the [{{ yandex-cloud }} role reference](../../../iam/roles-reference.md).
  1. [Get the user ID](../../../iam/operations/users/get.md).
  1. Assign the role using the command:

      ```bash
      yc resource-manager folder add-access-binding <folder_name_or_ID> \
          --role <role_ID> \
          --subject federatedUser:<user_ID>
      ```

      Where:

      * `<folder_name_or_ID>`: Folder name or ID.
      * `--role`: Role ID, e.g., `editor`.
      * `--subject`: ID of the user account that gets the role.

      For example, assign the `editor` role to the `aje6o61dvog2********` federated user for `my-folder`:

      ```bash
      yc resource-manager folder add-access-binding my-folder \
          --role editor \
          --subject federatedUser:aje6o61dvog2********
      ```

{% endlist %}



## What's next {#what-is-next}

* [{#T}](update.md)
* [{#T}](../../concepts/resources-hierarchy.md)
