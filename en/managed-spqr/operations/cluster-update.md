---
title: Updating a {{ SPQR }} cluster
description: After creating a {{ SPQR }} cluster, you can edit its basic and advanced settings.
keywords:
  - Updating an {{ SPQR }} cluster
  - '{{ SPQR }} cluster'
  - '{{ SPQR }}'
---

# Updating a {{ SPQR }} cluster

{% include notitle [preview](../../_includes/note-preview.md) %}

After creating a cluster, you can edit its basic and advanced settings.

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
    1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        * Edit the cluster name and description.
        * Delete or add new [labels](../../resource-manager/concepts/labels.md).

    1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select security groups for the cluster.

    1. Update the computing resource configuration:

        * For standard sharding, update the infrastructure host configuration under **{{ ui-key.yacloud.spqr.section_infra }}**.
        * For advanced sharding, update the router host configuration under **{{ ui-key.yacloud.spqr.section_router }}**. If employing a coordinator, update the coordinator host configuration under **{{ ui-key.yacloud.spqr.section_coordinator }}**.

        To update your computing resource configuration:

        1. Change platform in the **{{ ui-key.yacloud.mdb.forms.resource_presets_field-generation }}** field.
        1. Change **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}** for the VM the hosts are deployed on.
        1. Change **{{ ui-key.yacloud.mdb.forms.section_resource }}**.
        1. Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**, change disk type and storage size.

    1. Change additional cluster settings:

        {% include [extra-settings](../../_includes/mdb/mspqr/console/extra-settings.md) %}

    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

{% endlist %}
