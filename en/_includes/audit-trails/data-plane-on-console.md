Check **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}** and adjust the settings if required:

  {% include [events-by-default](./events-by-default.md) %}

  * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}**: `{{ ui-key.yacloud.common.enabled }}`.
  * Select the [services](../../audit-trails/concepts/events-data-plane.md) to collect audit logs for.
  * For each service you select, specify the audit log collection [scope](../../audit-trails/concepts/trail.md#collecting-area) and event filter type:

      * `Receive all`: To receive all events within the service.
      * `Selected`: To receive only the selected events. Then proceed to select the [events](../../audit-trails/concepts/events-data-plane.md#dns).
      * `Exclude`: To receive all events except for the selected ones. Then proceed to select the events.
