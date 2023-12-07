# Adding a feedback form

To resolve current issues received by the HR department from company employees, create a separate queue available to all employees and configure adding a feedback form upon closing an issue.

## Create a queue

1. [Create a queue](manager/create-queue.md) using the <q>Start now</q> template.
1. Give it a name, e.g., `General Questions`.
1. Create additional issue types and workflows if needed.

## Set up a feedback form

1. Create a feedback form. For instance, this can be a form named "Evaluate our work" with a single question of the `List` type. You can specify the following as list options:
   - `Excellent`
   - `Good`
   - `Average`
   - `Bad`
1. Set up the form's integration, for example, with [your API](../forms/send-request.md) for collecting statistics.

## Set up a trigger for adding a form

### Create a trigger

1. Go to the `General Questions` queue settings and click **Create trigger** in **Triggers**.
1. Add the condition: **Status** → **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldBecameEqual }}** → **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}**.
1. Add the **Add comment** action.
1. Use the following code as the comment text:

   ```
   {{=<% %>=}}/iframe/(src="https://forms.yandex.ru/cloud/<form_id>/?iframe=1" frameborder=0 width=100% height=660px scrolling=no)
   ```
   Where `<form_id>` is the ID of the form to add.
1. Click ![](../_assets/tracker/summon.png) and enter <q>Assignee</q> in the **Invite users from a field** line.
1. Enable **Send as robot**.
1. Click **Create** to save the trigger.

### Grant access permissions to the {{ forms-name }} robot

To ensure the form is inserted correctly, provide the {{ forms-name }} robot (`yndx-forms-cnt-robot@`) with access to the queue:

1. In the `General Questions` queue settings, select **Access**.
1. Under **Access control**, enter `Robot` in the search field and select **Service robot {{ forms-name }} Robot** from the list.
1. Click **Save**.

## Test the trigger

1. Create an issue on the `General Questions` queue page.
1. Change the issue status to **{{ ui-key.startrek-backend.applinks.samsara.status.closed }}**.
1. Make sure a comment with the feedback form has appeared.