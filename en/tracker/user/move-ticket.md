---
title: "How to move an issue to another queue in {{ tracker-name }}"
description: "Follow this guide to move an issue to another queue in {{ tracker-name }}."
---

# Move an issue to another queue {{ tracker-name }}

{% note alert %}

When you move an issue, its sub-issues remain in the source queue. If the issue has the [local field](../local-fields.md) values specified, they will be reset when moving the issue to a different queue.

{% endnote %}

To move a issue:

1. Make sure that you have [access to creating issues](../manager/queue-access.md) in the queue to which you want to move the issue.

1. Open the issue that you want to move.

1. In the top-right corner, select **{{ ui-key.startrek.ui_components_IssueMenu.title }}** → **{{ ui-key.startrek.ui_components_IssueMenu.move-issue }}**.

1. Specify the queue to which you want to move the issue, then click **Save**.

To move multiple issues to another queue, use [bulk operations](../manager/bulk-change.md#change-queue).

Once moved to another queue, the issue is assigned a new key. Links to the issue using the old key remain valid. When following such a link, the issue automatically opens in the new queue. However, you won't be able to find the issue by the old key using a [filter](../manager/quick-filters.md) or a [query](../user/query-filter#query-format.md).

