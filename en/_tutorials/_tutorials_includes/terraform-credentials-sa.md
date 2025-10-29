Use a [service account](../../iam/concepts/users/service-accounts.md) to manage the {{ yandex-cloud }} infrastructure using {{ TF }}. It will help you flexibly configure access permissions to resources.

You can also use {{ TF }} under your [Yandex account](../../iam/concepts/users/accounts.md#passport) or a [federated account](../../iam/concepts/users/accounts.md#saml-federation), but this method is less secure. For more information, see the end of this section.
1. If you do not have the {{ yandex-cloud }} CLI yet, [install it](../../cli/quickstart.md#install).
1. If you do not have a service account, create one:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your service account.
     1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
     1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
     1. Enter a name for the service account.

        Follow these naming requirements:

        {% include [name-format](../../_includes/name-format.md) %}

     1. Click **Create**.

   - CLI {#cli}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     Run the following command to create a service account:

     ```bash
     yc iam service-account create --name <service_account_name>
     ```

     Where `name` is the service account name in the following format:

     {% include [name-format](../../_includes/name-format.md) %}

     Result:

     ```text
     id: ajehr0to1g8b********
     folder_id: b1gv87ssvu49********
     created_at: "2022-09-14T09:03:11.665153755Z"
     name: sa-terraform
     ```

   - API {#api}

     To create a service account, use the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call or the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the `ServiceAccount` resource.

    {% endlist %}

1. Assign, to the service account, the following [roles](../../iam/concepts/access-control/roles.md) needed to manage {{ yandex-cloud }} resources:

   {% include [sa-assign-role-note](../../_includes/sa-assign-role-note.md) %}

   {% list tabs group=instructions %}

   - Management console {#console}

     To assign a role for a folder to a service account:

     {% include [grant-role-console-sa](../../_includes/grant-role-console-sa.md) %}

   - CLI {#cli}

     1. Find out the ID of the service account (the `ID` column) you want to assign the role to:

        ```bash
        yc iam service-account list
        ```

        Result:

        ```text
        +----------------------+--------------+--------+---------------------+-----------------------+
        |          ID          |     NAME     | LABELS |     CREATED AT      | LAST AUTHENTICATED AT |
        +----------------------+--------------+--------+---------------------+-----------------------+
        | ajeg2b2et02f******** | terraform-sa |        | 2024-09-08 18:59:45 | 2025-08-21 06:40:00   |
        | ajegtlf2q28a******** | default-sa   |        | 2023-06-27 16:18:18 | 2025-08-21 06:30:00   |
        +----------------------+--------------+--------+---------------------+-----------------------+
        ```

     1. Assign the role for the resource to the service account:

        ```bash
        yc <service-name> <resource> add-access-binding <resource-name>|<resource-id> \
          --role <role-id> \
          --subject serviceAccount:<service-account-id>
        ```

        Where:
        * `<service-name>`: Name of the [service](../../cli/cli-ref/index.md#service-manage) for whose resource you want to assign the role, e.g., `resource-manager`.
        * `<resource>`: Resource category, e.g., `cloud` to assign a role for the entire [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), or `folder` to assign a role for a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
        * `<resource-name>`: Resource name. You can specify a resource by its name or ID (cloud or folder name).
        * `<resource-id>`: Resource ID (cloud or folder ID).
        * `<role-id>`: Role being assigned, e.g., `{{ roles-cloud-owner }}`.
        * `<service-account-id>`: ID of the service account the role is assigned to.

        >Here is an example:
        > 
        >```bash
        >yc resource-manager folder add-access-binding **********9n9hi2qu --role editor --subject serviceAccount:**********qhi2qu
        >```
        >
        >Result:
        >
        >```text
        >done (1s)
        >```

   - API {#api}

     {% include [grant-role-for-sa-to-folder-via-api](../../_includes/iam/grant-role-for-sa-to-folder-via-api.md) %}

   {% endlist %}

1. Add your credentials to the environment variables. When creating an [IAM token](../../iam/concepts/authorization/iam-token.md), use the [impersonation](../../iam/concepts/access-control/impersonation.md) of the service account you created earlier, specifying its ID in the `--impersonate-service-account-id` parameter:

    {% include [impersonation-role-notice](../../_includes/cli/impersonation-role-notice.md) %}

    {% list tabs group=programming_language %}

    - Bash {#bash}

      ```bash
      export YC_TOKEN=$(yc iam create-token --impersonate-service-account-id <service_account_ID>)
      export YC_CLOUD_ID=$(yc config get cloud-id)
      export YC_FOLDER_ID=$(yc config get folder-id)
      ```

      Where:
      * `YC_TOKEN`: Service account [IAM token](../../iam/concepts/authorization/iam-token.md).
      * `YC_CLOUD_ID`: Cloud ID.
      * `YC_FOLDER_ID`: Folder ID.

    - PowerShell {#powershell}

      ```powershell
      $Env:YC_TOKEN=$(yc iam create-token --impersonate-service-account-id <service_account_ID>)
      $Env:YC_CLOUD_ID=$(yc config get cloud-id)
      $Env:YC_FOLDER_ID=$(yc config get folder-id)
      ```

      Where:
      * `YC_TOKEN`: Service account [IAM token](../../iam/concepts/authorization/iam-token.md).
      * `YC_CLOUD_ID`: Cloud ID.
      * `YC_FOLDER_ID`: Folder ID.

    {% endlist %}

    {% note info %}

    {% include [iam-token-lifetime](../../_includes/iam-token-lifetime.md) %}

    {% endnote %}
