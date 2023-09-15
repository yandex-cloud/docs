# Setting up {{ tracker-name }}

Set up your workspace in {{ tracker-name }} and create your first issues.

## Step 1. Create a workflow {#create-process}

To get started with {{ tracker-name }}, create a queue: this is a shared space where all your issues are brought together. To conveniently manage issues, use boards, a visual method to track the status of issues belonging to several queues. Issues on the board are distributed across columns corresponding to different statuses. Managing issue boards in {{ tracker-name }} is similar to working with regular sticker boards: just drag your issues between columns to change their status.

In {{ tracker-name }}, you can [create](manager/create-queue.md) and [set up](manager/edit-queue-general.md) a queue manually, or use [automation tools](automation.md). To create a queue preconfigured for a specific workflow, you can use [workflow templates](manager/create-work-process.md).

1. On the [**{{ ui-key.startrek.blocks-desktop_b-head.my-page }}**](https://tracker.yandex.ru/pages/my) home page, click **{{ ui-key.startrek.ui_components_dashboard_InfoPresetsWidget.choose-template-button }}** in the **{{ ui-key.startrek.ui_components_dashboard_InfoPresetsWidget.widget-title }}** widget.
1. Select **{{ ui-key.startrek.ui_components_new-process_ProcessTypeStep.process-type-standard }}** and click **{{ ui-key.startrek.ui_components_new-process_ProcessTypeStep.next-button }}**.
1. Specify the queue parameters:
   * Issue queue name
   * [Queue key](manager/create-queue.md#key)
   * Permissions
1. Click **{{ ui-key.startrek.ui_components_new-process_ProcessTypeStep.next-button }}**.

This will create a queue with a basic set of issue [types and statuses](manager/workflow.md) and a [simple issue board](manager/agile.md#sec_boards).

## Step 2. Create your first issues {#create-tasks}

Issues are the foundation of {{ tracker-name }}. To make your work more efficient, try to break it down into individual issues with clear execution criteria.

{{ tracker-name }} provides multiple ways to create issues. For instance, you can create a new issue right from the board in just a couple of clicks, or you can use the full issue creation form.

### Creating an issue on a board {#tasks-board}

The fastest way to create an issue is to do it from the board. You only need to enter the issue name. Everything else can be set up later.

1. To create an issue, click **{{ ui-key.startrek.blocks-desktop_guide.ticket--main--action_new--title }}**.

1. In the dialog that opens, enter the issue name in the **{{ ui-key.startrek.ui_components_create-issue-popup_NewIssueForm.issue-name }}** field. Make sure that the name is informative, so it is easier to find in the list, for example: <q>Find the answer to the ultimate question of life, the Universe, and everything else</q>.

1. Click **{{ ui-key.startrek.ui_components_create-issue-popup_NewIssueForm.create }}** and press **Enter**.

The new issue will appear on the board, the queue page, and the [{{ tracker-name }} home page]({{ link-tracker }}) in your issue list.

### Creating an issue using the full form {#tasks-form}

Use the full form to set up all the issue attributes you need right from the start.

1. Click ![](../_assets/tracker/svg/icon-add.svg) **{{ ui-key.startrek.blocks-desktop_b-head.new_issue }}** in the left panel.

1. In the top-left corner of the page, choose the queue to create your issue in, such as <q>QUEUE</q>.

   {% note tip %}

   If you create an issue from a queue page, the queue field is pre-populated.

   {% endnote %}

1. You will be suggested to fill out a standard form with a pre-configured list of parameters.

   1. In the **{{ ui-key.startrek.ui_components_create-issue-popup_NewIssueForm.issue-name }}** field, enter an issue name. Make sure that the name is informative, so it is easier to find in the list, for example: <q>Find the answer to the ultimate question of life, the Universe, and everything else</q>.

   1. Enter a description of the issue if needed. To do so, click the `{{ ui-key.startrek.ui_components_PageCreateIssue.description-placeholder }}` placeholder and describe the issue in the text editor that opens.

   1. If you need to upload files, click **{{ ui-key.startrek.ui_components_AttachmentsManager.attach }}**.

   1. You can also add checkpoints to **{{ ui-key.startrek.components_Checklist.header-title }}**. To do so, click **{{ ui-key.startrek.ui_components_Checklist.new-item-button-caption }}**, then fill out the form that opens.

   1. On the left-hand panel, enter the relevant issue details, for example:
      * In the **{{ ui-key.startrek-backend.fields.issue.assignee-key-value }}** field, assign the issue to yourself by clicking **{{ ui-key.startrek.blocks-desktop_i-typed-field.assign-to-me }}**.
      * In the **{{ ui-key.startrek-backend.fields.issue.dueDate-key-value }}** field, enter an arbitrary deadline.

   1. Edit the list of the issue's displayed fields if needed. To do this, click **{{ ui-key.startrek.ui_components_PageCreateIssue.add-parameter }}** and set the relevant parameters.

1. Click **{{ ui-key.startrek-backend.types.types.trigger.action.create.issue }}**.

The new issue is ready-to-go. It will appear on the board, the queue page, and the [{{ tracker-name }} home page]({{ link-tracker }}) in your issue list.

## Step 3. What's next {#whats-next}

{{ tracker-name }} will help you effectively allocate team resources, assign issues, and track progress. Check the following sections to get started with {{ tracker-name }}:

Section | Description
------ | --------
[{#T}](about-tracker.md) | Find out what is inside {{ tracker-name }} and how it works.
[Change the interface language](user/personal.md#choose-language) | Choose English or Russian as your interface language.
[{#T}](manager/queue-access.md) | Set up user access to issues in your queue.
[{#T}](user/search-task.md) | Learn how to quickly find relevant issues.
[{#T}](user/dashboard.md) | Create a dashboard, a page that provides statistics on your key issues.
