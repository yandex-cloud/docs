# Backward compatibility

When editing or deleting workflows, backward compatibility should be maintained for existing queue issues.

Possible backward compatibility errors include:
* Trying to delete a workflow when the queue contains issues that support this workflow.
* Trying to delete an [issue type](./add-ticket-type.md##delete-ticket-type) or [resolution](./create-resolution.md##delete-resolution) used in queue issues from a workflow.
* Trying to delete a status from a workflow.

## Editing a workflow {#edit-worflow}

If you want to completely revise a workflow without any compatibility errors related to existing queue issues, we recommend the following:

* Move existing issues to a different queue together with the old workflow and edit the workflow in the old queue.
* Create a new queue for a new workflow and there set up the workflow you need from the very beginning.

If you do not want to create a new queue, you can combine the old and new workflows in one queue. For that purpose, in both workflows, you should maintain:
* The same status for which transitions from any workflow status are configured.
* The same resolution.
* The same issue type.

## Deleting a workflow {#delete-worflow}

Before deleting a workflow, make sure you maintain backward compatibility for existing issues with the types this workflow is set for. There are several ways to do this:

* [Add the issue types](./add-ticket-type.md#add-ticket-type-queue) of the workflow you are going to delete to other workflows in the queue and then delete them from the workflow in question.
* Use filters to [find all the queue issues](quick-filters.md) with the types for which the workflow you are going to delete is configured and change the issue type for them.

Once you ensured backward compatibility for the issue types of the workflow to be deleted, you can proceed to deleting it:

1. Open the queue page and go to its settings by clicking ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. In the **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-workflows }}** tab, find the workflow you want to delete.

1. Delete the [resolutions](./create-resolution.md#delete-resolution) and [issue types](./add-ticket-type.md#delete-ticket-type) in this workflow.

1. Delete the workflow itself by clicking ![](../../_assets/tracker/svg/icon-filter-delete.svg) in the top-right corner.
