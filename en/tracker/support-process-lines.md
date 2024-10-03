---
title: How to configure multi-tiered support in {{ tracker-full-name }}
description: Follow this guide to configure multi-tiered support.
---

# Configuring multi-tiered support

Technical support services often have a multi-tiered structure.

- Support line 1 accepts user requests, collect necessary information, and resolves relatively simple problems. More complex problems are handed over to Support line 2.

- Support line 2 involves highly qualified experts capable to solve sophisticated technical problems.

- Sometimes companies decide to enable Support line 3 to solve the most sophisticated problems.

To distribute requests between the support lines and determine which line is currently dealing with a given request, you can use issue statuses in {{ tracker-name }} or a dedicated line field.

## Using statuses

You can assign an issue status for each support line. For example, the queue template called [Multi-tiered support](manager/workflows.md#section_sup_lines) includes such issue statuses as **Support line 1** and **Support line 2**. If you need to set up a third support line, [configure an additional status](manager/workflow.md).

## Using issue fields

Sometimes, it may be more convenient [to create a new issue field](user/create-param.md#section_pxn_fp4_xgb). Let's say you [receive user requests via forms](#form) and you want them to be automatically distributed between your two support lines based on the subject of the request. When you create an issue from a form, you cannot set its status to any of the support lines, because all new issues automatically have the **Open** status. However, you can assign values to issue fields provided the request has a specific subject. You can then automatically change issue statuses based on the value in that issue field.

To do this in {{ tracker-name }}:


### Step 1. Create a new field for the issue

Go to the {{ tracker-name }} settings and [create a new field](user/create-param.md#section_pxn_fp4_xgb) with the following parameters:

- Field type: **Drop-down list**.

- Category: **{{ ui-key.startrek-backend.fields.issue.fields.system }}**.

- Name: Line. Use any English name and key you like, for example, Line.

- Item selection: **Single item**.

- Values in the list: 1, 2 (for two-tiered support).

![](../_assets/tracker/param-support-line.png)


### Step 2. Set up a request form

1. Go to [{{ forms-full-name }}]({{ link-forms }}) and create a new form.

1. Add questions that allow users to provide relevant information that is required to register their request.

   To distribute requests between support lines, add a drop-down list called **Subject** to the form and specify some common problems.

1. Configure [issue creation in {{ tracker-name }}](../forms/create-task.md) for the first support line in the integration settings:

   1. Configure [notification conditions](../forms/notifications.md). The **Subject** list displays subjects to be tackled by the first support line.

      ![](../_assets/tracker/support-form-condition.png)

   1. Add the **Line** issue field and set its value to 1.

      ![](../_assets/tracker/support-form-fields.png)

   1. If you want to assign the issue to the employee responsible for the specified support line, specify their username in the **Assignee** field.

   1. Save your integration settings.

1. Similarly to Support line 1, add a new notification group and set up a condition for creating an issue for Support line 2 with its parameters.

1. Save the integration settings.

### Step 3. Set up a condition that triggers a status change

In the support team queue, create two triggers that will be fired if the **Line** field value changes and will update issue statuses:

1. Go to the queue settings, open the **Triggers** section, and click [**Create trigger**](user/create-trigger.md).

1. Add the condition **{{ ui-key.startrek-backend.fields.issue.fields.system }}** → **Line** → **{{ ui-key.startrek-backend.messages.trigger.condition.type.fieldBecameEqual }}** → **1**.

1. Add the action **Change issue status** → **Support line 1**.

1. Save your trigger.

   ![](../_assets/tracker/support-line-triggers.png)

1. Create a similar trigger for Support line 2.

Issues created via the form will now automatically be distributed between the two support lines based on their subject.