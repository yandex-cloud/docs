# Setting up access rights for service accounts

This section describes how to assign [roles](../../concepts/access-control/roles.md) for the [service account](../../concepts/users/service-accounts.md) as a resource. To assign the service account a role for another resource, follow the instructions in [{#T}](assign-role-for-sa.md).

## Assign a role to a service account {#assign-role-to-sa}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
   1. At the top of the screen, go to the **Service accounts** tab.
   1. Choose a service account and click the line with its name.
   1. Go to **Access rights**.
   1. Click **Assign roles**.
   1. In the **Configure access bindings** window, click **Select user**.
   1. Select a user from the list or search for a user.
   1. Click **Add role**.
   1. Choose the role.
   1. Click **Save**.

- CLI

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the description of the command to assign a role for a service account as a resource:

      ```bash
      yc iam service-account add-access-binding --help
      ```

   1. Select a service account (for example, `my-robot`):

      ```bash
      yc iam service-account list
      ```

      Result:

      ```
      +----------------------+----------+------------------+
      |          ID          |   NAME   |   DESCRIPTION    |
      +----------------------+----------+------------------+
      | ajebqtreob2dpblin8pe | test-sa  | test-description |
      | aje6o61dvog2h6g9a33s | my-robot |                  |
      +----------------------+----------+------------------+
      ```

   1. Choose the [role](../../concepts/access-control/roles.md).

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

    1. Find out the user's ID from the login or email address. To assign a role to a service account or group of users rather than one user, see the [examples](#examples) below.

        ```bash
        yc iam user-account get test-user
        ```

        Result:

        ```
        id: gfei8n54hmfhuk5nogse
        yandex_passport_user_account:
            login: test-user
            default_email: test-user@yandex.ru
        ```

    1. Assign a user named `test-user` the `editor` role for the `my-robot` service account. In the subject, specify the `userAccount` type and user ID:

        ```bash
        yc iam service-account add-access-binding my-robot \
          --role editor \
          --subject userAccount:gfei8n54hmfhuk5nogse
        ```

- API

   Use the [updateAccessBindings](../../api-ref/ServiceAccount/updateAccessBindings.md) REST API method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/UpdateAccessBindings](../../api-ref/grpc/service_account_service.md#UpdateAccessBindings) gRPC API call. You will need the service account ID and the ID of the user who is assigned the role for the service account.

   1. Find out the service account ID using the [list](../../api-ref/ServiceAccount/list.md) REST API method:

      ```bash
      curl -H "Authorization: Bearer <IAM-TOKEN>" \
        https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=b1gvmob95yysaplct532
      ```

      Result:

      ```
      {
      "serviceAccounts": [
          {
          "id": "aje6o61dvog2h6g9a33s",
          "folderId": "b1gvmob95yysaplct532",
          "createdAt": "2018-10-19T13:26:29Z",
          "name": "my-robot"
          }
          ...
      ]
      }
      ```

    1. Find out the user ID from the login using the [getByLogin](../../api-ref/YandexPassportUserAccount/getByLogin.md) REST API method:

        ```bash
        curl -H "Authorization: Bearer <IAM-TOKEN>" \
          https://iam.{{ api-host }}/iam/v1/yandexPassportUserAccounts:byLogin?login=test-user
        ```

        Result:

        ```
        {
        "id": "gfei8n54hmfhuk5nogse",
        "yandexPassportUserAccount": {
            "login": "test-user",
            "defaultEmail": "test-user@yandex.ru"
        }
        }
        ```


    1. Assign the user the `editor` role for the `my-robot` service account. Set the `action` property to `ADD` and specify the `userAccount` type and user ID in the `subject` property:

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
         https://iam.{{ api-host }}/iam/v1/serviceAccounts/aje6o61dvog2h6g9a33s:updateAccessBindings
        ```

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Add the resource parameters to the configuration file and specify the users' role to access the service account:

      * `service_account_id`: ID of the service account that access must be configured for.
      * `role`: Role being assigned. This parameter is required.
      * `members`: List of users or service account the role is being assigned to. Specified in the following format: `userAccount:<user ID>` or `serviceAccount:<service account ID>`. This parameter is required.

      Example of the configuration file structure:

      ```
      resource "yandex_iam_service_account_iam_binding" "admin-account-iam" {
        service_account_id = "<service account ID>"
        role               = "<role>"
        members            = [
          "federatedUser:<user ID>",
        ]
      }
      ```

      For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account_iam_binding).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

      All the resources you need will then be created in the specified folder. You can verify that the resource has been created in the [management console]({{ link-console-main }}) or with the following [CLI](../../../cli/quickstart.md) command:

      ```
      yc resource-manager service-account list-access-bindings <service account name>|<service account ID>
      ```

{% endlist %}

## Examples {#examples}

* [{#T}](#multiple-roles).
* [{#T}](#impersonation).
* [{#T}](#access-to-sa).
* [{#T}](#access-to-all).

### Assign multiple roles {#multiple-roles}

{% list tabs %}

- CLI

   The `add-access-binding` command allows you to add only one role. You can assign multiple roles using the `set-access-binding` command.

   {% note alert %}

   The `set-access-binding` command completely rewrites the access rights to the resource. All current resource roles will be deleted.

   {% endnote %}

   1. Make sure the resource doesn't have any roles that you don't want to lose:

      ```bash
      yc iam service-account list-access-bindings my-robot
      ```

   1. For example, assign a role to multiple users:

        ```bash
        yc iam service-account set-access-bindings my-robot \
          --access-binding role=editor,subject=userAccount:gfei8n54hmfhuk5nogse \
          --access-binding role=viewer,subject=userAccount:helj89sfj80aj24nugsz
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
       https://iam.{{ api-host }}/iam/v1/serviceAccounts/aje6o61dvog2h6g9a33s:updateAccessBindings
   ```

    You can also assign roles using the [setAccessBindings](../../api-ref/ServiceAccount/setAccessBindings.md) REST API method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../api-ref/grpc/service_account_service.md#SetAccessBindings) gRPC API call.

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
        https://iam.{{ api-host }}/iam/v1/serviceAccounts/aje6o61dvog2h6g9a33s:setAccessBindings
    ```

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the provider {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To assign several roles to a service account created with {{ TF }}:

    1. Add the resource parameters to the configuration file and specify the users' role to access the service account:

       * `service_account_id`: ID of the service account that access must be configured for.
       * `role`: Role being assigned. This parameter is required.

       {% note info %}

       For each role, only one `yandex_iam_service_account_iam_binding resource can be used`.

       {% endnote %}

       * `members`: List of users or service account the role is being assigned to. Specified in the following format: `userAccount:<user ID>` or `serviceAccount:<service account ID>`. This parameter is required.

     {% cut "Example of assigning multiple roles to a service account using {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_iam_service_account_iam_binding" "admin-account-iam" {
       service_account_id = "aje82upckiqhi3943ekr"
       role               = "admin"
       members = [
         "userAccount:aje82upckiqhi3943ekr",
       ]
     }
     resource "yandex_iam_service_account_iam_binding" "admin-account-iam2" {
       service_account_id = "aje82upckiqhi3943ekr"
       role               = "viewer"
       members = [
         "userAccount:aje82upckiqhi3943ekr",
       ]
     }
     ...
     ```

     {% endcut %}

     For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account_iam_binding).

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

       The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.

    1. Apply the configuration changes:
       ```
       terraform apply
       ```

    1. Confirm the changes: type `yes` into the terminal and press **Enter**.

       You can verify the change in the folder using the [management console]({{ link-console-main }}) or the following [CLI](../../../cli/quickstart.md) command:

       ```
       yc resource-manager service-account list-access-bindings <service account name>|<service account ID>
       ```

{% endlist %}

### Set up impersonation {#impersonation}

[Impersonation](../../concepts/access-control/index.md#impersonation) enables a user to perform actions on behalf of a service account using the `--impersonate-service-account-id` flag. For this, the service account needs the relevant permissions, and the user needs the `iam.serviceAccounts.tokenCreator` role.

{% list tabs %}

- CLI

   1. Find out the ID of the service account that you want to assign the role to (for example, `test-sa`). For this, get a list of available service accounts (in the administrator profile):

      ```bash
      yc iam service-account list
      ```

      Result:

      ```
      +----------------------+----------+------------------+
      |          ID          |   NAME   |   DESCRIPTION    |
      +----------------------+----------+------------------+
      | ajebqtreob2dpblin8pe | test-sa  | test-description |
      | aje6o61dvog2h6g9a33s | my-robot |                  |
      +----------------------+----------+------------------+
      ```

   1. Assign the `viewer` role for `my-folder` to the `test-sa` service account. In the subject type, specify `serviceAccount`, and in its value, specify the ID of the service account (in the administrator profile):

      ```
      yc resource-manager folder add-access-binding my-folder \
        --role viewer \
        --subject serviceAccount:ajebqtreob2dpblin8pe
      ```

   1. Retrieve the user ID and assign, to the user, the `iam.serviceAccounts.tokenCreator` role for the `test-sa`  service account (in the administrator profile):

      ```
      yc iam service-account add-access-binding test-sa \
        --role iam.serviceAccounts.tokenCreator \
        --subject userAccount:gfei8n54hmfhuk5nogse
      ```


   1. The user can perform the command on behalf of the `test-sa` service account using the `--impersonate-service-account-id` flag.

      For example, the user can get a list of VM instances in `my-folder`:

      ```
      yc compute instance list --folder-name my-folder \
        --impersonate-service-account-id ajebqtreob2dpblin8pe
      ```

      The user can also obtain an [IAM token](../../concepts/authorization/iam-token.md) for your `test-sa` service account, for short-term access.

      ```
      yc iam create-token --impersonate-service-account-id ajebqtreob2dpblin8pe
      ```

      The token will expire automatically.

   1. If the user no longer needs this permission, revoke the role from the service account (in the administrator's profile):

      ```
      yc resource-manager folder remove-access-binding my-folder \
        --role viewer \
        --subject serviceAccount:ajebqtreob2dpblin8pe
      ```
   1. Revoke the `iam.serviceAccounts.tokenCreator` role from the user you assigned the service account's privileges to:

      ```
      yc iam service-account remove-access-binding test-sa \
        --role iam.serviceAccounts.tokenCreator \
        --subject userAccount:gfei8n54hmfhuk5nogse
      ```


{% endlist %}

### Setting up access from one service account to another service account {#access-to-sa}

Allow the `test-sa` service account to manage the `my-robot` service account:

{% list tabs %}

- CLI

   1. Find out the ID of the `test-sa` service account that you want to assign the role to. To do this, get a list of available service accounts:

      ```bash
      yc iam service-account list
      ```

      Result:

      ```
      +----------------------+----------+------------------+
      |          ID          |   NAME   |   DESCRIPTION    |
      +----------------------+----------+------------------+
      | ajebqtreob2dpblin8pe | test-sa  | test-description |
      | aje6o61dvog2h6g9a33s | my-robot |                  |
      +----------------------+----------+------------------+
      ```

   1. Assign the `editor` role to the `test-sa` service account by specifying its ID. In the subject type, specify `serviceAccount`:

      ```bash
      yc iam service-account add-access-binding my-robot \
        --role editor \
        --subject serviceAccount:ajebqtreob2dpblin8pe
      ```

- API

   1. Find out the ID of the `test-sa` service account that you want to assign the role to. To do this, get a list of available service accounts:

      ```bash
      curl -H "Authorization: Bearer <IAM-TOKEN>" \
        https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=b1gvmob95yysaplct532
      ```

      Result:

      ```
      {
       "serviceAccounts": [
        {
         "id": "ajebqtreob2dpblin8pe",
         "folderId": "b1gvmob95yysaplct532",
         "createdAt": "2018-10-18T13:42:40Z",
         "name": "test-sa",
         "description": "test-description"
        },
        {
         "id": "aje6o61dvog2h6g9a33s",
         "folderId": "b1gvmob95yysaplct532",
         "createdAt": "2018-10-15T18:01:25Z",
         "name": "my-robot"
        }
       ]
      }
      ```

   1. Assign the `test-sa` service account the `editor` role for another `my-robot` service account. In the `subject` property, specify the `serviceAccount` type and the `test-sa` ID. In the request URL, specify the `my-robot` ID as a resource:

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
                      "id": "ajebqtreob2dpblin8pe",
                      "type": "serviceAccount"
          }}}]}' \
          https://iam.{{ api-host }}/iam/v1/serviceAccounts/aje6o61dvog2h6g9a33s:updateAccessBindings
      ```

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the provider {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To allow the `test-sa` service account to manage the `my-robot` service account created using {{ TF }}:

   1. Add the resource parameters to the configuration file and specify the users' role to access the service account:

      * `service_account_id`: ID of the service account that access must be configured for.
      * `role`: Role being assigned. This parameter is required.
      * `members`: List of users or service account the role is being assigned to. Specified in the following format: `userAccount:<user ID>` or `serviceAccount:<service account ID>`. This parameter is required.

   {% cut "Example of allowing the `test-sa` service account to manage the `my-robot` service account using {{ TF }}" %}

   ```hcl
   ...
   resource "yandex_iam_service_account_iam_binding" "admin-account-iam" {
     service_account_id = "aje82upckiqhi3943ekr"
     role               = "admin"
     members = [
       "serviceAccount:aje82upckiqhi3943ekr",
     ]
   }
   ...
   ```

   {% endcut %}

   For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account_iam_binding).

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the change in the folder using the [management console]({{ link-console-main }}) or the following [CLI](../../../cli/quickstart.md) command:

      ```
      yc resource-manager service-account list-access-bindings <service account name>|<service account ID>
      ```

{% endlist %}

### Allowing all users to access the resource {#access-to-all}

{% include [set-access-to-all](../../../_includes/iam/set-access-to-all.md) %}

For example, allow any authenticated user to view information about the `my-robot` service account:

{% list tabs %}

- CLI

   Assign the `viewer` role to the `allAuthenticatedUsers` system group. In the subject type, specify `system`:

   ```bash
   yc iam service-account add-access-binding my-robot \
     --role viewer \
     --subject system:allAuthenticatedUsers
   ```

- API


   Assign the `viewer` role to the `allAuthenticatedUsers` system group. In the `subject` property, specify the `system` type:

   ```bash
   curl -X POST \
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
       https://iam.{{ api-host }}/iam/v1/serviceAccounts/aje6o61dvog2h6g9a33s:updateAccessBindings
   ```

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the provider {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To allow any authenticated user to view information about the `my-robot` service account:

   1. Add the resource parameters to the configuration file and specify the users' role to access the service account:

      * `service_account_id`: ID of the service account that access must be configured for.
      * `role`: Role being assigned. This parameter is required.
      * `members`: List of users or service account the role is being assigned to. Specified in the format `userAccount:<user ID>` or `serviceAccount:<service account ID>`. This parameter is required.

   {% cut "Example of allowing any authenticated user to view information about the `my-robot` service account" %}

   ```hcl
   ...
   resource "yandex_iam_service_account_iam_binding" "admin-account-iam" {
     service_account_id = "aje82upckiqhi3943ekr"
     role               = "viewer"
     members = [
       "system:allUsers",
     ]
   }
   ...
   ```

   {% endcut %}

   For more information about resources you can create using {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account_iam_binding).

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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:
      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the change in the folder using the [management console]({{ link-console-main }}) or the following [CLI](../../../cli/quickstart.md) command:

      ```
      yc resource-manager service-account list-access-bindings <service account name>|<service account ID>
      ```

{% endlist %}
