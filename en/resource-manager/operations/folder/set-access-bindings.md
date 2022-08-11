# Setting up folder access rights

To grant a user access to all the folder resources, assign the user a [role](../../../iam/concepts/access-control/roles.md) for this folder.

## Assign a role for a folder {#access-to-user}

{% list tabs %}

- Management console

   {% include [set-access-binding](../../../_includes/resource-manager/set-access-binding-user-acc-abstract-console.md) %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. See the description of the command to assign a role for a folder:

      ```bash
      yc resource-manager folder add-access-binding --help
      ```

   1. Select a folder (for example, `my-folder`):

      ```bash
      yc resource-manager folder list
      ```

      Result:

      ```
      +----------------------+-----------+--------+--------+
      |          ID          |   NAME    | LABELS | STATUS |
      +----------------------+-----------+--------+--------+
      | b1gd129pp9ha0vnvf5g7 | my-folder |        | ACTIVE |
      +----------------------+-----------+--------+--------+
      ```

   1. Choose the [ role](../../../iam/concepts/access-control/roles.md).

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

{% if product == "yandex-cloud" %}

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

{% endif %}
{% if product == "cloud-il" %}

   1. [Get the user ID](../../../iam/operations/users/get.md).

{% endif %}
   1. Assign the `editor` role for the `my-folder` folder to a user named `test-user`. In the subject, specify the {% if product == "yandex-cloud" %}`userAccount`{% endif %}{% if product == "cloud-il" %}`federatedUser`{% endif %} type and user ID:
{% if product == "yandex-cloud" %}

      ```bash
      yc resource-manager folder add-access-binding my-folder \
        --role editor \
        --subject userAccount:gfei8n54hmfhuk5nogse
      ```

{% endif %}
{% if product == "cloud-il" %}

      ```
      yc resource-manager folder add-access-binding my-folder \
          --role editor \
          --subject federatedUser:gfei8n54hmfhuk5nogse
      ```

{% endif %}

- API

   Use the [updateAccessBindings](../../api-ref/Folder/updateAccessBindings.md) method for the [Folder](../../api-ref/Folder/index.md) resource. You will need the folder ID and the ID of the user who is assigned the role for the folder.

   1. Find out the folder ID using the [list](../../api-ref/Folder/list.md):
      ```bash
      curl -H "Authorization: Bearer <IAM-TOKEN>" \
        https://resource-manager.{{ api-host }}/resource-manager/v1/folders?cloudId=b1gg8sgd16g7qca5onqs
      ```

      Result:

      ```json
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
{% if product == "yandex-cloud" %}
   1. Find out the user ID from the login using the [getByLogin](../../../iam/api-ref/YandexPassportUserAccount/getByLogin.md) method:
      ```bash
      curl -H "Authorization: Bearer <IAM-TOKEN>" \
        https://iam.{{ api-host }}/iam/v1/yandexPassportUserAccounts:byLogin?login=test-user
      ```

      Result:

      ```json
      {
       "id": "gfei8n54hmfhuk5nogse",
       "yandexPassportUserAccount": {
        "login": "test-user",
        "defaultEmail": "test-user@yandex.ru"
       }
      }
      ```
{% endif %}
{% if product == "cloud-il" %}

   1. [Get the user ID](../../../iam/operations/users/get.md).

{% endif %}
   1. Assign the `editor` role for the `my-folder` folder to the user. Set the `action` property to `ADD` and specify the {% if product == "yandex-cloud" %}`userAccount`{% endif %}{% if product == "cloud-il" %}`federatedUser`{% endif %} type and user ID in the `subject` property:
{% if product == "yandex-cloud" %}

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
                    "id": "gfei8n54hmfhuk5nogse",
                    "type": "userAccount"
        }}}]}' \
        https://resource-manager.{{ api-host }}/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:updateAccessBindings
      ```

{% endif %}
{% if product == "cloud-il" %}

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
                      "id": "gfei8n54hmfhuk5nogse",
                      "type": "federatedUser"
          }}}]}' \
          https://resource-manager.{{ api-host }}/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:updateAccessBindings
      ```

{% endif %}
- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% note alert %}

   Don't create the resource together with the `yandex_resourcemanager_folder_iam_policy` resource. They will conflict with each other.

   {% endnote %}

   To assign a role for a folder created using {{ TF }}:

   1. Describe the parameters of the folder role in a configuration file:

      * `folder_id`: [ID of the folder](get-id.md) to grant permissions for. Required parameter.
      * `role`: The role assigned. Required parameter.

         {% note info %}

         For each role, only one `yandex_resourcemanager_folder_iam_binding` resource can be used.

         {% endnote %}

      * `members`: List of users to assign the role to. Required parameter. Each entry may have one of the following values:
{% if product == "yandex-cloud" %}
         * `userAccount:<user ID>`: [User ID](../../../iam/operations/users/get.md).
{% endif %}
         * `serviceAccount:<service account ID>`: [Service account ID](../../../iam/operations/sa/get-id.md).
         * `federatedUser:<user account ID>`: [User account ID](../../../organization/users-get.md).

      {% cut "Example of assigning roles for the folder using {{ TF }}" %}
{% if product == "yandex-cloud" %}

      ```hcl
      ...
      data "yandex_resourcemanager_folder" "project1" {
        folder_id = "<folder ID>"
      }

      resource "yandex_resourcemanager_folder_iam_binding" "editor" {
        folder_id = "${data.yandex_resourcemanager_folder_iam_member.project1.id}"

        role = "editor"

        members = [
          "userAccount:<login@yandex.ru>",
        ]
      }
      ...
      ```

{% endif %}
{% if product == "cloud-il" %}

      ```hcl
      ...
      data "yandex_resourcemanager_folder" "project1" {
        folder_id = "<folder ID>"
      }

      resource "yandex_resourcemanager_folder_iam_binding" "editor" {
        folder_id = "${data.yandex_resourcemanager_folder_iam_member.project1.id}"

        role = "editor"

        members = [
          "federatedUser:<user ID>",
        ]
      }
      ...
      ```

{% endif %}
      {% endcut %}

      For more information about the parameters of the `yandex_resourcemanager_folder_iam_binding` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/resourcemanager_folder_iam_binding).

   1. Check the configuration using the command:
      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:
      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, {{ TF }} points them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the change in the folder using the [management console]({{ link-console-main }}) or the following [CLI](../../../cli/quickstart.md) command:

      ```
      yc resource-manager folder list-access-bindings <folder name>|<folder ID>
      ```

{% endlist %}

## Examples {#examples}

* [{#T}](#multiple-roles)
* [{#T}](#access-to-sa)
* [{#T}](#access-to-all)

### Assign multiple roles {#multiple-roles}

{% list tabs %}

- Management console

   {% include [set-access-binding](../../../_includes/resource-manager/set-access-binding-multiple-users-console.md) %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   The `add-access-binding` command allows you to add only one role. You can assign multiple roles using the `set-access-binding` command.

   {% note alert %}

   The `set-access-binding` command completely rewrites the access rights to the resource. All current resource roles will be deleted.

   {% endnote %}

   1. Make sure the resource doesn't have any roles that you don't want to lose:
      ```bash
      yc resource-manager folder list-access-bindings my-folder
      ```
   1. For example, assign a role to multiple users:
{% if product == "yandex-cloud" %}
      ```bash
      yc resource-manager folder set-access-bindings my-folder \
        --access-binding role=editor,subject=userAccount:gfei8n54hmfhuk5nogse
        --access-binding role=viewer,subject=userAccount:helj89sfj80aj24nugsz
      ```

{% endif %}
{% if product == "cloud-il" %}
      ```
      yc resource-manager folder set-access-bindings my-folder \
          --access-binding role=editor,subject=federatedUser:gfei8n54hmfhuk5nogse
          --access-binding role=viewer,subject=federatedUser:helj89sfj80aj24nugsz
      ```

{% endif %}

- API

   Assign the `editor` role to one user and the `viewer` role to another user:
{% if product == "yandex-cloud" %}

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
     https://resource-manager.{{ api-host }}/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:updateAccessBindings
   ```

