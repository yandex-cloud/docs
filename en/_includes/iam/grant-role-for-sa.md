You can assign roles to a service account for any resources in any cloud if these resources belong to the same organization as the service account. You can also assign roles to a service account for the organization.

## Assigning a role for a resource {#binding-role-resource}

Access rights will be inherited by child resources from their parent resources. For example, if a service account is assigned a role for a cloud, the service account will be granted the appropriate permissions to all resources in all folders of this cloud.

{% list tabs %}

- Management console

   You assign roles to a service account the same way as to a user account.

   To assign a service account a role for a cloud or folder:

   1. In the [management console]({{ link-console-main }}), select the appropriate cloud or folder.
   1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
   1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
   1. In the window that opens, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.select-subject }}** → **{{ ui-key.yacloud.common.resource-acl.label_service-accounts }}**.
   1. Select the required service account from the list or use the search.
   1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}**.
   1. Select a role in the folder.
   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To assign a service account a role for a cloud or folder, run this command:

   ```bash
   yc resource-manager <resource_category> add-access-binding <resource_name_or_ID> \
     --role <role_ID> \
     --subject serviceAccount:<service_account_ID>
   ```

   Where:

   * `<resource_category>`: `Cloud` to assign a cloud role, or `folder` to assign a folder role.
   * `<resource_name_or_ID>`: Name or ID of the resource the role is assigned for.
   * `--role`: Role ID, e.g., `{{ roles-viewer }}`.
   * `--subject serviceAccount`: ID of the service account which is being assigned the role.

   For example, to assign a service account the `{{ roles-viewer }}` role for the `my-folder` [folder](../../resource-manager/concepts/resources-hierarchy.md#folder):

   {% include [grant-role-for-sa-to-folder-via-cli](grant-role-for-sa-to-folder-via-cli.md) %}

- API

   {% include [grant-role-for-sa-to-folder-via-api](grant-role-for-sa-to-folder-via-api.md) %}

- {{ TF }}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the parameters of the resources you want to create:

      Here is an example of the configuration file structure:

      ```
      resource "yandex_resourcemanager_folder_iam_member" "admin-account-iam" {
        folder_id   = "<folder_ID>"
        role        = "<role>"
        member      = "serviceAccount:<service_account_ID>"
      }
      ```

      Where:
      * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md). This is a required parameter.
      * `role`: Role being assigned. You can find a description of the roles in the {{ iam-full-name }} documentation, [{#T}](../../iam/concepts/access-control/roles.md). This is a required parameter.
      * `member`: [ID](../../iam/operations/sa/get-id.md) of the service account the role is assigned to. It should be specified in `serviceAccount:<service_account_ID>` format. This is a required parameter.

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```
         terraform plan
         ```

      If the configuration is specified correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

      All the resources you need will then be created in the specified folder. You can check the new resource using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc resource-manager folder list-access-bindings <folder_name_or_ID>
      ```

{% endlist %}

## Assigning a role for an organization {#binding-role-organization}

Access rights are inherited from an organization by all resources created in the organization. For example, if a service account is assigned a role for an organization, the service account will be granted the appropriate permissions to all resources in all clouds of this organization.

To grant a service account access rights to an organization, you need the `{{ roles-organization-admin }}` role or higher.

{% list tabs %}

- {{ org-name }}

   1. [Log in]({{ link-passport-login }}) as the organization administrator or owner.

   1. Go to [{{ org-full-name }}]({{ link-org-main }}).

   1. In the left-hand panel, click ![icon-acl](../../_assets/console-icons/shield.svg) [**{{ ui-key.yacloud_org.pages.acl }}**]({{ link-org-acl }}).

   1. Select `{{ ui-key.yacloud.common.resource-acl.label_service-accounts }}` in the account type filter.

   1. If the respective service account has at least one role, select it from the list or use the search bar. In the line with the account name, click ![icon-context-menu](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.entity.user.action.acl }}**.

      If the service account is not on the list, click **{{ ui-key.yacloud_org.entity.user.action.acl }}** in the top-right corner. In the window that opens, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.select-subject }}** → **{{ ui-key.yacloud.common.resource-acl.label_service-accounts }}** and select the appropriate account from the list or use the search bar.

   1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and enter the role name or select one from the list.

      You can find a description of the available roles in the {{ iam-full-name }} documentation, [{#T}](../../iam/concepts/access-control/roles.md).

   1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To assign a service account a role for an organization, run this command:

   ```bash
   yc organization-manager organization add-access-binding <organization_name_or_ID> \
     --role <role_ID> \
     --subject serviceAccount:<service_account_ID>
   ```

   Where:
   * `<organization_name_or_ID>`: Technical name or ID of the organization.
   * `--role`: Role ID, e.g., `{{ roles-viewer }}`.
   * `--subject serviceAccount`: ID of the service account which is being assigned the role.

   For example, to assign a service account the `{{ roles-viewer }}` role for the `MyOrg` organization:

   1. Select the role to assign to the service account. You can find a description of the roles in the {{ iam-full-name }} documentation, [{#T}](../../iam/concepts/access-control/roles.md).

   1. Get a list of available organizations to find out their IDs and technical names:

      ```bash
      yc organization-manager organization list
      ```

      Result:

      ```bash
      +---------------------------------+---------------------------------+----------------------+
      |               ID                |              NAME               |        TITLE         |
      +---------------------------------+---------------------------------+----------------------+
      | bpf1smsil5q0********            | hdt5j5uw********                | MyOrg                |
      +---------------------------------+---------------------------------+----------------------+
      ```

      The organization's technical name is in the `NAME` column and its ID is in the `ID` column.

   1. Find out the service account ID by its name:

      ```bash
      yc iam service-account get my-robot
      ```

      Result:

      ```bash
      id: aje6o61dvog2********
      folder_id: b1gvmob95yys********
      created_at: "2018-10-15T18:01:25Z"
      name: my-robot
      ```

      If you do not know the name of the service account, get a complete list of service accounts with their IDs:

      ```bash
      yc iam service-account list
      ```

      Result:

      ```bash
      +----------------------+------------------+-----------------+
      |          ID          |       NAME       |   DESCRIPTION   |
      +----------------------+------------------+-----------------+
      | aje6o61dvog2******** | my-robot         | my description  |
      +----------------------+------------------+-----------------+
      ```

   1. Assign the `my-robot` service account the `{{ roles-viewer }}` role for an organization with the `bpf1smsil5q0********` ID:

      ```bash
      yc organization-manager organization add-access-binding bpf1smsil5q0******** \
        --role viewer \
        --subject serviceAccount:aje6o61dvog2********
      ```

- API

   To assign the service account a role for the organization, use the [updateAccessBindings](../../organization/api-ref/Organization/updateAccessBindings.md) REST API method for the [Organization](../../organization/api-ref/Organization/index.md) resource:

   1. Select the role to assign to the service account. You can find a description of the roles in the {{ iam-full-name }} documentation, [{#T}](../../iam/concepts/access-control/roles.md).
   1. [Get](../../resource-manager/operations/folder/get-id.md) the ID of the folder with service accounts.
   1. [Get](../../iam/operations/iam-token/create.md) an IAM token for authorization in the {{ yandex-cloud }} API.
   1. Get a list of folder service accounts to find out their IDs:

      ```bash
      export FOLDER_ID=b1gvmob95yys********
      export IAM_TOKEN=CggaATEVAgA...
      curl -H "Authorization: Bearer ${IAM_TOKEN}" \
        "https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=${FOLDER_ID}"
      ```

      Result:


      ```json
      {
       "serviceAccounts": [
        {
         "id": "ajebqtreob2d********",
         "folderId": "b1gvmob95yys********",
         "createdAt": "2018-10-18T13:42:40Z",
         "name": "my-robot",
         "description": "my description"
        }
       ]
      }
      ```

   1. Get a list of organizations to find out their IDs:

      ```bash
      export IAM_TOKEN=CggaATEVAgA...
      curl -H "Authorization: Bearer ${IAM_TOKEN}" \
        -X GET "https://organization-manager.{{ api-host }}/organization-manager/v1/organizations"
      ```

      Result:

      ```bash
      {
       "organizations": [
        {
         "id": "bpfaidqca8vd********",
         "createdAt": "2023-04-07T08:11:54.313033Z",
         "name": "xvdq9q22********",
         "title": "MyOrg"
        }
       ]
      }
      ```

   1. Create a request body, for example, in a `body.json` file. Set the `action` property to `ADD` and the `roleId` property to the appropriate role, such as `{{ roles-viewer }}`, and specify the `serviceAccount` type and service account ID in the `subject` property:

      **body.json:**

      ```json
      {
        "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
            "roleId": "viewer",
            "subject": {
              "id": "ajebqtreob2d********",
              "type": "serviceAccount"
            }
          }
        }]
      }
      ```

   1. Assign a role to a service account. For example, for an organization with the `bpfaidqca8vd********` ID:

      ```bash
      export ORGANIZATION_ID=bpfaidqca8vd********
      export IAM_TOKEN=CggaATEVAgA...
      curl -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d '@body.json' \
        -X POST "https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:updateAccessBindings"
      ```

- {{ TF }}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the parameters of the resources you want to create:

      Here is an example of the configuration file structure:

      ```
      resource "yandex_organizationmanager_organization_iam_binding" "editor" {
        organization_id   = "<organization_ID>"
        role              = "<role>"
        members           = [
                              "serviceAccount:<service_account_ID>",
                            ]
      }
      ```

      Where:
      * `organization_id`: [Organization ID](../../organization/operations/org-profile.md). This is a required parameter.
      * `role`: Role being assigned. You can find a description of the roles in the {{ iam-full-name }} documentation, [{#T}](../../iam/concepts/access-control/roles.md). For each role, you can only use one `yandex_organization manager_organization_iam_binding`. This is a required parameter.
      * `members`: [ID](../../iam/operations/sa/get-id.md) of the service account the role is being assigned to. It should be specified in `serviceAccount:<service_account_ID>` format. This is a required parameter.

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of the roles assigned. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

      All the resources you need will then be created in the specified organization. You can check the new resource using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

      ```bash
      yc organization-manager organization list-access-bindings <organization_name_or_ID>
      ```

{% endlist %}