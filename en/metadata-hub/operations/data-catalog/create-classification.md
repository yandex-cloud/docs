# Creating a classification

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog where you want to create a classification.
  1. Go to the ![image](../../../_assets/console-icons/tag.svg) **Tags and classifications** tab.
  1. Click **Create classification**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, specify a unique name for the classification.
  1. Optionally, describe the classification.
  1. Optionally, select *Mutually exclusive**.

      With this option on, not more than one classification tag can be assigned to any {{ data-catalog-name }} resource.

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
