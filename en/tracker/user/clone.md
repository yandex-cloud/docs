# Cloning an issue

You can use issue cloning to create new issues based on existing ones. You can clone issues into any queue that is available to you.

{% note tip %}

If you need to create similar issues on a regular basis, use [templates](ticket-template.md).

{% endnote %}

To clone an issue:

1. Open the issue page.

1. In the top-right corner, select **{{ ui-key.startrek.ui_components_IssueMenu.title }}** → **{{ ui-key.startrek.ui_components_IssueMenu.clone-issue-action-title }}**.

1. Select the queue to create your cloned issue in.

1. To save the issue parameters, enable **Copy issue fields**. If some parameters are missing from the target queue (such as versions or components), they remain empty.

   {% note warning %}

   If the issue has the [local field](../local-fields.md) values specified, they will be reset when cloning the issue to a different queue.

   {% endnote %}

1. To establish a link between the issue and its clone, enable **Link the cloned issue**.

1. Click **Clone**.

You can open the issue's clone from the notification bar in the bottom-right corner of the page.
