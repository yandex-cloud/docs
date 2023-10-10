# Setting up a form for creating standard issues

To enable the employees of other departments in your company to submit requests for recruiting new experts, create a vacancy management queue and set up a vacancy description form.

## Create a queue

1. [Create a queue](manager/create-queue.md) using the <q>{{ ui-key.startrek.components_QueuePresetOnboarding.preset-name--recruitment-preset }}</q> template.
1. Give it a name, e.g., `Vacancy Queue`.

## Set up workflows

Queue templates include built-in workflows that are sets of statuses and status transition rules. Using workflows, you can automate routine operations for handling issues.
You can set up multiple workflows for different types of issues in a single queue. For example, vacancies for jobs that do not require high qualification can be managed in a simplified way.

### Configure a built-in workflow

1. Open the queue page.
1. In the top-right corner, click ![](../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}** and select **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-workflows }}**.
1. Select the built-in **Recruiting** workflow.
1. On the workflow page, rename the workflow to **Qualified personnel**.
1. Specify the type of issues this workflow applies to. To do this, click ![](../_assets/tracker/svg/icon-add.svg) to the right of the workflow name and enter a name for a new issue type, such as `Experts`.
1. Click the ![](../_assets/tracker/svg/icon-add.svg)**Create <q>Experts</q>** option that appears below and then click **{{ ui-key.startrek.ui_components_queue-admin-tab-workflows_OrgAdminEntityForm.create }}** in the dialog box that opens.
1. Save the workflow:
   1. Click **{{ ui-key.startrek.blocks-desktop_queue-access-msg-modal.add-button }}** at the top right.
   1. In the next dialog box, click **{{ ui-key.startrek.ui_components_queue-admin-tab-workflows_StatusTypesDialog.apply-button }}**.

### Copy and set up the new workflow

1. Return to the workflows page.
1. In the <q>Qualified personnel</q> workflow card, click ![](../_assets/tracker/button-copy.png).
1. Wait until the <q>Qualified personnel (1)</q> workflow card appears and click the ![](../_assets/tracker/button-edit.png) edit button.
1. On the <q>Qualified personnel (1)</q> workflow page, rename the workflow to **Unqualified personnel**.
1. Specify the type of issues this workflow applies to by creating a type named `Nonexperts` as described above.
1. Remove the approval stage from the workflow. To do this, click the **Awaiting approval** status in the workflow diagram and then click ![](../_assets/tracker/svg/actions.svg) in the status settings panel at the top right. Select **{{ ui-key.startrek.ui_components_queue-admin-tab-workflows_StatusEdit.action-remove }}**.
1. Save the workflow as described above.

## Create issue templates

You can use {{ forms-full-name }} to create standard issues in a queue more easily.

### Create a form for the first workflow

1. In the left-hand panel, click ![](../_assets/tracker/svg/icon-add.svg) **{{ ui-key.startrek.blocks-desktop_b-head.new_issue }}**.
1. Under **{{ ui-key.startrek.ui_components_PageCreateIssue.try-yandex-forms }}**, click **{{ ui-key.startrek.ui_components_PageCreateIssue.create-new }}**.
1. Create a new form:
   * Name it `Expert`.
   * Add a description, e.g., `Vacancy form for qualified personnel`.
   * Click **{{ ui-key.startrek.ui_components_PageCreateIssueForm.continue }}**.
1. Wait for the page to load and select the **Text** widget.
1. In the **Question** field, enter `Name`.
1. Click ![](../_assets/tracker/svg/icon-add.svg) **Add question**.
1. In the new question's card, enter **Department** in the `Question` field.
1. Repeat the steps to add another question: `Description`. Change the question type from `Short answer` to `Long answer`.
1. Add other questions if needed.

### Set up form integration

1. Click **Configure integrations** and wait for the page to load.
1. In the **Issue type** field, select `Experts`.
1. In the **Header** field, click ![](../_assets/tracker/svg/icon-add.svg) and select **Response option**. In the dialog box that opens, select **Name** in the **Question** field and click **Save**.
1. In the **Description** field, click ![](../_assets/tracker/svg/icon-add.svg) and select **Response options**. In the dialog box that opens, click **Select all** and choose **Formatted** in the **Response formatting** field. Click **Save**.
1. On the page below, click **Save** and then click **Publish**.

### Set up access to the form

If you want to restrict access to the form:

1. On the issue creation page, hover over the widget with the name of the form you need, e.g., `Expert`.
1. Click ![](../_assets/tracker/svg/actions.svg) and select ![](../_assets/tracker/icon-edit.png)**{{ ui-key.startrek.ui_components_PageCreateIssue.change-template }}**.
1. At the bottom of the page, follow the **{{ forms-full-name }} full version** link.
1. In the **Settings** tab, select **Only employees of the organization** under **Who can fill out the form**.
1. Click **Save**.

### Create a form for the second workflow

Repeat the steps to create and set up a form for vacancies that require no qualification.
Open the issue creation page, click **{{ ui-key.startrek.ui_components_PageCreateIssue.create-new-template }}**, and perform the same actions as described above using the values corresponding to the second workflow.

### Create test issues and group them by type

1. On the issue creation page, select **{{ ui-key.startrek.ui_components_QueueAdminTemplateOptions.allow-empty-template }}** in the **{{ ui-key.startrek.ui_components_QueueAdminTemplateOptions.never }}** field at the top right.
1. Click the widget with the name of the form you need, e.g., `Expert`.
1. Fill out the form and click **Submit**.
1. In the same way, create an issue of the `Nonexpert` type.
1. Enable issue grouping by type. To do this, click **{{ ui-key.startrek.blocks-desktop_issues-table.group-by--null }}** on the issue board and select **By issue type**.
