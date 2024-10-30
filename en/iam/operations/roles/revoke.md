# Revoke a role for a resource

If you want to prevent a [subject](../../concepts/access-control/index.md#subject) from accessing a resource, revoke the relevant roles for this resource and for resources that grant inherited access rights. For more information, see [{#T}](../../concepts/access-control/index.md).


## Revoking a role {#revoke-one-role}

{% list tabs group=instructions %}

- Management console {#console}

    * To revoke a role in the folder and its child resources:

        {% include [update-access-binding-user-console-folder](../../../_includes/resource-manager/update-access-binding-user-console-folder.md) %}

    * To revoke a role in the cloud:

        {% include [update-access-binding-user-console-cloud](../../../_includes/resource-manager/update-access-binding-user-console-cloud.md) %}

    * To revoke all the folder or cloud roles at once:

        1. On the management console [home page]({{ link-console-main }}), select a folder or a cloud.
        1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
        1. Select a user from the list and click ![image](../../../_assets/console-icons/ellipsis.svg) next to the username.
        1. If you want to revoke all of the user's roles in the cloud, click **{{ ui-key.yacloud.common.resource-acl.button_remove-bindings }}** and confirm the revocation.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    To revoke a role from a subject, delete access permissions for the appropriate resource:

    1. {% include [list-access-bindings-via-cli](../../../_includes/iam/list-access-bindings-via-cli.md) %}
    1. To delete access permissions, run this command:

        ```bash
        yc <service_name> <resource_category> remove-access-binding <resource_name_or_ID> \
            --role <role_ID> \
            --subject <subject_type>:<subject_ID>
        ```

        Where:
        * `--role`: ID of the role to revoke, e.g., `{{ roles-cloud-owner }}`.
        * `<subject_type>`: [Subject](../../concepts/access-control/index.md#subject) type to revoke a role from.
        * `<subject_ID>`: Subject ID.

- {{ TF }} {#tf}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    1. To revoke a resource role from a subject, find the resource description in the configuration file:


        ```
        resource "yandex_resourcemanager_cloud_iam_binding" "admin" {
            cloud_id    = "<cloud_ID>"
            role        = "<role>"
            members     = [
            "serviceAccount:<service_account_ID>",
            "userAccount:<user_ID>",
            ]
        }
        ```

    1. Delete the record with information about the subject whose permissions you need to revoke from the `members` list of users.

       For more information about the `yandex_resourcemanager_cloud_iam_binding` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/iam_service_account_iam_binding).

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

        All the resources you need will then be created in the specified folder. You can check the new resource using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

        ```
        yc resource-manager cloud list-access-bindings <cloud_name_or_ID>
        ```

- API {#api}

    To revoke a resource role from a subject, delete the relevant access permissions:

    1. {% include [include](../../../_includes/iam/list-access-bindings-via-api.md) %}
    1. Create the request body, e.g., in the `body.json` file. In the request body, specify access permissions to delete. For example, revoke the `editor` role from the `ajei8n54hmfh********` user:

        **body.json:**
        ```json
        {
            "accessBindingDeltas": [{
                "action": "REMOVE",
                "accessBinding": {
                    "roleId": "editor",
                    "subject": {
                        "id": "ajei8n54hmfh********",
                        "type": "userAccount"
                        }
                    }
                }
            ]
        }
        ```


    1. Revoke a role by deleting the assigned permissions:

        {% include [grant-role-folder-via-curl](../../../_includes/iam/grant-role-folder-via-curl.md) %}

{% endlist %}