{% endif %}
{% if product == "cloud-il" %}

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
     }}}]}' \
     https://resource-manager.{{ api-host }}/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:updateAccessBindings
   ```

{% endif %}
   You can also assign roles using the [setAccessBindings](../../api-ref/Folder/setAccessBindings.md).

   {% note alert %}

   The `setAccessBindings` method completely rewrites the access rights to the resource! All current resource roles will be deleted.

   {% endnote %}
{% if product == "yandex-cloud" %}

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
     https://resource-manager.{{ api-host }}/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:setAccessBindings
   ```

{% endif %}
{% if product == "cloud-il" %}

   ```bash
   curl -X POST \
       -H 'Content-Type: application/json' \
       -H "Authorization: Bearer <IAM-TOKEN>" \
       -d '{
       "accessBindings": [{
          "roleId": "editor",
          "subject": { "id": "ajei8n54hmfhuk5nog0g", "type": "federatedUser" }
     },{
          "roleId": "viewer",
          "subject": { "id": "helj89sfj80aj24nugsz", "type": "federatedUser" }
     }]}' \
     https://resource-manager.{{ api-host }}/resource-manager/v1/folders/b1gd129pp9ha0vnvf5g7:setAccessBindings
   ```

{% endif %}

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% note alert %}

   Don't create the resource together with the `yandex_resourcemanager_folder_iam_policy` resource. They will conflict with each other.

   {% endnote %}

   To assign several roles to a folder created with {{ TF }}:

   1. Describe the parameters of the folder role in a configuration file:

      * `folder_id`: [ID of the folder](get-id.md) to grant permissions for. Required parameter.
      * `role`: The role assigned. Required parameter.

         {% note info %}

         For each role, only one `yandex_resourcemanager_folder_iam_binding` resource can be used.

         {% endnote %}

      * `members`: List of users to assign the role to. To add a user to the list, create an entry in the format {% if product == "yandex-cloud" %}`userAccount:<user ID>`{% endif %}{% if product == "cloud-il" %}`federatedUser:<user ID>`{% endif %}{% if product == "yandex-cloud" %} where `<user ID>` is the email address of the Yandex account (for example, `ivan@yandex.ru`){% endif %}. Required parameter.

      {% cut "Example of assigning roles for the folder using {{ TF }}" %}
{% if product == "yandex-cloud" %}

      ```hcl
      ...
      data "yandex_resourcemanager_folder" "project1" {
        folder_id = "<folder ID>"
      }

      resource "yandex_resourcemanager_folder_iam_binding" "editor" {
        folder_id = "${data.yandex_resourcemanager_folder.project1.id}"

        role = "editor"

        members = [
          "userAccount:<login1@yandex.ru>"
        ]
      }
      resource "yandex_resourcemanager_folder_iam_binding" "operator" {
        folder_id = "${data.yandex_resourcemanager_folder.project1.id}"

        role = "operator"

        members = [
          "userAccount:<login1@yandex.ru>"
        ]
      }
      ...
      ```

