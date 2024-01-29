Use a [service account](../iam/concepts/users/service-accounts.md) to manage the {{ yandex-cloud }} infrastructure using {{ TF }}. It will help you to flexibly configure access rights for resources.

You can also access {{ TF }} from your [Yandex account](../iam/concepts/index.md#passport),, or a [federated account](../iam/concepts/index.md#saml-federation), but this method is less secure. For more information, see the end of this section.

1. If you do not have the {{ yandex-cloud }} command line interface, [install](../cli/quickstart.md#install) it.
1. If you do not have a service account, create one:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select a folder where you want to create a service account.
      1. In the **Service accounts** tab, click **Create service account**.
      1. Enter a name for the service account.

         The name format requirements are as follows:

         {% include [name-format](../_includes/name-format.md) %}

      1. Click **Create**.

   - CLI {#cli}

      {% include [default-catalogue](../_includes/default-catalogue.md) %}

      Run the command to create a service account:

      ```bash
      yc iam service-account create --name <service_account_name>
      ```

      Where `name` is the name of the service account in the following format:

      {% include [name-format](../_includes/name-format.md) %}

      Result:

      ```yaml
      id: ajehr0to1g8b********
      folder_id: b1gv87ssvu49********
      created_at: "2022-09-14T09:03:11.665153755Z"
      name: sa-terraform
      ```

   - API {#api}

      To create a service account, use the method [ServiceAccountService/Create](../iam/api-ref/grpc/service_account_service.md#Create) from the gRPC API or the [create](../iam/api-ref/ServiceAccount/create.md) method for the `ServiceAccount` resource from the REST API.

   {% endlist %}

1. Assign, to the service account, the following [roles](../iam/concepts/access-control/roles.md) needed to manage {{ yandex-cloud }} resources:

   {% include [sa-assign-role-note](../_includes/sa-assign-role-note.md) %}

   {% list tabs group=instructions %}

   - Management console {#console}

      To assign a service account a role for the folder:

      {% include [grant-role-console-sa](../_includes/grant-role-console-sa.md) %}

   - CLI {#cli}

      1. Find the ID of the service account you want to assign the role to (the `ID` column):

         ```bash
         yc iam service-account list
         ```

         Result:

         ```text
         +----------------------+--------------+
         |          ID          |     NAME     |
         +----------------------+--------------+
         | aje6ij7qvdhb******** | sa-terraform |
         +----------------------+--------------+
         ```

      1. Assign the service account the role for the resource.

         ```bash
         yc <service-name> <resource> add-access-binding <resource-name>|<resource-id> \
           --role <role-id> \
           --subject serviceAccount:<service-account-id>
         ```

         Where:

         * `<service-name>`: Name of the [service](../cli/cli-ref/index.md#service-manage) for whose resource you want to assign the role, e.g., `resource-manager`.
         * `<resource>`: Resource category, e.g., `cloud` to assign a role for the entire cloud or `folder` to assign a role for a directory.
         * `<resource-name>`: Name of the resource. You can specify a resource by its name or ID (cloud or directory name).
         * `<resource-id>`: Resource ID (cloud or directory ID).
         * `<role-id>`: Assigned [role](../iam/concepts/access-control/roles.md), e.g., `{{ roles-cloud-owner }}`.
         * `<service-account-id>`: ID of the service account the role is assigned to.

         For example:
         ```sh
         yc resource-manager folder add-access-binding **********9n9hi2qu --role editor --subject serviceAccount:**********qhi2qu
         ```

         Result:

         ```text
         done (1s)
         ```

   - API {#api}

      {% include [grant-role-for-sa-to-folder-via-api](../_includes/iam/grant-role-for-sa-to-folder-via-api.md) %}

   {% endlist %}

1. Set up the CLI profile to execute operations on behalf of the service account:

   {% list tabs group=instructions %}

   - CLI {#cli}

      1. Create an [authorized key](../iam/concepts/authorization/key.md) for your service account and save the file:

         ```bash
         yc iam key create \
           --service-account-id <service_account_ID> \
           --folder-name <name_of_folder_with_service_account> \
           --output key.json
         ```

         Where:
         * `service-account-id`: ID of your service account.
         * `folder-name`: Name of the folder the service account was created in.
         * `output`: Name of the file with the authorized key.

         Result:

         ```yaml
         id: aje8nn871qo4********
         service_account_id: ajehr0to1g8********
         created_at: "2022-09-14T09:11:43.479156798Z"
         key_algorithm: RSA_2048
         ```

      1. Set up the CLI profile to execute operations on behalf of the service account. Name the profile:

         ```bash
         yc config profile create <profile_name>
         ```

         Result:

         ```text
         Profile 'sa-terraform' created and activated
         ```

      1. Set the profile configuration:

         ```bash
         yc config set service-account-key key.json
         yc config set cloud-id <cloud_ID>
         yc config set folder-id <folder_ID>
         ```

         Where:
         * `service-account-key`: File with the authorized key of the service account.
         * `cloud-id`: [Cloud ID](../resource-manager/operations/cloud/get-id.md).
         * `folder-id`: [Folder ID](../resource-manager/operations/folder/get-id.md).

   {% endlist %}

1. Add the credentials to the environment variables:

   {% include [terraform-token-variables](../_includes/terraform-token-variables.md) %}
