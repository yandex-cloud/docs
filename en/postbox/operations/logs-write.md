---
title: Writing to the execution log in {{ postbox-full-name }}
description: Follow this guide to configure address logging.
---

# Writing to the execution log in {{ postbox-name }}

{% include [logging-note](../../_includes/functions/logging-note.md) %}

You can set up logging when or after [creating](create-address.md) an address. To configure logging for an existing address:

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing the address.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. Select the address for which you want to configure logging.
    1. Under **{{ ui-key.yacloud.logging.label_title }}**, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.  
    1. In the **{{ ui-key.yacloud.logging.label_destination }}** field, select:
        * `{{ ui-key.yacloud.common.unspecified }}`: To disable logging.
        * `{{ ui-key.yacloud.common.folder }}`: To write logs to the default [log group](../../logging/concepts/log-group.md) for the folder where the address is located.
        * `{{ ui-key.yacloud.logging.label_loggroup }}`: To write logs to a custom log group. In the **{{ ui-key.yacloud.logging.label_loggroup }}** field, select the log group to write the logs to. If you do not have a log group, [create one](../../logging/operations/create-group.md).
    1. Optionally, to write logs for the emails switching from one status to another, enable **{{ ui-key.yacloud.postbox.label_mail-statuses }}**.
    1. Click **{{ ui-key.yacloud.common.save }}**.

    By default, {{ postbox-name }} only writes logs for address verification. When **{{ ui-key.yacloud.postbox.label_mail-statuses }}** is on, {{ postbox-name }} will write logs on the email being processed and delivered to the email client, as well as when it was not delivered to the recipient.

    To search for certain entries in the log group, you can use the [filter expression language](../../logging/concepts/filter.md). For example, to find all entries on sending messages to the recipient's email client with errors, use this expression:

    ```
    message = "Message bounced" and json_payload.message.to: "example@yandex.ru"
    ```

{% endlist %}

## See also {#see-also}

* [Create a configuration](create-configuration.md)
