# Configuring issue types

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

A queue may include different types of issues, such as <q>New feature</q>, <q>{{ ui-key.startrek.blocks-desktop_queue-new-presets.preset--task-type--improvement }}</q>, or <q>{{ ui-key.startrek.blocks-desktop_queue-new-presets.preset--task-type--bug }}</q>. Each issue type has its [workflow](./workflows.md) and a set of [resolutions](./create-resolution.md). In your queue settings, you can change the set of types available when creating an issue, as well as specify the default type for created issues.

You can see a list of all issue types in the [{{ tracker-name }} settings]({{ link-admin-types }}).

## Adding an issue type to a queue {#add-ticket-type-queue}

To add a new issue type to the queue:

1. Go to the queue page.

1. In the top-right corner, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Click the **{{ ui-key.startrek.blocks-desktop_page-admin.tab-title--types }}** tab.

1. Click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_types.add-issue-type }}**.

1. Configure the settings:
   * **{{ ui-key.startrek.blocks-desktop_b-queue-form.choose-issue-type }}**: Select one of the available types.
       The most popular issue types are available in {{ tracker-name }}. If you don't see the type you need, admin can [create one](#create-ticket-type).
   * **{{ ui-key.startrek.blocks-desktop_b-queue-form.choose-workflow }}**: Set the workflow to apply to this type of issue. Select one of the available workflows or [create a new one](add-workflow.md) based on any of them.
   * **{{ ui-key.startrek.blocks-desktop_b-queue-form.choose-resolutions }}**: Select possible resolutions.
       The most popular resolutions are available in {{ tracker-name }} by default. If you don't see the resolution you need, admin can [create one](create-resolution.md).

1. The **{{ ui-key.startrek.blocks-desktop_b-queue-issue-type.workflow-view-label }}** section shows the main settings of the selected workflow. When needed, you can edit it or create its copy.

1. Click **{{ ui-key.startrek.blocks-desktop_b-queue-form.save }}** at the bottom of the tab.

{% note tip %}

In your queue settings, you can specify the default issue type. All the newly created issues in the queue will have this type. For this, in the upper-right corner, click **Default issue type:**, then select the type from the list.

{% endnote %}


## Creating an issue type {#create-ticket-type}

{% note warning %}

Only an [administrator](../role-model.md) can create new issue types. Once the issue type has been created, you can't delete or edit it.

{% endnote %}

The most popular issue types are available in {{ tracker-name }}. If there is no matching type among them, create a new type.

1. Make sure you are authorized in {{ tracker-full-name }} as an [administrator](../role-model.md).

1. In the left-hand panel, select ![](../../_assets/tracker/svg/admin.svg) **{{ ui-key.startrek.blocks-desktop_b-page-queue.cp }}** → **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.tracker-settings }}**.

1. Click the **{{ ui-key.startrek.blocks-desktop_page-admin.tab-title--types }}** tab.

1. Click **{{ ui-key.startrek.blocks-desktop_page-admin-tab.create--types }}**.

1. Fill in the fields and click **{{ ui-key.startrek.blocks-desktop_b-create-ticket-form__labels.submit }}**.


## Removing an issue type from the queue {#delete-ticket-type}

If you no longer need some issue type in your queue, you can delete it.

{% note warning %}

However, you can only delete the types that aren't used by any issue in the queue.

{% endnote %}

To delete an issue type from the queue:

1. Go to the queue page.

1. In the top-right corner, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Click the **{{ ui-key.startrek.blocks-desktop_page-admin.tab-title--types }}** tab.

1. To remove the type, click ![](../../_assets/tracker/remove-task-type.png).

1. Click **{{ ui-key.startrek.blocks-desktop_b-queue-form.save }}** at the bottom of the tab.
