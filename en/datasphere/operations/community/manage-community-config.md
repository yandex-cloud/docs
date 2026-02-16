---
title: How to manage community restrictions
description: Follow this guide to restrict the {{ ml-platform-name }} resources and features available across all your community projects.
---

# Managing community restrictions

{% note info %}

You can restrict the {{ ml-platform-name }} resources and features available across all your community projects only if you have the `{{ roles-datasphere-communities-admin }}` role in the community.

{% endnote %}

1. {% include [ui-find-community](../../../_includes/datasphere/ui-find-community.md) %}
1. Select the community for which you want to configure the {{ ml-platform-name }} features.
1. Go to the **{{ ui-key.yc-ui-datasphere.common.restrictions }}** tab.
1. Under **{{ ui-key.yc-ui-datasphere.restrictions.project-mode }}**:

    * **{{ ui-key.yc-ui-datasphere.restrictions.JUPYTER_TOKEN }}**: Enables [working with projects from any local IDE](../projects/remote-connect.md) that supports the use of remote {{ jlab }} servers.
    * **{{ ui-key.yc-ui-datasphere.restrictions.DEDICATED_INSTANCE_COUNT }}**: Number of VMs available in community projects.

1. Under **{{ ui-key.yc-ui-datasphere.common.resources }}**:

    * **{{ ui-key.yc-ui-datasphere.restrictions.CHANGING_DISK_SIZE }}**: Enables project storage resizing.
    * **{{ ui-key.yc-ui-datasphere.restrictions.NODES_AND_ALIASES }}**: Enables service deployment using [nodes](../../concepts/deploy/index.md#node) and [aliases](../../concepts/deploy/index.md#alias) in community projects.
    * **{{ ui-key.yc-ui-datasphere.restrictions.DATAPROC_TEMPLATES }}**: Enables the use of [{{ dataproc-name }} templates](../../concepts/data-processing-template) in community projects.
    * **{{ ui-key.yc-ui-datasphere.common.datasets }}**: Enables creating [datasets](../../concepts/dataset) in community projects.

1. Under **{{ ui-key.yc-ui-datasphere.spaces-page.configurations }}**, you can select [computing resource configurations](../../concepts/configurations.md) that will be available across all your community projects.
