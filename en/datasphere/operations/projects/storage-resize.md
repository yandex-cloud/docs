---
title: Resizing project storage
description: In this tutorial, you will learn how to resize your project storage.
---

# Resizing project storage

{% note info %}

You can only resize a project storage if you have the `{{ roles-datasphere-project-admin }}` [role](../../security/index.md) in the project or the `{{ roles-datasphere-communities-admin }}` role in the project community.

You can [restrict](../community/manage-community-config.md) resizing the project storage in the community settings.

{% endnote %}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Information about the project storage size is available on the project page in the **{{ ui-key.yc-ui-datasphere.project-page.tab.overview }}** tab, under **{{ ui-key.yc-ui-datasphere.project-page.project-disk }}**. Click ![pencil](../../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yc-ui-datasphere.common.resize }}**.
1. Specify the size you need as an integer.
1. Click **{{ ui-key.yc-ui-datasphere.common.resize }}**.
1. You will be able to open the project as soon as storage resizing is completed.

{% note warning %}

The project storage is used not only for storing files but also for file system operations and other technical needs.

{% endnote %}