{% endif %}
{% if product == "cloud-il" %}

      ```hcl
      ...
      data "yandex_resourcemanager_folder" "project1" {
        folder_id = "<folder ID>"
      }

      resource "yandex_resourcemanager_folder_iam_binding" "editor" {
        folder_id = "${data.yandex_resourcemanager_folder.project1.id}"

        role = "editor"

        members = [
          "federatedUser:<user ID>"
        ]
      }
      resource "yandex_resourcemanager_folder_iam_binding" "operator" {
        folder_id = "${data.yandex_resourcemanager_folder.project1.id}"

        role = "operator"

        members = [
          "federatedUser:<user ID>"
        ]
      }
      ...
      ```

{% endif %}

      {% endcut %}

      For more information about the parameters of the `yandex_resourcemanager_folder_iam_binding` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/resourcemanager_folder_iam_binding).

   1. Check the configuration using the command:
      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:
      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, {{ TF }} points them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the change in the folder using the [management console]({{ link-console-main }}) or the following [CLI](../../../cli/quickstart.md) command:

      ```
      yc resource-manager folder list-access-bindings <folder name>|<folder ID>
      ```

{% endlist %}


### Folder access for a service account {#access-to-sa}

You can only use the management console to assign a service account a role for a folder in the same cloud as the service account folder.

