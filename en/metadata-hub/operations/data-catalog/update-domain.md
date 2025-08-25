# Updating a domain


{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog containing the domain you want to update.
  1. Navigate to the ![image](../../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.data-catalog.label_domains }}** tab.
  1. In the list of domains, click ![image](../../../_assets/console-icons/ellipsis.svg) next to the domain and select **{{ ui-key.yacloud.common.edit }}**.  
  1. In the **{{ ui-key.yacloud.common.name }}** field, specify a new unique name for the domain.
  1. Optionally, update the domain description.
  1. Click **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}
