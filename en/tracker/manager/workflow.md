# Configuring issue types and statuses

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

Issues are generally completed in multiple stages. In {{ tracker-name }}, each issue stage corresponds to a certain status. A set of possible issue statuses and status transition rules is called a _workflow_.

You can add different issue types to a single queue, such as <q>New feature</q>, <q>Improvement</q>, or <q>Bug</q>. A unique workflow can be configured for each issue type.

To configure a workflow for a particular issue type:

1. Go to the queue page and select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. [Add a new issue type to the queue](add-ticket-type.md) and choose the workflow and resolution set.

   You can select an existing [workflow from the queue template](workflows.md) or [create a new workflow](add-workflow.md). The same workflow can be used for multiple types of issues.

1. Once you've created a workflow, [set possible issue statuses](workflow-status-edit.md).

1. [Set status transitions](workflow-action-edit.md) for each available status:
    - The order and conditions for status transitions.
    - Additional actions to trigger during a status transition. For example, you can set up your issue fields to change their values automatically.
    - Transition screens are pop-up windows with preset fields displayed during status changes.

[{#T}](add-ticket-type.md)

[{#T}](add-workflow.md)

[{#T}](workflow-status-edit.md)

[{#T}](workflow-action-edit.md)

