Use a [service account](../iam/concepts/users/service-accounts.md) to manage the {{ yandex-cloud }} infrastructure using {{ TF }}. It will help you to flexibly configure access rights for resources.

You can also access {{ TF }} from your [Yandex account](../iam/concepts/index.md#passport),, or a [federated account](../iam/concepts/index.md#saml-federation), but this method is less secure. For more information, see the end of this section.

1. If you don't have the {{ yandex-cloud }} command line interface, [install](../cli/quickstart.md#install) it.
1. If you don't have a service account, create one:

   {% list tabs %}

   - Management console

      1. In [the management console]({{ link-console-main }}), select a folder where you wish to create a service account.
      1. In the **Service accounts** tab, click **Create service account**.
      1. Enter the name of the service account.

         Name format requirements:

         {% include [name-format](../_includes/name-format.md) %}

      1. Click **Create**.

   - CLI

      {% include [default-catalogue](../_includes/default-catalogue.md) %}

      Run the command to create a service account:

      ```bash
      yc iam service-account create --name <service_account_name>
      ```

      Where `name` is the name of the service account in the format:

      {% include [name-format](../_includes/name-format.md) %}

      Result:

      ```yaml
      id: ajehr0to1g8bh0la8c8r
      folder_id: b1gv87ssvu497lpgjh5o
      created_at: "2022-09-14T09:03:11.665153755Z"
      name: sa-terraform
      ```

   - API

      To create a service account, use the method [ServiceAccountService/Create](../iam/api-ref/grpc/service_account_service.md#Create) from the gRPC API or the [create](../iam/api-ref/ServiceAccount/create.md) method for the `ServiceAccount` resource from the REST API.

   {% endlist %}

1. Assign, to the service account, the following [roles](../iam/concepts/access-control/roles.md) needed to manage {{ yandex-cloud }} resources:

   {% include [sa-assign-role-note](../_includes/sa-assign-role-note.md) %}

   {% list tabs %}

   - Management console

      In the management console, you can only grant a service account roles to folders in the same cloud as the service account's folder and to the cloud itself. To assign it a role for another resource, use the CLI or API.

      To assign a service account a role for the folder:

      {% include [grant-role-console-sa](../_includes/grant-role-console-sa.md) %}

   - CLI

      1. Find the ID of the service account you want to assign the role to (the `ID` column):

         ```bash
         yc iam service-account list
         ```

         Result:

         ```text
         +----------------------+--------------+
         |          ID          |     NAME     |
         +----------------------+--------------+
         | aje6ij7qvdhbns1e91ut | sa-terraform |
         +----------------------+--------------+

      1. Assign the service account the role for the resource.

         ```bash
         yc <service-name> <resource> add-access-binding <resource-name>|<resource-id> \
           --role <role-id> \
           --subject serviceAccount:<service-account-id>
         ```

         Where:
         * `<service-name>`: The name of the [service](../cli/cli-ref/index.md#service-manage) whose resource the role is assigned for (for example, `resource-manager`).
         * `<resource>`: The resource category, for example, `cloud`.
         * `<resource-name>`: The name of the resource. You can specify a resource by its name or ID.
         * `<resource-id>`: The resource ID.
         * `<role-id>`: The [role](../iam/concepts/access-control/roles.md) ID, for example, `{{ roles-cloud-owner }}`.
         * `<service-account-id>`: The identifier of the service account assigned the role.

         Result:

         ```text
         done (1s)
         ```

   - API

      {% include [grant-role-for-sa-to-folder-via-api](../_includes/iam/grant-role-for-sa-to-folder-via-api.md) %}

   {% endlist %}

1. Set up the CLI profile to execute operations on behalf of the service account:

   {% list tabs %}

   - CLI

      1. Create an [authorized key](../iam/concepts/authorization/key.md) for your service account and save the file:

         ```bash
         yc iam key create \
           --service-account-id <service_account_ID> \
           --folder-name <name_of_folder_with_service_account> \
           --output key.json
         ```

         Where:
         * `service-account-id`: The ID of your service account.
         * `folder-name`: The name of the folder the service account was created in.
         * `output`: The name of the file with the authorized key.

         Result:

         ```yaml
         id: aje8nn871qo4a8bbopvb
         service_account_id: ajehr0to1g8bh0la8c8r
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
         * `service-account-key`: A file including the service account's authorized key.
         * `cloud-id`: [ID of the cloud](../resource-manager/operations/cloud/get-id.md).
         * `folder-id`: [ID of the folder](../resource-manager/operations/folder/get-id.md).

   {% endlist %}

1. Add the credentials to the environment variables:

   {% include [terraform-token-variables](../_includes/terraform-token-variables.md) %}
