---
title: "How to set up a trigger action in {{ tracker-full-name }}"
description: "In this tutorial, you will learn how to set up a trigger action."
---

# Configuring trigger actions

Configure one or more actions under **Trigger action** by clicking **Add action**:

- [Change issue status](set-action.md#section_change_status)
- [Update fields](set-action.md#section_mod_fields)
- [Add comment](set-action.md#create-comment)
- [Create checklist](set-action.md#create-checklist)
- [Calculate value](set-action.md#section_calc_field)
- [Move issue](set-action.md#sec_move)
- [Create issue](set-action.md#sec_create_issue)
- [HTTP request](set-action.md#create-http)

## Change issue status {#section_change_status}

Set a new issue status. The available statuses depend on the [workflow](../manager/workflow-status-edit.md) settings.

If you set up a [transition screen](../manager/workflow-action-edit.md#section_uf2_sks_gcb) for a status update, make sure it does not have required fields. Otherwise, you will not be able to change the status using a trigger.


## Updating fields {#section_mod_fields}

Set up new values for one or more fields.

1. Click **Select fields** and specify the field.

1. Select an action:

   | Action | Description |
   ----- | -----
   | Set value | Assign the value to a field |
   | Clear field | Delete a field value |
   | Add to list | Add another value for the field (for multiple-item fields) |
   | Remove from list | Remove one value from the field (for multiple-item fields) |

1. Specify the new value for the field.


## Add comment {#create-comment}

Write the comment text that will be added to an issue.

You can insert [values of issue fields](vars.md) into the comment text. To do this, click **Add variable** and select one or more values. The **{{ ui-key.startrek-backend.fields.issue.meta.comment }}** field will show a sequence like `not_var{{issue.<field_ID>}}`.


## Creating a checklist {#create-checklist}

Create a [checklist](checklist.md) that will be added to an issue.

{% note info %}

The action won't work if the issue already contains a checklist.

{% endnote %}

To add a checklist item:

1. Click **Add item**.

1. Enter a description for the item. If necessary, specify the assignee and deadline.

1. Click **Save**.


## Calculate value {#section_calc_field}

You can set up a special field whose values are calculated automatically based on values entered in other fields. For example, you can automatically calculate the value of a certain metric.

To calculate the field value automatically:

1. Add an action for the **{{ ui-key.startrek-backend.types.types.trigger.action.calc.formula }}** trigger.

1. Set a formula for calculating the value:
   - Click **Add variable** and add a field formula with numeric values. The formula will include a [sequence](vars.md) like `not_var{{issue.<field_key>}}`.
            If the desired field is missing in {{ tracker-name }}, you can [create one](create-param.md).
   - You can use mathematical symbols for addition `+`, subtraction `-`, multiplication `*`, and division `/`.
   - To set the priority of operations, use parentheses.

1. Click **Choose the field** and set the field you want to put the calculated value into.

   {% note info %}

   If the field supports only integer values, the value will be rounded.

   {% endnote %}

1. Set a condition that will trigger the calculation of the field value in the [**Trigger conditions**](set-condition.md#section_set_condition) section. We recommend choosing the **{{ ui-key.startrek-backend.messages.trigger.condition.type.calculate.formula.watch }}** event. You can also set any conditions you need for your issue workflow.


## Moving an issue {#sec_move}

1. Add the **Move issue** trigger action.

1. Select the queue to move your issue to.

The issue will be moved only if the user who ran the trigger has rights for creating issues in the selected queue.

## Creating an issue {#sec_create_issue}

You can set up a trigger that will automatically create an issue when certain conditions are met. For example, you can create a trigger that creates an issue for beta testing when a programmer implements a new feature and updates the issue status to <q>{{ ui-key.startrek-backend.applinks.samsara.status.resolved }}</q>.

To set up creation of an issue:

1. Add the **Create issue** trigger action.

1. Click **Fill in fields**.

1. In the **Issue creation** window:

   1. Specify the queue to create an issue automatically in.

   1. Set issue parameters and click **Save**.

1. If you want the Tracker robot to be the issue reporter, select **Create as robot**. Make sure that the robot has rights for creating issues in the selected queue.

   If the option is disabled, the user whose action fired the trigger will be assigned as the issue's reporter. In this case, the issue will be created only if the user has rights for creating issues in the selected queue.

1. If you want to link the issue that enabled the trigger to the issue created by that trigger, select **Link with initial issue**.

## HTTP request {#create-http}

To send an HTTP request whenever the trigger is fired:

1. Select the HTTP request method.

1. Specify the [full URL of the resource](https://tools.ietf.org/html/rfc3986) to which the request will be sent. For example: `http://example.org/newfolder/newfile`.


1. Choose the authorization method:
   - **NoAuth**

      Without authorization.

   - [**Basic**](https://tools.ietf.org/html/rfc2617)

      You are prompted to enter your username and password.

   - [**OAuth 2.0**](https://tools.ietf.org/html/rfc6749)

      You're prompted to enter a token, authorization header, and token type.

   The authorization data (username, password, token, authorization header, token type) are transmitted in relevant fields and don't require to be re-entered in headers.

1. Enter the request body.

   You can add [issue field values](vars.md) or custom variables to the request body. To do this, click **{ }** to the right of the field and choose the name for the field or value. The request body will include a sequence like `not_var{{variable_name}}`.

   {% note info %}

   You can also use variables in the resource URL and header value.

   {% endnote %}

1. Enter the headers and their values.

1. Add new variables if you need them in the request body or headers. For example, you can add an authentication key or other secret information.

   {% note info %}

   When you save the trigger, the variable's value is hidden, and you can't look it up later.

   {% endnote %}

Sample HTTP request settings:

- [Sending notifications from {{ tracker-name }} to Slack and Telegram](../messenger.md).

- [Creating and updating a checklist in an issue](../manager/trigger-examples.md#checklist).

- [Creating an issue with field values from its parent issue](../manager/trigger-examples.md#create-ticket-with-params).

- [Updating status, priority and adding a comment in related issues](../manager/trigger-examples.md#update-related-tasks).

