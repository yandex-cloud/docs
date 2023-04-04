# Setting up cloud access rights

To grant a user access to cloud resources, assign the user a [role](../../../iam/concepts/access-control/roles.md) for the cloud.


## Assign a role for the cloud {#access-to-user}

{% list tabs %}

- Management console

   {% include [set-access-binding-user-cloud-console](../../../_includes/resource-manager/set-access-binding-user-cloud-console.md) %}

- CLI

   1. See the description of the command to assign a role for a cloud:

      ```bash
      yc resource-manager cloud add-access-binding --help
      ```

   1. Get a list of available clouds:

      ```bash
      yc resource-manager cloud list
      ```

      Result:

      ```bash
      +----------------------+----------+
      |          ID          |   NAME   |
      +----------------------+----------+
      | b1gg8sgd16g7qca5onqs | my-cloud |
      +----------------------+----------+
      ```

   1. Get a list of available [roles](../../../iam/concepts/access-control/roles.md):

      ```bash
      yc iam role list
      ```

      Result:

      ```bash
      +--------------------------------+-------------+
      |               ID               | DESCRIPTION |
      +--------------------------------+-------------+
      | admin                          |             |
      | compute.images.user            |             |
      | editor                         |             |
      | ...                            |             |
      +--------------------------------+-------------+
      ```

   1. Find out the user's ID from the login or email address. To assign a role to a service account or system group instead of a user, see the [examples](#examples) below.

      ```bash
      yc iam user-account get test-user
      ```

      Result:

      ```bash
      id: gfei8n54hmfhuk5nogse
      yandex_passport_user_account:
          login: test-user
          default_email: test-user@yandex.ru
      ```

   1. Assign the `editor` role for the `my-cloud` cloud to a user named `test-user`. In the subject, specify the `userAccount` type and user ID:

      ```bash
      yc resource-manager cloud add-access-binding my-cloud \
        --role editor \
        --subject userAccount:<user ID>
      ```


- API

   Use the [updateAccessBindings](../../api-ref/Cloud/updateAccessBindings.md) REST API method for the [Cloud](../../api-ref/Cloud/index.md) resource or the [CloudService/UpdateAccessBindings](../../api-ref/grpc/cloud_service.md#UpdateAccessBindings) gRPC API call.

   You will need the cloud ID and the ID of the user who is assigned the role for the cloud.

   1. Find out the cloud ID using the [list](../../api-ref/Cloud/list.md) REST API method:

      ```bash
      curl -H "Authorization: Bearer <IAM-TOKEN>" \
          https://resource-manager.{{ api-host }}/resource-manager/v1/clouds
      ```

      Result:

      ```bash
      {
       "clouds": [
        {
         "id": "b1gg8sgd16g7qca5onqs",
         "createdAt": "2018-09-23T12:14:45Z",
         "name": "cloud-b1gg8sgd16g7qc"
        }
       ]
      }
      ```

   1. Find out the user ID from the login using the [getByLogin](../../../iam/api-ref/YandexPassportUserAccount/getByLogin.md) method:

      ```bash
      curl -H "Authorization: Bearer <IAM-TOKEN>" \
          https://iam.{{ api-host }}/iam/v1/yandexPassportUserAccounts:byLogin?login=test-user
      ```

      Result:

      ```bash
      {
       "id": "gfei8n54hmfhuk5nogse",
       "yandexPassportUserAccount": {
        "login": "test-user",
        "defaultEmail": "test-user@yandex.ru"
       }
      }
      ```

   1. Assign the user the `editor` role for the `my-cloud` cloud. Set the `action` property to `ADD` and specify the `userAccount` type and user ID in the `subject` property:

      ```bash
      curl -X POST \
          -H 'Content-Type: application/json' \
          -H "Authorization: Bearer <IAM-TOKEN>" \
          -d '{
          "accessBindingDeltas": [{
              "action": "ADD",
              "accessBinding": {
                  "roleId": "editor",
                  "subject": {
                      "id": "<user ID>",
                      "type": "userAccount"
          }}}]}' \
          https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:updateAccessBindings
      ```


- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Describe the properties of the cloud access rights in a configuration file:
      * `cloud_id`: Cloud ID. You can get a list of available clouds using the [CLI](../../../cli/quickstart.md) command: `yc resource-manager cloud list`.
      * `role`: Role to assign. You can get a list of roles using the [CLI](../../../cli/quickstart.md) command: `yc iam role list`. In one `yandex_resourcemanager_cloud_iam_binding` resource, you can assign only one role.
      * `members` section: List of users to assign the role to. Each entry may have one of the following values:
         * `userAccount:<user ID>`: [User ID](../../../iam/operations/users/get.md).
         * `serviceAccount:<ID of service account>`: [ID of the service account](../../../iam/operations/sa/get-id.md).
         * `federatedUser:<federated user ID>`: [ID of the federated user](../../../organization/users-get.md).

      Example of the configuration file structure:

      ```hcl
      data "yandex_resourcemanager_cloud" "project1" {
      name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_binding" "editor" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role = "editor"
        members = [
          "userAccount:<user ID>",
        ]
      }
      ```



      For more information about the parameters of the `yandex_resourcemanager_cloud_iam_binding` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/resourcemanager_cloud_iam_binding).
   1. In the command line, go to the directory where you created the configuration file.
   1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal displays a list of resources to be created and their parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      After that access rights are granted for the cloud.

