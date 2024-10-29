# Creating a template in {{ forms-full-name }} (beta)

In the [beta version of the new {{ tracker-full-name }} interface](../user/personal.md#sec_beta), we added an embedded {{ forms-full-name }} form builder. You can use the builder to create forms inside your queue and use the forms as templates for your issues.

Forms are available to all users who have a right to create issues in the queue. A list of forms is shown on the [issue creation](create-ticket.md) page.

{% note info %}

By default, form management is only available to the queue owner and the [{{ tracker-name }} administrator](../role-model.md#admin). For the users to be able to create or edit forms, grant to them [access to edit the queue settings](../manager/queue-access.md).

{% endnote %}

## Create a form {#create-template}

Forms that were created by the {{ forms-full-name }} embedded builder, are used as templates for creating issues. You can use forms to add questions: the answers to the questions will be passed to the issue using variables in the integration settings.

{% note tip %}

The embedded form builder supports only the main types of questions and integration settings. To edit the [appearance of a form](../../forms/appearance.md), add [additional prompts](../../forms/add-questions.md), and configure their display [logic](../../forms/send-condition.md), use the full version of the form constructor {{ forms-full-name }}.

{% endnote %}

To create a form for your issues:

1. In the panel on the left, click ![](../../_assets/tracker/svg/create-task.svg) **Create issue**.

1. Select a queue in the field located at the top of the page.

1. If there are no forms in the queue, select **{{ ui-key.startrek.ui_Issues_pages_PageCreateIssue.create-new }}**. If you already have forms, click **{{ ui-key.startrek.ui_Issues_pages_PageCreateIssue.create-new-template }}**.

1. Enter a name and description for the form and click **{{ ui-key.startrek.ui_Issues_pages_PageCreateIssueForm.continue }}**.

1. Add fields to the form.

   * To add the first prompt, select its type in the form creation space.

   * To add another prompt, click **Add prompt**, or hover over the created prompt and click ![](../../_assets/tracker/svg/icon-add.svg). The new prompt appears above the current one if you hover over the upper part of the block.

   * To copy or remove a prompt, click ![](../../_assets/tracker/svg/icon-copy.svg) or ![](../../_assets/tracker/svg/icon-remove.svg).

   * To add an image to a prompt or response option, click ![](../../_assets/tracker/svg/icon-picture.svg).

   * To split a form into multiple pages, click **Add page** below the form creation space.

1. Click **Set up integrations** and specify the issue's parameters that will be passed to {{ tracker-name }} from the form:

   1. Under **Perform actions**, specify **always**.
      If you need to set up the conditions on which the issue will be created, select **on condition**. Then select a question and specify the answer on which an issue will be created in {{ tracker-name }}.

   1. Select the **Queue** to create your issue in. To set up the **Parent issue – Sub-issue** [link](links.md) for the issue being created, select the **Convert to sub-issue** option and enter the key of the parent issue.

   1. Select the **Issue type** and **Priority**. Available issue types depend on the [issue settings](../manager/add-ticket-type.md).

   1. Enter the issue name in the **Title** field and the issue statement in the **Description** field. Use [YFM markup](markup.md) to format text.

   1. To set the default reporter and assignee, enter the logins of the users without `@`. If the reporter is omitted, the user who filled out the form will be assigned as a reporter by default.

   1. If you want to add a field that is missing in the list, to an issue, select **Add issue parameter**. The field will be shown in the integration settings, and you will be able to specify its value for the form.

      {% note info %}

      To add an answer to a question from the form, use variables: select the issue field and click ![](../../_assets/tracker/svg/icon-add.svg). For more information about variables, see the [{{ forms-full-name }} documentation](../../forms/vars.md).

      {% endnote %}

   1. To transfer attachments from a form to the issue, select a question of the **File** type in the **Attach files from responses to prompts** field.

   1. To show a link to the created issue, enable the option **Show message with action result to the user**.

1. You can also set up integrations with other team collaboration services.

   * [Send notifications by email](../../forms/send-mail.md).

   * [Add user responses to {{ wiki-name }}](../../forms/send-wiki.md).

   * [Send HTTP request](../../forms/send-request.md).

1. Click **Save**.

## Manage forms {#manage-template}

Form management is available to the [{{ tracker-name }} administrator](../role-model.md#admin), queue owner, and users who have [access](../manager/queue-access.md) to editing the queue settings.

To go to the queue forms, in the left panel, click ![](../../_assets/tracker/svg/create-task.svg) **Create issue**.

### Set up the issue creation page {#new-task-page}

To change the form order on the issue creation page, click ![](../../_assets/tracker/svg/range.svg) and drag the form.

You can set up your issues to be created without a form or only with a form. To do this, select **{{ ui-key.startrek.ui_Queues_smart-components_QueueAdminTemplateOptions.allow-empty-template }}** in the top-right corner.
* **{{ ui-key.startrek.ui_Queues_smart-components_QueueAdminTemplateOptions.always }}**: All users will be able to create issues without a form.
* **{{ ui-key.startrek.ui_Queues_smart-components_QueueAdminTemplateOptions.never }}**: Users will only be able to create issues using a form.
* **{{ ui-key.startrek.ui_Queues_smart-components_QueueAdminTemplateOptions.team }}**: Only the members of the [queue team](../manager/queue-team.md) will be able to create issues without a form.

### Changing form parameters {#edit-template-name}

To change the name or description of a form:

1. Select the form and click ![](../../_assets/horizontal-ellipsis.svg).

1. Select **{{ ui-key.startrek.ui_Issues_pages_PageCreateIssue.change-title-and-description }}**.

1. Enter a new name and description for the form and click **Save**.

### Change the form {#edit-template}

To change the form:

1. Select the form and click ![](../../_assets/horizontal-ellipsis.svg).

1. Select **{{ ui-key.startrek.ui_Issues_pages_PageCreateIssue.change-template }}**.

1. Edit the form's questions in the embedded {{ forms-full-name }} builder and set up integrations with {{ tracker-name }}, same as when [creating a form](#create-template).

### Deleting a form {#remove-template}

To delete a form:

1. Select the form and click ![](../../_assets/horizontal-ellipsis.svg).

1. Select **{{ ui-key.startrek.ui_Issues_pages_PageCreateIssue.switch-to-admin-panel }}**.

1. In the queue settings next to the form, click ![](../../_assets/tracker/icon-delete.png).
