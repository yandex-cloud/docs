(Optional) Under **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}**, set up the collection of service-level audit logs:

* **Status**: Select `{{ ui-key.yacloud.common.enabled }}`.
* Select the [services](../../audit-trails/concepts/index.md#data-plane-logs) to collect audit logs for.
* For each service you select, specify the audit log collection [scope](../../audit-trails/concepts/trail.md#collecting-area) and objects.

{% include notitle [preview](../note-preview-by-request.md) %}
