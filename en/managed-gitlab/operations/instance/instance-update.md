# Editing instance settings

After creating a [{{ GL }} instance](../../concepts/index.md#instance), you can edit the general and advanced instance settings yourself.

## Changing general and advanced instance settings {#change-settings}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the management console, select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the [{{ GL }} instance](../../concepts/index.md#instance) is located.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Select the instance and click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** at the top of the page.
  1. At the top of the page:

      * Specify a new instance name and description.
      * Add [tags](../../../resource-manager/concepts/labels.md) to break instances into logical groups.
      * Set or remove instance protection against accidental deletion by the user.

  1. Under **{{ ui-key.yacloud.gitlab.label_configuration-section }}**:

      * Change the [instance type](../../concepts/index.md#config). From the current instance type, you can only upgrade to a higher-performance type, e.g., from `s2.micro` to `s2.small`. You cannot downgrade to a lower-performance instance type.
      * Select another [security group](../../../vpc/concepts/security-groups.md) or create a new one:

        * Click **{{ ui-key.yacloud.component.network-subnet-select.button_create-security-group }}**.
        * Enter a name and description for the security group. You can add rules for the security group later in {{ vpc-name }}.
        * Click **{{ ui-key.yacloud.common.create }}**.

        {% include [sg-notes](../../../_includes/managed-gitlab/sg-notes.md) %}

      * Specify the disk size. You can increase the disk size or keep the same size. You cannot reduce the disk size.
      * Change the automatic backup retention period, in days.
      * Select the appropriate [configuration](../../concepts/approval-rules.md#packages) for approval rules.

          {% include [note-approval-rules-pricing](../../../_includes/managed-gitlab/note-approval-rules-pricing.md) %}

      * To activate the approval rules, specify a [{{ GL }} token](../approval-rules.md#gitlab-token).

  1. Under **{{ ui-key.yacloud.gitlab.label_additional-section }}**, enable or disable deletion of untagged images. This setting affects the amount of free disk space on the instance.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the [CLI](../../../cli) command to update the {{ mgl-name }} instance settings:

      ```bash
      {{ yc-mdb-gl }} instance update --help
      ```

  1. Update the {{ GL }} instance settings (this example does not use all available parameters):

      ```bash
      {{ yc-mdb-gl }} instance update <instance_name_or_ID> \
        --new-name <new_instance_name> \
        --resource-preset-id <host_class> \
        --disk-size <disk_size_in_GB> \
        --deletion-protection \
        --approval-rules <approval_rule_configuration>
      ```

      Where:

      * `--new-name`: New instance name, unique within {{ yandex-cloud }}. The naming requirements are as follows:

          {% include [name-format](../../../_includes/name-format.md) %}

      * `--resource-preset-id`: Host class. Represents the configuration of the virtual machine to host the {{ GL }} instance. The possible values are:

          * `s2.micro`: 2 vCPUs, 8 GB RAM
          * `s2.small`: 4 vCPUs, 16 GB RAM
          * `s2.medium`: 8 vCPUs, 32 GB RAM
          * `s2.large`: 16 vCPUs, 64 GB RAM

      * `--disk-size`: Disk size in GB.
      * `--deletion-protection`: Instance protection against accidental deletion by the user.

          {% note info %}

          You can use the CLI to enable but not disable the accidental deletion protection.

          {% endnote %}

      * `--approval-rules`: [Approval rule](../../concepts/approval-rules.md) configuration. The possible values are:

          * `BASIC`
          * `STANDARD`
          * `ADVANCED`

          {% include [note-approval-rules-pricing](../../../_includes/managed-gitlab/note-approval-rules-pricing.md) %}

      Result:

      ```text
      id: c17c60tpadua********
      folder_id: b1g2slt7p9ug********
      created_at: "2025-07-20T18:34:16.078Z"
      updated_at: "2025-07-20T18:54:49.829961285Z"
      name: test-cli
      resource_preset_id: s2.small
      disk_size: "107374182400"
      status: RUNNING
      admin_login: admin-gl
      admin_email: user@example.com
      domain: test-domain-user.gitlab.yandexcloud.net
      subnet_id: e9b4rrpuu2a********
      backup_retain_period_days: "7"
      deletion_protection: true
      approval_rules_id: BASIC
      gitlab_version: 17.11.6
      ```

      For more information about this command, see the [CLI reference](../../cli-ref/instance/update.md).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file that defines your infrastructure.

      For more information about creating this file, see [Creating a {{ GL }} instance](instance-create.md#create).

  1. Change the parameter values in the {{ GL }} instance description:

      ```hcl
      resource "yandex_gitlab_instance" "my_gitlab_instance" {
        ...
        resource_preset_id        = "<host_class>"
        disk_size                 = <disk_size_in_GB>
        approval_rules_id         = "<approval_rule_configuration>"
        backup_retain_period_days = <backup_retention_period>
        deletion_protection       = <true_or_false>
        ...
      }
      ```

      Where:

      * `resource_preset_id`: Host class. Represents the configuration of the virtual machine to host the {{ GL }} instance. The possible values are:
          * `s2.micro`: 2 vCPUs, 8 GB RAM
          * `s2.small`: 4 vCPUs, 16 GB RAM
          * `s2.medium`: 8 vCPUs, 32 GB RAM
          * `s2.large`: 16 vCPUs, 64 GB RAM

      * `disk_size`: Disk size in GB.
      * `approval_rules_id`: [Approval rule](../../concepts/approval-rules.md) configuration. The possible values are:

          * `BASIC`
          * `STANDARD`
          * `ADVANCED`

          {% include [note-approval-rules-pricing](../../../_includes/managed-gitlab/note-approval-rules-pricing.md) %}

      * `backup_retain_period_days`: Automatic backup retention period, in days.
      * `deletion_protection`: Instance protection against accidental deletion by the user. The possible values are `true` or `false`.

      For more information about `yandex_gitlab_instance` properties, see the [relevant provider documentation]({{ tf-provider-resources-link }}/gitlab_instance).

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      {{ TF }} will update all the required resources. You can check the resource update using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

      ```bash
      {{ yc-mdb-gl }} instance list
      ```

  For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/gitlab_instance).

- API {#api}

  Use the [Update](../../api-ref/Instance/update.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Update](../../api-ref/grpc/Instance/update.md) gRPC API call.

{% endlist %}
