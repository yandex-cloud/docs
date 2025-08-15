---
title: How to delete a notebook or a project in {{ ml-platform-full-name }}
description: In this guide, you will learn how to delete a notebook or a project in {{ ml-platform-name }}.
---

# Deleting a notebook or a project

## Deleting a notebook {#delete-notebook}

To delete a notebook from a project:
1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. Click **{{ ui-key.yc-ui-datasphere.project-page.project-card.go-to-jupyter }}**.
1. On the left-hand panel, right-click the name of the notebook you want to delete.
1. Select ![image](../../../_assets/console-icons/xmark.svg) **Delete** and click **Delete** in the window that opens.

## Deleting a project {#delete-project}

{% note alert %}

Once you delete a project, all its notebooks and created resources will be lost.

{% endnote %}

To delete a project:
1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. In the top-right corner, click **{{ ui-key.yc-ui-datasphere.common.more }}** and select ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. In the window that opens, click **{{ ui-key.yc-ui-datasphere.common.delete }}**.

{% include [deletion-time](../../../_includes/datasphere/deletion-time.md) %}