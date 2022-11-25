# Moving an issue to another queue in {{ tracker-name }}

{% note alert %}

When you move an issue, its sub-issues remain in the original queue. If the issue has the [local field](../local-fields.md) values specified, they will be reset when moving the issue to a different queue.

{% endnote %}

To move an issue:

1. Make sure you have [access to issue creation](../manager/queue-access.md) in the queue you wish to move the issue to.

1. Open the issue you wish to move.

1. Select **Actions** → **Change queue**.

1. Specify the queue to move the issue to.

1. If necessary, specify the issue parameters and click **Move**.

Once moved to another queue, the issue is assigned a new key. Links to the issue using the old key remain valid. When following such a link, the issue automatically opens in the new queue. However, you won't be able to find the issue by the old key using a [filter](../manager/quick-filters.md) or a [query](../user/query-filter#query-format.md).

