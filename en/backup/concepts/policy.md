---
title: Backup policies in {{ backup-full-name }}
description: In this article, you will learn how backup policies in {{ backup-name }} work.
---


# Backup policies


[Resource](./index.md#protected-resources) backups are created in {{ backup-name }} automatically according to _backup policies_.

You can start [creating](../operations/policy-vm/create.md) the policies after you [activate](index.md#providers) {{ backup-name }}.

{% note info %}

You can create or [update](../operations/policy-vm/update.md) a policy using the {{ yandex-cloud }} management console, {{ TF }}, or a [JSON](https://en.wikipedia.org/wiki/JSON) [specification](#specification) via the {{ yandex-cloud }} [CLI](../../cli/quickstart.md) or API.

The {{ yandex-cloud }} management console does not support some parameters from the JSON specification for policies.

{% endnote %}

{% include [default-policies](../../_includes/backup/default-policies.md) %}

By default, resources in {{ backup-name }} are not linked to any backup policies. To start creating backups, [link](./vm-connection/index.md) your resource to one or more policies.

The backup policy specifies:

* Backup type: Full or incremental. For more information, see [{#T}](backup.md#types).

  {% include [av-note](../../_includes/backup/av-note.md) %}

* Schedule type and settings:

    * `{{ ui-key.yacloud.backup.policy-form.value_schedule-type-fixed }}`: Backup frequency in hours, days, weeks, or months. Use [UTC±00:00](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00) time.
    * `{{ ui-key.yacloud.backup.policy-form.value_schedule-type-interval }}`: Interval, in hours or days, between the end of the previous backup and the start of the new one.

* [Backup retention](#retention) settings.

{% include [policy-execute-time](../../_includes/backup/policy-execute-time.md) %}

## Storing backups {#retention}

You can set up backup storage for the policy. For each resource linked to a policy, you can store:

* All backups created under this policy.
* Only the last several backups.
* Only the backups younger than a certain age, e.g., those created during the last few days.

The settings apply to all resources linked to the policy.

{% note info %}

{% include [vm-and-bms-backup-incompatibility](../../_includes/backup/vm-and-bms-backup-incompatibility.md) %}

{% endnote %}

If you make changes to the backup retention rules, by default they will take effect as soon as you create another backup. For more on the backup retention rule settings, see the next section.

## Backup policy specification {#specification}

In {{ backup-name }}, you can [create](../operations/policy-vm/create.md) or [update](../operations/policy-vm/update.md) backup policies based on a specification in [JSON](https://en.wikipedia.org/wiki/JSON) format by using the {{ yandex-cloud }} [command line](../../cli/quickstart.md) or making an API request.

The complete backup policy specification for {{ backup-name }} is detailed below. You can also view the current specification version in the [REST API reference](../backup/api-ref/Policy/create.md).

{% include [full-config](../../_includes/backup/operations/full-config.md) %}

## Use cases {#examples}

* [{#T}](../tutorials/vm-with-backup-policy/index.md)


#### Useful links {#see-also}

* [{#T}](../operations/policy-vm/create.md)
* [{#T}](../operations/policy-vm/attach-and-detach-vm.md)
* [{#T}](../operations/policy-vm/detach-vm.md)
* [{#T}](../operations/policy-vm/update.md)
* [{#T}](../operations/policy-vm/get-info.md)
