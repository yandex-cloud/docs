# Configuring multi-tiered support

Technical support services often have a multi-tiered structure:

- Tier 1 accepts user requests, collect necessary information, and resolves relatively simple problems. More complex problems are handed over to Tier 2.

- Tier 2 support includes highly qualified experts capable to solve sophisticated technical problems.

- Sometimes companies decide to enable Tier 3 support to solve the most sophisticated problems.

To distribute requests between the support tiers and determine which tier is currently dealing with a given request, you can use issue statuses in {{ tracker-name }} or a dedicated tier field.

## Using statuses

You can assign an issue status for each support tier. For example, the [<q>Multi-tiered support</q>](manager/workflows.md#section_sup_lines) queue template includes issue statuses like <q>Support line 1</q> and <q>Support line 2</q>. If you need to set up a third support line, [configure an additional status](manager/workflow.md).

## Using issue fields

Sometimes it may be more convenient to [create a new issue field](user/create-param.md#section_pxn_fp4_xgb). Let's say you [receive user requests via forms](#form) and you want them to be automatically distributed between your two support lines based on the subject of the request. When you create an issue from a form, you cannot assign it a status that corresponds to any of the support lines, because all new issues automatically have the <q>Open</q> status. However, you can assign values to issue fields provided the request has a specific subject. You can then automatically change issue statuses based on the value in that issue field.

To do this in {{ tracker-name }}:


### Step 1. Create a new field for the issue

Go to the {{ tracker-name }} settings and [create a new field](user/create-param.md#section_pxn_fp4_xgb) with the following parameters:

- Field type: **Dropdown list**.

- Category: **{{ ui-key.startrek-backend.fields.issue.fields.system }}**.

- Name: <q>Line</q>. Use any English name and key you like, for example, Line.

- List item count: **Single item**.

- Values in the list: 1, 2 (for two-tiered support).

![](../_assets/tracker/param-support-line.png)


### Step 2. Set up a request form

1. Go to [{{ forms-full-name }}]({{ link-forms }}) and create a new form.

1. Add questions that allow users to provide relevant information that is required to register their request.

   To distribute requests between support lines, add a drop-down list to the <q>Request subject</q> form and specify some common problems.

1. Configure [issue creation in {{ tracker-name }}](../forms/create-task.md) for the first support line in the integration settings:

   1. Configure [notification conditions](../forms/notifications.md). The <q>Request subject</q> list displays subjects that should be tackled by the first support line.

      ![](../_assets/tracker/support-form-condition.png)

   1. Add the <q>Line</q> issue field and set the value to 1.

      ![](../_assets/tracker/support-form-fields.png)

   1. If you want to assign the issue to the employee responsible for the specified support line, specify their username in the **Assignee** field.

   1. Save your integration settings.

1. Similarly to Tier 1, add a new notification group and set up a condition for creating an issue for Tier 2 with its parameters.

1. Save the integration settings.

### Step 3. Set up a condition that triggers a status change

In the support team queue, create two triggers that will be fired if the **Line** field value changes and will update issue statuses:

1. Go to **Triggers** in the queue settings and click [**Create trigger**](user/create-trigger.md).

1. Add the condition **{{ ui-key.startrek-backend.fields.issue.fields.system }}** → **Line** → **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldBecameEqual }}** → **1**.

1. Add the action **Change issue status** → **Support line 1**.

1. Save your trigger.

    ![](../_assets/tracker/support-line-triggers.png)

1. Create a similar trigger for Tier 2.

Issues created via the form will now automatically be distributed between the two support lines based on their subject.