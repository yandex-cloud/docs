# Resolutions

A resolution is an issue attribute that specifies why the issue was closed. For example, an issue can be closed because it was completed (the <q>{{ ui-key.startrek-backend.applinks.samsara.resolution.resolved }}</q> resolution) or because it is a duplicate of another issue (the <q>{{ ui-key.startrek-backend.applinks.samsara.resolution.duplicate }}</q> resolution).

For each [issue type](./add-ticket-type.md) in a queue, you can define their own set of resolutions within a [workflow](./add-workflow.md). The queue owner and users granted [permission to access the queue settings](queue-access.md) can edit resolutions in queue workflows.

In {{ tracker-name }}, there are system resolutions that are listed in the [{{ tracker-name }} settings]({{ link-admin-resolutions }}). You can use these resolutions in any queues. If you do not find a suitable resolution among the system ones, a {{ tracker-name }} [administrator](../role-model.md) can create a new resolution. It will appear in the common resolution list and users will be able to use it in their queues.

## Adding a resolution to a queue {#add-resolution}

To add a resolution to a queue:

1. Go to the queue page.

1. In the top-right corner, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Go to the **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-workflows }}** tab. It shows the list of workflows in the queue. To see what issue types and resolutions are set in each workflow, click ![](../../_assets/tracker/svg/arrow.svg) in the respective workflow line.

1. To add a resolution to an existing workflow, hover over the part of this workflow line containing resolutions. Click the ![](../../_assets/tracker/svg/add-filter.svg) icon that appears and select a resolution from the list. To learn how to add a resolution to a new workflow, see the [guide on creating workflows](./add-workflow.md#create).

## Creating a resolution {#create-resolution}

{% note warning %}

Only an [administrator](../role-model.md) can create new resolutions. Once you have created a resolution, you cannot delete or edit it.

{% endnote %}

To create a resolution:

1. Make sure you are authorized in {{ tracker-full-name }} as an [administrator](../role-model.md).

1. In the left-hand panel, select ![](../../_assets/tracker/svg/admin.svg) **{{ ui-key.startrek.blocks-desktop_b-page-queue.cp }}** → **{{ ui-key.startrek.blocks-desktop_page-admin.tab-title--resolutions }}**.

1. Click **{{ ui-key.startrek.blocks-desktop_page-admin-tab.create--resolutions }}**.

1. Fill out the fields below:
   * **Name**: Enter a name for a new resolution in Russian.
   * **Name in English**: Will be generated automatically from the Russian name.
   * **Key**: Will be generated automatically based on the Russian name.

1. Click **{{ ui-key.startrek.blocks-desktop_b-create-ticket-form__labels.submit }}**.

You can also create a resolution on the workflows page. The new resolution will be created within a workflow in the queue.

1. Go to the queue page.

1. In the top-right corner, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Go to the **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-workflows }}** tab. It shows the list of workflows in the queue. Select the workflow to add your new resolution to.

1. Hover over the part of the line with resolutions. Click the ![](../../_assets/tracker/svg/add-filter.svg) icon that appears, start typing the name of the new resolution, and click the **Create** button.

1. Fill out the fields below:
   * **Name**: Enter a name for a new resolution in Russian.
   * **Name in English**: Will be generated automatically from the Russian name.
   * **Key**: Will be generated automatically based on the Russian name.

1. Click **{{ ui-key.startrek.ui_components_queue-admin-tab-workflows_OrgAdminEntityForm.create }}**.

## Removing a resolution from a queue {#delete-resolution}

Before removing a resolution from the queue, make sure none of the queue issues is closed with this resolution.

1. Open the queue page.

1. Use filters to [find all the issues in the queue](quick-filters.md) that include the resolution to be deleted. After that, change the resolution for such issues or update their status.

1. In the top-right corner of the queue page, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Go to the **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-workflows }}** tab. It shows the list of workflows in the queue. Select the workflow containing the resolution you want to remove.

1. Hover over the line with the resolution to be removed and click the cross icon next to this resolution.
