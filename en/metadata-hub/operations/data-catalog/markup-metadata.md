# Metadata markup

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

To mark up metadata, you can:

* [Assign domains](#assign-domains)
* [Change terms](#change-terms)
* [Change tags](#change-tags)
* [Change metadata description](#change-metadata-description)

## Assigning domains {#assign-domains}

You can assign [domains](../../concepts/data-catalog.md#domains-and-subdomains) to all metadata.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud.data-catalog.title_search-data }}**.
  1. To assign a domain to a single object:
     1. Click ![image](../../../_assets/console-icons/ellipsis.svg) in the row with the object and select **{{ ui-key.yacloud.data-catalog.action_set-domain }}**. If the domain is already assigned and you need to change it, click **{{ ui-key.yacloud.data-catalog.action_edit-domain }}**.
     1. Select the required domain from the list in the pop-up window and click **{{ ui-key.yacloud.common.save }}**.
  1. To assign or change a domain for multiple objects:
     1. Select the required objects in the column on the left.
     1. On the panel below, click **{{ ui-key.yacloud.data-catalog.action_set-domain }}**.
     1. Select the required domain from the list in the pop-up window and click **{{ ui-key.yacloud.common.save }}**.

  {% include [search-tip](../../../_includes/metadata-hub/tip-search.md) %}

{% endlist %}

## Changing terms {#change-terms}

You can change [terms](../../concepts/data-catalog.md#glossaries-and-terms) for all metadata.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud.data-catalog.title_search-data }}**.
  1. To add or change terms for a single object:
     1. Click ![image](../../../_assets/console-icons/ellipsis.svg) in the row with the object and select **{{ ui-key.yacloud.data-catalog.label_add-terms }}**.
     1. Select the required terms from the list in the pop-up window and click **{{ ui-key.yacloud.common.save }}**.
  1. To add or change terms for multiple objects:
     1. Select the required objects in the column on the left.
     1. On the panel below, click **{{ ui-key.yacloud.data-catalog.label_add-terms }}**.
     1. Select the required terms from the list in the pop-up window and click **{{ ui-key.yacloud.common.save }}**.

  {% include [search-tip](../../../_includes/metadata-hub/tip-search.md) %}

{% endlist %}

## Changing tags {#change-tags}

You can change [tags](../../concepts/data-catalog.md#classifications-and-tags) for metadata, as well as domains, glossaries, and terms.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud.data-catalog.title_search-data }}**.
  1. To add or change tags for a single object:
     1. Click ![image](../../../_assets/console-icons/ellipsis.svg) in the row with the object and select **{{ ui-key.yacloud.data-catalog.label_add-tags }}**.
     1. Select the required tags from the list in the pop-up window and click **{{ ui-key.yacloud.common.save }}**.
  1. To add or change tags for multiple objects:
     1. Select the required objects in the column on the left.
     1. On the panel below, click **{{ ui-key.yacloud.data-catalog.label_add-tags }}**.
     1. Select the required terms from the list in the pop-up window and click **{{ ui-key.yacloud.common.save }}**.

  {% include [search-tip](../../../_includes/metadata-hub/tip-search.md) %}

{% endlist %}

## Changing metadata descriptions {#change-metadata-description}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud.data-catalog.title_search-data }}**.
  1. Click the object of interest in the list.
  1. To edit the description of an object with a type intended for metadata markup (tag, term, classification, glossary, domain), click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.

     To edit the description of an object of a different type, click **{{ ui-key.yacloud.common.edit }}** on the top panel.

     To edit the description of a table column (**Dataset** object type), go to the **Schema** tab, click ![image](../../../_assets/console-icons/ellipsis.svg) in the row with the column name, and select **{{ ui-key.yacloud.common.edit }}**.
  1. Enter the description and click **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}
