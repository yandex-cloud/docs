# Setting up service account access permissions

This section describes how to assign [roles](../../concepts/access-control/roles.md) for the [service account](../../concepts/users/service-accounts.md) as a resource. To assign the service account a role for another resource, follow the instructions in [{#T}](assign-role-for-sa.md).

{% note info %}

To assign a role for a service account, you need the `iam.serviceAccounts.admin` role.

{% endnote %}

## Assigning a role for a service account {#assign-role-to-sa}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder the service account belongs to.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
    1. In the left-hand panel, select ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** and select the service account.
    1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
    1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
    1. In the **{{ ui-key.yacloud_components.acl.label.title }}** window, click **{{ ui-key.yacloud_components.acl.action.select-subject }}**.
    1. Select a user from the list or search by user.
    1. Click **{{ ui-key.yacloud_components.acl.button.add-role }}**.
    1. Choose the role.
    1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. View the description of the command to assign a role for a service account as a resource:

        ```bash
        yc iam service-account add-access-binding --help
        ```

    1. Select a service account, e.g., `my-robot`:

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

    1. Find out the user ID from the login or email address. To assign a role to a service account or a user group rather than to a single user, see the [examples](#examples) below.

        ```bash
        yc iam user-account get test-user
        ```

        Result:

        ```
        id: gfei8n54hmfh********
        yandex_passport_user_account:
            login: test-user
            default_email: test-user@yandex.ru
        ```

    1. Assign the `editor` role to the user `test-user` for the `my-robot` service account. In the subject, specify the `userAccount` type and user ID:

        ```bash
        yc iam service-account add-access-binding my-robot \
          --role editor \
          --subject userAccount:gfei8n54hmfh********
        ```

- {{ TF }} {#tf}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    1. Add the resource parameters to the configuration file and specify the users' role to access the service account:

       * `service_account_id`: ID of the service account to configure access for.
       * `role`: Role being assigned. This is a required parameter.
       * `members`: List of users or service accounts the role is being assigned to. Specify it as `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`. This is a required parameter.

       Here is an example of the configuration file structure:

       ```
       resource "yandex_iam_service_account_iam_binding" "admin-account-iam" {
         service_account_id = "<service_account_ID>"
         role               = "<role>"
         members            = [
           "federatedUser:<user_ID>",
         ]
       }
       ```

       For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account_iam_binding).

    1. Make sure the configuration files are correct.

       1. In the command line, go to the folder where you created the configuration file.
       1. Run a check using this command:

          ```
          terraform plan
          ```

       If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

    1. Deploy cloud resources.

       1. If the configuration does not contain any errors, run this command:

          ```
          terraform apply
          ```

       1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

       All the resources you need will then be created in the specified folder. You can check the new resource using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

       ```
       yc resource-manager service-account list-access-bindings <service_account_name_or_ID>
       ```

- API {#api}

    Use the [updateAccessBindings](../../api-ref/ServiceAccount/updateAccessBindings.md) REST API method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/UpdateAccessBindings](../../api-ref/grpc/ServiceAccount/updateAccessBindings.md) gRPC API call. You will need the ID of the service account and the ID of the user to whom you want to assign the role for the service account.

    1. Find out the service account ID using the [list](../../api-ref/ServiceAccount/list.md) REST API method:

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
            "id": "aje6o61dvog2********",
            "folderId": "b1gvmob95yys********",
            "createdAt": "2018-10-19T13:26:29Z",
            "name": "my-robot"
            }
            ...
        ]
        }
        ```

    1. Find out the user ID from the login using the [getByLogin](../../api-ref/YandexPassportUserAccount/getByLogin.md) REST API method:
        
        ```bash
        curl \
          --header "Authorization: Bearer <IAM_token>" \
          https://iam.{{ api-host }}/iam/v1/yandexPassportUserAccounts:byLogin?login=test-user
        ```

        Result:

        ```
        {
        "id": "gfei8n54hmfh********",
        "yandexPassportUserAccount": {
            "login": "test-user",
            "defaultEmail": "test-user@yandex.ru"
        }
        }
        ```


    1. Assign the `editor` role for the `my-robot` sevice account. Set the `action` property to `ADD` and specify the `userAccount` type and user ID in the `subject` property:

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

## Examples {#examples}

* [Assigning multiple roles](#multiple-roles)
* [Setting up impersonation](#impersonation)
* [Setting up access of one service account to another service account](#access-to-sa)

### Assigning multiple roles {#multiple-roles}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    The `add-access-binding` command allows you to add only one role. You can assign multiple roles using the `set-access-binding` command.

    {% note alert %}

    The `set-access-binding` method completely rewrites access permissions for the resource. All current resource roles will be deleted.

    {% endnote %}

    1. Make sure the resource has no roles assigned that you would not want to lose:
    
        ```bash
        yc iam service-account list-access-bindings my-robot
        ```

    1. For example, assign a role to multiple users:

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
       * `role`: Role being assigned. This is a required parameter.

       {% note info %}

       For each role, you can only use one `yandex_iam_service_account_iam_binding` resource.

       {% endnote %}

       * `members`: List of users or service accounts the role is being assigned to. Specify it as `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`. This is a required parameter.

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

     For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account_iam_binding).
 
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

     The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

  1. Apply the configuration changes:
     ```
     terraform apply
     ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     You can check the folder update using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

     ```
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
          "subject": { "id": "ajei8n54hmfh********", "type": "userAccount" }
      },{
          "roleId": "viewer",
          "subject": { "id": "helj89sfj80a********", "type": "userAccount" }
      }]}' \
      https://iam.{{ api-host }}/iam/v1/serviceAccounts/aje6o61dvog2********:setAccessBindings
    ```


