# Configuring access rights to secrets

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ lockbox-short-name }}**.
   1. Click the name of the desired secret.
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

   1. Assign the role to a secret for a user or a [service account](../../iam/concepts/users/service-accounts.md):
      * For a user:

         ```bash
         yc lockbox secret add-access-binding \
           --id <secret_ID> \
           --user-account-id <user_ID> \
           --role <role>
         ```

         Where:
         * `id`: Secret ID.
         * `user-account-id`: [User id](../../iam/operations/users/get.md).
         * `role`: The [role](../security/index.md#roles-list) assigned.

      * For a service account:

         ```bash
         yc lockbox secret add-access-binding \
           --id <secret_ID> \
           --service-account-id <service_account_ID> \
           --role <role>
         ```

         Where:
         * `id`: Secret ID.
         * `service-account-id`: [The ID of your service account](../../iam/operations/sa/get-id.md).
         * `role`: The [role](../security/index.md#roles-list) assigned.

{% endlist %}

{% note info %}

You can also [assign](../../iam/operations/roles/grant.md) the role for a resource from which access rights are inherited, for example, for a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) or [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) to a group, user, or service account.

{% endnote %}

#### See also {#see-also}

* [{#T}](../../iam/concepts/access-control/index.md)
* [{#T}](../security/index.md)
