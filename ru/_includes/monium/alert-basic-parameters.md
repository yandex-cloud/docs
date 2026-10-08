* **{{ ui-key.yacloud_monitoring.alert.title_name }}** — произвольное название алерта.
* **{{ ui-key.yacloud_monitoring.header.description.field.id }}** — уникальный идентификатор алерта с префиксом проекта. Если не задан, генерируется автоматически. После создания алерта изменить ID нельзя.
* **{{ ui-key.yacloud_monitoring.alert.title_description }}** — назначение алерта или комментарий.
* **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.severity-level }}** — [уровень критичности алерта](../../monium/concepts/alerting/alert.md#severity). Выбирайте уровень по влиянию события:

    * `Unspecified` — черновик или тест без выбранного уровня.
    * `Disaster` — недоступность сервиса или риск потери данных.
    * `Critical` — деградация сервиса или нехватка ресурсов.
    * `Info` — плановая операция или тестовый алерт.
