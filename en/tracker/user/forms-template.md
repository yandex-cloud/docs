# Creating a template in {{ forms-full-name }} (beta)

The [beta version of the new interface in {{ tracker-full-name }}](../user/personal.md#sec_beta) includes an integrated form builder {{ forms-full-name }} for creating issue templates.

Templates are available to all users who have the permission to create issues in the queue. The template list is displayed on the [issue creation](create-ticket.md) page.

{% note info %}

By default, only the queue owner{% if audience == "external" %}&nbsp;and the [{{ tracker-name }} admin](../role-model.md#admin){% endif %} can manage templates. If you want other users to create or edit templates, grant them [access to edit queue settings](../manager/queue-access.md).

{% endnote %}

## Creating a template {#create-template}

Issue templates are based on forms used in {{ forms-full-name }}. You can add questions to the form. The responses will then be included in the issue via variables used in integration settings.

{% note tip %}

The form builder only supports basic question types and integration settings. You can change the [form design](../../forms/appearance.md), add [additional questions](../../forms/add-questions.md), and set up their [display logic](../../forms/send-condition.md) in the full version of the builder in {{ forms-full-name }} for Business.

{% endnote %}

To create an issue template:

1. On the left-hand panel, click ![](../../_assets/tracker/svg/create-task.svg) **Create issue**.

1. Select a queue in the field at the top of the page.

1. If you don't have any preset templates in {{ forms-full-name }}, select **New template**. If you already have issue templates to use, click **Create new template**.

1. Enter a name and description for your template and click **Continue**.

1. Add fields to the template.

    * To add your first question, select the question type in the form creation area.

    * To add more questions to the page, click **Add question** or hover over the existing question and click ![](../../_assets/tracker/svg/icon-add.svg). The new question will appear over the previous question when you hover over the top of the section.

    * To copy or remove a question, click ![](../../_assets/tracker/svg/icon-copy.svg) or ![](../../_assets/tracker/svg/icon-remove.svg).

    * To add an image to the question body or one of the answers, click ![](../../_assets/tracker/svg/icon-picture.svg).

    * To split the form into multiple pages, click **Add page** under the form creation area.

1. Click **Configure integration** and specify issue parameters to transfer to {{ tracker-name }} from the template:

    1. In the **Perform actions** section, choose **always**.
If you need to set up specific conditions that would trigger issue creation, select **when**. Then choose a question and specify the response that would create an issue in {{ tracker-name }}.

    1. Choose the **Queue** for your issue. To create a [link](links.md) of the <q>Parent issue — Sub-issue</q> type, select **Convert to sub-issue** and enter the parent issue key.

    1. Select your issue's **Type** and **Priority**. Available issue types depend on your [issue settings](../manager/add-ticket-type.md).

    1. Enter the issue name into the **Name** field and describe the issue in the **Description** field. Use [YFM markup](markup.md) to format text.

    1. To select the author or assignee, enter their usernames without the `@` symbol. If the author is not specified, the user who filled out the form is set as the issue author.

    1. If you want to add an issue field that's not on the list, select **Add issue parameter**. The field will be displayed in integration settings, and you will be able to specify its value for your template.

        {% note info %}

        Use variables to add an answer to a question from the form: select an issue field and click ![](../../_assets/tracker/svg/icon-add.svg). To learn more about variables, see the [{{ forms-full-name }} service documentation](../../forms/vars.md).

        {% endnote %}

    1. To send attachments used in the form to the issue, find the **Attach files from answers** field and select the <q>File</q> question type.

    1. To display a link to the created issue, enable **Display notification when an action has been performed**.

1. You can also set up integrations with other services for collaborative work:

    * [Sending notifications by email](../../forms/send-mail.md).

    * [Adding user responses to {{ wiki-name }}](../../forms/send-wiki.md).

    * [Sending HTTP requests](../../forms/send-request.md).

1. Click **Save**.

## Managing templates {#manage-template}

Templates can only be managed by the {% if audience == "external" %}[{{ tracker-name }} admin](../role-model.md#admin), {% endif %} queue owner, and users with [access](../manager/queue-access.md) to queue settings.

To open issue templates, find the left-hand panel and click ![](../../_assets/tracker/svg/create-task.svg) **Create issue**.

### Setting up the issue creation page {#new-task-page}

To change the template order on the issue creation page, click ![](../../_assets/tracker/svg/range.svg) and drag the template.

You can choose to create issues based on a template or create them from scratch. To enable the option, click **Allow issue creation with no templates** in the upper-right corner:

* **Always**: All users will be able to create issues without using templates.
* **Never**: You will only be able to create issues from templates.
* **Queue team only**: Only the [queue team](../manager/queue-team.md) members will be able to create issues without templates.

### Changing template parameters {#edit-template-name}

To change a template's name or description:

1. Choose a template and click ![](../../_assets/horizontal-ellipsis.svg).

1. Select **Edit name or description**.

1. Enter a new name and description for your template and click **Save**.

### Editing templates {#edit-template}

To change your template's design:

1. Choose a template and click ![](../../_assets/horizontal-ellipsis.svg).

1. Choose **Edit template**.

1. Edit the questions in the form using the dedicated {{ forms-full-name }} builder and set up {{ tracker-name }} integration, like you do when [creating templates](#create-template).

### Deleting templates {#remove-template}

To delete a template:

1. Choose a template and click ![](../../_assets/horizontal-ellipsis.svg).

1. Choose **Go to admin panel**.

1. In the queue settings next to the template, click ![](../../_assets/tracker/icon-delete.png).

