---
title: Getting a data profile
description: Follow this guide to get a data profile in {{ data-catalog-full-name }}.
---

# Getting a data profile

{% note info %}

{% include [preview-pp](../../../_includes/preview-pp.md) %}

{% endnote %}

You can get a selected dataset's profile.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [resource folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you created the metadata catalog in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. In the list that opens, select the metadata catalog.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud.data-catalog.title_search-data }}**.
  1. Select from the list a line with the **Dataset** type and go to the **Profile** tab.
    
      This tab gives the statistics for the specified profiling parameters.

      To view the specified profiling parameters, click **{{ ui-key.yacloud.metadata-hub.data-catalog.AssetProfiling.ProfileHeader.title_profile-parameters_26kSu }}**.

{% endlist %}