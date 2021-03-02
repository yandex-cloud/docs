# Macros

In {{ tracker-name }}, macros are scripted algorithms that can be executed on the issue page. You can use macros to automate repeating actions. Macros allow you to change issue fields, create automated comments and send messages in just one click.

## Creating a macro {#section_inq_5b1_x2b}

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

Each {{ tracker-name }} queue has its own set of macros. To create a new queue macro, do the following:

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Administration**.

1. On the left-hand panel, select **Automation** → **Macros** and click **Create macro**.

1. Set up your macro parameters:
    - **Macro name**.
    - **Message**: Message body (comment or email) created when executing a macro. If you don't want your macro to leave any messages, leave this field empty.
You can insert field values into your comments. To do this, click **Add variable** and select one or more values. The **Message** field will show a sequence like `not_var{{issue.fieldKey}}`.
    - **Actions**: Choose the issue fields a macro should change and specify their values after the change.

1. Click **Create macro**.

## Edit and delete macros {#section_swl_sdb_x2b}

{% note warning %}

By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Administration**.

1. On the left-hand panel, select **Automation** → **Macros** and hover the cursor over the macro you need.

1. To edit the macro, click ![](../../_assets/tracker/icon-edit.png).
To delete a macro, click ![](../../_assets/tracker/icon-delete.png).

## Run a macro {#section_ekq_22b_x2b}

Macros allow you to change issue fields, create automated comments and email messages. Any user with access rights to issue editing can execute macros.

To run a macro:

1. Open the issue page.

1. Go to the comment field.

1. Select a macro from the drop-down **Macros** list.
You can select multiple macros at the same time. If multiple macros change the same field, only the last executed change will be applied.

1. To send a message using a macro, go to the **Message** tab and [configure its fields](../user/comments.md#section_zpd_ph5_wdb).

1. To execute the macro, click **Send**.



[Contact support](../troubleshooting.md)

