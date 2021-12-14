# Assigning roles

To grant access to a resource, assign a [role](../../../iam/concepts/access-control/roles.md) to the subject for that resource or the resource that the access rights are inherited from (such as a folder or cloud). For more information, see [{#T}](../../concepts/access-control/index.md).

## Assign a role to a user {#access-to-user}

This section describes how to assign a role to a user with a Yandex account. The examples below show how to assign roles to a [service account](#access-to-sa), [federated user](#access-to-federated-user), and [all users at once](#access-to-all).

{% list tabs %}

- Management console

  In the management console, you can only assign a role for a cloud or folder:

  {% include [grant-role-console](../../../_includes/grant-role-console.md) %}

- CLI

  1. Choose a role from the list in the [Roles](../../../iam/concepts/access-control/roles.md) section.

  1. [Get a user ID](../users/get.md).

  1. Assign the role using the command:

      ```
      yc <SERVICE-NAME> <RESOURCE> add-access-binding <RESOURCE-NAME>|<RESOURCE-ID> \
          --role <ROLE-ID> \
          --subject userAccount:<USER-ACCOUNT-ID>
      ```

      where:
      * `<SERVICE-NAME>` is the name of the service that the resource belongs to (for example, `resource-manager`).
      * `<RESOURCE>` is the resource category, for example `cloud`.
      * `<RESOURCE-NAME>` is the name of the resource. You can specify a resource by its name or ID.
      * `<RESOURCE-ID>` is the resource ID.
      * `<ROLE-ID>` is the role ID, for example `{{ roles-cloud-owner }}`.
      * `<USER-ACCOUNT-ID>` is the ID of the user account assigned the role.

      For example, assign the `viewer` role for the [cloud](../../../resource-manager/concepts/resources-hierarchy.md#folder) `mycloud`:

      ```
      $ yc resource-manager cloud add-access-binding mycloud \
          --role viewer \
          --subject userAccount:aje6o61dvog2h6g9a33s
      ```

- API

  Use the `updateAccessBindings` method for the corresponding resource.

  1. Choose a role from the list in the [Roles](../../../iam/concepts/access-control/roles.md) section.

  1. [Get a user ID](../users/get.md).

  1. Create a request body, for example, in a `body.json` file. Set the `action` property to `ADD` and specify the `userAccount` type and user ID in the `subject` property:

      **body.json:**

      ```json
      {
          "accessBindingDeltas": [{
              "action": "ADD",
              "accessBinding": {
                  "roleId": "editor",
                  "subject": {
                      "id": "gfei8n54hmfhuk5nogse",
                      "type": "userAccount"
                      }
                  }
              }
          ]
      }
      ```

  1. {% include [grant-role-folder-via-curl-step](../../../_includes/iam/grant-role-folder-via-curl-step.md) %}

  For detailed instructions on how to assign a role for the corresponding resource, see:
  * [{#T}](../sa/set-access-bindings.md)
  * [{#T}](../../../resource-manager/operations/cloud/set-access-bindings.md)
  * [{#T}](../../../resource-manager/operations/folder/set-access-bindings.md)

{% endlist %}

## Examples {#examples}

* [{#T}](#multiple-roles)
* [{#T}](#access-to-sa)
* [{#T}](#access-to-federated-user)
* [{#T}](#access-to-all)

### Assign multiple roles {#multiple-roles}

{% list tabs %}

- Management console

  Follow the instructions at the [beginning of the section](#access-to-user) and assign multiple roles to the user.

  To assign a role to another user, repeat all the steps in the instructions.

- CLI

  The `add-access-binding` command allows you to add only one role. You can assign multiple roles using the `set-access-binding` command.

  {% note alert %}

  The `set-access-binding` command completely rewrites the access rights to the resource. All current resource roles will be deleted.

  {% endnote %}

  For example, to assign multiple roles for a folder:
  1. Make sure the resource doesn't have any roles that you don't want to lose:

      ```
      $ yc resource-manager folder list-access-binding my-folder
      ```
  2. Assign roles. For example, assign the `editor` role to one user and the `viewer` role to another user:

      ```
      $ yc resource-manager folder set-access-bindings my-folder \
          --access-binding role=editor,subject=userAccount:gfei8n54hmfhuk5nogse
          --access-binding role=viewer,subject=userAccount:helj89sfj80aj24nugsz
      ```

- API

  1. To assign the `editor` role to one user and the `viewer` role to another user, add multiple access bindings to the request body file in `accessBindingDeltas`.

      **body.json:**

      ```json
      {
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
                  }
              }
          }]
      }
      ```

  2. Assign the specified roles, say, for the folder with the `b1gvmob95yysaplct532` ID:

      {% include [grant-role-folder-via-curl](../../../_includes/iam/grant-role-folder-via-curl.md) %}

  You can also assign roles using the `setAccessBindings` method.

  {% note alert %}

  The `setAccessBindings` method completely rewrites the access rights to the resource! All current resource roles will be deleted.

  {% endnote %}

  1. List new access bindings in the request body.

      **body.json:**

      ```json
      {
          "accessBindings": [{
              "roleId": "editor",
              "subject": { "id": "ajei8n54hmfhuk5nog0g", "type": "userAccount" }
          },{
              "roleId": "viewer",
              "subject": { "id": "helj89sfj80aj24nugsz", "type": "userAccount" }
          }]
      }
      ```

  2. Assign roles:

      ```bash
      $ export FOLDER_ID=b1gvmob95yysaplct532
      $ export IAM_TOKEN=CggaATEVAgA...
      $ curl -X POST \
          -H "Content-Type: application/json" \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d '@body.json' \
          "https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/${FOLDER_ID}:setAccessBindings"
      ```

{% endlist %}

### Resource access for a service account {#access-to-sa}

{% include [grant-role-for-sa](../../../_includes/iam/grant-role-for-sa.md) %}

### Resource access for a federated user {#access-to-federated-user}

{% include [include](../../../_includes/saml-assign-role-note.md) %}

Currently, [a federated user](../../../organization/add-federation.md) can only be assigned a role from the management console.

{% list tabs %}

- Management console

  The role assignment procedure is the same as for a user with a Yandex account. The user's federation name is shown next to the username.

  In the management console, you can only assign a role for a cloud or folder:

  {% include [grant-role-console](../../../_includes/grant-role-console.md) %}

{% endlist %}

### Access to a resource for all users {#access-to-all}

{% include [grant-role-for-sa](../../../_includes/iam/grant-role-for-all.md) %}

