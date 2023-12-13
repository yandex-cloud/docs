# Configuring a response in {{ cloud-logging-full-name }} and {{ sf-full-name }}

You can configure [{{ sf-name }}](../../functions/) to automatically respond to audit log events. For example, to send messages through convenient notification channels or automatically modify {{ yandex-cloud }} resource settings to compensate for changes.

## How it works {#scheme}

In general, you will require the following components to configure a response via {{ sf-name }}:

1. A trail uploads [audit logs to a log group](../operations/export-cloud-logging.md).
2. A [log group](../../logging/concepts/log-group.md) acts as an interface between a trail and a {{ sf-name }} trigger.
3. A [{{ cloud-logging-full-name }} trigger](../../functions/concepts/trigger/cloud-logging-trigger.md) calls the function when adding an entry to a log group.
4. A [{{ sf-name }} function](../../functions/concepts/function.md) to execute the response logic.
5. An optional auxiliary component, such as a Telegram bot or mail server.

## Example implementation {#example}

[Yc-security-solutions-library](https://github.com/yandex-cloud-examples/yc-security-solutions-library) contains an example [solution](https://github.com/yandex-cloud-examples/yc-audit-trails-automatic-response) that uses {{ sf-name }} to provide notification of specified events via a Telegram bot and perform compensating actions on {{ yandex-cloud }} resources via API methods.

Notifications are implemented for the following events:
* Security groups: Allowing incoming traffic to all private addresses (0.0.0.0/0).
* {{ objstorage-name }}: Enabling public access to buckets.
* {{ lockbox-name }}: Assigning access to a secret.

Compensating actions on {{ yandex-cloud }} resources:
* Security groups: Delete the rule.
* {{ lockbox-name }}: Disable assigned access to the secret.

{% include [Yc-security-solutions-library](../../_includes/security-solution-library.md) %}

A solution contains the source codes of a Python function and a {{ TF }} script that configures all the {{ yandex-cloud }} components required to complete the procedure.

## What's next {#whats-next}

* Learn more about the [audit log format](../concepts/format.md).
* Learn about existing solutions to [export audit logs to SIEM](../concepts/export-siem.md).
