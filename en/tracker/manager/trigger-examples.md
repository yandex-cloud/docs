# Examples

Let's look at some examples of how triggers work in {{ tracker-name }}:

- How to [automatically pick assignees](#assign_ticket) based on their status or component.

- How to [automatically invite assignees](#summon_ticket) based on the status or field value.

- How to [automatically change an issue's status](#new-link) after adding a certain type of link to it.

- How to [automatically notify a user](#notify_mail) after an issue was created based on a request sent to the support team via email.

- How to [automatically notify a user](#notify_form) after an issue was created based on a request sent to the support team via {{ forms-full-name }}.

- How to [automatically add a form](#insert_form) to the issue comment.

- How to [automatically add issues to the board](#board).

- How to [set up notifications in messengers](#section_vsn_mb2_d3b) via HTTP requests.

## Picking assignees automatically {#assign_ticket}

Different stages of a project are often handled by different employees. When an employee does their part, they transfer the issue to another assignee. In {{ tracker-name }}, each issue stage has its own status. When an issue receives a status update, a new employee can be automatically assigned to work on the issue with a trigger.

However, sometimes employees only handle issues related to their field of expertise and don't collaborate on a single issue. For example, each support team member only processes requests related to the product they were assigned to. To manage this kind of workflow, you can [configure components](components.md) so that they correspond to specific products. When a specific component is added to the issue, the employee responsible for the corresponding product is automatically assigned to work on it via a trigger.

Let's set up a trigger that automatically picks an assignee for our issue:



1. Make sure every employee you might want to assign [has full access to {{ tracker-name }}](../access.md).


1. Go to the queue settings, open the **Triggers** section, and click [**Create trigger**](../user/create-trigger.md).

1. Enter the trigger name.

1. Set the trigger to fire when the issue's <q>Status</q> or <q>Components</q> change:

    1. Choose **Conditions to be met** → **All**.

    1. Add the condition **Event type** → **Issue changed**.

    1. If you want a new assignee to be picked after a status update, add the following condition: **System** → **Status** → **Field value became equal to** and specify the status. The available statuses depend on the [workflow](workflow.md) set up for the queue.

        ![](../../_assets/tracker/trigger-example-status.png)

        If you want a new assignee to be picked after a component changes, add the following condition: **System** → **Components** → **Field value became equal to** and specify the components.

        ![](../../_assets/tracker/trigger-example-components.png)

        {% note info %}

        This trigger only works if only one component is specified in the issue.

        {% endnote %}

1. Set a trigger action:

    1. Add the action **Update fields**.

    1. Choose **System** → **Assignee** → **Set value** and specify who should be picked as the assignee after the trigger is fired.

        ![](../../_assets/tracker/trigger-example-assignee.png)

1. Save your trigger.
To see if you trigger works, pick any issue from the queue with the added trigger and change the issue's status or components.

## Inviting assignees automatically {#summon_ticket}

After completing an issue, the assignee may forget to specify some important information, such as time spent. In this case, you can configure a trigger that will automatically invite the assignee if the issue is closed and the time spent is not specified:

1. Go to the queue settings, open the **Triggers** section, and click [**Create trigger**](../user/create-trigger.md).

1. Enter the trigger name.

1. Set the trigger to react when the issue is closed with the <q>Time spent</q> field being empty:

    1. Choose **Conditions to be met** → **All**.

    1. Add the condition **System** → **Status** → **Field value became equal to** → **Closed**. The available statuses depend on the [workflow](workflow.md) set up for the queue.

    1. Add the condition **Time Spent** → **Time spent** → **Field value is empty**.

1. Set trigger actions:

    1. Add the **Add comment** action.

    1. Tap ![](../../_assets/tracker/summon.png), find the line **Invite users from a field**, and enter <q>Assignee</q>.

    1. Enter the comment to be displayed to the assignee and choose **Send as robot**.

1. Click **Create** to save the trigger.

    ![](../../_assets/tracker/trigger-example-summon.png)

When closing any issue that does not specify the time spent, the robot will create a comment and invite the assignee.

## Changing an issue's status after creating a link {#new-link}

In many projects, issues depend on each other even if different people are working on them. If an issue affects the progress of one or more other issues, it's important to notify other team members if any problems arise. For example, you can link such issues to each other and set the [link type](../user/links.md) **Blocker to**.

Let's set up a trigger that will change an issue's status and add a comment for its reporter when the **Blocker to** link is added:

1. Go to the queue settings, open the **Triggers** section, and click [**Create trigger**](../user/create-trigger.md).

1. Enter the trigger name.

1. Set the trigger to fire when the **Blocker to** link appears:

    1. Choose **Conditions to be met** → **All**.

    1. Add the following condition: **Action with link** → **Link created** → **Blocking issue**.

    ![](../../_assets/tracker/blocker-conditions.png)

1. Set trigger actions:

    1. Add the action **Change issue status**.

    1. In the **Next status** field, select the status to switch the issue to when the condition is met. For example, **Need info**. The available statuses depend on the [workflow](workflow.md) set up for the queue.

    1. Add the **Add comment** action.

    1. Tap ![](../../_assets/tracker/summon.png), find the line **Invite users from a field**, and enter <q>Reporter</q>.

    1. Enter the comment to be displayed to the issue reporter and choose **Send as robot**. Otherwise, the comment is sent on behalf of the user who initiates the trigger action by adding the link.

    ![](../../_assets/tracker/blocker-actions.png)

1. Click **Create** to save the trigger.

## Sending a notification when an issue is created from an email {#notify_mail}

Let's say the support team is processing user requests in {{ tracker-name }}. Users contact the support team via email, and those emails are used as the basis for issues in {{ tracker-name }}.

Let's set up a trigger that automatically sends an email to the user telling them that their request has been registered:

#### Step 1. Configure email integration

You need to set up email integration if you want to send emails right from {{ tracker-name }} and create issues from incoming emails:

1. [Set up an email address for the queue](queue-mail.md#section_gwv_hqb_hgb) to store issues created based on user requests.

    If you can't create such an address, this means your organization doesn't have its own domain. You need a domain to create mailboxes and newsletters. This includes creating queue addresses. A domain is free to [add in {{ ya-360 }}]({{ support-business-domain }}).

1. [Set up sender names and signatures](queue-mail.md#send_outside) if needed.



1. If users aren't your organization's employees:

    1. [Allow receiving emails from external addresses](queue-mail.md#mail_tasks).

    1. [Allow sending emails from issue pages to external addresses](queue-mail.md#send_outside).


#### Step 2. Set up a trigger for sending email

Set up a trigger that automatically notifies users by mail when a new issue is created based on an email:

1. Go to the queue settings, open the **Triggers** section, and click [**Create trigger**](../user/create-trigger.md).

1. Enter the trigger name.

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

    1. Write the email. You can add [issue parameters](../user/vars.md) to the email by clicking the **Add variable** button.

    ![](../../_assets/tracker/trigger-example-mail-action.png)

1. Save your trigger.

    To see if the trigger works, send an email to the queue address.

## Sending a notification when an issue is created based on a form {#notify_form}

Let's say the support team is processing user requests in {{ tracker-name }}. Users contact the support team via a feedback form created in [{{ forms-full-name }}]({{ link-forms }}). A {{ tracker-name }} issue is then created based on that form.

Let's set up a trigger that automatically sends an email to the user telling them that their request has been registered:

#### Step 1. Configure email integration

You need to set up email integration if you want to send emails from {{ tracker-name }}:

1. [Set up an email address for the queue](queue-mail.md#section_gwv_hqb_hgb) to store issues created based on user requests.

   If you can't create such an address, this means your organization doesn't have its own domain. You need a domain to create mailboxes and newsletters. This includes creating queue addresses. A domain is free to [add in {{ ya-360 }}]({{ support-business-domain }}).

1. [Set up sender names and signatures](queue-mail.md#send_outside) if needed.

1. If the users aren't your organization's employees, [allow sending emails from issue pages to external addresses](queue-mail.md#send_outside).

#### Step 2. Set up a form to register requests

To create issues from requests sent through forms:

1. Go to [{{ forms-full-name }}]({{ link-forms }}) and create a new form.

1. Add questions that let users provide relevant information necessary to register their request.

    If you want to know the user's email address, add the **Email** question and make it a required field.

    ![](../../_assets/tracker/trigger-example-form-constructor.png)

1. Set up your form's [integration with {{ tracker-name }}](../../forms/create-task.md):

    1. Specify your queue and other issue parameters.

    1. Use the **Issue description** field to add answers to the questions included in your form.

    1. To save the user's email address in the issue settings, add the **From** field and select **Variables** → **Answer to question** → **Email**.

    1. Save your integration settings.

    ![image](../../_assets/tracker/trigger-example-form-integration.png)

1. [Publish](../../forms/publish.md#section_link) your form.

#### Step 3. Set up a trigger for sending email

Set up a trigger that sends automatic email notifications via a form when a new issue is created:

1. Go to the queue settings, open the **Triggers** section, and click [**Create trigger**](../user/create-trigger.md).

1. Enter the trigger name.

1. Set the trigger to fire when a new issue is created based on an incoming email:

    1. Choose **Conditions to be met** → **All**.

    1. Add the condition **Event type** → **Issue created**.

    1. Add the condition **Email** → **From** → **Field value became not empty.**.

    ![](../../_assets/tracker/trigger-example-form-condition.png)

1. Set sending a message as the trigger action:

    1. Choose the **Add comment** action.

    1. Enable the **Email** option.

    1. In the **To** field, add the variable with the address of the user who sent the request. To do this, select the **To** field, click **Add variable**, and choose **Email** → **From**.

    1. Write the email. You can add [issue parameters](../user/vars.md) to the email by clicking the **Add variable** button.

    ![](../../_assets/tracker/trigger-example-mail-action.png)

1. Save your trigger.

    To see if your trigger works, fill out the form you integrated with {{ tracker-name }}.

## Automatically adding a form to the issue comments {#insert_form}

Using a trigger, you can add a form with auto-prefilled fields to the issue comments. To do this, add a special code with a link to the form in the comment text. Values can be passed to the form fields via [GET parameters](../../forms/get-params.md). For example, you can send issue parameters via [variables](../user/vars.md) available in triggers.

Let's set up a trigger that adds a feedback form to the comments and invites an assignee after the issue is closed:

#### Step 1. Create a feedback form

1. Go to [{{ forms-full-name }}]({{ link-forms }}) and create a form. 

1. Add questions to the form so that the assignee can provide necessary information.

#### Step 2. Create a trigger to add the form

1. Go to the queue settings, open the **Triggers** section, and click [**Create trigger**](../user/create-trigger.md).

1. Set the trigger to fire when the issue is closed:

    1. Choose **Conditions to be met** → **All**.

    1. Add the condition **Status** → **Field value became equal to** → **Closed**.

    ![](../../_assets/tracker/trigger-example-add-form-1.png)

1. Add the **Add comment** action.

1. In the comment text, insert the code:

    

    ```
    {{=<% %>=}}/iframe/(src="https://forms.yandex.ru/surveys/<form_id>/?iframe=1&<question_id>=<value>" frameborder=0 width=500)
    ```


    - `<form id>` is the ID of the form to be added.

    - `<question_id>`is the [ID of the question](../../forms/question-id.md#sec_question).

    - `<value>` is the value to populate the form field.

      To transfer issue parameters to the form, use [ variables](../user/vars.md)   as values: click **Add variable** and choose your issue parameter. Then replace the `not_var{{ }}` characters around the name of the variable with `<% %>`.

      For example, to pass an issue key, use the `<%issue.key%>` value. To pass the username of an assignee, use the `<%issue.assignee.login%>` value.

    Code example where an issue key is passed to the form field:

     

     ```
     {{=<% %>=}}/iframe/(src="https://forms.yandex.ru/surveys/68417/?iframe=1&answer_short_text_584943=<%issue.key%>" frameborder=0 width=100% height=660px scrolling=no}}
     ```


1. Click ![](../../_assets/tracker/summon.png), find the line **Invite users from a field**, and enter <q>Assignee</q>.

1. Enable the **Send as robot** option.



1. Click **Create** to save the trigger.

#### Step 3. Add yndx-forms-cnt-robot@ to the queue

To ensure the form is inserted correctly, provide access to the queue for the yndx-forms-cnt-robot@ robot. To learn more about configuring access, see [Setting access rights for queues](queue-access.md).



Once the issue is closed, the robot will create a comment with the form and invite the assignee.

## Automatically adding issues to the board {#board}

The [new version of the issue board](agile-new.md) currently doesn't support filters that let you add issues to the board automatically. However, you can set up a trigger as a substitute for the feature.

You can also [set up an auto action](../user/create-autoaction.md) with similar conditions and outcomes. When using an auto action, issues that fit your desired conditions will be added to the board at preset intervals rather than all at once.

{% note warning %}

Triggers and auto actions work only for issues within the queue they were configured in.

{% endnote %}

Let's look at an example of a trigger that adds an issue to the board once a specific user is selected as the assignee for the issue:

1. Go to the queue settings, open the **Triggers** section, and click [**Create trigger**](../user/create-trigger.md).

1. Enter the trigger name.

1. Set the condition: **Assignee** → **equals** → `<User's name>`.

   {% note info %}

   A trigger with this condition will also activate when a new issue with the selected assignee is created.

   {% endnote %}

1. Set the action:

    1. Select the action **Update fields**.

    1. Select the **Boards** field.

    1. Select **Add to list** and choose the board to add the issue to.

    ![](../../_assets/tracker/trigger-example-board.png)

1. Save your trigger.

## Sending notifications to instant messengers {#section_vsn_mb2_d3b}

Messengers are a great way to quickly notify employees about important events. If a messenger has an API, you can use {{ tracker-name }} to set up a trigger that sends HTTP requests to the messenger's API when certain events occur. For instance, a request can be triggered once an error with the critical priority status is added to the queue.

To view examples for setting up triggers that send notifications to Slack and Telegram, see [{#T}](../messenger.md).

