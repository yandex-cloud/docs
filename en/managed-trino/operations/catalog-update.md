---
title: Updating a {{ TR }} catalog
description: Follow this guide to update catalog parameters in a {{ mtr-name }} cluster.
---

# Updating a {{ TR }} catalog

{% include [preview](../../_includes/managed-trino/note-preview.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    1. On the [resource folder]({{ link-console-main }}) page, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Click the cluster name.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.
    1. Next to the catalog, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
    1. Update the {{ TR }} catalog parameters and click **{{ ui-key.yacloud.common.update }}**.

{% endlist %}