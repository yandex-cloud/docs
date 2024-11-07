{% include [sa-binding-roles](sa-binding-roles.md) %}

## Assigning a role for a resource {#binding-role-resource}

Child resources inherit access permissions from their parent resources. For example, if a service account gets a role for a cloud, it will also get the required permissions for all resources across the cloud's folders.

[Learn](../../iam/concepts/access-control/resources-with-access-control.md) which resources you can assign a role for.

To assign a role for a resource:

{% list tabs group=instructions %}

- Management console {#console}

    You assign roles to a service account the same way as to a user account.
    
    To assign a service account a role for a cloud or folder:

    1. In the [management console]({{ link-console-main }}), select the cloud or folder.
    1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
    1. Click **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
    1. In the window that opens, select **{{ ui-key.yacloud_components.acl.label.service-accounts}}**.
    1. Select the service account from the list or use the search to locate it.
    1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the role from the list or use the search bar to locate it.
    1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  To assign a service account a role for a cloud or folder, run this command:

  ```bash
  yc resource-manager <resource_category> add-access-binding <resource_name_or_ID> \
    --role <role_ID> \
    --subject serviceAccount:<service_account_ID>
  ```

  Where:

  * `<resource_category>`: `cloud` to assign a role for a cloud or `folder` to assign a role for a folder.
  * `<resource_name_or_ID>`: Name or ID of the resource to assign a role for.
  * `--role`: Role ID, e.g., `{{ roles-viewer }}`.
  * `--subject serviceAccount`: ID of the service account getting the role.

  For example, to assign a service account the `{{ roles-viewer }}` role for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) named `my-folder`:

  {% include [grant-role-for-sa-to-folder-via-cli](grant-role-for-sa-to-folder-via-cli.md) %}

