# Editing instance settings

After creating a [{{ GL }} instance](../../concepts/index.md#instance), you can change its name and description, configure protection against accidental deletion by the user, and change the retention period for automatic backups. You cannot change other settings.

## Changing instance settings {#change-settings}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the management console, select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the [{{ GL }} instance](../../concepts/index.md#instance) is located.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Select the instance and click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** at the top of the page.
  1. Under **{{ ui-key.yacloud.compute.group.overview.section_base }}**:

      * Specify a new instance name and description.
      * Add [tags](../../../resource-manager/concepts/labels.md) to break instances into logical groups.
      * Set or remove instance protection against accidental deletion by the user.

  1. Under **{{ ui-key.yacloud.gitlab.label_configuration-section }}**:

      * Change the automatic backup retention period, in days.
      * Select the appropriate [configuration](../../concepts/approval-rules.md#packages) for approval rules.

          {% include [note-approval-rules-pricing](../../../_includes/managed-gitlab/note-approval-rules-pricing.md) %}

      * To activate the approval rules, specify a [{{ GL }} token](../approval-rules.md#gitlab-token).

  1. Under **{{ ui-key.yacloud.gitlab.label_additional-section }}**, enable or disable deletion for untagged images. This setting affects the amount of free disk space on the instance.
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}
