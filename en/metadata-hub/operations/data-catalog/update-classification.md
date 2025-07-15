# Updating a classification

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog you want to update a classification in.
  1. In the list of classifications, click ![image](../../../_assets/console-icons/ellipsis.svg) in the line with the classification and select **{{ ui-key.yacloud.common.edit }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, specify a new unique name for the classification.
  1. Optionally, edit the classification description.
  1. Optionally, enable or disable **Mutual exclusion**.

      With this option on, not more than one classification tag can be assigned to any {{ data-catalog-name }} resource.

  1. Click **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}
