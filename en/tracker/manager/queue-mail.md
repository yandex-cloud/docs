# Mail

You can use {{ tracker-name }} to [create issues from emails sent to the queue mailbox](../user/create-ticket-by-mail.md) or [communicate with external users from the issue page](../user/comments.md#section_zpd_ph5_wdb). This lets you [register user requests sent to the support team](../support-process.md#mail).

To set up mail integration{% if audience == "external" %}:{% else %}, [add an email address to the queue](#sec-mail-yandex). You can add multiple addresses for creating issues with different types or different [components](edit-versions-and-components.md).{% endif %}

{% if audience == "external" %}

1. [Add an email address to the queue](#section_gwv_hqb_hgb). You can add multiple addresses for creating issues with different types or different [components](edit-versions-and-components.md).

1. [Set up issue creation from emails](#mail_tasks).

1. [Allow sending email to external users.](#send_outside).

{% note warning %}

Your organization must have a [domain]{% if locale == "ru" %}(https://yandex.ru/support/connect/add-domain.html){% else %}(https://yandex.com/support/connect/add-domain.html){% endif %} added to Yandex.Connect if you want to set up an email address.
By default, [only the queue owner](queue-access.md) can configure a queue.

{% endnote %}

## Adding email addresses {#section_gwv_hqb_hgb}

To add an email address to your queue, follow these steps:

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Administration**.

1. Go to the **Mailboxes** tab.

1. Click **Create address**.
If you can't create such an address, this means your organization doesn't have its own domain. You need a domain to create mailboxes and newsletters. This includes creating queue addresses. You can [add a domain]{% if locale == "ru" %}(https://yandex.ru/support/connect/add-domain.html){% else %}(https://yandex.com/support/connect/add-domain.html){% endif %} to Yandex.Connect for free.

1. Enter the address to assign to the queue in the **Email** field.

2. Choose the signature type for emails sent from the issue page:
    - **Standard**: Displays the sender's full name.
    - **Advanced**: Lets you hide the sender's name and insert one or several [nicknames](#section_ffq_gqb_hgb) instead.

3. Click **Save**.

{% note info %}

The queue email is only used for creating issues, writing comments, and as a return address when [sending emails](../user/comments.md#section_zpd_ph5_wdb) to external users. You can't log in to it as you would with a regular mailbox, as well as view or send regular emails.

{% endnote %}

## Set up issue creation via email {#mail_tasks}

Emails sent to the queue address can be used to create issues. You can configure issue creation parameters:

1. Go to the [**Mailboxes**](#section_gwv_hqb_hgb) tab in the queue settings.

1. Hover the cursor over the mailbox and click ![](../../_assets/tracker/icon-edit.png).

1. Set up the following parameters in the **Create issues by email** section:
    - Select the [type for issues](add-ticket-type.md) to be created from emails.
    - You can specify additional issue [components](edit-versions-and-components.md#section_ywj_1k4_4bb) in the **Components** field.
    - If you want to allow external users to create issues by email, choose **Accept email from external addresses**.

1. Click **Save**.

{% note info %}

To make sure your employees can create issues from emails, set up their [queue access](queue-access.md).

{% endnote %}

## Changing email settings {#section_kbm_rdb_qgb}

To change your queue email settings, follow these steps:

1. Go to the [**Mailboxes**](#section_gwv_hqb_hgb) tab in the queue settings.

1. Hover the cursor over the mailbox and click ![](../../_assets/tracker/icon-edit.png).

1. Make your changes and click **Save**.

## Nicknames {#section_ffq_gqb_hgb}

Nickname is a name used in place of an author's full name when sending email to outside users. For instance, you can set your company name as your own nickname. That way, all correspondence with your clients is conducted on behalf of your company rather than individual employees.

Each email address can have multiple nicknames associated with it.

#### Adding nicknames

1. Open your queue email settings or [set up a new email address](#section_gwv_hqb_hgb).

1. In the **Signature type** section, choose **Custom**.

1. Click **Add a custom sender name and signature**.

1. Enter your nickname. You can use one or multiple words consisting of letters, numbers, and symbols.

1. Click **Save**.

#### Adding multiple nicknames

You can add multiple nicknames and email addresses to use in different circumstances. If you don't want to mix up your nicknames when dealing with an outside user, do the following:

1. Go to the [**Mailboxes**](#section_gwv_hqb_hgb) tab in the queue settings.

1. Enable **Preserve sender name in issues**.

Now {{ tracker-name }} will first offer the nickname you've been using to talk to a particular user within a particular issue.

{% else %}

## Adding email addresses {#sec-mail-yandex}

To add an email address to your queue, follow these steps:

1. [Create](https://ml.yandex-team.ru/request/) a mailing list with the desired email address.

1. To link this mailing list to your queue, contact the {{ tracker-name }} support team via the form at the end of the current section:

    1. Under **Issue \ problem**, choose **Queues \ Queues**.

    1. Under **Request type**, choose **Link mailing list to queue**.

    1. Specify the parameters for linking the mailing list to the queue.

1. To change your mailing list settings, for example, create nicknames or link new components, use the same form.

{% endif %}

## Allowing sending email to external users {#send_outside}

If you want to [send email](../user/comments.md#section_zpd_ph5_wdb) to external email addresses from the issue page, you can enable this feature in the queue settings:

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Administration**.

1. Go to the **Basic settings** tab and click **Show advanced settings**.

1. Enable **Allow emails to be sent externally**.

{% if audience == "external" %}

[Contact support](../troubleshooting.md)

{% endif %}

