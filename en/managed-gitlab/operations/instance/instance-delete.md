---
title: Deleting an instance
description: Follow this guide to delete an instance.
---

# Deleting an instance

If the instance has deletion protection enabled, [disable](instance-update.md) it first, and then delete the instance.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the management console, select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to delete a [{{ GL }} instance](../../concepts/index.md#instance) from.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) for the instance and select **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}

If you have deleted the instance but want to restore it, contact [support]({{ link-console-support }}). When you delete an instance, the system automatically creates its [backup](../../concepts/backup.md) which is stored for two weeks.
