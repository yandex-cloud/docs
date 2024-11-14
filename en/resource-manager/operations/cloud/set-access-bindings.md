# Setting up cloud access permissions

To grant a user access to cloud resources, assign the user a [role](../../../iam/concepts/access-control/roles.md) for the cloud.


## Assigning a role for a cloud {#access-to-user}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [set-access-binding-user-cloud-console](../../../_includes/resource-manager/set-access-binding-user-cloud-console.md) %}

- CLI {#cli}

  1. View a description of the command to assign a role for a cloud:

      ```bash
      yc resource-manager cloud add-access-binding --help
      ```

  1. Get a list of available clouds:

      ```bash
      yc resource-manager cloud list
      ```

      Result:

      ```text
      +----------------------+----------+
      |          ID          |   NAME   |
      +----------------------+----------+
      | b1gg8sgd16g7******** | my-cloud |
      +----------------------+----------+
      ```

  1. Get a list of available [roles](../../../iam/concepts/access-control/roles.md):

      ```bash
      yc iam role list
      ```

      Result:

      ```text
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

  1. Assign the `editor` role for the `my-cloud` cloud to `test-user`. In the subject, specify the `userAccount` type and user ID:

      ```bash
      yc resource-manager cloud add-access-binding my-cloud \
        --role editor \
        --subject userAccount:<user_ID>
      ```

  To assign a role to a [service account](../../../iam/concepts/users/service-accounts.md), [user group](../../../organization/concepts/groups.md), or [system group](../../../iam/concepts/access-control/system-group.md) instead of a user, see [these examples](../../../iam/operations/roles/grant.md#cloud-or-folder).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Describe the cloud access permission parameters in the configuration file:
      * `cloud_id`: Cloud ID. You can get a list of available clouds using the [CLI](../../../cli/quickstart.md) command: `yc resource-manager cloud list`.
      * `role`: Role to assign. You can get a list of roles using the [CLI](../../../cli/quickstart.md) command: `yc iam role list`. In one `yandex_resourcemanager_cloud_iam_member` resource, only one role can be assigned.
      * `member`: User or group to assign the role to. Each `yandex_resourcemanager_cloud_iam_member` resource may have one of the following values:
        * `userAccount:<user_ID>`: [User ID](../../../iam/operations/users/get.md).
        * `serviceAccount:<service_account_ID>`: [Service account ID](../../../iam/operations/sa/get-id.md).
        * `federatedUser:<federated_account_ID>`: [Federated account ID](../../../organization/operations/users-get.md).
        * `system:group:organization:<organization_ID>:users`: ID of the [organization](../../../organization/quickstart.md) to assign a role to the `All users in organization X` [system group](../../../iam/concepts/access-control/system-group.md#allOrganizationUsers).
        * `system:group:federation:<federation_ID>:users`: ID of the [identity federation](../../../organization/concepts/add-federation.md) to assign a role to the `All users in federation N` [system group](../../../iam/concepts/access-control/system-group.md#allFederationUsers).

      Here is an example of the configuration file structure:

      ```hcl
      data "yandex_resourcemanager_cloud" "project1" {
        name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_member" "editor" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role     = "editor"
        member   = "userAccount:<user_ID>"
      }
      ```



      For more information about the `yandex_resourcemanager_cloud_iam_member` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/resourcemanager_cloud_iam_member).
  1. In the command line, go to the folder where you created the configuration file.
  1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```bash
      Success! The configuration is valid.
      ```

  1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal displays a list of resources to be created and their parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.
  1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      This will assign access permissions for the cloud.

- API {#api}

  Use the [updateAccessBindings](../../api-ref/Cloud/updateAccessBindings.md) REST API method for the [Cloud](../../api-ref/Cloud/index.md) resource or the [CloudService/UpdateAccessBindings](../../api-ref/grpc/Cloud/updateAccessBindings.md) gRPC API call.

  You will need the cloud ID and the ID of the user who is assigned the role for the cloud.

  1. Find out the cloud ID using the [list](../../api-ref/Cloud/list.md) REST API method:

      ```bash
      curl \
        --header "Authorization: Bearer <IAM_token>" \
        https://resource-manager.{{ api-host }}/resource-manager/v1/clouds
      ```

      Result:

      ```text
      {
       "clouds": [
        {
         "id": "b1gg8sgd16g7********",
         "createdAt": "2018-09-23T12:14:45Z",
         "name": "cloud-b1gg8sgd16g7qc"
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

      ```text
      {
       "id": "gfei8n54hmfh********",
       "yandexPassportUserAccount": {
        "login": "test-user",
        "defaultEmail": "test-user@yandex.ru"
       }
      }
      ```

  1. Assign the `editor` role for the `my-cloud` cloud to the user. In the `action` property, enter `ADD` and specify the `userAccount` user type and ID under `subject`.

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
                    "id": "<user_ID>",
                    "type": "userAccount"
        }}}]}' \
        https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/b1gg8sgd16g7********:updateAccessBindings
      ```


{% endlist %}


## Assigning multiple roles {#multiple-roles}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [set-access-binding-multiple-users-cloud-console](../../../_includes/resource-manager/set-access-binding-multiple-users-cloud-console.md) %}

- CLI {#cli}

  The `add-access-binding` command allows you to add only one role. You can assign multiple roles using the `set-access-binding` command.

  {% note alert %}

  The `set-access-binding` method completely rewrites access permissions for the resource! All current resource roles will be deleted.

  {% endnote %}

  1. Make sure the resource has no roles assigned that you would not want to lose:

      ```bash
      yc resource-manager cloud list-access-binding my-cloud
      ```

  1. For example, assign a role to multiple users:

      ```bash
      yc resource-manager cloud set-access-bindings my-cloud \
        --access-binding role=editor,subject=userAccount:<first_user_ID>
        --access-binding role=viewer,subject=userAccount:<second_user_ID>
      ```

  To assign a role to a [service account](../../../iam/concepts/users/service-accounts.md), [user group](../../../organization/concepts/groups.md), or [system group](../../../iam/concepts/access-control/system-group.md) instead of a user, see [these examples](../../../iam/operations/roles/grant.md#multiple-roles).

- {{ TF }} {#tf}

  1. Describe the cloud access permission parameters in the configuration file. Assign the `editor` role to one user and the `viewer` role to another:

      ```hcl
      data "yandex_resourcemanager_cloud" "project1" {
        name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_member" "editor" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role     = "editor"
        member   = "userAccount:<first_user_ID>"
      }

      resource "yandex_resourcemanager_cloud_iam_member" "viewer" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role     = "viewer"
        member   = "userAccount:<second_user_ID>"
      }
      ```

  1. In the command line, go to the folder where you created the configuration file.
  1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```bash
      Success! The configuration is valid.
      ```

  1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal displays a list of resources to be created and their parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.
  1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      This will assign access permissions for the cloud.

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
                "id": "<first_user_ID>",
                "type": "userAccount"
            }
        }
    },{
        "action": "ADD",
        "accessBinding": {
            "roleId": "viewer",
            "subject": {
                "id": "<second_user_ID>",
                "type": "userAccount"
    }}}]}' \
    https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/b1gg8sgd16g7********:updateAccessBindings
  ```

  You can also assign roles using the [setAccessBindings](../../api-ref/Cloud/setAccessBindings.md) REST API method for the [Cloud](../../api-ref/Cloud/index.md) resource or the [CloudService/SetAccessBindings](../../api-ref/grpc/Cloud/setAccessBindings.md) gRPC API call.

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
        "subject": { "id": "<first_user_ID>", "type": "userAccount" }
    },{
        "roleId": "viewer",
        "subject": { "id": "<second_user_ID>", "type": "userAccount" }
    }]}' \
    https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/b1gg8sgd16g7********:setAccessBindings
  ```


{% endlist %}


## Cloud access for service accounts {#access-to-sa}

A service account can be [assigned](../../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) roles for any cloud and folder within the organization it belongs to.

Allow the `test-sa` service account to manage `my-cloud` and its resources:

{% list tabs group=instructions %}

- Management console {#console}

  You assign roles to a service account the same way as to a user account.

  To assign a service account a role for a cloud:

  {% include [set-accessbinding-sa-cloud-console](../../../_includes/iam/set-accessbinding-sa-cloud-console.md) %}

- CLI {#cli}

  1. Find out the ID of the `test-sa` service account you want to assign the role to. To do this, get a list of available service accounts:

      ```bash
      yc iam service-account list
      ```

      Result:

      ```text
      +----------------------+----------+------------------+
      |          ID          |   NAME   |   DESCRIPTION    |
      +----------------------+----------+------------------+
      | ajebqtreob2d******** | test-sa  | test-description |
      +----------------------+----------+------------------+
      ```

  1. Assign the `editor` role to the `test-sa` service account by specifying its ID. In the subject type, specify `serviceAccount`:

      ```bash
      yc resource-manager cloud add-access-binding my-cloud \
        --role editor \
        --subject serviceAccount:<service_account_ID>
      ```

- {{ TF }} {#tf}

  1. Assign the `editor` role to the service account:

      ```hcl
      data "yandex_resourcemanager_cloud" "project1" {
        name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_member" "editor" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role     = "editor"
        member   = "serviceAccount:<service_account_ID>"
      }
      ```

  1. In the command line, go to the folder where you created the configuration file.
  1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```bash
      Success! The configuration is valid.
      ```

  1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal displays a list of resources to be created and their parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.
  1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      This will assign access permissions for the cloud.

- API {#api}

  1. Find out the ID of the `test-sa` service account you want to assign the role to. To do this, get a list of available service accounts:

      ```bash
      curl \
        --header "Authorization: Bearer <IAM_token>" \
        https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=b1gvmob95yys********
      ```

      Result:

      ```text
      {
       "serviceAccounts": [
        {
         "id": "ajebqtreob2d********",
         "folderId": "b1gvmob95yys********",
         "createdAt": "2018-10-18T13:42:40Z",
         "name": "test-sa",
         "description": "test-description"
        }
       ]
      }
      ```

  1. Assign the `editor` role for `my-cloud` to the `test-sa` service account. In the `subject` property, specify the `serviceAccount` type and `test-sa` ID. In the request URL, specify the `my-cloud` ID as the resource:

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
                    "id": "<service_account_ID>",
                    "type": "serviceAccount"
        }}}]}' \
        https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/b1gg8sgd16g7********:updateAccessBindings
      ```

{% endlist %}


## What's next {#what-is-next}

* [{#T}](../folder/create.md)
* [{#T}](../folder/set-access-bindings.md)
* [{#T}](../../concepts/resources-hierarchy.md)
