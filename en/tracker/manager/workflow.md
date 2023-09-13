# Changing basic queue settings

A workflow for an issue usually involves multiple stages. In {{ tracker-name }}, each issue stage corresponds to a certain status. A set of possible issue statuses and status transition rules is called a _workflow_.

You can add different issue types to a single queue, such as <q>New feature</q>, <q>{{ ui-key.startrek.blocks-desktop_queue-new-presets.preset--task-type--improvement }}</q>, or <q>{{ ui-key.startrek.blocks-desktop_queue-new-presets.preset--task-type--bug }}</q>. You can assign a specific workflow for each issue type.

To set up a life cycle for issues of a specific type:

1. Go to the [queue page](../user/queue.md).

1. In the top-right corner, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

   {% note alert %}

   By default, [only the queue owner](queue-access.md) can configure a queue.

   {% endnote %}

1. [Add a new issue type to the queue](add-ticket-type.md) and choose the workflow and resolution set.

   You can select an existing [workflow from the queue template](workflows.md) or [create a new workflow](add-workflow.md). You can use the same workflow for multiple issue types as well.

1. Once you've created a workflow, [set possible issue statuses](workflow-status-edit.md).

1. [Set status transitions](workflow-action-edit.md) for each available status:
   - Order and conditions of transitions between statuses.
   - Additional actions during transitions between statuses. For example, changing the values of issue fields automatically.
   - Transition screens are pop-up windows with selected fields that are shown when the issue status is changing.

#### See also

* [{#T}](add-ticket-type.md)

* [{#T}](add-workflow.md)

* [{#T}](workflow-status-edit.md)

* [{#T}](workflow-action-edit.md)
