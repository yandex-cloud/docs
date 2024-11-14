{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.

  1. In the left-hand panel, select ![groups](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}**.
  
  1. In the row with the [group](../../organization/concepts/groups.md) you need, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_org.entity.group.action_edit }}**.

  1. Enter a new name or description for the group.

      The name must be unique within the organization and satisfy the relevant requirements:

      {% include [group-name-format](group-name-format.md) %}

  1. Click **{{ ui-key.yacloud_org.actions.save-changes }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the command to edit a {{ org-name }} user group:

      ```bash
      yc organization-manager group update --help
      ```

  1. To edit a user group, run this command:

      ```bash
      yc organization-manager group update \
        --name <group_name> \
        --new-name <new_name_for_group> \
        --organization-id <organization_ID> \
        --description <group_description>
      ```

      Where:

      * `--name`: User group name. This is a required parameter. The name must be unique within the organization and satisfy the relevant requirements:

        {% include [group-name-format](group-name-format.md) %}

      * `--new-name`: New name for the user group.
      * `--organization-id`: [Organization ID](../../organization/operations/organization-get-id.md). This is an optional parameter.
      * `--description`: Text description of the user group. This is an optional parameter.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, edit the group parameters:

     ```hcl
     resource "yandex_organizationmanager_group" "my-group" {
        name            = "<group_name>"
        description     = "<group_description>"
        organization_id = "<organization_ID>"
     }
     ```

     Where:

     * `name`: New group name. The name must be unique within the organization and satisfy the relevant requirements:

        {% include [group-name-format](group-name-format.md) %}

     * `description`: New group description.
     * `organization_id`: [ID](../../organization/operations/organization-get-id.md) of the organization the group belongs to.
  1. Create resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

     ```bash
     yc organization-manager group get \
       --name <group_name> \
       --organization-id <organization_ID>
     ```

- API {#api}

    Use the [Group.update](../../organization/api-ref/Group/update.md) REST API method for the [Group](../../organization/api-ref/Group/index.md) resource or the [GroupService/Update](../../organization/api-ref/grpc/Group/update.md) gRPC API call.

{% endlist %}