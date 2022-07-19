# Revoke a role for a resource

If you wish to deny a [subject](../../concepts/access-control/index.md#subject) access to a resource, revoke the relevant roles for this resource and for resources that grant inherited access rights. For more information, see [{#T}](../../concepts/access-control/index.md).

{% note info %}

If you need to temporarily revoke all access rights from a user with a Yandex account, you can revoke just the `{{ roles-cloud-member }}` role. Although the user keeps all the other roles, they can't perform any operations with the cloud resources. When you add the user to the cloud again, the access rights will already be configured.

{% endnote %}

## Revoking a role {#revoke-one-role}

{% list tabs %}

- Management console

   In the management console, you can only revoke a cloud or folder role:

   * To revoke a role only in the folder:

      1. Open the folder page. You can select a folder on the [home page]({{ link-console-main }}) of the management console. This page displays folders for the selected cloud.
      1. Go to **Access bindings in folder** (the **Access bindings** button in the left panel).
      1. Select the appropriate user in the list and click ![image](../../../_assets/options.svg) next to the user's name.
      1. Click **Edit roles**.
      1. Click ![image](../../../_assets/cross.svg) next to the role you wish to revoke.
      1. Click **Save**.

   * To revoke a role in the cloud:

      1. [Select the desired cloud](../../../resource-manager/operations/cloud/switch-cloud.md).
      1. Go to [Access bindings in cloud]({{ link-console-cloud }}?section=resource-acl) (the **Access bindings** button in the left panel).
      1. Select the appropriate user in the list and click ![image](../../../_assets/options.svg) next to the user's name.
      1. If you want to revoke all the user's roles in the cloud, click **Revoke roles**.
      1. If you want to revoke an individual user's roles in the cloud:
         1. Click **Edit roles**.
         1. In the **Configure access rights** window, click ![image](../../../_assets/cross.svg) next to each role you want to revoke.
         1. Click **Save**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   To revoke a role from a subject, delete the corresponding access binding for the appropriate resource:

   1. View roles and their assignees:

      {% include [include](../../../_includes/iam/list-access-bindings-via-cli.md) %}

   1. To delete an access binding, run:

      ```bash
      yc <service-name> <resource> remove-access-binding <resource-name>|<resource-id> \
        --role <role-id> \
        --subject <subject-type>:<subject-id>
      ```

      Where:

      * `<role-id>`: The ID of the role to revoke (such as `{{ roles-cloud-owner }}`).
      * `<subject-type>`: The [subject](../../concepts/access-control/index.md#subject) type to revoke a role from.
      * `<subject-id>`: The subject ID.

- API

   To revoke a resource role from a subject, delete the corresponding access binding:

   1. {% include [list-access-bindings-via-api](../../../_includes/iam/list-access-bindings-via-api.md) %}
   1. Create a request body, for example, in a `body.json` file. In the request body, specify which access binding to delete. For example, revoke the `editor` role from user `ajei8n54hmfhuk5nog0g`:
      **body.json:**
      ```json
      {
          "accessBindingDeltas": [{
              "action": "REMOVE",
              "accessBinding": {
                  "roleId": "editor",
                  "subject": {
                      "id": "ajei8n54hmfhuk5nog0g",
                      "type": "userAccount"
                      }
                  }
              }
          ]
      }
      ```
   1. Revoke the role by deleting the specified access binding:

      {% include [grant-role-folder-via-curl](../../../_includes/iam/grant-role-folder-via-curl.md) %}

{% endlist %}
