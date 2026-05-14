The `postbox.admin` role enables managing Yandex Cloud Postbox addresses, sending emails, and viewing info on sent emails as well as their statistics.

Users with this role can:
* Create, modify, and delete [addresses](../../postbox/concepts/glossary.md#adress) and their [configurations](../../postbox/concepts/glossary.md#configuration).
* View info on addresses and their configurations.
* Get a list of addresses and their configurations.
* Send emails.
* View [statistics](../../postbox/concepts/statistics.md) on sent emails in the **{{ ui-key.yacloud.postbox.label_statistics }}** section of the [management console]({{ link-console-main }}).
* View info on sent emails in the **{{ ui-key.yacloud.postbox.label_messages }}** section of the management console, including data on the sender, receivers, subject, sending date, deliverability and engagement [metrics](../../postbox/concepts/statistics.md#metrics), complaints, and unsubscriptions.

This role includes the `postbox.editor`, `postbox.messages.reader`, and `postbox.statistics.reader` permissions.
