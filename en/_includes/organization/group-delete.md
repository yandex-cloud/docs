{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.

  1. In the left-hand panel, select ![groups](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}**.

  1. In the row with the [group](../../organization/concepts/groups.md), click ![image](../../_assets/console-icons/ellipsis.svg) and select ![image](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.entity.group.action_delete-group }}**.

  1. In the window that opens, confirm the group deletion.

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
      * `--organization-id`: [Organization ID](../../organization/operations/organization-get-id.md).

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
     * `organization_id`: [ID](../../organization/operations/organization-get-id.md) of the organization to add the group to.
  1. Create resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

     ```bash
     yc organization-manager group list-memebers \
       --name <group_name> \
       --organization-id <organization_ID>
     ```

- API {#api}

    Use the [Group.delete](../../organization/api-ref/Group/delete.md) REST API method for the [Group](../../organization/api-ref/Group/index.md) resource or the [GroupService/Delete](../../organization/api-ref/grpc/Group/delete.md) gRPC API call.

{% endlist %}