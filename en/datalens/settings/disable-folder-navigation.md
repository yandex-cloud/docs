---
title: "Disabling folder navigation in {{ datalens-full-name }}"
description: "You can disable folder navigation after you start organizing objects in workbooks and collections."
---

# Disabling folder navigation

You can disable folder navigation after you switch to [workbooks and collections](../workbooks-collections/index.md) for organizing objects. Before you disable it, [migrate](../workbooks-collections/migrations.md) all objects in your folders to workbooks or delete them.

Folders can be disabled by the {{ datalens-short-name }} instance administrator (user with the `{{ roles-datalens-admin }}` role).

{% note warning %}

Once you disable folder navigation, it cannot be re-enabled.

{% endnote %}

To disable folder navigation:

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![image](../../_assets/console-icons/sliders.svg) **Service settings**.
1. In the **Disable folder navigation** section, click **Disable folder navigation**.
1. In the window that opens, you will see a list of the remaining objects in the folders, which you need to migrate to workbooks or delete before disabling the folders. If the list of objects is empty, you can disable navigation. To do this, click **Disable**.