{% endlist %}


## Assign multiple roles {#multiple-roles}

{% list tabs %}

- Management console

   {% include [set-access-binding-multiple-users-cloud-console](../../../_includes/resource-manager/set-access-binding-multiple-users-cloud-console.md) %}

- CLI

   The `add-access-binding` command allows you to add only one role. You can assign multiple roles using the `set-access-binding` command.

   {% note alert %}

   The `set-access-binding` command completely rewrites the access rights to the resource. All current resource roles will be deleted.

   {% endnote %}

   1. Make sure the resource doesn't have any roles that you don't want to lose:

      ```bash
      yc resource-manager cloud list-access-binding my-cloud
      ```

   1. For example, assign a role to multiple users:

      ```bash
      yc resource-manager cloud set-access-bindings my-cloud \
        --access-binding role=editor,subject=userAccount:<first user ID>
        --access-binding role=viewer,subject=userAccount:<second user ID>
      ```


      ```bash
      yc resource-manager cloud set-access-bindings my-cloud \
        --access-binding role=editor,subject=federatedUser:<first user ID>
        --access-binding role=viewer,subject=federatedUser:<second user ID>
      ```

- API

   Assign the `editor` role to one user and the `viewer` role to another user:

   ```bash
   curl -X POST \
       -H 'Content-Type: application/json' \
       -H "Authorization: Bearer <IAM-TOKEN>" \
       -d '{
       "accessBindingDeltas": [{
           "action": "ADD",
           "accessBinding": {
               "roleId": "editor",
               "subject": {
                   "id": "<first user ID>",
                   "type": "userAccount"
               }
           }
       },{
           "action": "ADD",
           "accessBinding": {
               "roleId": "viewer",
               "subject": {
                   "id": "<second user ID>",
                   "type": "userAccount"
       }}}]}' \
       https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:updateAccessBindings
   ```

   You can also assign roles using the [setAccessBindings](../../api-ref/Cloud/setAccessBindings.md) REST API method for the [Cloud](../../api-ref/Cloud/index.md) resource or the [CloudService/SetAccessBindings](../../api-ref/grpc/cloud_service.md#SetAccessBindings) gRPC API call.

   {% note alert %}

   The `setAccessBindings` method completely rewrites the access rights to the resource! All current resource roles will be deleted.

   {% endnote %}

   ```bash
   curl -X POST \
       -H 'Content-Type: application/json' \
       -H "Authorization: Bearer <IAM-TOKEN>" \
       -d '{
       "accessBindings": [{
           "roleId": "editor",
           "subject": { "id": "<first user ID>", "type": "userAccount" }
       },{
           "roleId": "viewer",
           "subject": { "id": "<second user ID>", "type": "userAccount" }
       }]}' \
       https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:setAccessBindings
   ```

- {{ TF }}

   1. Describe the properties of the cloud access rights in a configuration file. Assign the `editor` role to one user and the `viewer` role to another user:

      ```hcl
      data "yandex_resourcemanager_cloud" "project1" {
        name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_binding" "editor" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role = "editor"
        members = [
          "userAccount:<first user ID>",
        ]
      }

      resource "yandex_resourcemanager_cloud_iam_binding" "viewer" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role = "viewer"
        members = [
          "userAccount:<second user ID>",
        ]
      }
      ```

   1. In the command line, go to the directory where you created the configuration file.
   1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal displays a list of resources to be created and their parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      After that access rights are granted for the cloud.

{% endlist %}


## Cloud access for service accounts {#access-to-sa}

A service account can only be assigned roles for the cloud that it belongs to.

Allow the `test-sa` service account to manage the `my-cloud` cloud and its resources:

{% list tabs %}

- Management console

   You assign roles to a service account the same way as to a user account.

   To assign a service account a role for a cloud:

   {% include [set-accessbinding-sa-cloud-console](../../../_includes/iam/set-accessbinding-sa-cloud-console.md) %}

- CLI

   1. Find out the ID of the `test-sa` service account that you want to assign the role to. To do this, get a list of available service accounts:

      ```bash
      yc iam service-account list
      ```

      Result:

      ```bash
      +----------------------+----------+------------------+
      |          ID          |   NAME   |   DESCRIPTION    |
      +----------------------+----------+------------------+
      | ajebqtreob2dpblin8pe | test-sa  | test-description |
      +----------------------+----------+------------------+
      ```

   1. Assign the `editor` role to the `test-sa` service account by specifying its ID. In the subject type, specify `serviceAccount`:

      ```bash
      yc resource-manager cloud add-access-binding my-cloud \
        --role editor \
        --subject serviceAccount:<service account ID>
      ```

- API

   1. Find out the ID of the `test-sa` service account that you want to assign the role to. To do this, get a list of available service accounts:

      ```bash
      curl -H "Authorization: Bearer <IAM-TOKEN>" \
          https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=b1gvmob95yysaplct532
      ```

      Result:

      ```bash
      {
       "serviceAccounts": [
        {
         "id": "ajebqtreob2dpblin8pe",
         "folderId": "b1gvmob95yysaplct532",
         "createdAt": "2018-10-18T13:42:40Z",
         "name": "test-sa",
         "description": "test-description"
        }
       ]
      }
      ```

   1. Assign the `editor` role for the `my-cloud` cloud to the `test-sa` service account. In the `subject` property, specify the `serviceAccount` type and the `test-sa` ID. In the request URL, specify the `my-cloud` ID:

   ```bash
   curl -X POST \
       -H 'Content-Type: application/json' \
       -H "Authorization: Bearer <IAM-TOKEN>" \
       -d '{
       "accessBindingDeltas": [{
           "action": "ADD",
           "accessBinding": {
               "roleId": "editor",
               "subject": {
                   "id": "<service account ID>",
                   "type": "serviceAccount"
       }}}]}' \
       https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:updateAccessBindings
   ```

- {{ TF }}

   1. Assign the `editor` role to a service account.

      ```hcl
      data "yandex_resourcemanager_cloud" "project1" {
        name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_binding" "editor" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role = "editor"
        members = [
          "serviceAccount:<service account ID>",
        ]
      }
      ```

   1. In the command line, go to the directory where you created the configuration file.
   1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal displays a list of resources to be created and their parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      After that access rights are granted for the cloud.

{% endlist %}


## Access to a resource for all users {#access-to-all}

{% include [set-accessbinding-all-console](../../../_includes/iam/set-accessbinding-all-console.md) %}


## What's next {#what-is-next}

* [{#T}](../folder/create.md)
* [{#T}](../folder/set-access-bindings.md)
* [{#T}](../../concepts/resources-hierarchy.md)
