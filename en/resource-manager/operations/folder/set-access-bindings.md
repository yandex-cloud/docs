# Setting up folder access permissions

{% note warning %}

{% include [access-control-vs-roles-notice](../../../_includes/iam/access-control-vs-roles-notice.md) %}

{% endnote %}

To grant a user access to [folder](../../concepts/resources-hierarchy.md#folder) resources, assign the user a [role](../../../iam/concepts/access-control/roles.md) for the folder.

{% include [console-user-access](../../../_includes/organization/console-user-access.md) %}

## Assigning a role for a folder {#access-to-user}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [set-access-binding](../../../_includes/resource-manager/set-access-binding-user-acc-abstract-console.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the command to assign a role for a folder:

      ```bash
      yc resource-manager folder add-access-binding --help
      ```

  1. Get a list of available folders:

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

  1. Get a list of available roles:

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

  1. Assign the user a role for the folder. In the subject, specify the `userAccount` type and user ID:

      ```bash
      yc resource-manager folder add-access-binding my-folder \
        --role editor \
        --subject userAccount:gfei8n54hmfh********
      ```

      Where:

      * `--role`: ID of the role you need to assign.
      * `--subject`: [Subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-cli](../../../_includes/iam/subjects-designations-cli.md) %}

          {% endcut %}

  To assign a role to a [service account](../../../iam/concepts/users/service-accounts.md), [user group](../../../organization/concepts/groups.md), or [system group](../../../iam/concepts/access-control/system-group.md) instead of a user, see [these examples](../../../iam/operations/roles/grant.md#cloud-or-folder).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Describe the roles you are assigning in the configuration file:

      Here is an example of the configuration file structure:

      ```hcl
      data "yandex_resourcemanager_folder" "project1" {
        folder_id = "<folder_ID>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "editor" {
        folder_id = "${data.yandex_resourcemanager_folder.project1.id}"
        role      = "editor"
        member    = "userAccount:<user_ID>"
      }
      ```

      Where:

      * `folder_id`: [ID of the folder](get-id.md) to grant permissions for. This is a required setting.
      * `role`: Role you need to assign. In one `yandex_resourcemanager_folder_iam_member` resource, only one role can be assigned.
      * `member`: [Subject](../../../iam/concepts/access-control/index.md#subject) getting the role. This is a required setting.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      For more on the properties of the `yandex_resourcemanager_folder_iam_member` in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      This will assign access permissions for the folder.

- API {#api}

  Use the [updateAccessBindings](../../api-ref/Folder/updateAccessBindings.md) REST API method for the [Folder](../../api-ref/Folder/index.md) resource or the [FolderService/UpdateAccessBindings](../../api-ref/grpc/Folder/updateAccessBindings.md) gRPC API call. You will need the IDs of the folder and the user you are assigning a role for the folder to.

  1. Find out the folder ID using the [list](../../api-ref/Folder/list.md) REST API method:

      ```bash
      curl \
        --header "Authorization: Bearer <IAM_token>" \
        https://resource-manager.{{ api-host }}/resource-manager/v1/folders?cloudId=<cloud_ID>
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

  1. Find out the user ID by login using the [getByLogin](../../../iam/api-ref/YandexPassportUserAccount/getByLogin.md) REST API method:

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

  1. Assign the user a role for the folder. In the `action` property, enter `ADD` and specify the `userAccount` type and user ID under `subject`:

      ```bash
      curl \
        --request POST \
        --header 'Content-Type: application/json' \
        --header "Authorization: Bearer <IAM_token>" \
        --data '{
          "accessBindingDeltas": [
            {
              "action": "ADD",
              "accessBinding": {
                "roleId": "<role>",
                "subject": {
                  "id": "<user_ID>",
                  "type": "userAccount"
                }
              }
            }
          ]
        }' \
        https://resource-manager.{{ api-host }}/resource-manager/v1/folders/<folder_ID>:updateAccessBindings
      ```

      Where:

      * `roleId`: Role.
      * `subject`: [Subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

          {% endcut %}

{% endlist %}


## Assigning multiple roles {#multiple-roles}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [set-access-binding](../../../_includes/resource-manager/set-access-binding-multiple-users-console.md) %}

- CLI {#cli}

  The `add-access-binding` command allows you to add only one role. You can assign multiple roles using the `set-access-bindings` command.

  {% include [set-access-bindings-cli](../../../_includes/iam/set-access-bindings-cli.md) %}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Make sure the resource has no important roles assigned before proceeding:

      ```bash
      yc resource-manager folder list-access-bindings <folder_name_or_ID>
      ```

  1. To assign a role, run this command:

      ```bash
      yc resource-manager folder set-access-bindings <folder_name_or_ID> \
        --access-binding role=<role>,subject=<subject_type>:<subject_ID>
      ```

      Where:

      * `role`: ID of the role you need to assign.
      * `subject`: [Subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      Provide a separate `--access-binding` parameter for each role. Here is an example:

      ```bash
      yc resource-manager folder set-access-bindings my-folder \
        --access-binding role=editor,subject=userAccount:gfei8n54hmfh******** \
        --access-binding role=viewer,subject=userAccount:helj89sfj80a********
      ```

  To assign a role to a [service account](../../../iam/concepts/users/service-accounts.md), [user group](../../../organization/concepts/groups.md), or [system group](../../../iam/concepts/access-control/system-group.md) instead of a user, see [these examples](../../../iam/operations/roles/grant.md#multiple-roles).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Describe the folder access permissions in the configuration file.

      Here is an example of the configuration file structure:

      ```hcl
      data "yandex_resourcemanager_folder" "project1" {
        folder_id = "<folder_ID>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "member1" {
        folder_id = "${data.yandex_resourcemanager_folder.project1.id}"
        role      = "<role_1>"
        member    = "userAccount:<user_ID>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "member2" {
        folder_id = "${data.yandex_resourcemanager_folder.project1.id}"
        role      = "<role_2>"
        member    = "userAccount:<user_ID>"
      }
      ```

      Where:

      * `folder_id`: [ID of the folder](get-id.md) to grant permissions for. This is a required setting.
      * `role`: Role you need to assign. In one `yandex_resourcemanager_folder_iam_member` resource, only one role can be assigned.
      * `member`: [Subject](../../../iam/concepts/access-control/index.md#subject) getting the role. This is a required setting.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      This will assign access permissions for the folder.

- API {#api}

  Assign roles to the users:

  ```bash
  curl \
    --request POST \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer <IAM_token>" \
    --data '{
      "accessBindingDeltas": [
        {
          "action": "ADD",
          "accessBinding": {
            "roleId": "<role_1>",
            "subject": {
              "id": "<user_ID>",
              "type": "userAccount"
            }
          }
        },
        {
          "action": "ADD",
          "accessBinding": {
            "roleId": "<role_2>",
            "subject": {
              "id": "<user_ID>",
              "type": "userAccount"
            }
          }
        }
      ]
    }' \
    https://resource-manager.{{ api-host }}/resource-manager/v1/folders/<folder_ID>:updateAccessBindings
  ```

  Where:

  * `roleId`: Role.
  * `subject`: [Subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

      {% cut "Subject designations" %}

      {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

      {% endcut %}

  You can also assign roles using the [setAccessBindings](../../api-ref/Folder/setAccessBindings.md) REST API method for the [Folder](../../api-ref/Folder/index.md) resource or the [FolderService/SetAccessBindings](../../api-ref/grpc/Folder/setAccessBindings.md) gRPC API call.

  {% include [set-access-bindings-api](../../../_includes/iam/set-access-bindings-api.md) %}

{% endlist %}


## Folder access for a service account {#access-to-sa}

A service account can be [assigned](../../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) roles for any cloud and folder within the organization it belongs to.

{% list tabs group=instructions %}

- Management console {#console}

  {% include [grant-role-console-sa](../../../_includes/grant-role-console-sa.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [grant-role-for-sa-to-folder-via-cli](../../../_includes/iam/grant-role-for-sa-to-folder-via-cli.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Assign the `editor` role to the service account:

      ```hcl
      data "yandex_resourcemanager_folder" "project1" {
        folder_id = "<folder_ID>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "editor" {
        folder_id = "${data.yandex_resourcemanager_folder.project1.id}"
        role      = "editor"
        member    = "serviceAccount:<service_account_ID>"
      }
      ```

      Where:

      * `folder_id`: [Folder ID](get-id.md).
      * `role`: Role you need to assign.
      * `member`: [Subject](../../../iam/concepts/access-control/index.md#subject) getting the role. For a service account, specify `serviceAccount:<service_account_ID>`.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      This will assign access permissions for the folder.

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
  1. [Get the user ID](../../../organization/operations/users-get.md).
  1. Assign a role using this command:

      ```bash
      yc resource-manager folder add-access-binding <folder_name_or_ID> \
          --role <role_ID> \
          --subject federatedUser:<user_ID>
      ```

      Where:

      * `<folder_name_or_ID>`: Folder name or ID.
      * `--role`: Role ID, e.g., `editor`.
      * `--subject`: [Subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-cli](../../../_includes/iam/subjects-designations-cli.md) %}

          {% endcut %}

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
