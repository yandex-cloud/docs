# Assigning roles

To provide access to a resource, assign a user a [role](../../../iam/concepts/access-control/roles.md) to the resource itself or a resource from which access privileges are inherited, such as a folder or a cloud. For more information, see [{#T}](../../concepts/access-control/index.md).

{% if product == "yandex-cloud" %}
## Assigning a role to a user {#access-to-user}

This section describes how to assign a role to a user with a Yandex. The following examples explain how to assign a role to a [service account](#access-to-sa), [federated users](#access-to-federated-user), or [all users](#access-to-all).

{% endif %}
{% if product == "cloud-il" %}

### Access to a federated user {#access-to-federated-user}

{% include [saml-assign-role-note](../../../_includes/saml-assign-role-note.md) %}

You can assign a role to a [federated user](../../../organization/add-federation.md) for the entire cloud or a specific folder.

{% endif %}
{% list tabs %}

- Management console

   In the management console, you can only assign a role for a cloud or folder:
{% if product == "yandex-cloud" %}
   1. Add the user to the cloud via the [management console](../users/create.md#console-user) or [{{ org-full-name }}](../users/create.md#organization-user).
{% endif %}
   1. Assign the user a role in the cloud:
      1. [Select the desired cloud](../../../resource-manager/operations/cloud/switch-cloud.md).
      1. Go to [Access bindings in cloud]({{ link-console-cloud }}?section=resource-acl) (the **Access bindings** button in the left panel).
      1. Switch the **Inherited roles** option to on so that the list shows users added to an organization.
      1. Select the appropriate user in the list and click ![image](../../../_assets/options.svg) next to the user's name.
      1. Click **Edit roles**.
      1. In the cloud's **Field permission** settings window, click **Add role**.
      1. Select a role in the cloud.
      1. Click **Save**.
   2. Assign the user a role in the folder:
      1. Open the folder page. You can select a folder on the [home page]({{ link-console-main }}) of the management console. This page displays folders for the selected cloud.
      1. Go to **Access bindings in folder** (the **Access bindings** button in the left panel).
      1. Click **Assign roles**.
      1. In the folder's **Field permission** settings window, click **Add user**.
      1. Select a user from the list or search for a user.
      1. Click **Add role**.
      1. Select a role in the folder.
      1. Click **Save**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. Choose a role from the list in [Roles](../../../iam/concepts/access-control/roles.md).
   1. [Get the user ID](../users/get.md).
   1. Assign the role using the command:
{% if product == "yandex-cloud" %}
      ```bash
      yc <service-name> <resource> add-access-binding <resource-name>|<resource-id> \
        --role <role-id> \
        --subject userAccount:<user-account-id>
      ```
{% endif %}
{% if product == "cloud-il" %}

      ```bash
      yc <service-name> <resource> add-access-binding <resource-name>|<resource-id> \
        --role <role-id> \
        --subject federatedUser:<user-account-id>
      ```

{% endif %}
      Where:

      * `<service-name>`: The name of the service whose resource a role is assigned for (for example, `resource-manager`).
      * `<resource>`: The resource category, for example, `cloud`.
      * `<resource-name>`: The name of the resource. You can specify a resource by its name or ID.
      * `<resource-id>`: The resource ID.
      * `<role-id>`: The role ID, for example, `{{ roles-cloud-owner }}`.
      * `<user-account-id>`: The ID of the user account assigned the role.

      For example, assign the `viewer` role for the `mycloud` [cloud](../../../resource-manager/concepts/resources-hierarchy.md#folder):
{% if product == "yandex-cloud" %}

      ```bash
      yc resource-manager cloud add-access-binding mycloud \
        --role viewer \
        --subject userAccount:aje6o61dvog2h6g9a33s
      ```

{% endif %}

{% if product == "cloud-il" %}

      ```bash
      yc resource-manager cloud add-access-binding mycloud \
        --role viewer \
        --subject federatedUser:aje6o61dvog2h6g9a33s
      ```

{% endif %}
- API

   Use the `updateAccessBindings` method for the corresponding resource.

   1. Choose a role from the list in [Roles](../../../iam/concepts/access-control/roles.md).
   2. [Get the user ID](../users/get.md).
   3. Create a request body, for example, in a `body.json` file. Set the `action` property to `ADD` and specify the `userAccount` type and user ID in the `subject` property:
{% if product == "yandex-cloud" %}

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
{% endif %}
{% if product == "cloud-il" %}

      **body.json:**
      ```json
      {
          "accessBindingDeltas": [{
              "action": "ADD",
              "accessBinding": {
                  "roleId": "editor",
                  "subject": {
                      "id": "gfei8n54hmfhuk5nogse",
                      "type": "federatedUser"
                      }
                  }
              }
          ]
      }
      ```

{% endif %}
   4. {% include [grant-role-folder-via-curl-step](../../../_includes/iam/grant-role-folder-via-curl-step.md) %}

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
 
      ```bash
      yc resource-manager folder list-access-binding my-folder
      ```

   1. Assign roles. For example, assign the `editor` role to one user and the `viewer` role to another user:

{% if product == "yandex-cloud" %}

      ```bash
      yc resource-manager folder set-access-bindings my-folder \
        --access-binding role=editor,subject=userAccount:gfei8n54hmfhuk5nogse
        --access-binding role=viewer,subject=userAccount:helj89sfj80aj24nugsz
      ```
{% endif %}
{% if product == "cloud-il" %}

      ```bash
      yc resource-manager folder set-access-bindings my-folder \
        --access-binding role=editor,subject=federatedUser:gfei8n54hmfhuk5nogse
        --access-binding role=viewer,subject=federatedUser:helj89sfj80aj24nugsz
      ```

{% endif %}
- API

   1. To assign the `editor` role to one user and the `viewer` role to another user, add multiple access bindings to the request body file in `accessBindingDeltas`.
{% if product == "yandex-cloud" %}
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
{% endif %}
{% if product == "cloud-il" %}

      **body.json:**
      ```json
      {
          "accessBindingDeltas": [{
              "action": "ADD",
              "accessBinding": {
                  "roleId": "editor",
                  "subject": {
                      "id": "gfei8n54hmfhuk5nogse",
                      "type": "federatedUser"
                  }
              }
          },{
              "action": "ADD",
              "accessBinding": {
                  "roleId": "viewer",
                  "subject": {
                      "id": "helj89sfj80aj24nugsz",
                      "type": "federatedUser"
                  }
              }
          }]
      }
      ```

{% endif %}
   1. Assign the specified roles, say, for the folder with the `b1gvmob95yysaplct532` ID:

      {% include [grant-role-folder-via-curl](../../../_includes/iam/grant-role-folder-via-curl.md) %}

      You can also assign roles using the `setAccessBindings`.

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

   1. Assign roles:

      ```bash
      export FOLDER_ID=b1gvmob95yysaplct532
      export IAM_TOKEN=CggaATEVAgA...
      curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d '@body.json' \
        "https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/${FOLDER_ID}:setAccessBindings"
      ```

{% endlist %}

### Resource access for a service account {#access-to-sa}

{% include [grant-role-for-sa](../../../_includes/iam/grant-role-for-sa.md) %}

{% if product == "yandex-cloud" %}

### Resource access for a federated user {#access-to-federated-user}

{% include [saml-assign-role-note](../../../_includes/saml-assign-role-note.md) %}

In the management console, you can assign a [federated user](../../../organization/add-federation.md) a role for an individual cloud or folder.

{% list tabs %}

- Management console

   The role assignment procedure is the same as for a user with a Yandex account. The user's federation name is shown next to the username.

   In the management console, you can only assign a role for a cloud or folder:

   1. Assign the user a role in the cloud:
      1. [Select the desired cloud](../../../resource-manager/operations/cloud/switch-cloud.md).
      1. Go to [Access bindings in cloud](https://console.cloud.yandex.com/cloud?section=resource-acl) (the **Access bindings** button in the left panel).
      1. Select the appropriate user in the list and click ![image](../../../_assets/options.svg) next to the user's name.
      1. Click **Edit roles**.
      1. In the cloud's **Field permission** settings window, click **Add role**.
      1. Select a role in the cloud.
      1. Click **Save**.
   1. Assign the user a role in the folder:
      1. Open the folder page. You can select a folder on the [home page]({{ link-console-main }}) of the management console. This page displays folders for the selected cloud.
      1. Go to **Access bindings in folder** (the **Access bindings** button in the left panel).
      1. Click **Assign roles**.
      1. In the folder's **Field permission** settings window, click **Add user**.
      1. Select a user from the list or search for a user.
      1. Click **Add role**.
      1. Select a role in the folder.
      1. Click **Save**.

{% endlist %}

{% endif %}

### Access to a resource for all users {#access-to-all}

{% include [grant-role-for-all](../../../_includes/iam/grant-role-for-all.md) %}
