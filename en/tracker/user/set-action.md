# Configure trigger actions

Configure one or more actions under **Trigger actions** by clicking **Add new action**:

- [Change issue status](set-action.md#section_change_status )
- [Update fields](set-action.md#section_mod_fields)
- [Add comment](set-action.md#dlentry_xvj_wls_kgb)
- [Calculate value](set-action.md#section_calc_field)
- [Move issue](set-action.md#sec_move)
- [Create issue](set-action.md#sec_create_issue)
- [HTTP request](set-action.md#dlentry_nbq_nms_kgb)

## Change issue status {#section_change_status}

Set a new issue status. Available issue statuses are set in the [workflow](../manager/workflow-status-edit.md) settings.

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

## Add comment {#dlentry_xvj_wls_kgb}

Enter the comment you wish to add to the issue.

You can also enter issue field values in your comment. To do this, click **Add variable** and select one or more values. The **Comment** field will show a sequence like `not_var{{issue.field_ID}}`.

## Calculate value {#section_calc_field}

You can set up a special field whose values are calculated automatically based on values entered in other fields. For example, you can automatically calculate the value of a metric.

To automatically calculate the value of a field:

1. Add the **Calculate value** trigger action.

1. Specify the formula to calculate the value by:
    - Click **Add variable** to add a field formula with numeric values. The formula will include a sequence like `not_var{{issue.field_ID}}`.
{% if audience == "external" %} If {{ tracker-name }} doesn't have the required field, you can [create one](create-param.md).{% endif %}
    - You can use mathematical symbols for addition `+`, subtraction `-`, multiplication `*`, and division `/`.
    - Use brackets (parentheses) to prioritize certain operations over others.

1. Click **Choose the field** and select the field where you want to insert the calculated value.

    {% note info %}

    The field value is rounded up to an integer.

    {% endnote %}

1. Set a condition that will trigger the calculation of the field value in the [**Trigger condition**](set-condition.md#section_set_condition) section. We recommend using the event **Formula fields changed**. You can also set any condition appropriate for your workflow.

## Move issue {#sec_move}

Specify the queue to move the issue to.

## Create an issue {#sec_create_issue}

You can set a trigger that automatically creates an issue when all specified conditions are met. For example, you can create a trigger that creates an issue for beta testing when a programmer implements a new feature and updates the issue status to <q>Resolved</q>.

To configure issue creation:

1. Add the trigger action **Create issue**.

1. Click **Fill in the fields**.

1. In the **Create issue** window:

    1. Specify the queue to create the issue in.

    1. Set the issue parameters and click **Save**.

1. If you want the Tracker robot to be the issue reporter, enable the option **Create as robot**. Make sure the robot has permission to create issues in the queue.

   If this option is disabled, the user who triggered the action becomes the issue reporter instead.

1. To link the automatically created issue to the issue that fired the trigger, enable the option **Link with initial issue**.

## HTTP request {#dlentry_nbq_nms_kgb}

If you want the trigger to send an HTTP request:

1. Select the HTTP request method.

1. Specify [the full URL of the website](https://tools.ietf.org/html/rfc3986) that will be used to send the request. For example: `http://example.org/newfolder/newfile`.

1. Choose your login method:

    - **NoAuth**

        No authorization.

    - [**Basic**](https://tools.ietf.org/html/rfc2617)

        Requires a username and a password.

    - [**OAuth 2.0**](https://tools.ietf.org/html/rfc6749)

        Requires a token, an auth header, and a token type.

   All authorization data (login, password, token, authorization header, token type) is sent to the according fields and you don't need to specify any of it again in the headers.

1. Enter request body.

   You can insert field values and user variables in your request body (see below). To do this, click **{ }** to the right of the field and choose the field or variable name. The request body will include a sequence like `not_var{{variable_name}}` .

   {% note info %}

   You can also add variables to the website address or header value.

   {% endnote %}

1. Enter headers and their values.

1. You can add more variables to your request body or header if needed. For example, you can add an authentication key or any other private information.

   {% note info %}

   After the trigger is saved, the value of the variable is hidden and can't be viewed.

   {% endnote %}

To view examples for setting up HTTP requests that send notifications from {{ tracker-name }} to Slack and Telegram, see [{#T}](../messenger.md).

{% if audience == "external" %}

[Contact support](../troubleshooting.md)

{% endif %}

