# Assigning roles

To provide access to a resource, assign the subject a [role](../../concepts/access-control/roles.md) to the resource itself or a resource from which access privileges are inherited, such as a folder or a cloud. For more information, see [{#T}](../../concepts/access-control/index.md).


## Assigning a role to a user with a Yandex account {#access-to-user}

This section describes how to assign a role to a user with a Yandex account. The examples below show how to assign a role to a [service account](#access-to-sa), [federated user](#access-to-federated-user), or [all users at once](#access-to-all).



{% list tabs %}

- Management console

   In the management console, you can only assign a role for a cloud or folder:


   1. Add the user to the cloud via the [management console](../users/create.md#console-user) or [{{ org-full-name }}](../users/create.md#organization-user).

   1. Assign the user a role in the cloud:

      {% include [set-access-binding-user-cloud-console](../../../_includes/resource-manager/set-access-binding-user-cloud-console.md) %}

   1. Grant the user a role to the folder:

      {% include [set-access-binding-user-acc-abstract-console](../../../_includes/resource-manager/set-access-binding-user-acc-abstract-console.md) %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. Choose a role from the list in [Roles](../../concepts/access-control/roles.md).
   1. [Get the user ID](../users/get.md).
   1. Assign the role using the command:

      ```bash
      yc <service-name> <resource> add-access-binding <resource-name>|<resource-id> \
          --role <role-id> \
          --subject userAccount:<user-account-id>
      ```

      Where:

      * `<service-name>`: Name of the service to whose resource the role (e.g., `resource-manager`) is assigned.
      * `<resource>`: Resource category, e.g., `cloud`.
      * `<resource-name>`: Resource name. You can specify a resource by its name or ID.
      * `<resource-id>`: Resource ID.
      * `<role-id>`: Role ID, e.g., `{{ roles-cloud-owner }}`.
      * `<user-account-id>`: ID of the user account to which the role is assigned.

      For example, assign the `viewer` role for the `mycloud` [cloud](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc resource-manager cloud add-access-binding mycloud \
          --role viewer \
          --subject userAccount:aje6o61dvog2h6g9a33s
      ```


- API

   Use the `updateAccessBindings` REST API method for the respective resource.

   1. Choose a role from the list in [Roles](../../concepts/access-control/roles.md).
   1. [Get the user ID](../users/get.md).
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

    For detailed instructions on how to assign a role to a resource, see:
    * [{#T}](../sa/set-access-bindings.md).
    * [{#T}](../../../resource-manager/operations/cloud/set-access-bindings.md).
    * [{#T}](../../../resource-manager/operations/folder/set-access-bindings.md).

- {{ TF }}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. Add the resource parameters to the configuration file, specify the required role and a list of cloud users:

      * `cloud_id`: [Cloud ID](../../../resource-manager/operations/cloud/get-id.md). You can also assign a role in an individual folder. To do this, specify `folder_id` instead of `cloud_id` and the required folder ID in the resource parameters.
      * `role`: Role being assigned. This is a required parameter.
      * `members`: List of users or service account the role is being assigned to. It is specified in the following format: `userAccount:<user ID>` or `serviceAccount:<service account ID>`. This is a required parameter.

      Example of the configuration file structure:

      ```
      resource "yandex_resourcemanager_cloud_iam_binding" "admin" {
          cloud_id    = "<cloud ID>"
          role        = "<role>"
          members     = [
          "serviceAccount:<service account ID>",
          "userAccount:<user ID>",
          ]
      }
      ```


       For more information about the parameters of the `yandex_resourcemanager_cloud_iam_binding` resource, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account_iam_binding).

   1. Make sure the configuration files are valid.

       1. In the command line, go to the directory where you created the configuration file.
       1. Run the check using the command:

          ```
          terraform plan
          ```

       If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

    1. Deploy cloud resources.

        1. If there are no errors in the configuration, run the terraform apply command

          ```
          terraform apply
          ```

        1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

        All the resources you need will then be created in the specified folder. You can check the new resource using the [management console]({{ link-console-main }}) or this [CLI] command (../../../cli/quickstart.md):

        ```
        yc resource-manager folder list-access-bindings <folder name>|<folder ID>
        ```

{% endlist %}


## Assign multiple roles {#multiple-roles}

{% list tabs %}

- Management console

   {% include [set-access-binding](../../../_includes/resource-manager/set-access-binding-multiple-users-console.md) %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   The `add-access-binding` command allows you to add only one role. You can assign multiple roles using the `set-access-binding` command.

   {% note alert %}

   The `set-access-binding` command completely rewrites the access rights to the resource. All current resource roles will be deleted.

   {% endnote %}

   For example, to assign multiple roles for a folder:

   1. Make sure the resource does not have any roles that you do not want to lose:

      ```bash
      yc resource-manager folder list-access-binding my-folder
      ```

   1. Assign roles. For example, assign the `editor` role to one user and the `viewer` role to another user:


        ```bash
        yc resource-manager folder set-access-bindings my-folder \
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

   1. Assign the specified roles, say, for the folder with the `b1gvmob95yysaplct532` ID:

        {% include [grant-role-folder-via-curl](../../../_includes/iam/grant-role-folder-via-curl.md) %}

    You can also assign roles using the [setAccessBindings](../../api-ref/ServiceAccount/setAccessBindings.md) REST API method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../api-ref/grpc/service_account_service.md#SetAccessBindings) gRPC API call.

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
        export FOLDER_ID=b1gvmob95yysaplct532
        export IAM_TOKEN=CggaATEVAgA...
        curl -X POST \
            -H "Content-Type: application/json" \
            -H "Authorization: Bearer ${IAM_TOKEN}" \
            -d '@body.json' \
            "https://resource-manager.{{ api-host }}/resource-manager/v1/folders/${FOLDER_ID}:setAccessBindings"
        ```

{% endlist %}


## Resource access for a service account {#access-to-sa}

{% include [grant-role-for-sa](../../../_includes/iam/grant-role-for-sa.md) %}


## Resource access for a federated user {#access-to-federated-user}

In the management console, you can assign a [federated user](../../../organization/concepts/add-federation.md) a role for an individual cloud or folder.

{% list tabs %}

- Management console

   The role assignment procedure is the same as for a user with a Yandex account. The user's federation name is shown next to the username.

   In the management console, you can only assign a role for a cloud or folder:

   1. Assign the user a role in the cloud:

      {% include [set-access-binding-user-cloud-console](../../../_includes/resource-manager/set-access-binding-user-cloud-console.md) %}

   1. Assign the user a role in the folder:

      {% include [set-access-binding-user-acc-abstract-console](../../../_includes/resource-manager/set-access-binding-user-acc-abstract-console.md) %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. Choose a role from the list in [Roles](../../concepts/access-control/roles.md).
   1. [Get the user ID](../users/get.md).
   1. Assign the role using the command:

      ```bash
      yc <service-name> <resource> add-access-binding <resource-name>|<resource-id> \
          --role <role-id> \
          --subject federatedUser:<federated-user-id>
      ```

      Where:

      * `<service-name>`: Name of the service to whose resource a role, e.g., `resource-manager`, is assigned.
      * `<resource>`: Resource category, e.g., `cloud`.
      * `<resource-name>`: Name of the resource. You can specify a resource by its name or ID.
      * `<resource-id>`: Resource ID.
      * `<role-id>`: Role ID, e.g., `{{ roles-cloud-owner }}`.
      * `<federated-user-id>`: ID of user account assigned the role.

      For example, assign the `viewer` role for the `mycloud` [cloud](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc resource-manager cloud add-access-binding mycloud \
          --role viewer \
          --subject federatedUser:aje6o61dvog2h6g9a33s
      ```

- API

   Use the `updateAccessBindings` REST API method for the respective resource.

   1. Choose a role from the list in [Roles](../../concepts/access-control/roles.md).
   1. [Get the user ID](../users/get.md).
   1. Create a request body, for example, in a `body.json` file. In the `action` property, specify `ADD`, and in the `subject` property, `federatedUser` as the type and the user ID:

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

   1. {% include [grant-role-folder-via-curl-step](../../../_includes/iam/grant-role-folder-via-curl-step.md) %}

{% endlist %}



## Resource access for a group of users {#access-group}

{% list tabs %}

- Management console

   Assign the group of users a role in the cloud:

   1. In the [management console]({{ link-console-main }}), [select](../../../resource-manager/operations/cloud/switch-cloud.md) a cloud.
   1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
   1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. In the **{{ ui-key.yacloud_components.acl.label.title }}** window, click **{{ ui-key.yacloud_components.acl.action.select-subject }}**:
      1. Go to **{{ ui-key.yacloud.common.resource-acl.label_groups }}** or search for a group by name.
      1. Click **{{ ui-key.yacloud_components.acl.button.add-role }}**.
      1. Select a role in the cloud.
      1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

   The group name will be displayed in **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** in the cloud along with the other users with roles in this cloud.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. Choose a role from the list in [Roles](../../concepts/access-control/roles.md).
   1. [Get the user ID](../users/get.md).
   1. Assign the role using the command:

      ```bash
      yc <service-name> <resource> add-access-binding <resource-name>|<resource-id> \
          --role <role-id> \
          --subject group:<group-id>
      ```

      Where:

      * `<service-name>`: Name of the service to whose resource a role, e.g., `resource-manager`, is assigned.
      * `<resource>`: Resource category, e.g., `cloud`.
      * `<resource-name>`: Name of the resource. You can specify a resource by its name or ID.
      * `<resource-id>`: Resource ID.
      * `<role-id>`: Role ID, e.g., `{{ roles-cloud-owner }}`.
      * `<group-id>`: The ID of the group assigned the role.

      For example, assign the `viewer` role for the `mycloud` [cloud](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc resource-manager cloud add-access-binding mycloud \
          --role viewer \
          --subject group:aje6o61dvog2h6g9a33s
      ```

{% endlist %}

## Access to a resource for all users {#access-to-all}

{% include [grant-role-for-all](../../../_includes/iam/grant-role-for-all.md) %}