{% endlist %}

### Set up impersonation {#impersonation}

[Impersonation](../../concepts/access-control/index.md#impersonation) enables a user perform actions under a service account using the `--impersonate-service-account-id` flag. To use impersonation, the service account needs the relevant permissions, and the user needs the `iam.serviceAccounts.tokenCreator` role.

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Find out the ID of the service account, such as `test-sa`, you want to assign the role to. To do this, get a list of available service accounts (in the administrator profile):

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

  1. Assign the `test-sa` service account the `viewer` role for `my-folder`. In the subject type, specify `serviceAccount`, and in its value, specify the service account ID from the administrator profile:

      ```
      yc resource-manager folder add-access-binding my-folder \
        --role viewer \
        --subject serviceAccount:ajebqtreob2d********
      ```

  1. Get the user ID and assign them the `iam.serviceAccounts.tokenCreator` role for the `test-sa` service account (in the administrator profile):

      ```
      yc iam service-account add-access-binding test-sa \
        --role iam.serviceAccounts.tokenCreator \
        --subject userAccount:gfei8n54hmfh********
      ```


  1. The user can run the command as the `test-sa` service account using the `--impersonate-service-account-id` flag.

      For example, the user can get a list of VMs in `my-folder`:

      ```
      yc compute instance list --folder-name my-folder \
        --impersonate-service-account-id ajebqtreob2d********
      ```

      The user can also get an [IAM token](../../concepts/authorization/iam-token.md) of the `test-sa` service account for short-term access:

      ```
      yc iam create-token --impersonate-service-account-id ajebqtreob2d********
      ```

      The token will expire automatically.

  1. If the user no longer needs this permission, revoke the role from the service account (in the administrator's profile):

      ```
      yc resource-manager folder remove-access-binding my-folder \
        --role viewer \
        --subject serviceAccount:ajebqtreob2d********
      ```
  1. Revoke the `iam.serviceAccounts.tokenCreator` role from the user you granted service account permissions to:

      ```
      yc iam service-account remove-access-binding test-sa \
        --role iam.serviceAccounts.tokenCreator \
        --subject userAccount:gfei8n54hmfh********
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

  1. Assign the `editor` role to the `test-sa` service account by specifying its ID. In the subject type, specify `serviceAccount`:

      ```bash
      yc iam service-account add-access-binding my-robot \
        --role editor \
        --subject serviceAccount:ajebqtreob2d********
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To allow the `test-sa` service account to manage the `my-robot` service account created with {{ TF }}:

    1. Add the resource parameters to the configuration file and specify the users' role to access the service account:

       * `service_account_id`: ID of the service account to configure access for.
       * `role`: Role being assigned. This is a required parameter.
       * `members`: List of users or service accounts the role is being assigned to. Specify it as `userAccount:<user_ID>` or `serviceAccount:<service_account_ID>`. This is a required parameter.

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

     For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account_iam_binding).

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

     The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

  1. Apply the configuration changes:
     ```
     terraform apply
     ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

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

  1. Assign the `editor` role to the `test-sa` service account for another service account named `my-robot`. In the `subject` property, specify the `serviceAccount` type and `test-sa` ID. In the request URL, specify the `my-robot` ID as a resource:

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
