To create a [group](../../organization/concepts/groups.md), you need _at least_ the [`organization-manager.editor` role](../../organization/security/index.md#organization-manager-editor) for the [organization](../../organization/concepts/organization.md).

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. In the left-hand panel, select ![groups](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}**.

  1. In the top-right corner of the page, click ![Circles3Plus](../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.entity.group.action_create }}**.

  1. Enter a name and description for the [group](../../organization/concepts/groups.md).

      The name must be unique within the organization and satisfy the relevant requirements:

      {% include [group-name-format](group-name-format.md) %}

  1. Click **{{ ui-key.yacloud_org.groups.action_create-group }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the command for creating a {{ org-name }} user group:

      ```bash
      yc organization-manager group create --help
      ```

  1. To create a user group in {{ org-name }}, run this command:

      ```bash
      yc organization-manager group create \
        --name <group_name> \
        --organization-id <organization_ID> \
        --description <group_description>
      ```

      Where:

      * `--name`: User group name. This is a required parameter. The name must be unique within the organization and satisfy the relevant requirements:

        {% include [group-name-format](group-name-format.md) %}

      * `--organization-id`: [Organization ID](../../organization/operations/organization-get-id.md). This is an optional parameter.
      * `--description`: Text description of the user group. This is an optional parameter.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the [group](../../organization/concepts/groups.md) parameters:

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
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

     ```bash
     yc organization-manager group list \
       --organization-id <organization_ID>
     ```

- API {#api}

    Use the [Group.create](../../organization/api-ref/Group/create.md) REST API method for the [Group](../../organization/api-ref/Group/index.md) resource or the [GroupService/Create](../../organization/api-ref/grpc/Group/create.md) gRPC API call.

{% endlist %}