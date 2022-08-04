# Creating an issue via email

To create an issue via email, send a message with the issue description to the {% if audience == "external" %}[queue address](../manager/queue-mail.md){% else %}queue address{% endif %}:

{% if audience == "external" %}

1. Make sure the queue has its [email address](../manager/queue-mail.md#section_gwv_hqb_hgb) set up first.

1. Check that you have [access to the queue](../manager/queue-access.md).

{% endif %}

1. Creating a new message.

    {% note tip %}

    Create a new message for every issue. If you respond to a {{ tracker-name }} email or send an existing email again, it appears as an issue comment.

    {% endnote %}

1. Enter the issue name in the **Subject** field.

1. Describe the issue in the message body.

1. Send an email to the address {% if audience == "internal" %}`<KEY>-bugs@yandex-team.ru`, where `<KEY>` — is the queue key{% else %}, specified in [queue settings](../manager/queue-mail.md#section_gwv_hqb_hgb){% endif %}.

{% if audience == "external" %}You'll receive a reply notifying you that a new issue was created.{% endif %}

{% if audience == "internal" %}

## Changing the mailing list address {#section_kk4_4r4_xgb}

If the standard address `<KEY>-bugs@yandex-team.ru` doesn't suit you, change it. To do this, [create a mailing list and link it to your queue](../manager/queue-mail.md).

## Automatic reply {#section_yxj_sky_3bb}

To set up automatic replies to issue creation from emails, contact {{ tracker-name }} support using this [form](../manager/queue-mail.md#feedback_support_ya).

{% endif %}

