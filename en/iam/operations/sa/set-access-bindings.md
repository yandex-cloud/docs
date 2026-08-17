# Setting up service account access permissions

This section describes how to assign [roles](../../concepts/access-control/roles.md) for the [service account](../../concepts/users/service-accounts.md) as a resource. To assign the service account a role for another resource, follow the instructions in [{#T}](assign-role-for-sa.md).

{% note info %}

To assign a role for a service account, you need the `iam.serviceAccounts.admin` role.

{% endnote %}


## Assigning a role for a service account {#assign-role-to-sa}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), click ![image](../../../_assets/console-icons/layout-side-content-left.svg) or ![image](../../../_assets/console-icons/chevron-down.svg) in the top panel and select the folder the service account belongs to.
  1. [Navigate]({{ link-console-main }}/link/iam) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** and then select the required service account.
  1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Click **{{ ui-key.yacloud.shared.iam.action_assign-roles_8vkmR }}**.
  1. In the **{{ ui-key.yacloud_components.acl.label.subject }}** field of the the **{{ ui-key.yacloud_components.acl.label.title }}** window, select a subject or use the search.
  1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select a role.
  1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the command to assign a role for a service account as a resource:

      ```bash
      yc iam service-account add-access-binding --help
      ```

  1. Get the [role](../../concepts/access-control/roles.md) ID:

      ```bash
      yc iam role list
      ```

      Result:

      ```text
      +-------------------------------------+-------------+
      |                 ID                  | DESCRIPTION |
      +-------------------------------------+-------------+
      | access-transparency.admin           |             |
      | access-transparency.billingProvider |             |
      | access-transparency.editor          |             |
      | ...                                 |             |
      ```

  1. Assign a role for a service account to the subject:

      ```bash
      yc iam service-account add-access-binding <service_account_name_or_ID> \
        --role <role_ID> \
        --subject <subject_type>:<subject_ID>
      ```

      Where:

      * `--role`: ID of the role you need to assign.
      * `--subject`: [Subject](../../concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-cli](../../../_includes/iam/subjects-designations-cli.md) %}

          {% endcut %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Describe the resource with the role for the organization in the configuration file.

      Here is an example of the configuration file structure:

      ```hcl
      resource "yandex_iam_service_account_iam_binding" "admin-account-iam" {
        service_account_id = "<service_account_ID>"
        role               = "<role>"
        members            = ["<subject_1>","<subject_2>,...,<subject_n>"]
      }
      ```

      Where:

      * `service_account_id`: ID of the service account to configure access for.
      * `role`: Role.
      * `members`: Designations of [subjects](../../concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      For more information about the resources you can create with {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/iam_service_account_iam_binding).

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Assign the role.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      This will create all the resources you need in the specified folder. You can check the new resource using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```
      yc resource-manager service-account list-access-bindings <service_account_name_or_ID>
      ```

- API {#api}

  Use the [updateAccessBindings](../../api-ref/ServiceAccount/updateAccessBindings.md) REST API method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/UpdateAccessBindings](../../api-ref/grpc/ServiceAccount/updateAccessBindings.md) gRPC API call. You will need the ID of the service account and that of the subject to whom you want to assign the role for the service account.

  1. Find out the service account ID using the [list](../../api-ref/ServiceAccount/list.md) REST API method:

      ```bash
      curl \
        --header "Authorization: Bearer <IAM_token>" \
        https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=<folder_ID>
      ```

      Result:

      ```json
      {
      "serviceAccounts": [
          {
          "id": "aje6o61dvog2********",
          "folderId": "b1gvmob95yys********",
          "createdAt": "2018-10-19T13:26:29Z",
          "name": "my-robot"
          }
          ...
      ]
      }
      ```

  1. Assign a role for a service account to the subject; in the `action` property, specify `ADD`:

      ```bash
      curl \
        --request POST \
        --header 'Content-Type: application/json' \
        --header "Authorization: Bearer <IAM_token>" \
        --data '{
        "accessBindingDeltas": [{
            "action": "ADD",
            "accessBinding": {
                "roleId": "<role>",
                "subject": {
                    "id": "<subject_ID>",
                    "type": "<subject_type>"
        }}}]}' \
        https://iam.{{ api-host }}/iam/v1/serviceAccounts/<service_account_ID>:updateAccessBindings
      ```

      Where:

      * `roleId`: Role.
      * `subject`: [Subject](../../concepts/access-control/index.md#subject) to assign the role to.

          {% cut "Subject designations" %}

          {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

          {% endcut %}

      * `<service_account_ID>`: ID of the service account to configure access for.

{% endlist %}


## Examples {#examples}

* [Configuring user access permissions for the service account](#user-access).
* [Assigning multiple roles](#multiple-roles).
* [Setting up access of one service account to another service account](#access-to-sa).


### Configuring user access permissions for the service account {#user-access}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), click ![image](../../../_assets/console-icons/layout-side-content-left.svg) or ![image](../../../_assets/console-icons/chevron-down.svg) in the top panel and select the folder the service account belongs to.
  1. [Navigate]({{ link-console-main }}/link/iam) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** and then select the required service account.
  1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Click **{{ ui-key.yacloud.shared.iam.action_assign-roles_8vkmR }}**.
  1. In the **{{ ui-key.yacloud_components.acl.label.title }}** field of the **{{ ui-key.yacloud_components.acl.label.subject }}** window, select a user from the list or search by user.
  1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select a role.
  1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Assign the `editor` role for the `my-robot` service account to `test-user`:

      ```bash
      yc iam service-account add-access-binding my-robot \
        --role editor \
        --user-yandex-login test-user
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Add the resource parameters to the configuration file and specify the users' role to access the service account.

      Here is an example of the configuration file structure:

      ```hcl
      resource "yandex_iam_service_account_iam_binding" "admin-account-iam" {
        service_account_id = "aje6o61dvog2********"
        role               = "editor"
        members            = ["userAccount:gfei8n54hmfh********",]
      }
      ```

      Where:

      * `service_account_id`: ID of the service account to configure access for.
      * `role`: Role.
      * `members`: List of users getting the role. Use one of these formats: `userAccount:<user_ID>`.

      For more information about the resources you can create with {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/iam_service_account_iam_binding).

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Assign the role.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      This will create all the resources you need in the specified folder. You can check the new resource using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```
      yc resource-manager service-account list-access-bindings <service_account_name_or_ID>
      ```

- API {#api}

  Use the [updateAccessBindings](../../api-ref/ServiceAccount/updateAccessBindings.md) REST API method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/UpdateAccessBindings](../../api-ref/grpc/ServiceAccount/updateAccessBindings.md) gRPC API call. You will need the ID of the service account and that of the user to whom you want to assign the role for the service account.

  1. Find out the service account ID using the [list](../../api-ref/ServiceAccount/list.md) REST API method:

      ```bash
      curl \
        --header "Authorization: Bearer <IAM_token>" \
        https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=b1gvmob95yys********
      ```

      Result:

      ```json
      {
      "serviceAccounts": [
          {
          "id": "aje6o61dvog2********",
          "folderId": "b1gvmob95yys********",
          "createdAt": "2018-10-19T13:26:29Z",
          "name": "my-robot"
          }
          ...
      ]
      }
      ```

  1. Find out the user ID by login using the [getByLogin](../../api-ref/YandexPassportUserAccount/getByLogin.md) REST API method:
      
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

  1. Assign the `editor` role for the `my-robot` sevice account. In the `action` property, enter `ADD` and specify the `userAccount` type and user ID under `subject`.

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
        https://iam.{{ api-host }}/iam/v1/serviceAccounts/aje6o61dvog2********:updateAccessBindings
      ```

{% endlist %}

### Assigning multiple roles {#multiple-roles}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    The `add-access-binding` command allows you to add only one role. You can assign multiple roles using the `set-access-binding` command.

    {% note alert %}

    The `set-access-binding` command completely overwrites access permissions for the resource! All roles previously assigned for this resource will be deleted.

    {% endnote %}

    1. Make sure the resource has no important roles assigned before proceeding:
    
        ```bash
        yc iam service-account list-access-bindings my-robot
        ```

    1. Assign a role to multiple users:

        ```bash
        yc iam service-account set-access-bindings my-robot \
          --access-binding role=editor,subject=userAccount:gfei8n54hmfh******** \
          --access-binding role=viewer,subject=userAccount:helj89sfj80a********
        ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To assign several roles to a service account created with {{ TF }}:

  1. Add the resource parameters to the configuration file and specify the users' role to access the service account:

      * `service_account_id`: ID of the service account to configure access for.
      * `role`: Role.

          {% note info %}

          For each role, you can only use one `yandex_iam_service_account_iam_binding` resource.

          {% endnote %}

      * `members`: List of users or service accounts the role is being assigned to. Use one of these formats: `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`.

      {% cut "Example of assigning multiple roles to a service account using {{ TF }}" %}

      ```hcl
      ...
      resource "yandex_iam_service_account_iam_binding" "admin-account-iam" {
        service_account_id = "aje82upckiqh********"
        role               = "admin"
        members = [
          "userAccount:aje82upckiqh********",
        ]
      }
      resource "yandex_iam_service_account_iam_binding" "admin-account-iam2" {
        service_account_id = "aje82upckiqh********"
        role               = "viewer"
        members = [
          "userAccount:aje82upckiqh********",
        ]
      }
      ...
      ```

      {% endcut %}

      For more information about the resources you can create with {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/iam_service_account_iam_binding).
 
  1. Make sure the settings are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Assign the role.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      You can check the folder update using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc resource-manager service-account list-access-bindings <service_account_name_or_ID>
      ```

- API {#api}

    Assign the `editor` role to one user and the `viewer` role to another user:

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
      https://iam.{{ api-host }}/iam/v1/serviceAccounts/aje6o61dvog2********:updateAccessBindings
    ```

    You can also assign roles using the [setAccessBindings](../../api-ref/ServiceAccount/setAccessBindings.md) REST API method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../api-ref/grpc/ServiceAccount/setAccessBindings.md) gRPC API call.

    {% note alert %}

    The `setAccessBindings` method completely overwrites access permissions for the resource! All roles previously assigned for this resource will be deleted.

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
      https://iam.{{ api-host }}/iam/v1/serviceAccounts/aje6o61dvog2********:setAccessBindings
    ```

{% endlist %}


### Setting up access from one service account to another service account {#access-to-sa}

Allow the `test-sa` service account to manage the `my-robot` service account:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Find out the ID of the `test-sa` service account you want to assign the role to. To do this, get a list of available service accounts:

      ```bash
      yc iam service-account list
      ```

      Result:

      ```
      +----------------------+----------+------------------+
      |          ID          |   NAME   |   DESCRIPTION    |
      +----------------------+----------+------------------+
      | ajebqtreob2d******** | test-sa  | test-description |
      | aje6o61dvog2******** | my-robot |                  |
      +----------------------+----------+------------------+
      ```

  1. Assign the `editor` role to the `test-sa` service account by specifying its ID:

      ```bash
      yc iam service-account add-access-binding my-robot \
        --role editor \
        --service-account-id ajebqtreob2d********
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To allow the `test-sa` service account to manage the `my-robot` service account created with {{ TF }}:

  1. Add the resource parameters to the configuration file and specify the users' role to access the service account:

      * `service_account_id`: ID of the service account to configure access for.
      * `role`: Role.
      * `members`: List of users or service accounts the role is being assigned to. Use one of these formats: `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`.

      {% cut "Example of granting the `test-sa` service account permissions to manage the `my-robot` service account using {{ TF }}" %}

      ```hcl
      ...
      resource "yandex_iam_service_account_iam_binding" "admin-account-iam" {
        service_account_id = "aje82upckiqh********"
        role               = "admin"
        members = [
          "serviceAccount:aje82upckiqh********",
        ]
      }
      ...
      ```

      {% endcut %}

      For more information about the resources you can create with {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/iam_service_account_iam_binding).

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Assign the role.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      You can check the folder update using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

      ```
      yc resource-manager service-account list-access-bindings <service_account_name_or_ID>
      ```

- API {#api}

  1. Find out the ID of the `test-sa` service account you want to assign the role to. To do this, get a list of available service accounts:

      ```bash
      curl \
        --header "Authorization: Bearer <IAM_token>" \
        https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=b1gvmob95yys********
      ```

      Result:

      ```
      {
       "serviceAccounts": [
        {
         "id": "ajebqtreob2d********",
         "folderId": "b1gvmob95yys********",
         "createdAt": "2018-10-18T13:42:40Z",
         "name": "test-sa",
         "description": "test-description"
        },
        {
         "id": "aje6o61dvog2********",
         "folderId": "b1gvmob95yys********",
         "createdAt": "2018-10-15T18:01:25Z",
         "name": "my-robot"
        }
       ]
      }
      ```

  1. Assign the `editor` role to the `test-sa` service account for another service account named `my-robot`. In the `subject` property, specify the `serviceAccount` type and `test-sa` ID. In the request URL, specify the `my-robot` ID as the resource:

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
                    "id": "ajebqtreob2d********",
                    "type": "serviceAccount"
        }}}]}' \
        https://iam.{{ api-host }}/iam/v1/serviceAccounts/aje6o61dvog2********:updateAccessBindings
      ```

{% endlist %}


## Useful links {#see-also}

* [{#T}](./impersonate-sa.md)