- {{ TF }} {#tf}

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
     * `role`: Role you want to assign. You can find the description of the roles in the {{ iam-full-name }} documentation in the [{{ yandex-cloud }} role reference](../../iam/roles-reference.md). This is a required parameter.
     * `member`: [ID](../../iam/operations/sa/get-id.md) of the service account getting the role. Use this format: `serviceAccount:<service_account_ID>`. This is a required parameter.

     For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

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

     All the resources you need will then be created in the specified folder. You can check the new resource using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc resource-manager folder list-access-bindings <folder_name_or_ID>
     ```

- API {#api}

  {% include [grant-role-for-sa-to-folder-via-api](grant-role-for-sa-to-folder-via-api.md) %}

{% endlist %}

## Assigning a role for an organization {#binding-role-organization}

Access permissions are inherited from an organization by all resources created in the organization. For example, if a service account gets a role for an organization, it will also get the required permissions for all resources across the organization's clouds.

To grant a service account permissions to access an organization, you need the `{{ roles-organization-admin }}` role or higher.

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.

  1. In the left-hand panel, select ![persons-lock](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.

  1. In the **{{ ui-key.yacloud.common.resource-acl.placeholder_filter-by-type }}** filter, select `{{ ui-key.yacloud_components.acl.label.service-accounts}}`.

  1. If the service account you need already has at least one role assigned, click ![icon-context-menu](../../_assets/console-icons/ellipsis.svg) in the row with that service account and select **{{ ui-key.yacloud_org.entity.user.action.acl }}**.

      If the service account is not on the list, click **{{ ui-key.yacloud_org.entity.user.action.acl }}** in the top-right corner. In the window that opens, go to **{{ ui-key.yacloud_components.acl.label.service-accounts}}** and select the account from the list or use the search bar to locate it.

  1. Click ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.form.acl.edit.action.role.add }}** and select the [role](../../iam/concepts/access-control/roles.md) to assign to the service account. You can assign multiple roles.

      You can find the description of the available roles in the {{ iam-full-name }} documentation in the [{{ yandex-cloud }} role reference](../../iam/roles-reference.md).

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  To assign a service account a role for an organization, run this command:

  ```bash
  yc organization-manager organization add-access-binding <organization_name_or_ID> \
    --role <role_ID> \
    --subject serviceAccount:<service_account_ID>
  ```

  Where:
  * `<organization_name_or_ID>`: Technical name or [ID](../../organization/operations/organization-get-id.md) of the organization.
  * `--role`: Role ID, e.g., `{{ roles-viewer }}`.
  * `--subject serviceAccount`: ID of the service account getting the role.

  For example, to assign a service account the `{{ roles-viewer }}` role for the `MyOrg` organization:

  1. Select the role to assign to the service account. You can find the description of the roles in the {{ iam-full-name }} documentation in the [{{ yandex-cloud }} role reference](../../iam/roles-reference.md).

  1. Get a list of available organizations to find out their IDs and technical names:

      ```bash
      yc organization-manager organization list
      ```

      Result:

      ```text
      +---------------------------------+---------------------------------+----------------------+
      |               ID                |              NAME               |        TITLE         |
      +---------------------------------+---------------------------------+----------------------+
      | bpf1smsil5q0********            | hdt5j5uw********                | MyOrg                |
      +---------------------------------+---------------------------------+----------------------+
      ```

      The organization's technical name is in the `NAME` column and its ID, in the `ID` column.

  1. Find out the service account ID by its name:

      ```bash
      yc iam service-account get my-robot
      ```

      Result:

      ```text
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

  1. Assign the `my-robot` service account the `{{ roles-viewer }}` role for the organization with the `bpf1smsil5q0********` ID:

      ```bash
      yc organization-manager organization add-access-binding bpf1smsil5q0******** \
        --role viewer \
        --subject serviceAccount:aje6o61dvog2********
      ```

- {{ TF }} {#tf}

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
     * `organization_id`: [Organization ID](../../organization/operations/organization-get-id.md). This is a required parameter.
     * `role`: Role you want to assign. You can find the description of the roles in the {{ iam-full-name }} documentation in the [{{ yandex-cloud }} role reference](../../iam/roles-reference.md). For each role, you can only use one `yandex_organization manager_organization_iam_binding` resource. This is a required parameter.
     * `members`: [ID](../../iam/operations/sa/get-id.md) of the service account getting the role. Use this format: `serviceAccount:<service_account_ID>`. This is a required parameter.

     For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

  1. Make sure the configuration files are correct.
    
     1. In the command line, go to the folder where you created the configuration file.
     1. Run a check using this command:
 
        ```
        terraform plan
        ```

     If the configuration is described correctly, the terminal will display a list of the assigned roles. If the configuration contains any errors, {{ TF }} will point them out.
 
  1. Deploy cloud resources.
  
     1. If the configuration does not contain any errors, run this command:

        ```
        terraform apply
        ```

     1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.
	 
     This will create the required resources in the specified organization. You can check the new resource using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc organization-manager organization list-access-bindings <organization_name_or_ID>
     ```

- API {#api}

  To assign the service account a role for the organization, use the [updateAccessBindings](../../organization/api-ref/Organization/updateAccessBindings.md) REST API method for the [Organization](../../organization/api-ref/Organization/index.md) resource:

  1. Select the role to assign to the service account. You can find the description of the roles in the {{ iam-full-name }} documentation in the [{{ yandex-cloud }} role reference](../../iam/roles-reference.md).
  1. [Get](../../resource-manager/operations/folder/get-id.md) the ID of the service accounts folder.
  1. [Get](../../iam/operations/iam-token/create.md) an IAM token required for authorization in the {{ yandex-cloud }} API.
  1. Get a list of folder service accounts to find out their IDs:

      ```bash
      export FOLDER_ID=b1gvmob95yys********
      export IAM_TOKEN=CggaATEVAgA...
      curl \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
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
      curl \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --request GET \
        "https://organization-manager.{{ api-host }}/organization-manager/v1/organizations"
      ```

      Result:

      ```text
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

  1. Create the request body, e.g., in the `body.json` file. Set the `action` property to `ADD` and `roleId` to the appropriate role, such as `{{ roles-viewer }}`, and specify the `serviceAccount` type and service account ID in the `subject` property:

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

  1. Assign a role to a service account. For example, assign it for the organization with the `bpfaidqca8vd********` ID:

      ```bash
      export ORGANIZATION_ID=bpfaidqca8vd********
      export IAM_TOKEN=CggaATEVAgA...
      curl \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        --request POST \
        "https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:updateAccessBindings"
      ```

{% endlist %}