# Examples

Let's look at some examples of how triggers work in {{ tracker-name }}:

- How to [automatically pick assignees](#assign_ticket) based on status or component.

- How to [automatically invite assignees](#summon_ticket) based on the status or field value.

- How to [automatically notify a user](#notify_mail) after an issue was created based on a request sent to the support team via email.

- How to [automatically notify a user](#notify_form) after an issue was created based on a request sent to the support team via Yandex.Forms.

{% if audience == "internal" %}

- How to [automatically add a form](#insert_form) to the issue comment.

{% endif %}

- How to [set up notifications in messengers](#section_vsn_mb2_d3b) via HTTP requests.

## Pick assignees automatically {#assign_ticket}

Different stages of a project are often handled by different employees. When an employee does their part, they transfer the issue to another assignee. In {{ tracker-name }}, each issue stage has its own status. When an issue receives a status update, a new employee can be automatically assigned to work on the issue with a trigger.

However, sometimes employees only handle issues related to their field of expertise and don't collaborate on a single issue. For example, each support team member only processes requests related to the product they were assigned to. To manage this kind of workflow, you can [configure components](components.md) so that they correspond to specific products. When a specific component is added to the issue, the employee responsible for the corresponding product is automatically assigned to work on it via a trigger.

Let's set up a trigger that automatically picks an assignee for our issue:

{% if audience == "external" %}

1. Make sure every employee you might want to assign [has full access to {{ tracker-name }}](../enable-tracker.md).

{% endif %}

1. Go to queue settings, open the **Triggers** section, and click [**Create trigger**](../user/create-trigger.md).

1. Set the trigger to react when the issue's <q>Status</q> or <q>Components</q> change:

    1. Choose **Conditions to be met** → **All**.

    1. Add the condition **Event type** → **Issue changed**.

    1. If you want a new assignee to be picked after a status update, add the following condition: **System** → **Status** → **Field value became equal to** and specify the status.

        ![](../../_assets/tracker/trigger-example-status.png)

        If you want a new assignee to be picked after a component changes, add the following condition: **System** → **Components** → **Field value became equal to** and specify the components.

        ![](../../_assets/tracker/trigger-example-components.png)

        {% note info %}

        This trigger only works if only one component is specified in the issue.

        {% endnote %}

1. Set a trigger action:

    1. Add the action **Change field values**.

    1. Choose **System** → **Assignee** → **Set value** and specify who should be picked as the assignee after the trigger is executed.

        ![](../../_assets/tracker/trigger-example-assignee.png)

1. Save your trigger.
To see if you trigger works, pick any issue from the queue with the added trigger and change the issue's status or components.

## Invite assignees automatically {#summon_ticket}

After completing an issue, the assignee may forget to specify some important information, such as time spent. In this case, you can configure a trigger that will automatically invite the assignee if the issue is closed and the time spent is not specified:

1. Go to queue settings, open the **Triggers** section, and click [**Create trigger**](../user/create-trigger.md).

1. Set the trigger to react when the issue is closed with the <q>Time spent</q> field being empty:

    1. Choose **Conditions to be met** → **All**.

    1. Add the condition **Status** → **Field value became equal to** → **Closed**.

    1. Add the condition **Time spent** → **Field value empty**.

1. Set trigger actions:

    1. Add the **Add comment** action.

    1. Click ![](../../_assets/tracker/summon.png), find the line **Invite users from a field**, and enter <q>Assignee</q>.

    1. Enter the comment to be displayed to the assignee and choose **Send as robot**.

1. Click **Create** to save the trigger.

    ![](../../_assets/tracker/trigger-example-summon.png)

When closing any issue that does not specify the time spent, the robot will create a comment and invite the assignee.

## Send a notification when an issue is created from an email {#notify_mail}

Let's say the support team is processing user requests in {{ tracker-name }}. Users contact the support team via email, and those emails are used as the basis for issues in {{ tracker-name }}.

Let's set up a trigger that automatically sends an email to the user telling them that their request has been registered:

#### Step 1. Configure email integration

You need to set up email integration if you want to send emails right from {{ tracker-name }} and create issues from incoming emails:

1. [Set up an email address for the queue]{% if audience == "external" %} (queue-mail.md#section_gwv_hqb_hgb){% else %}(queue-mail.md#sec-mail-yandex){% endif %} that will create issues from user requests.

    If you can't create such an address, this means your organization doesn't have its own domain. You need a domain to create mailboxes and newsletters. This includes creating queue addresses. A domain is free to [add in Yandex.Mail 360 for Business]({{ support-business-domain }}).

1. [Set up sender names and signatures](queue-mail.md#send_outside) if needed.

{% if audience == "external" %}

1. If users aren't your organization's employees:

    1. [Allow accepting email from external addresses](queue-mail.md#mail_tasks).

    1. [Allow sending email from issue pages to external addresses](queue-mail.md#send_outside).

{% else %}

1. If the users aren't Yandex employees, [allow sending email from issue pages to external addresses](queue-mail.md#send_outside).

{% endif %}

#### Step 2. Set up a trigger for sending email

Set up a trigger that automatically notifies users by mail when a new issue is created based on an email:

1. Go to queue settings, open the **Triggers** section, and click [**Create trigger**](../user/create-trigger.md).

1. Set the trigger to fire when a new issue is created based on an incoming email:

    1. Choose **Conditions to be met** → **All**.

    1. Add the condition **Event type** → **Issue created**.

    1. Add the condition **Email** → **Created by email to** → **Equals string** and enter the email address to your queue.

    1. Enable **Ignore case** so that the queue address isn't case sensitive.

    ![](../../_assets/tracker/trigger-example-mail-condition.png)

1. Set sending a message as the trigger action:

    1. Choose the **Add comment** action.

    1. Enable the **Email** option.

    1. In the **To** field, add the variable with the address of the user who sent the request. To do this, select the **To** field, click **Add variable**, and choose **Email** → **From**.

    1. Write the email. You can add issue fields to your message by clicking **Add variable**.

    ![](../../_assets/tracker/trigger-example-mail-action.png)

1. Save your trigger.

    To see if the trigger works, send an email to the queue address.

## Send a notification when an issue is created based on a form {#notify_form}

Let's say the support team is processing user requests in {{ tracker-name }}. Users contact the support team via a feedback form created in [Yandex.Forms]{% if audience == "external" %}({{ link-forms }}){% else %}({{ link-forms-ya }}){% endif %}. A {{ tracker-name }} issue is then created based on that form.

Let's set up a trigger that automatically sends an email to the user telling them that their request has been registered:

#### Step 1. Configure email integration

You need to set up email integration if you want to send emails from {{ tracker-name }}:

1. [Set up an email address for the queue]{% if audience == "external" %} (queue-mail.md#section_gwv_hqb_hgb){% else %}(queue-mail.md#sec-mail-yandex){% endif %} that will create issues from user requests.

   If you can't create such an address, this means your organization doesn't have its own domain. You need a domain to create mailboxes and newsletters. This includes creating queue addresses. A domain is free to [add in Yandex.Mail 360 for Business]({{ support-business-domain }}).

1. [Set up sender names and signatures](queue-mail.md#send_outside) if needed.

1. If the users aren't employees of your organization, [allow sending email from issue pages to external addresses](queue-mail.md#send_outside).

#### Step 2. Set up a form to register requests

To create issues from requests sent through forms:

1. Go to [Yandex.Forms]{% if audience == "external" %}({{ link-forms }}){% else %}({{ link-forms-ya }}){% endif %} and create a new form.

1. Add questions that let users provide relevant information necessary to register their request.

    If you want to know the user's email address, add the **Email** question and make it a required field.

    ![](../../_assets/tracker/trigger-example-form-constructor.png)

1. Set up [{{ tracker-name }} integration]{% if audience == "external" %}({{ support-forms-tracker }}){% else %}({{ support-forms-tracker-ya }}){% endif %} for the form:

    1. Specify your queue and other issue parameters.

    1. Use the **Issue description** field to add answers to the questions included in your form.

    1. If you want to save a user's email address in your issue parameters, add the **From** field and choose **Variables** → **Answer** → **Email**.

    1. Save your integration settings.

    ![](../../_assets/tracker/trigger-example-form-integration.png)

1. [Publish]{% if audience == "external" %}({{ support-forms-publish }}){% else %}({{ support-forms-publish-ya }}){% endif %} the form.

#### Step 3. Set up a trigger for sending email

Set up a trigger that automatically notifies users by email when a new issue is created from a form:

1. Go to queue settings, open the **Triggers** section, and click [**Create trigger**](../user/create-trigger.md).

1. Set the trigger to fire when a new issue is created based on an incoming email:

    1. Choose **Conditions to be met** → **All**.

    1. Add the condition **Event type** → **Issue created**.

    1. Add the condition **Email** → **From** → **Field value became not empty**.

    ![](../../_assets/tracker/trigger-example-form-condition.png)

1. Set sending a message as the trigger action:

    1. Choose the **Add comment** action.

    1. Enable the **Email** option.

    1. In the **To** field, add the variable with the address of the user who sent the request. To do this, select the **To** field, click **Add variable**, and choose **Email** → **From**.

    1. Write the email. You can add issue fields to your message by clicking **Add variable**.

    ![](../../_assets/tracker/trigger-example-mail-action.png)

1. Save your trigger.

    To see if your trigger works, fill out the form you integrated with {{ tracker-name }}.

    {% if audience == "internal" %}

## Automatically add a form to the issue comments {#insert_form}

Using a trigger, you can add a form with auto-prefilled fields to the issue comments. To do this, add a special code with a link to the form in the comment text. Values can be passed to the form fields via [GET-params]({{ support-forms-get-params-ya }}). For example, you can pass the issue parameters using variables that are available in the trigger.

Let's set up a trigger that adds a feedback form to the comments and invites an assignee after the issue is closed:

#### Step 1. Create a feedback form

1. Go to [Yandex.Forms]{% if audience == "external" %}({{ link-forms }}){% else %}({{ link-forms-ya }}){% endif %} and create a form. {% if audience == "internal" %}For information on which admin panel to create a form in, [читайте в документации]({{ support-forms-instance-ya }}).{% endif %}

1. Add questions to the form so that the assignee can provide necessary information.

#### Step 2. Create a trigger to add the form

1. Go to queue settings, open the **Triggers** section, and click [**Create trigger**](../user/create-trigger.md).

1. Set the trigger to fire when the issue is closed:

    1. Choose **Conditions to be met** → **All**.

    1. Add the condition **Status** → **Field value became equal to** → **Closed**.

    ![](../../_assets/tracker/trigger-example-add-form-1.png)

1. Set a trigger action:

    1. Add the **Add comment** action.

    1. In the comment text, insert the code:

    ```
    {{=<% %>=}}{{iframe src=//forms.yandex-team.ru/surveys/<id_формы>/?iframe=1&<id_вопроса>=<значение> frameborder=0 width=100% height=660px scrolling=no}}
    ```

    `<form id>` is the ID of the form to be added.

    `<question_id>` is the [идентификатор вопроса]({{ support-forms-question-id }}).

    `<value>` is the value to populate the form field.

    To transfer issue parameters to the form, use variables as values: at the bottom of the window, click the **Add variable** button and choose the issue parameter. Then replace the `{{ }}` characters around the name of a variable with `<% %>`.

    For example, to pass an issue key, use the `<%issue.key%>` value. To pass the username of an assignee, use the `<%issue.assignee.login%>` value.

    Code example where an issue key is passed to the form field:

    ```
    {{=<% %>=}}{{iframe src=//forms.yandex-team.ru/surveys/68417/?iframe=1&answer_short_text_584943=<%issue.key%> frameborder=0 width=100% height=660px scrolling=no}}
    ```

    1. Click ![](../../_assets/tracker/summon.png), find the line **Invite users from a field**, and enter <q>Assignee</q>.

    1. Enable the **Send as robot** option.

    ![](../../_assets/tracker/trigger-example-add-form-2.png)

1. Click **Create** to save the trigger.

#### Step 3. Add robot-forms@ to the queue

To ensure the form is inserted correctly, provide access to the queue for the `robot-forms@` robot. To learn more about configuring access, see [Setting access rights for queues](queue-access.md).

![](../../_assets/tracker/trigger-example-add-form-3.png)

Once the issue is closed, the robot will create a comment with the form and invite the assignee.

{% endif %}

## Send notifications to instant messengers {#section_vsn_mb2_d3b}

Messengers are a great way to quickly notify employees about important events. If a messenger has an API, you can use {{ tracker-name }} to set up a trigger that sends HTTP requests to the messenger's API when certain events occur. For instance, a request can be triggered once an error with the critical priority status is added to the queue.

To view examples for setting up triggers that send notifications to Slack and Telegram, see [{#T}](../messenger.md).

