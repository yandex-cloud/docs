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

{% endlist %}
