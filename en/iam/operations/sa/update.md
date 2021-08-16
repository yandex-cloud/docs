# Updating a service account

You can edit the description of a [service account](../../concepts/users/service-accounts.md) via the CLI or API. For now, the management console only allows you to change the name of a service account.

You can use the management console to immediately add or remove [roles](../../concepts/access-control/roles.md) of a service account for the folder it belongs to. To assign the service account a role for another resource, use the CLI or API by following the instructions in [{#T}](assign-role-for-sa.md).

{% list tabs %}

- Management console
  1. Go to the folder that the service account belongs to.
  2. Go to the **Service accounts** tab.
  3. Click ![image](../../../_assets/options.svg) next to the service account and select **Edit service account**.
  4. Change the name of your service account.
  5. Add or remove roles assigned to the service account. The roles will be assigned for the folder where the service account was created.
  6. Click **Save**.

- CLI

  1. See the description of the update service account command:

      ```
      $ yc iam service-account update --help
      ```

  2. Select a service account (for example, `my-robot`):

      ```
      $ yc iam service-account list
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2h6g9a33s | my-robot         |                               |
      | aje9sda1ufvqcmfksd3f | blabla           | bla bla bla is my description |
      +----------------------+------------------+-------------------------------+
      ```

  3. Change the service account parameters, such as name and description:

      ```
      yc iam service-account update my-robot \
          --new-name my-service-account \
          --description "this is my service account"
      ```

      {% include [name-format](../../../_includes/name-format.md) %}

- API

  To update the service account, use the [update](../../api-ref/ServiceAccount/update.md) method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource.

{% endlist %}

