* **{{ ui-key.yacloud_monitoring.alert.title_name }}**: Alert name.
* **ID**: Unique alert ID with the project's prefix. By default, it matches the name.
* **{{ ui-key.yacloud_monitoring.alert.title_description }}**: Alert description or comment.
* **Alert level**: [Alert severity level](../../monium/concepts/alerting/alert.md#severity). Select it based on the event effect:

    * `Unspecified`: Draft or a test without a level.
    * `Disaster`: Service unavailability or data loss risk.
    * `Critical`: Service degradation or lack of resources.
    * `Info`: Scheduled operation or a test alert.