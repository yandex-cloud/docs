---
title: Updating a {{ ytsaurus-name }} cluster
description: After creating a {{ ytsaurus-name }} cluster, you can edit its basic and advanced settings.
keywords:
  - Updating an {{ ytsaurus-name }} cluster
  - '{{ ytsaurus-name }} cluster'
  - '{{ ytsaurus-name }}'
---

# Updating a {{ ytsaurus-name }} cluster

{% include [preview](../../_includes/managed-ytsaurus/note-preview.md) %}

After creating a cluster, you can edit its basic and advanced settings.

{% list tabs group=instructions %}

- Management console {#console}

    To change the cluster settings:

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
    1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        * Edit the cluster name and description.
        * Delete or add new [labels](../../resource-manager/concepts/labels.md).

    1. Under **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.filestore-section_title_tYMR7 }}**, change the number of disks.
    1. Under **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.exec-node-configuration-section_title_mfa54 }}**, change the number of exec nodes.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

{% endlist %}
