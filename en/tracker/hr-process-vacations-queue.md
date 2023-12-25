# Setting up regular reminders

For your employees to be able to easily submit a vacation or sick leave in advance, create a queue and a request form and configure request status auto checks with a reminder to be sent to the HR staff should they fail to start processing the request on time.

## Create a queue

1. [Create a queue](manager/create-queue.md) using the <q>Personnel management</q> template.
1. Give it a name, e.g., `Vacations Queue`.
1. Set up a workflow for the `Vacation` issue type.
1. Create additional issue types and workflows if needed.

## Set up a request form

### Create a form

1. In the left-hand panel, click ![](../_assets/tracker/svg/icon-add.svg) **New issue**.
1. Under **{{ ui-key.startrek.ui_components_PageCreateIssue.try-yandex-forms }}**, click **{{ ui-key.startrek.ui_components_PageCreateIssue.create-new }}**.
1. Create a new form:
   * Name it `Vacation request`.
   * Add a description, e.g., `Form for vacation requests`.
   * Click **{{ ui-key.startrek.ui_components_PageCreateIssueForm.continue }}**.
1. Wait for the page to load and click **{{ forms-full-name }} full version**.
1. Create a request form, e.g., with the following fields:
   * `Full name` (short text, required field)
   * `Department` (short text, required field)
   * `Vacation type` (drop-down list, required field). Add options to the list, such as:
      - `Paid vacation`
      - `Unpaid leave`
      - `Maternity leave`
      - `Sick leave`
   * `Start` (date, required field)
   * `End` (date, required field)
1. Add other fields if needed.

### Set up integration with {{ tracker-name }}

1. Click **Configure integrations** and wait for the page to load.
1. In the **Issue type** field, select `Vacation`.
1. In the **Header** field, click ![](../_assets/tracker/svg/icon-add.svg) and select **Response**. In the dialog box that opens, select **Vacation type** in the **Question** field and click **Save**.
1. In the **Description** field, click ![](../_assets/tracker/svg/icon-add.svg) and select **Responses**. In the dialog box that opens, click **Select all** and choose **Formatted** in the **Response formatting** field. Click **Save**.
1. Click **Add issue parameters** and select the **Deadline** option using the search field.
1. Use the **Deadline** field to add an answer to the `Start` question.
1. Click **Save** to save the form.
1. Return to the form builder by clicking **To builder** at the top of the page.
1. Click **Publish** and copy the link to the form in the dialog box that opens.
1. Return to the `Vacations Queue` settings and click **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-forms }}**.
1. Click **Add form** and fill out the form that opens pasting the link you copied earlier into the **Link to the form** field.
1. Click **Save** to save the form integration.

## Set up an auto action

{{ tracker-name }} has the [auto actions](user/autoactions.md) feature to perform regular actions in a queue. Use an auto action to set up regular checks of the `Vacations Queue` for requests that work is not started on yet. To avoid overloading the employees responsible for registration of vacations with reminders, configure them to be sent once a day and not earlier than two weeks prior to the vacation start date specified in the request.

1. Return to the `Vacations Queue` settings and click **{{ ui-key.startrek.ui_components_page-queue-admin_QueueAdminPageContent.menu-item-autoactions }}**.
1. Wait for the page to load and click **Create auto action**.
1. In the **Auto action type** field, enable **Issue update**.
1. In the **Name** field, enter a name, such as `vacation_warning`.
1. In the **Update once per** field, set the update frequency to once a day (for testing purposes, once an hour is recommended).
1. Under **Filter settings**, select **Query** and use the [query language](user/query-filter.md):
   ```
   Deadline: <= today() +14D Status: New
   ```

   The condition will trigger for an issue with a vacation start date within the next two weeks which is still in the <q>New</q> status.
1. Under **Issue actions**, click **Add new action** and select **Add comment**.
1. Click the ![](../_assets/tracker/summon.png) button to invite to comment and, in the **Invite to comment** line, add employees responsible for vacation registration.
1. In the comment field, add the following text:
   ```
   Vacation is not registered! Deadline: "not_var{{issue.dueDate}}".
   ```
1. To save an auto action, click **Save**.

## Test the auto action

1. On the issue creation page, select **{{ ui-key.startrek.ui_components_QueueAdminTemplateOptions.never }}** in the **{{ ui-key.startrek.ui_components_QueueAdminTemplateOptions.allow-empty-template }}** field at the top right.
1. Click the `Vacation` widget.
1. Fill out the form. In the **Start** field, specify a date that is a week from now.
1. Submit the form.
1. Make sure that, after the deadline specified in the auto action, the comment you set previously appears in the issue.
