---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Setting up cloud access rights

To grant a user access to all the cloud resources, assign them a [role](../../../iam/concepts/access-control/roles.md) for that cloud.

## Assign a role for the cloud {#access-to-user}

{% list tabs %}

- Management console
  1. {% include [grant-role-console-first-steps](../../../_includes/iam/grant-role-console-first-steps.md) %}
  1. {% include [configure-roles-console](../../../_includes/iam/configure-roles-console.md) %}
  1. Click the ![image](../../../_assets/plus-sign.svg) in the **Roles for the cloud <cloud name>** section.
  1. Select a role from the list.

- CLI

  1. See the description of the command to assign a role for a cloud:

      ```
      $ yc resource-manager cloud add-access-binding --help
      ```

  2. Select a cloud (for example, `my-cloud`):

      ```
      $ yc resource-manager cloud list
      +----------------------+----------+
      |          ID          |   NAME   |
      +----------------------+----------+
      | b1gg8sgd16g7qca5onqs | my-cloud |
      +----------------------+----------+
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

  4. Find out the user's ID from the login or email address. To assign a role to a service account or system group instead of a user, see the [examples](#examples) below.

      ```
      $ yc iam user-account get test-user
      id: gfei8n54hmfhuk5nogse
      yandex_passport_user_account:
          login: test-user
          default_email: test-user@yandex.ru
      ```

  5. Assign the `editor` role for the `my-cloud` cloud to a user named `test-user`. In the subject, specify the `userAccount` type and user ID:

      ```
      $ yc resource-manager cloud add-access-binding my-cloud \
          --role editor \
          --subject userAccount:gfei8n54hmfhuk5nogse
      ```

- API

  Use the [updateAccessBindings](../../api-ref/Cloud/updateAccessBindings.md) method for the [Cloud](../../api-ref/Cloud/index.md) resource. You will need the cloud ID and the ID of the user who is assigned the role for the cloud.

  1. Find out the cloud ID using the [list](../../api-ref/Cloud/list.md) method:

      ```bash
      $ curl -H "Authorization: Bearer <IAM-TOKEN>" \
          https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds
      
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

  3. Assign the user the `editor` role for the `my-cloud` cloud. Set the `action` property to `ADD` and specify the `userAccount` type and user ID in the `subject` property:

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
          https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:updateAccessBindings
      ```

{% endlist %}

## Examples {#examples}

* [{#T}](#multiple-roles)
* [{#T}](#access-to-sa)
* [{#T}](#access-to-all)

### Assign multiple roles {#multiple-roles}

{% list tabs %}

- CLI

  The `add-access-binding` command allows you to add only one role. You can assign multiple roles using the `set-access-binding` command.

  {% note alert %}

  The `set-access-binding` command completely rewrites the access rights to the resource. All current resource roles will be deleted.

  {% endnote %}
  1. Make sure the resource doesn't have any roles that you don't want to lose:

      ```
      $ yc resource-manager cloud list-access-binding my-cloud
      ```
  2. For example, assign a role to multiple users:

      ```
      $ yc resource-manager cloud set-access-bindings my-cloud \
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
      https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:updateAccessBindings
  ```

  You can also assign roles using the [setAccessBindings](../../api-ref/Cloud/setAccessBindings.md) method.

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
      https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:setAccessBindings
  ```

{% endlist %}

### Cloud access for service accounts {#access-to-sa}

A service account can only be assigned roles for the cloud that it belongs to.

Allow the `test-sa` service account to manage the `my-cloud` cloud and its resources:

{% list tabs %}

- CLI

  1. Find out the ID of the `test-sa` service account that you want to assign the role to. To do this, get a list of available service accounts:

      ```
      $ yc iam service-account list
      +----------------------+----------+------------------+
      |          ID          |   NAME   |   DESCRIPTION    |
      +----------------------+----------+------------------+
      | ajebqtreob2dpblin8pe | test-sa  | test-description |
      +----------------------+----------+------------------+
      ```

  2. Assign the `editor` role to the `test-sa` service account by specifying its ID. In the subject type, specify `serviceAccount`:

      ```
      $ yc resource-manager cloud add-access-binding my-cloud \
          --role editor \
          --subject serviceAccount:ajebqtreob2dpblin8pe
      ```

- API

  1. Find out the ID of the `test-sa` service account that you want to assign the role to. To do this, get a list of available service accounts:

      ```bash
      $ curl -H "Authorization: Bearer <IAM-TOKEN>" \
          https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts?folderId=b1gvmob95yysaplct532
      
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

  2. Assign the `editor` role for the `my-cloud` cloud to the `test-sa` service account. In the `subject` property, specify the `serviceAccount` type and the `test-sa` ID. In the request URL, specify the `my-cloud` ID:

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
                  "id": "ajebqtreob2dpblin8pe",
                  "type": "serviceAccount"
      }}}]}' \
      https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:updateAccessBindings
  ```

{% endlist %}

### Access to a resource for all users {#access-to-all}

{% include [set-access-to-all](../../../_includes/iam/set-access-to-all.md) %}

For instance, allow any authenticated user to view information about the `my-cloud` cloud and its resources:

{% list tabs %}

- CLI

  Assign the `viewer` role to the `allAuthenticatedUsers` system group. In the subject type, specify `system`:

  ```
  $ yc resource-manager cloud add-access-binding my-cloud \
      --role viewer \
      --subject system:allAuthenticatedUsers
  ```

- API

  Assign the `viewer` role to the `allAuthenticatedUsers` system group. In the `subject` property, specify the `system` type:

  ```bash
  $ curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM-TOKEN>" \
      -d '{
      "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
              "roleId": "viewer",
              "subject": {
                  "id": "allAuthenticatedUsers",
                  "type": "system"
      }}}]}' \
      https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:updateAccessBindings
  ```

{% endlist %}

#### What's next {#what-is-next}

* [{#T}](../folder/create.md)
* [{#T}](../folder/set-access-bindings.md)
* [{#T}](../../concepts/resources-hierarchy.md)

