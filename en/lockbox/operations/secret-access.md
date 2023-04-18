# Configuring access rights to secrets

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ lockbox-short-name }}**.
   1. Click the name of the secret you need.
   1. On the left-hand panel, select ![image](../../_assets/organization/icon-groups.svg) **Access rights** and click **Assign roles**.
   1. In the window that opens, click ![image](../../_assets/plus-sign.svg) **Select user**.
   1. Select the group, user, or [service account](../../iam/concepts/users/service-accounts.md) to grant access to a secret to.
   1. Click ![image](../../_assets/plus-sign.svg) **Add role** and select the required [roles](../security/index.md#roles-list).
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Get the secret ID (the `ID` column in the command output):

      ```bash
      yc lockbox secret list
      ```

      Result:

      ```bash
      +----------------------+-------------+------------+---------------------+----------------------+--------+
      |          ID          |    NAME     | KMS KEY ID |     CREATED AT      |  CURRENT VERSION ID  | STATUS |
      +----------------------+-------------+------------+---------------------+----------------------+--------+
      | e6qtoqv06f1bbjs38sqc | test-secret |            | 2022-09-12 08:10:11 | e6qtpq6a9k7qskiruuq4 | ACTIVE |
      +----------------------+-------------+------------+---------------------+----------------------+--------+
      ```

   1. To assign a role for a secret:

      * To a user:

         ```bash
         yc lockbox secret add-access-binding \
           --id <secret_ID> \
           --user-account-id <user_ID> \
           --role <role>
         ```

         Where:
         * `id`: Secret ID.
         * `user-account-id`: [User ID](../../iam/operations/users/get.md).
         * `role`: [Role](../security/index.md#roles-list) being assigned.

      * To a [service account](../../iam/concepts/users/service-accounts.md):

         ```bash
         yc lockbox secret add-access-binding \
           --id <secret_ID> \
           --service-account-id <service_account_ID> \
           --role <role>
         ```

         Where:
         * `id`: Secret ID.
         * `service-account-id`: [ID of your service account](../../iam/operations/sa/get-id.md).
         * `role`: [Role](../security/index.md#roles-list) being assigned.

- API

   To configure access rights to a secret, use the [setAccessBindings](../api-ref/Secret/setAccessBindings.md) REST API method for the [Secret](../api-ref/Secret/index.md) resource or the [SecretService/SetAccessBindings](../api-ref/grpc/secret_service.md#SetAccessBindings) gRPC API call.

{% endlist %}

{% note warning %}

If you [assign](../../iam/operations/roles/grant.md) a group, user, or service account a role for a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) or [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) where the secret is stored, all permissions of this role will also apply to the secret.

For more information, see [How access management works](../../iam/concepts/access-control/#inheritance).

{% endnote %}

#### See also {#see-also}

* [{#T}](../../iam/concepts/access-control/index.md)
* [{#T}](../security/index.md)
