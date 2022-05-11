{% include [include](../sa-assign-role-note.md) %}

In the management console, you can assign a service account a role only for the folders that are located in the same folder as the cloud where the service account was created. To assign it a role for another resource, use the CLI or API.

{% list tabs %}

- Management console

   To assign the viewer role to a service account for the folder:

   1. In the [management console]({{ link-console-main }}), open the page of the folder to assign the role for.
   1. Go to **Access bindings in folder** (the **Access bindings** button in the left panel).
   1. Switch the **Inherited roles** option to on so that the list shows service accounts that don't belong to the current folder.
   1. Click ![image](../../_assets/options.svg) next to the name of the service account.
   1. Click **Edit roles**.
   1. Click **Add role** and select the role you'd like to add.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To assign the service account a role for a resource, run:

   ```bash
   yc <service-name> <resource> add-access-binding <resource-name>|<resource-id> \
     --role <role-id> \
     --subject serviceAccount:<service-account-id>
   ```

   Where:

   * `<service-name>`: The name of the service whose resource a role is assigned for (for example, `resource-manager`).
   * `<resource>`: The resource category, for example, `cloud`.
   * `<resource-name>`: The name of the resource. You can specify a resource by its name or ID.
   * `<resource-id>`: The resource ID.
   * `<role-id>`: The role ID, for example, `{{ roles-cloud-owner }}`.
   * `<service-account-id>`: The identifier of the service account assigned the role.

   For example, to assign the `viewer` role to a service account for the `my-folder` [folder](../../resource-manager/concepts/resources-hierarchy.md#folder):

   {% include [grant-role-for-sa-to-folder-via-cli](grant-role-for-sa-to-folder-via-cli.md) %}

- API

   {% include [grant-role-for-sa-to-folder-via-api](grant-role-for-sa-to-folder-via-api.md) %}

{% endlist %}
