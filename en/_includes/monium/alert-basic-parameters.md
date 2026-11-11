* **{{ ui-key.yacloud_monitoring.alert.title_name }}**: Alert name.
* **{{ ui-key.yacloud_monitoring.header.description.field.id }}**: Unique alert ID with the project's prefix. If not set, it is generated automatically. Once the alert is created, you cannot change its ID.
* **{{ ui-key.yacloud_monitoring.alert.title_description }}**: Alert description or comment.
* **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.severity-level }}**: [Alert criticality level](../../monium/concepts/alerting/alert.md#severity). Select it based on the event effect:

    * `Unspecified`: Draft or a test without a level.
    * `Disaster`: Service unavailability or data loss risk.
    * `Critical`: Service degradation or lack of resources.
    * `Info`: Scheduled operation or a test alert.
