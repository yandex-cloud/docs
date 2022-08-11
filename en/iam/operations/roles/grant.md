# Assigning roles

To provide access to a resource, assign the subject a [role](../../concepts/access-control/roles.md) to the resource itself or a resource from which access privileges are inherited, such as a folder or a cloud. For more information, see [{#T}](../../concepts/access-control/index.md).

{% if product == "yandex-cloud" %}

## Assigning a role to a user with a Yandex account {#access-to-user}

This section describes how to assign a role to a user with a Yandex account. The examples below show how to assign a role to a [service account](#access-to-sa), [federated user](#access-to-federated-user), or [all users at once](#access-to-all).

{% endif %}

{% if product == "cloud-il" %}

### Resource access for a federated user {#access-to-federated-user}

In the management console, you can assign a [federated user](../../../organization/add-federation.md) a role for an individual cloud or folder.

{% endif %}

{% list tabs %}

- Management console

   In the management console, you can only assign a role for a cloud or folder:

{% if product == "yandex-cloud" %}

    1. Add the user to a cloud via the [management console](../users/create.md#console-user) or [{{ org-full-name }}](../users/create.md#organization-user).

{% endif %}
    1. Assign the user a role in the cloud:

        1. In the [management console]({{ link-console-main }}), [select](../../../resource-manager/operations/cloud/switch-cloud.md) a cloud.
        1. Click the **Access bindings** tab.
        1. Enable the **Inherited roles** option to display users added to the organization.
        1. Select a user from the list and click ![image](../../../_assets/options.svg) next to the username.
        1. Click **Edit roles**.
        1. In the cloud's **Configure access rights** window, click **Add role**.
        1. Select a role in the cloud.
        1. Click **Save**.

    1. Assign the user a role in the folder:

        1. In the [management console]({{ link-console-main }}), go to the desired folder.
        1. Click the **Access bindings** tab.
        1. Click **Assign roles**.
        1. In the **Configure access bindings** window, click **Select user**.
        1. Select a user from the list or search for a user.
        1. Click **Add role**.
        1. Select a role in the folder.
        1. Click **Save**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. Choose a role from the list in [Roles](../../concepts/access-control/roles.md).
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

        For example, assign the `viewer` role for the [cloud](../../../resource-manager/concepts/resources-hierarchy.md#folder) `mycloud`:
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

   1. Choose a role from the list in [Roles](../../concepts/access-control/roles.md).
   1. [Get the user ID](../users/get.md).
   1. Create a request body, for example, in a `body.json` file. Set the `action` property to `ADD` and specify the `userAccount` type and user ID in the `subject` property:
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
   1. {% include [grant-role-folder-via-curl-step](../../../_includes/iam/grant-role-folder-via-curl-step.md) %}

      You can view detailed instructions for assigning roles for the relevant resource:
      * [{#T}](../sa/set-access-bindings.md).
      * [{#T}](../../../resource-manager/operations/cloud/set-access-bindings.md).
      * [{#T}](../../../resource-manager/operations/folder/set-access-bindings.md).

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Add the resource parameters to the configuration file, specify the required role and a list of cloud users:

      * `cloud_id`: Cloud ID. You can also assign a role in an individual folder. To do this, specify `folder_id` instead of `cloud_id` and the required folder ID in the resource parameters.
      * `role`: The role assigned. Required parameter.
      * `members`: List of users or service account the role is being assigned to. Specified in the following format: {% if product == "yandex-cloud" %}`userAccount:<user ID>`{% endif %}{% if product == "cloud-il" %}`federatedUser:<user ID>`{% endif %} or `serviceAccount:<service account ID>`. Required parameter.
{% if product == "yandex-cloud" %}

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

{% endif %}
{% if product == "cloud-il" %}

      ```
      resource "yandex_resourcemanager_cloud_iam_binding" "admin" {
          cloud_id    = "<cloud ID>"
          role        = "<role>"
          members     = [
          "serviceAccount:<service account ID>",
          "federatedUser:<user ID>",
          ]
      }
      ```

{% endif %}

        For more information about the parameters of the `yandex_resourcemanager_cloud_iam_binding` resource, see the [provider documentation]({{ tf-provider-link }}/iam_service_account_iam_binding).

    1. Make sure that the configuration files are correct.

        1. In the command line, go to the directory where you created the configuration file.
        1. Run the check using the command:

          ```
          terraform plan
          ```

        If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

    1. Deploy the cloud resources.

        1. If there are no errors in the configuration, run the terraform apply command

           ```
           terraform apply
           ```

        1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

       Afterwards, all the necessary resources are created in the specified folder. You can verify that the resource has been created in the [management console]({{ link-console-main }}) or with the following [CLI](../../../cli/quickstart.md) command:

       ```
       yc resource-manager folder list-access-bindings <folder name>|<folder ID>
       ```

{% endlist %}

## Examples {#examples}

* [{#T}](#multiple-roles).
* [{#T}](#access-to-sa).
* [{#T}](#access-to-federated-user).
* [{#T}](#access-to-all).

### Assign multiple roles {#multiple-roles}

{% list tabs %}

- Management console

   Follow the instructions at the [beginning of the section](#access-to-user) and assign the user multiple roles.

    To assign a role to another user, repeat all the steps in the instructions.

- CLI

    The `add-access-binding` command allows you to add only one role. You can assign multiple roles using the `set-access-binding` command.

    {% note alert %}

    The `set-access-binding` command completely rewrites the access rights to the resource. All current resource roles will be deleted.

    {% endnote %}

    For example, to assign multiple roles for a folder:

    1. Make sure the resource doesn't have any roles that you don't want to lose:

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

        {% include [grant-role-folder-via-curl](../../../_includes/iam/grant-role-folder-via-curl.md) %}

        You can also assign roles using the `setAccessBindings`.

        {% note alert %}

        The `setAccessBindings` method completely rewrites the access rights to the resource! All current resource roles will be deleted.

        {% endnote %}

   1. List new access bindings in the request body.
{% if product == "yandex-cloud" %}

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

{% endif %}
{% if product == "cloud-il" %}

        **body.json:**
        ```json
        {
            "accessBindings": [{
                "roleId": "editor",
                "subject": { "id": "ajei8n54hmfhuk5nog0g", "type": "federatedUser" }
            },{
                "roleId": "viewer",
                "subject": { "id": "helj89sfj80aj24nugsz", "type": "federatedUser" }
            }]
        }
        ```

{% endif %}
   1. Assign roles:

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


### Resource access for a service account {#access-to-sa}

{% include [grant-role-for-sa](../../../_includes/iam/grant-role-for-sa.md) %}

{% if product == "yandex-cloud" %}

### Resource access for a federated user {#access-to-federated-user}

In the management console, you can assign a [federated user](../../../organization/add-federation.md) a role for an individual cloud or folder.

{% list tabs %}

- Management console

    The role assignment procedure is the same as for a user with a Yandex account. The user's federation name is shown next to the username.

    In the management console, you can only assign a role for a cloud or folder:

    1. Assign the user a role in the cloud:
        1. In the [management console]({{ link-console-main }}), [select](../../../resource-manager/operations/cloud/switch-cloud.md) a cloud.
        1. Click the **Access bindings** tab.
        1. Enable the **Inherited roles** option to display the users added to the organization.
        1. Select a user from the list and click ![image](../../../_assets/options.svg) next to the username.
        1. Click **Edit roles**.
        1. In the **Configure access bindings** window, click **Add role**.
        1. Select a role in the cloud.
        1. Click **Save**.

    1. Assign the user a role in the folder:
        1. In the [management console]({{ link-console-main }}), go to the desired folder.
        1. Click the **Access bindings** tab.
        1. Enable the **Inherited roles** option to display the users added to the organization.
        1. Click **Assign roles**.
        1. In the **Configure access bindings** window, click **Select user**.
        1. Select a user from the list or search for a user.
        1. Click **Add role**.
        1. Select a role in the folder.
        1. Click **Save**.

- CLI

    1. Choose a role from the list in [Roles](../../concepts/access-control/roles.md).
    1. [Get the user ID](../users/get.md).
    1. Assign the role using the command:

        ```bash
        yc <service-name> <resource> add-access-binding <resource-name>|<resource-id> \
            --role <role-id> \
            --subject federatedUser:<federated-user-id>
        ```

        Where:

        * `<service-name>`: The name of the service whose resource a role is assigned for (for example, `resource-manager`).
        * `<resource>`: The resource category, for example, `cloud`.
        * `<resource-name>`: The name of the resource. You can specify a resource by its name or ID.
        * `<resource-id>`: The resource ID.
        * `<role-id>`: The role ID, for example, `{{ roles-cloud-owner }}`.
        * `<federated-user-id>`: The ID of the user account assigned the role.

        For example, assign the `viewer` role for the `mycloud` [cloud](../../../resource-manager/concepts/resources-hierarchy.md#folder):

        ```bash
        yc resource-manager cloud add-access-binding mycloud \
            --role viewer \
            --subject federatedUser:aje6o61dvog2h6g9a33s
        ```

- API

   1. Assign the user a role in the cloud:
      1. In the [management console]({{ link-console-main }}), [select](../../../resource-manager/operations/cloud/switch-cloud.md) the cloud.
      1. Go to the **Access rights** tab.
      1. Enable the **Inherited roles** option to display the users added to the organization.
      1. Select a user from the list and click ![image](../../../_assets/options.svg) next to the username.
      1. Click **Edit roles**.
      1. In the **Configure access rights** window, click **Add role**.
      1. Select a role in the cloud.
      1. Click **Save**.

   1. Assign the user a role in the folder:

      {% include [set-access-binding](../../../_includes/resource-manager/set-access-binding-user-acc-abstract-console.md) %}

- CLI

   1. Choose a role from the list in [Roles](../../concepts/access-control/roles.md).
   1. [Get the user ID](../users/get.md).
   1. Assign the role using the command:

      ```bash
      yc <service-name> <resource> add-access-binding <resource-name>|<resource-id> \
          --role <role-id> \
          --subject federatedUser:<federated-user-id>
      ```

      Where:

      * `<service-name>`: The name of the service whose resource a role is assigned for (for example, `resource-manager`).
      * `<resource>`: The resource category, for example, `cloud`.
      * `<resource-name>`: The name of the resource. You can specify a resource by its name or ID.
      * `<resource-id>`: The resource ID.
      * `<role-id>`: The role ID, for example, `{{ roles-cloud-owner }}`.
      * `<federated-user-id>`: ID of user account assigned the role.

      For example, assign the `viewer` role for the `mycloud` [cloud](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc resource-manager cloud add-access-binding mycloud \
          --role viewer \
          --subject federatedUser:aje6o61dvog2h6g9a33s
      ```

- API

   Use the `updateAccessBindings` method for the corresponding resource.

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

{% endif %}

### Access to a resource for all users {#access-to-all}

{% include [grant-role-for-all](../../../_includes/iam/grant-role-for-all.md) %}
