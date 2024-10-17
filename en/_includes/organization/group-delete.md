{% list tabs group=instructions %}

- {{ org-name }} interface {#cloud-org}

  1. Go to [{{ org-full-name }}]({{ link-org-main }}).
  1. In the left-hand panel, select **{{ ui-key.yacloud_org.pages.groups }}** ![icon-services](../../_assets/console-icons/persons.svg).
  1. Select the [group](../../organization/concepts/groups.md) you need and click ![image](../../_assets/console-icons/ellipsis.svg) -> ![image](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.entity.group.action_delete-group }}**.
  1. In the window that opens, click **{{ ui-key.yacloud_org.entity.group.action_delete-group }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the command for deleting a {{ org-name }} user group:

      ```bash
      yc organization-manager group delete --help
      ```
  
  1. To delete a user group, run this command:

      ```bash
      yc organization-manager group delete \
        --name <group_name> \
        --organization-id <organization_ID>
      ```

      Where:

      * `--name`: User group name. This is a required parameter.
      * `--organization-id`: Organization ID.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Describe the infrastructure in the configuration file omitting the relevant [group](../../organization/concepts/groups.md):

     ```hcl
     resource "yandex_organizationmanager_group" "my-group" {
       name            = "<group_name>"
       description     = "<group_description>"
       organization_id = "<organization_ID>"
     }
     ```

     Where:
     * `name`: Group name. The name must be unique within the organization and satisfy the relevant requirements:

        {% include [group-name-format](group-name-format.md) %}

     * `description`: Group description. This is an optional parameter.
     * `organization_id`: ID of the organization to add the group to.
  1. Create resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

     ```bash
     yc organization-manager group list-memebers \
       --name <group_name> \
       --organization-id <organization_ID>
     ```

- API {#api}

    Use the [Group.delete](../../organization/api-ref/Group/delete.md) REST API method for the [Group](../../organization/api-ref/Group/index.md) resource or the [GroupService/Delete](../../organization/api-ref/grpc/Group/delete.md) gRPC API call.

{% endlist %}