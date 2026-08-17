# Revoke a role for a resource

{% note info %}

{% include [access-control-vs-roles-notice](../../../_includes/iam/access-control-vs-roles-notice.md) %}

{% endnote %}

If you want to prevent a [subject](../../concepts/access-control/index.md#subject) from accessing a resource, revoke the relevant roles for this resource and for resources that grant inherited access rights. For more information, see [{#T}](../../concepts/access-control/index.md).


## Revoking a role {#revoke-one-role}

{% list tabs group=instructions %}

- Management console {#console}

    * To revoke a role in the folder and its child resources:

        {% include [update-access-binding-user-console-folder](../../../_includes/resource-manager/update-access-binding-user-console-folder.md) %}

    * To revoke a role in the cloud:

        {% include [update-access-binding-user-console-cloud](../../../_includes/resource-manager/update-access-binding-user-console-cloud.md) %}

    * To revoke all the folder or cloud roles at once:

        1. In the [management console]({{ link-console-main }}), click ![image](../../../_assets/console-icons/layout-side-content-left.svg) or ![image](../../../_assets/console-icons/chevron-down.svg) in the top panel and select a folder or cloud.
        1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
        1. Select a user from the list and click ![image](../../../_assets/console-icons/ellipsis.svg) next to the username.
        1. If you want to revoke all of the user's roles in the cloud, click **{{ ui-key.yacloud_components.acl.action.revoke-access }}** and confirm the revocation.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    To revoke a role from a subject, delete access permissions for the appropriate resource:

    1. {% include [list-access-bindings-via-cli](../../../_includes/iam/list-access-bindings-via-cli.md) %}
    1. To delete access permissions, run this command:

        ```bash
        yc <service_name> <resource_category> remove-access-binding \
            --id <resource_ID> \
            --role <role_ID> \
            --subject <subject_type>:<subject_ID>
        ```

        Where:
        * `--id`: ID of the resource to revoke the role from.
        * `--role`: ID of the role to revoke, e.g., `{{ roles-cloud-owner }}`.
        * `--subject`: [Subject](../../concepts/access-control/index.md#subject) to revoke the role from.

            {% cut "Subject designations" %}

            {% include [subjects-designations-cli](../../../_includes/iam/subjects-designations-cli.md) %}

            {% endcut %}

- {{ TF }} {#tf}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    1. To revoke a resource role from a subject, find the resource description in the configuration file:

        ```
        resource "yandex_resourcemanager_cloud_iam_binding" "admin" {
            cloud_id    = "<cloud_ID>"
            role        = "<role>"
            members     = ["<subject_1>","<subject_2>,...,<subject_n>"]
        }
        ```

    1. Delete the record with information about the subject whose permissions you need to revoke from the list of [subjects](../../concepts/access-control/index.md#subject) titled `members`.

        {% cut "Subject designations" %}

        {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

        {% endcut %}

       For more on the properties of the `yandex_resourcemanager_cloud_iam_binding` resource, see [this provider guide]({{ tf-provider-resources-link }}/iam_service_account_iam_binding).

    1. Make sure the configuration files are correct.

        1. In the terminal, navigate to the directory where you created your configuration file.
        1. Run a check using this command:

          ```
          terraform plan
          ```

       If the configuration is correct, the terminal will display a list of the resources and their settings. Otherwise, {{ TF }} will show any detected errors.

    1. Deploy the cloud resources.

        1. If the configuration is correct, run this command:

           ```
           terraform apply
           ```

        1. Confirm creating the resources by typing `yes` and pressing **Enter**.

        This will create all the resources you need in the specified folder. You can check the new resource using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

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
