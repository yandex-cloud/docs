# Diagnostic logs

Trail diagnostic logs contain records of changes to the status of the [trail](./trail.md) itself.
Diagnostic logs have nothing to do with events occurring to the resources the trail collects [audit logs](./format.md) for.

The trail statuses are as follows:
* `active`: Trail is running and collecting audit logs from the available resources.
* `error`: Possible issues with the trail's destination objects or the trail itself. See [our recommendations](../operations/error.md) on how to recover the trail.

{% note info %}

{% include [error-note](../../_includes/audit-trails/error-note.md) %}

{% endnote %}
