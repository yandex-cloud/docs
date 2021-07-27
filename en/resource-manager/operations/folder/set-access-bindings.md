---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Setting up folder access rights

To grant a user access to all the folder resources, assign them a [role](../../../iam/concepts/access-control/roles.md) for that folder.

## Assign a role for a folder {#access-to-user}

{% list tabs %}

- Management console
  1. {% include [grant-role-console-first-steps](../../../_includes/iam/grant-role-console-first-steps.md) %}
  1. {% include [configure-roles-console](../../../_includes/iam/configure-roles-console.md) %}
  1. Select a folder in the **Roles in folders** section and click ![image](../../../_assets/plus-sign.svg).
  1. Select a role from the list.

- CLI

  1. See the description of the command to assign a role for a folder:

      ```
      $ yc resource-manager folder add-access-binding --help
      ```

  2. Select a folder (for example, `my-folder`):

      ```
      $ yc resource-manager folder list
      +----------------------+-----------+--------+--------+
      |          ID          |   NAME    | LABELS | STATUS |
      +----------------------+-----------+--------+--------+
      | b1gd129pp9ha0vnvf5g7 | my-folder |        | ACTIVE |
      +----------------------+-----------+--------+--------+
      ```

  3. Choose a [role](../../../iam/concepts/access-control/roles.md):

      ```
      $ yc iam role list
      +--------------------------------+-------------+
      |               ID               | DESCRIPTION |
      +--------------------------------+-------------+
      | admin                          |             |
      | compute.images.user            |             |
      | editor                         |             |
      | ...                            |             |
      +--------------------------------+-------------+
      ```

  4. Find out the user's ID from the login or email address. To assign a role to a service account or group of users rather than one user, see the [examples](#examples) below.

      ```
      $ yc iam user-account get test-user
      id: gfei8n54hmfhuk5nogse
      yandex_passport_user_account:
          login: test-user
          default_email: test-user@yandex.ru
      ```

  5. Assign the `editor` role for the `my-robot` folder to a user named `test-user`. In the subject, specify the `userAccount` type and user ID:

      ```
      $ yc resource-manager folder add-access-binding my-folder \
          --role editor \
          --subject userAccount:gfei8n54hmfhuk5nogse
      ```

- API

  Use the [updateAccessBindings](../../api-ref/Folder/updateAccessBindings.md) method for the [Folder](../../api-ref/Folder/index.md) resource. You will need the folder ID and the ID of the user who is assigned the role for the folder.

  1. Find out the folder ID using the [list](../../api-ref/Folder/list.md) method:

      ```bash
      $ curl -H "Authorization: Bearer <IAM-TOKEN>" \
          https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders?cloudId=b1gg8sgd16g7qca5onqs

      {
       "folders": [
        {
         "id": "b1g66mft1vopnevbn57j",
         "cloudId": "b1gd129pp9ha0vnvf5g7",
         "createdAt": "2018-10-17T12:44:31Z",
         "name": "my-folder",
         "status": "ACTIVE"
        }
       ]
      }
      ```

  2. Find out the user ID from the login using the [getByLogin](../../../iam/api-ref/YandexPassportUserAccount/getByLogin.md) method:

      ```bash
      $ curl -H "Authorization: Bearer <IAM-TOKEN>" \
          https://iam.api.cloud.yandex.net/iam/v1/yandexPassportUserAccounts:byLogin?login=test-user

      {
       "id": "gfei8n54hmfhuk5nogse",
       "yandexPassportUserAccount": {
        "login": "test-user",
        "defaultEmail": "test-user@yandex.ru"
       }
      }
      ```

  3. Assign the `editor` role for the `my-folder` folder to the user. Set the `action` property to `ADD` and specify the `userAccount` type and user ID in the `subject` property:

      ```bash
      $ curl -X POST \
          -H 'Content-Type: application/json' \
          -H "Authorization: Bearer <IAM-TOKEN>" \
          -d '{
          "accessBindingDeltas": [{
              "action": "ADD",
              "accessBinding": {
                  "roleId": "editor",
                  "subject": {
                      "id": "gfei8n54hmfhuk5nogse",
                      "type": "userAccount"
          }}}]}' \
          https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:updateAccessBindings
      ```

{% endlist %}

## Examples {#examples}

* [{#T}](#multiple-roles)
* [{#T}](#access-to-sa)
* [{#T}](#access-to-all)

### Assign multiple roles {#multiple-roles}

{% list tabs %}

- Management console

  Follow the instructions at the [beginning of the section](#access-to-user) and assign multiple roles to the user.

  To assign a role to another user, select the user from the [Users and roles]({{ link-console-access-management }}) tab and click **Configure roles**.

- CLI

  The `add-access-binding` command allows you to add only one role. You can assign multiple roles using the `set-access-binding` command.

  {% note alert %}

  The `set-access-binding` command completely rewrites the access rights to the resource. All current resource roles will be deleted.

  {% endnote %}
  1. Make sure the resource doesn't have any roles that you don't want to lose:

      ```
      $ yc resource-manager folder list-access-binding my-folder
      ```
  2. For example, assign a role to multiple users:

      ```
      $ yc resource-manager folder set-access-bindings my-folder \
          --access-binding role=editor,subject=userAccount:gfei8n54hmfhuk5nogse
          --access-binding role=viewer,subject=userAccount:helj89sfj80aj24nugsz
      ```

- API

  Assign the `editor` role to one user and the `viewer` role to another user:

  ```bash
  $ curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM-TOKEN>" \
      -d '{
      "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
              "roleId": "editor",
              "subject": {
                  "id": "gfei8n54hmfhuk5nogse",
                  "type": "userAccount"
              }
          }
      },{
          "action": "ADD",
          "accessBinding": {
              "roleId": "viewer",
              "subject": {
                  "id": "helj89sfj80aj24nugsz",
                  "type": "userAccount"
      }}}]}' \
      https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:updateAccessBindings
  ```

  You can also assign roles using the [setAccessBindings](../../api-ref/Folder/setAccessBindings.md) method.

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
          "subject": { "id": "ajei8n54hmfhuk5nog0g", "type": "userAccount" }
      },{
          "roleId": "viewer",
          "subject": { "id": "helj89sfj80aj24nugsz", "type": "userAccount" }
      }]}' \
      https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:setAccessBindings
  ```

{% endlist %}

### Folder access for a service account {#access-to-sa}

In the management console, you can only assign a role for the folder where the service account was created. To assign it a role for another resource, use the CLI or API.

Allow the service account to manage the folder and its resources:

{% list tabs %}

- Management console

  {% include [grant-role-console-sa](../../../_includes/grant-role-console-sa.md) %}

- CLI

  {% include [grant-role-for-sa-to-folder-via-cli](../../../_includes/iam/grant-role-for-sa-to-folder-via-cli.md) %}

- API

  {% include [grant-role-for-sa-to-folder-via-api](../../../_includes/iam/grant-role-for-sa-to-folder-via-api.md) %}

{% endlist %}

### Access to a resource for all users {#access-to-all}

{% include [grant-role-for-sa](../../../_includes/iam/grant-role-for-all.md) %}

#### What's next {#what-is-next}

* [{#T}](update.md)
* [{#T}](../../concepts/resources-hierarchy.md)