{% list tabs %}

- Management console

   {% include [grant-role-console-sa](../../../_includes/grant-role-console-sa.md) %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [grant-role-for-sa-to-folder-via-cli](../../../_includes/iam/grant-role-for-sa-to-folder-via-cli.md) %}

- API

   {% include [grant-role-for-sa-to-folder-via-api](../../../_includes/iam/grant-role-for-sa-to-folder-via-api.md) %}

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% note alert %}

   Don't create the resource together with the `yandex_resourcemanager_folder_iam_policy` resource. They will conflict with each other.

   {% endnote %}

   To assign a service account a role to a folder created with {{ TF }}:

   1. Describe the parameters of the folder role in a configuration file:

      * `folder_id`: [ID of the folder](get-id.md) to grant permissions for. Required parameter.
      * `role`: The role assigned. Required parameter.

         {% note info %}

         For each role, only one `yandex_resourcemanager_folder_iam_binding` resource can be used.

         {% endnote %}

      * `members`: List of users to assign the role to. To add a user to the list, create a record as follows: `serviceAccount:<service account ID>`, where `<service account ID>` is the [service account identifier](../../../iam/operations/sa/get-id.md). You can list several service accounts. Required parameter.

      {% cut "Example of assigning roles for the folder using {{ TF }}" %}

      ```hcl
      ...
      data "yandex_resourcemanager_folder" "project1" {
        folder_id = "<folder D>"
      }

      resource "yandex_resourcemanager_folder_iam_binding" "editor" {
        folder_id = "${data.yandex_resourcemanager_folder.project1.id}"

        role = "editor"

        members = [
          "serviceAccount:<service account ID>"
        ]
      }
      ...
      ```

      {% endcut %}

      For more information about the parameters of the `yandex_resourcemanager_folder_iam_binding` resource in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/resourcemanager_folder_iam_binding).

   1. Check the configuration using the command:
      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:
      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If there are errors in the configuration, {{ TF }} points them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the change in the folder using the [management console]({{ link-console-main }}) or the following [CLI](../../../cli/quickstart.md) command:

      ```
      yc resource-manager folder list-access-bindings <folder name>|<folder ID>
      ```

{% endlist %}

{% if product == "yandex-cloud" %}

### Folder access for a federated user {#access-to-federated-user}

{% list tabs %}

- Management console

   The role assignment procedure is the same as for a user with a Yandex account. The user's federation name is shown next to the username.

   {% include [set-access-binding](../../../_includes/resource-manager/set-access-binding-user-acc-abstract-console.md) %}

- CLI

   1. Choose a role from the list in [Roles](../../../iam/concepts/access-control/roles.md).
   1. [Get the user ID](../../../iam/operations/users/get.md).
   1. Assign the role using the command:

      ```bash
      yc resource-manager folder add-access-binding <folder-name>|<folder-id> \
          --role <role-id> \
          --subject federatedUser:<federated-user-id>
      ```

      Where:

      * `<folder-name>`: Folder name. You can specify a folder by name or ID.
      * `<folder-id>`: Folder ID.
      * `<role-id>`: Role ID, such as `editor`.
      * `<federated-user-id>`: ID of user account assigned the role.

      For example, grant a federated user with the ID `aje6o61dvog2h6g9a33s` the `editor` role to the `my-folder` folder:

      ```bash
      yc resource-manager folder add-access-binding my-folder \
          --role editor \
          --subject federatedUser:aje6o61dvog2h6g9a33s
      ```

{% endlist %}

{% endif %}


### Access to a resource for all users {#access-to-all}

{% include [grant-role-for-sa](../../../_includes/iam/grant-role-for-all.md) %}


#### What's next {#what-is-next}

* [{#T}](update.md)
* [{#T}](../../concepts/resources-hierarchy.md)