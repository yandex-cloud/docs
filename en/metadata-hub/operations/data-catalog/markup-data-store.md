---
title: Data storage markup in {{ data-catalog-name }}
description: How to assign a domain and update a description, tags, or terms for a data storage in {{ data-catalog-full-name }}.
---

# Data storage markup

{% note info %}

{% include [preview-pp](../../../_includes/preview-pp.md) %}

{% endnote %}

When marking up your data storage, you can do the following:

* [Assign a domain](#assign-domain)
* [Change terms](#change-terms)
* [Change tags](#change-tags)
* [Update a description](#change-description)

## Assigning a domain {#assign-domain}

To assign or change a domain for one or multiple data storages:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog with the data storages you need.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_data-store }}**.
  1. To assign a domain to a single data storage:
      1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the storage and select **{{ ui-key.yacloud.data-catalog.action_set-domain }}**. If the domain is already assigned and you need to change it, select **{{ ui-key.yacloud.data-catalog.action_edit-domain }}**.
      1. Select the domain from the list and click **{{ ui-key.yacloud.common.save }}**.
  1. To assign or change a domain for multiple data storages:
      1. Select one or more storages and click **{{ ui-key.yacloud.data-catalog.action_set-domain }}** in the bottom panel.
      1. Select the domain from the list and click **{{ ui-key.yacloud.common.save }}**.

  {% include [ai-domains](../../../_includes/metadata-hub/data-catalog-ai-markup-domains.md) %}

{% endlist %}

## Changing terms {#change-terms}

To assign or change terms for one or multiple data storages:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog with the data storages you need.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_data-store }}**.
  1. Select one or more data storages and click **{{ ui-key.yacloud.data-catalog.label_add-terms }}** in the bottom panel.
  1. Select the terms from the list and click **{{ ui-key.yacloud.common.save }}**.

  {% include [ai-terms](../../../_includes/metadata-hub/data-catalog-ai-markup-terms.md) %}
  
{% endlist %}

## Changing tags {#change-tags}

To assign or change tags for one or multiple data storages:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog with the data storages you need.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_data-store }}**.
  1. Select one or more data storages and click **{{ ui-key.yacloud.data-catalog.label_add-tags }}** in the bottom panel.
  1. Select the tags from the list and click **{{ ui-key.yacloud.common.save }}**.

  {% include [ai-tags](../../../_includes/metadata-hub/data-catalog-ai-markup-tags.md) %}
  
{% endlist %}

## Updating a description {#change-description}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog with the data storage you need.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_data-store }}**.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the storage and select **{{ ui-key.yacloud.common.edit }}**.
  1. Update the **Description** field and click **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}