# Configuring trigger actions

Configure one or more actions under **Actions** by clicking **Add new action**:

- [Change issue status](set-action.md#section_change_status)
- [Update fields](set-action.md#section_mod_fields)
- [Add a comment](set-action.md#create-comment)
- [Create checklist](set-action.md#create-checklist)
- [Calculate value](set-action.md#section_calc_field)
- [Move issue](set-action.md#sec_move)
- [Create issue](set-action.md#sec_create_issue)
- [HTTP request](set-action.md#create-http)

## Changing issue status {#section_change_status}

Set a new issue status. The available statuses depend on the [workflow](../manager/workflow-status-edit.md) settings.

If you set up a [transition screen](../manager/workflow-action-edit.md#section_uf2_sks_gcb) for a status update, make sure it doesn't have required fields. Otherwise, it won't be possible to change the status using a trigger.

## Update fields {#section_mod_fields}

Set new values for one or more fields:

1. Click **Select field** and specify the field.

1. Choose an action:

    | Action | Description |
    | ----- | ----- |
    | Set value | Assigns the set value to a field |
    | Clear field | Clears the field value. |
    | Add to the list | Add one more field value (for fields that can contain multiple elements). |
    | Remove from list | Remove one of the field values (for fields that can contain multiple elements). |

1. Enter a new field value.

## Add comment {#create-comment}

Enter the comment you wish to add to the issue.

You can also enter [issue field values in your comments](vars.md). To do this, click **Add variable** and select one or more values. The **Comment** field will show a sequence like `not_var{{issue.<field_ID>}}`.

## Create a checklist {#create-checklist}

Create a [checklist](checklist.md) that will be added to an issue.

{% note info %}

The action won't work if the issue already contains a checklist.

{% endnote %}

To add a checklist item:

1. Click **Add item**.

1. Enter a description for the item. If necessary, specify the assignee and deadline.

1. Click **Save**.

## Calculate value {#section_calc_field}

You can set up a special field whose values are calculated automatically based on values entered in other fields. For example, you can automatically calculate the value of a metric.

To automatically calculate the value of a field:

1. Add the trigger action **Calculate value**.

1. Specify the formula to calculate the value by:
    - Click **Add variable** and add a field formula with numeric values. The formula will include [a sequence](vars.md) like `not_var{{issue.field_ID}}`.
{% if audience == "external" %}If the desired field is missing in {{ tracker-name }}, you can [create one](create-param.md).{% endif %}
    - You can use mathematical symbols for addition `+`, subtraction `-`, multiplication `*`, and division `/`.
    - Use brackets (parentheses) to prioritize certain operations over others.

1. Click **Choose the field** and set the field you want to put the calculated value into.

    {% note info %}

    If the selected field only supports integers, the value will be rounded off.

    {% endnote %}

1. Set a condition that will trigger the calculation of the field value in the [**Trigger conditions**](set-condition.md#section_set_condition) section. We recommend using the event **Formula fields changed**. You can also set any condition appropriate for your workflow.

## Move issue {#sec_move}

1. Add the trigger action **Move issue**.

1. Specify the queue to move the issue to.

The issue will only be moved if the user initiating the trigger has the permission to create issues in the selected queue.

## Create an issue {#sec_create_issue}

You can set a trigger that automatically creates an issue when all specified conditions are met. For example, you can create a trigger that creates an issue for beta testing when a programmer implements a new feature and updates the issue status to <q>Resolved</q>.

To configure issue creation:

1. Add the trigger action **Create issue**.

1. Click **Fill in the fields**.

1. In the **Create issue** window:

    1. Specify the queue to create the issue in.

    1. Set issue parameters and click **Save**.

1. If you want the {% if audience == "external" %}Tracker robot{% else %}Yandex Tracker robot{% endif %} to be the issue reporter, select **Create as robot**. Make sure the robot has permission to create issues in the queue.

   If this option is disabled, the user who triggered the action becomes the issue reporter instead. In this case, the issue will only be created if the user has the permission to create issues in the selected queue.

1. If you want to link the issue that enabled the trigger to the issue created by that trigger, select **Link with initial issue**.

## HTTP request {#create-http}

If you want the trigger to send an HTTP request:

1. Select the HTTP request method.

1. Specify [the full address of the website](https://tools.ietf.org/html/rfc3986) that will be used to send the request. For example: `http://example.org/newfolder/newfile`.

1. Choose your login method:

    - **NoAuth**

        No authorization.

    - [**Basic**](https://tools.ietf.org/html/rfc2617)

        Requires a username and a password.

    - [**OAuth 2.0**](https://tools.ietf.org/html/rfc6749)

        Requires a token, an auth header, and a token type.

   All authorization data (login, password, token, authorization header, token type) is sent to the according fields and you don't need to specify any of it again in the headers.

1. Enter request body.

   You can insert [field values](vars.md) and user variables in your request body. To do this, click **{ }** to the right of the field and choose the name for the field or value. The request body will include a sequence like `not_var{{variable name}}`.

   {% note info %}

   You can also add variables to the website address or header value.

   {% endnote %}

1. Enter headers and their values.

1. You can add more variables to your request body or header if needed. For example, you can add an authentication key or any other private information.

   {% note info %}

   After the trigger is saved, the value of the variable is hidden and can't be viewed.

   {% endnote %}

To view examples for setting up HTTP requests that send notifications to Slack and Telegram from {{ tracker-name }}, see [{#T}](../messenger.md).

