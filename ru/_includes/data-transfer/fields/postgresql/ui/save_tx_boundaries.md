**{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresTargetAdvancedSettings.save_tx_boundaries.title }}** — включите, чтобы сервис записывал данные в базу-приемник только после полного чтения данных транзакции из базы-источника.

Рекомендуется включать настройку при трансфере из {{ PG }} в {{ PG }}. Это может немного снизить производительность трансфера, но позволит избежать [ошибок](../../../../../data-transfer/operations/endpoint/target/postgresql.md#duplicate-key), связанных с нарушением ограничений.


{% note warning %}

Эта функциональность находится на стадии [Preview](../../../../../overview/concepts/launch-stages.md).

{% endnote %}
