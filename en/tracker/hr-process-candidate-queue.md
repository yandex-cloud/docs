# Enabling notifications by email

To allow candidates to submit a request on their own, create a queue and a request form and configure automatic sending of confirmation emails.

## Create a queue for candidates

1. [Create a queue](manager/create-queue.md) using the <q>Recruitment</q> template.
1. Give it a name, e.g., `Candidates Queue`.
1. Set up a [workflow](manager/workflows.md#section_hire) or create a [new](manager/add-workflow.md) one.
1. Add the **Hired** and **Not hired** completion statuses to the workflow.
1. Specify an issue type, such as `Candidates`, for the workflow.

## Set up a request form

### Create a form

1. In the left-hand panel, click ![](../_assets/tracker/svg/icon-add.svg) **New issue**.
1. Under **{{ ui-key.startrek.ui_components_PageCreateIssue.try-yandex-forms }}**, click **{{ ui-key.startrek.ui_components_PageCreateIssue.create-new }}**.
1. Create a new form:
   * Name it `Candidate`.
   * Add a description, e.g., `Vacancy request form`.
   * Click **{{ ui-key.startrek.ui_components_PageCreateIssueForm.continue }}**.
1. Wait for the page to load and select the **Text** widget.
1. In the **Question** field, enter `Full name`.
1. Click ![](../_assets/tracker/svg/icon-add.svg) **Add question** and select **Text**.
1. In the new question's card, enter **Vacancy** in the `Question` field.
1. Repeat the steps to add another question: `About you`. Change the question type from `Short answer` to `Long answer`.
1. Click ![](../_assets/tracker/svg/icon-add.svg) **Add question** and select **Email**.
1. In the new question's card, enter **Email** in the `Question` field.
1. Add other questions if needed.

### Set up integration with {{ tracker-name }}

1. Click **Configure integrations** and wait for the page to load.
1. In the **Issue type** field, select `Candidates`.
1. In the **Header** field, click ![](../_assets/tracker/svg/icon-add.svg) and select **Response**. In the dialog box that opens, select **Name** in the **Question** field and click **Save**.
1. In the **Description** field, click ![](../_assets/tracker/svg/icon-add.svg) and select **Responses**. In the dialog box that opens, click **Select all** and choose **Formatted** in the **Response formatting** field. Click **Save**.

## Set up sending of emails

1. On the integration setup page below, click ![](../_assets/tracker/svg/icon-add.svg)**Add action group**.
1. In the **Action group #2** card that appears, select the **Email** widget.
1. In the **To** field, click ![](../_assets/tracker/svg/icon-add.svg) and select **Response**. In the dialog box that opens, select **Email** in the **Question** field and click **Save**.
1. In the **Subject** field, enter `Job application`.
1. In the **Text** field, enter an email text, e.g., `Thank you! Your request has been accepted`.
1. On the page below, click **Save** and then click **Publish**.

### Create a test issue

1. On the issue creation page, select **{{ ui-key.startrek.ui_components_QueueAdminTemplateOptions.never }}** in the **{{ ui-key.startrek.ui_components_QueueAdminTemplateOptions.allow-empty-template }}** field at the top right.
1. Click the widget named `Candidate`.
1. Fill out the form. Specify your own email address.
1. Click **Send**.
1. Check if there is a confirmation email in your mailbox.
