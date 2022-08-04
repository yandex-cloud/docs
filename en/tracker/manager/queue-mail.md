# Mail

You can use {{ tracker-name }} to [create issues from emails sent to the queue mailbox](../user/create-ticket-by-mail.md) or [communicate with external users](../user/comments.md#send-comment) from the issue page. This lets you [register user requests sent to the support team](../support-process-send-mail.md).

To set up email integration:



1. [Add an email address to the queue](#section_gwv_hqb_hgb). You can add multiple addresses for creating issues with different types or different [components](components.md).

1. [Set up issue creation based on emails](#mail_tasks).

1. [Allow sending emails to external users](#send_outside).

{% note warning %}

You can only set up an email address for the queue if your organization has a [domain]({{ support-business-domain }}) in {{ ya-360 }}. If you already have a mail domain set up in another service, you can create a subdomain for it and [add a domain]({{ support-business-domain }}).
By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

## Adding an email address {#section_gwv_hqb_hgb}

To add an email address to your queue, follow these steps:

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to the **Mailboxes** tab.

1. Click **Add email address**.
If you can't create such an address, this means your organization doesn't have its own domain. You need a domain to create mailboxes and newsletters. This includes creating queue addresses. A domain is free to [add in {{ ya-360 }}]({{ support-business-domain }}).

1. Enter the address to assign to the queue in the **Email** field.

1. Choose the signature type for emails sent from the issue page:
    - **Standard**: Displays the sender's full name.
    - **Advanced**: Lets you hide the sender's real name and place one or several [custom sender names](#section_ffq_gqb_hgb) instead.

1. Click **Save**.

{% note warning %}

The email address you've generated for the queue will become available within an hour after the queue's creation.

{% endnote %}

{% note info %}

The queue email address is only used for creating issues, writing comments, and as a return address when [sending emails](../user/comments.md#send-comment) to external users. You can't log in to it as you would with a regular mailbox, as well as view or send regular emails.

{% endnote %}

## Setting up issue creation via email {#mail_tasks}

Emails sent to the queue address can be used to create issues. You can configure issue creation parameters:

1. Go to the [**Mailboxes**](#section_gwv_hqb_hgb) tab in the queue settings.

1. Hover over the mailbox you need and click ![](../../_assets/tracker/icon-edit.png)

1. Set up the following parameters in the **Create issues by email** section:
    - Select the [type for issues](add-ticket-type.md) created from emails.
    - You can specify additional issue [components](components.md) in the **Components** field.
    - If you want to allow external users to create issues by email, select **Accept email from external addresses**.

1. Click **Save**.

{% note info %}

To enable your employees to create issues by email, set [queue access rights](queue-access.md) for them.

{% endnote %}

## Changing email settings {#section_kbm_rdb_qgb}

To change your queue email settings, follow these steps:

1. Go to the [**Mailboxes**](#section_gwv_hqb_hgb) tab in the queue settings.

1. Hover over the mailbox you need and click ![](../../_assets/tracker/icon-edit.png)

1. Make your changes and click **Save**.

## Sender names {#section_ffq_gqb_hgb}

The sender name is a name used in place of an author's full name when sending email to outside users. For instance, you can set your company name as your own sender name. That way, all correspondence with your clients is conducted on behalf of your company rather than individual employees.

Each email address can have multiple sender names associated with it.

#### Adding a sender name

1. Open your queue email settings or [set up a new email address](#section_gwv_hqb_hgb).

1. In the **Signature type** section, specify **Advanced**.

1. Click **Add a custom sender name and signature**.

1. Enter your nickname. You can use one or multiple words consisting of letters, numbers, and symbols.

1. Click **Save**.

#### Adding multiple nicknames

You can add multiple nicknames and email addresses to use in different circumstances. If you don't want to mix up your nicknames when dealing with an outside user, do the following:

1. Go to the [**Mailboxes**](#section_gwv_hqb_hgb) tab in the queue settings.

1. Enable **Preserve sender name in issues**.

That way {{ tracker-name }} will display the sender name you've been using when communicating with a particular user in a particular issue, unless you choose otherwise.


## Allowing sending emails to external users {#send_outside}

If you want to [send emails](../user/comments.md#send-comment) to external email addresses from the issue page, enable this feature in the queue settings:

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to the **Basic settings** tab and click **Show advanced settings**.

1. Enable **Allow to send emails outside of the intranet**.

