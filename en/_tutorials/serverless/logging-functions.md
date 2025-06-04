# Configuring responses in {{ cloud-logging-full-name }} and {{ sf-full-name }}


You can configure [{{ sf-name }}](../../functions/) to automatically respond to audit log events, e.g., to send messages through notification channels you prefer or automatically modify {{ yandex-cloud }} resource settings.

## How it works {#scheme}

In general, you will need the following components to configure responses via {{ sf-name }}:

1. Trail that uploads [audit logs to a log group](../../audit-trails/operations/create-trail.md).
1. [Log group](../../logging/concepts/log-group.md) that acts as an interface between the trail and a {{ sf-name }} trigger.
1. [{{ cloud-logging-full-name }}](../../functions/concepts/trigger/cloud-logging-trigger.md) trigger that invokes a function when adding a record to a log group.
1. [{{ sf-name }}](../../functions/concepts/function.md) function that implements the response logic.
1. Optional auxiliary component, such as a Telegram bot or mail server.
 
## Implementation example {#example}

[Yc-security-solutions-library](https://github.com/yandex-cloud-examples/yc-security-solutions-library) contains a [solution](https://github.com/yandex-cloud-examples/yc-audit-trails-automatic-response) example that uses {{ sf-name }} to notify of specific events via a Telegram bot and modify {{ yandex-cloud }} resources in line with changes using API methods.

You can get notifications of the following events:

* Security groups: Allowing incoming traffic to all private addresses (`0.0.0.0/0`).
* {{ objstorage-name }}: Enabling public access to buckets.
* {{ lockbox-name }}: Assigning permissions to a secret. 

The following actions may be performed on {{ yandex-cloud }} resources:

* Security groups: Deleting the rule.
* {{ lockbox-name }}: Removing assigned permissions to the secret.

{% include [Yc-security-solutions-library](../../_includes/security-solution-library.md) %}

This solution contains the source codes of a Python function and a {{ TF }} script that configures all the required {{ yandex-cloud }} components.

## What's next {#whats-next}

* Learn more about the [audit log format](../../audit-trails/concepts/format.md).
* Learn about existing solutions to [export audit logs to SIEM](../../audit-trails/concepts/export-siem.md).
