You can assign roles to a service account for any resources in any cloud if these resources belong to the same organization as the service account. You can also assign roles to a service account for the organization.

## Assigning a role for a resource {#binding-role-resource}

Access rights will be inherited by child resources from their parent resources. For example, if a service account is assigned a role for a cloud, the service account will be granted the appropriate permissions to all resources in all folders of this cloud.

{% list tabs %}

- Management console

   You assign roles to a service account the same way as to a user account.

   To assign a service account a role for a cloud or folder:

   1. In the [management console]({{ link-console-main }}), select the appropriate cloud or folder.
   1. Go to the **Access bindings** tab.
   1. Click **Assign roles**.
   1. In the window that opens, click ![image](../../_assets/plus.svg) **Select user** → **Service accounts**.
   1. Select the required service account from the list or use the search.
   1. Click ![image](../../_assets/plus.svg) **Add role**.
   1. Select a role in the folder.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To assign a service account a role for a cloud or folder, run this command:

   ```bash
   yc resource-manager <resource_category> add-access-binding <resource name>|<resource ID> \
     --role <role_ID> \
     --subject serviceAccount:<service_account_ID>
   ```

   Where:

   * `<resource_category>`: `Cloud` to assign a cloud role or `folder` to assign a folder role.
   * `<resource name>|<resource ID>`: Name or ID of the resource the role is assigned for.
   * `<role_ID>`: Role ID, such as `{{ roles-viewer }}`.
   * `<service_account_ID>`: ID of the service account the role is being assigned to.

   For example, to assign a service account the `{{ roles-viewer }}` role for the `my-folder` [folder](../../resource-manager/concepts/resources-hierarchy.md#folder):

   {% include [grant-role-for-sa-to-folder-via-cli](grant-role-for-sa-to-folder-via-cli.md) %}

- API

   {% include [grant-role-for-sa-to-folder-via-api](grant-role-for-sa-to-folder-via-api.md) %}

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of the resources you want to create:

      Example of the configuration file structure:

      ```
      resource "yandex_resourcemanager_folder_iam_member" "admin-account-iam" {
        folder_id   = "<folder_ID>"
        role        = "<role>"
        members     = [
                        "serviceAccount:<service_account_ID>"
                      ]
      }
      ```

      Where:
      * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md). This parameter is required.
      * `role`: Role being assigned. You can find a description of the roles in the {{ iam-full-name }} documentation, [{#T}](../../iam/concepts/access-control/roles.md). This parameter is required.
      * `members`: [ID](../../iam/operations/sa/get-id.md) of the service account the role is being assigned to. It should be specified in `serviceAccount:<service_account_ID>` format. This parameter is required.

      For more information on resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

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

      All the resources you need will then be created in the specified folder. You can verify that the resource has been created in the [management console]({{ link-console-main }}) or with the following [CLI](../../cli/quickstart.md) command:

      ```bash
      yc resource-manager folder list-access-bindings <folder name>|<folder_ID>
      ```

{% endlist %}

## Assigning a role for an organization {#binding-role-organization}

Access rights are inherited from an organization by all resources created in the organization. For example, if a service account is assigned a role for an organization, the service account will be granted the appropriate permissions to all resources in all clouds of this organization.

To grant a service account access rights to an organization, you need the `{{ roles-organization-admin }}` role or higher.

{% list tabs %}

- {{ org-name }}

   1. [Log in to an account]({{ link-passport-login }}) that belongs to an organization administrator or owner.

   1. Go to [{{ org-full-name }}]({{ link-org-main }}).

   1. In the left-hand panel, click ![icon-acl](../../_assets/organization/acl.svg) [Access bindings]({{ link-org-acl }}).

   1. Select `Service accounts` in the account type filter.

   1. If the respective service account has at least one role, select it from the list or use the search bar. In the line with the account name, click ![icon-context-menu](../../_assets/horizontal-ellipsis.svg) and select **Assign roles**.

      If the service account is not on the list, click **Assign roles** in the top-right corner. In the window that opens, click ![image](../../_assets/plus.svg) **Select user**→ **Service accounts** and select the appropriate account from the list or use the search bar.

   1. Click ![image](../../_assets/plus.svg) **Add role** and enter the role name or select one from the list.

      You can find a description of the available roles in the {{ iam-full-name }} documentation, [{#T}](../../iam/concepts/access-control/roles.md).

   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To assign a service account a role for an organization, run this command:

   ```bash
   yc organization-manager organization add-access-binding <organization_technical_name>|<organization_ID> \
     --role <role_ID> \
     --subject serviceAccount:<service_account_ID>
   ```

   Where:
   * `<organization_technical_name>`: Technical name of the organization.
   * `<organization_ID>`: ID of the organization.
   * `<role_ID>`: Role ID, such as `{{ roles-viewer }}`.
   * `<service_account_ID>`: ID of the service account the role is being assigned to.

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
      | bpf1smsil5q0cmlmb...            | hdt5j5uwsw4w3...                | MyOrg                |
      +---------------------------------+---------------------------------+----------------------+
      ```

      The organization's technical name is in the `NAME` column and its ID is in the `ID` column.

   1. Find out the service account ID by its name:

      ```bash
      yc iam service-account get my-robot
      ```

      Result:

      ```bash
      id: aje6o61dvog2h6g9a...
      folder_id: b1gvmob95yysaplct...
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
      | aje6o61dvog2h6g9a... | my-robot         | my description  |
      +----------------------+------------------+-----------------+
      ```

   1. Assign the `my-robot` service account the `{{ roles-viewer }}` role for an organization with the `bpf1smsil5q0cmlmb...` ID:

      ```bash
      yc organization-manager organization add-access-binding bpf1smsil5q0cmlmb... \
        --role viewer \
        --subject serviceAccount:aje6o61dvog2h6g9a...
      ```

- API

   To assign the service account a role for the organization, use the [updateAccessBindings](../../organization/api-ref/Organization/updateAccessBindings.md) REST API method for the [Organization](../../organization/api-ref/Organization/index.md) resource:

   1. Select the role to assign to the service account. You can find a description of the roles in the {{ iam-full-name }} documentation, [{#T}](../../iam/concepts/access-control/roles.md).
   1. [Get](../../resource-manager/operations/folder/get-id.md) the ID of the folder with service accounts.
   1. [Get](../../iam/operations/iam-token/create.md) an IAM token required for authorization in the {{ yandex-cloud }} API.
   1. Get a list of folder service accounts to find out their IDs:

      ```bash
      export FOLDER_ID=b1gvmob95yysaplct...
      export IAM_TOKEN=CggaATEVAgA...
      curl -H "Authorization: Bearer ${IAM_TOKEN}" \
        "https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=${FOLDER_ID}"
      ```

      Result:


      ```json
      {
       "serviceAccounts": [
        {
         "id": "ajebqtreob2dpblin...",
         "folderId": "b1gvmob95yysaplct...",
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
         "id": "bpfaidqca8vdopn05...",
         "createdAt": "2023-04-07T08:11:54.313033Z",
         "name": "xvdq9q22tcmla...",
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
              "id": "ajebqtreob2dpblin...",
              "type": "serviceAccount"
            }
          }
        }]
      }
      ```

   1. Assign a role to a service account. For example, for an organization with the `bpfaidqca8vdopn05...` ID:

      ```bash
      export ORGANIZATION_ID=bpfaidqca8vdopn05...
      export IAM_TOKEN=CggaATEVAgA...
      curl -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d '@body.json' \
        -X POST "https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:updateAccessBindings"
      ```

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of the resources you want to create:

      Example of the configuration file structure:

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
      * `organization_id`: [Organization ID](../../organization/org-profile.md). This parameter is required.
      * `role`: Role being assigned. You can find a description of the roles in the {{ iam-full-name }} documentation, [{#T}](../../iam/concepts/access-control/roles.md). For each role, you can only use one `yandex_organization manager_organization_iam_binding`. This parameter is required.
      * `members`: [ID](../../iam/operations/sa/get-id.md) of the service account the role is being assigned to. It should be specified in `serviceAccount:<service_account_ID>` format. This parameter is required.

      For more information on resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of the roles assigned. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

      All the resources you need will then be created in the specified organization. You can verify that the resource has been created in the [management console]({{ link-console-main }}) or with the following [CLI](../../cli/quickstart.md) command:

      ```bash
      yc organization-manager organization list-access-bindings <organization_technical_name>|<organization_ID>
      ```

{% endlist %}