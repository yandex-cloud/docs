# Local issue fields

If you want to add a new issue parameter that isn't already an existing field in {{ tracker-name }}, you can add local fields to your queue.

{% note info %}

See the list of available fields on the [{{ tracker-name }} settings](https://st.yandex-team.ru/admin/fields) page.

{% endnote %}

You can only use a local field for issues in the queue that the field is linked to. The advantage of local fields is that the queue owner can manage them without the risk of affecting the workflow in other queues. Users working in other queues won't see this field in their issues.

## Local field constraints {#restrictions}

#### Where you can use local fields

- On the issue page: you can [use](user/edit-ticket.md#section_jqw_ppn_jz) local fields the same way you use standard issue fields.

- In issue filters: you can specify a local field in [filter parameters](user/create-filter.md) or in the [query language](user/query-filter.md#local_fields) if the queue that the field is linked to is set.

#### Where you can't use local fields

Local fields are temporarily not supported in some issue use scenarios. Support for these scenarios will be added later.

- Local fields are not displayed in [cards on issue boards](manager/edit-agile-board.md#sec_layout).

- You can't use local fields in [triggers](user/trigger.md), [auto actions](user/autoactions.md), [macros](manager/create-macroses.md), [SLA rules](sla-head.md), and [status transition functions](manager/workflow-action-edit.md).

- You can't edit the values of local fields using [bulk change operations](manager/bulk-change.md).

- You can't use the [API](user/API.md) to edit local field values.

- Local fields are not exported to YT.

#### Moving and cloning issues

When you [move](user/edit-ticket.md#section_xwx_qpn_jz) or [clone](user/clone.md) issues with local fields to a different queue, the local field values are automatically deleted.

## Adding a local field {#add}

Submit a request to add a new field using the form below. In the comments, write that you want to add a local field.

Requests are processed within 2-3 business days. If the issue is urgent, increase its priority to <q>critical</q> and write in the comments why it's urgent.

