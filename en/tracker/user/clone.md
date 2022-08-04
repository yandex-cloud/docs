# Cloning an issue

You can use cloning to create new issues based on existing ones. You can clone issues in any queue that is available to you.

{% note tip %}

If you need to create similar issues on a regular basis, use [templates](ticket-template.md).

{% endnote %}

To clone an issue:

1. Open the issue page.

1. Select **Actions** → **Clone issue**.

1. Fill in the fields:

    - **Clone in**: Select the queue to create a cloned issue in.

    - **Copy issue fields**: If this option is selected, the issue settings are preserved in the clone. If some of the settings are not available in the target queue (for example, versions or components), they will be left empty.

        {% note warning %}

        If the issue has the [local field](../local-fields.md) values specified, they will be reset when cloning the issue to a different queue.

        {% endnote %}

    - **Link the cloned issue**: If this option is selected, the issue and its clone will be linked.

    - **Issue name**: The same issue name is used by default, but you can change it.

    - **Type**: Select the type of issue. The issue types available depend on the target queue settings.

    - **Status**: Select the issue status. The available issue statuses depend on the settings of the target queue for the selected issue type.

    - **Assignee** and **Followers**: These settings are preserved by default, but you can change them.

1. Click **Clone**.

