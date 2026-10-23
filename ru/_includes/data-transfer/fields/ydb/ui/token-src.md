**{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.token.title }}** — [OAuth-токен](https://ydb.yandex-team.ru/docs/getting_started/auth), с помощью которого сервис {{ data-transfer-name }} будет подключаться к базе.

Пользователь, владеющий токеном, должен иметь следующие [права](https://ydb.yandex-team.ru/docs/getting_started/start_auth):
  * `read` для трансфера типа  {{ dt-type-copy }}, если опция **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbShardedSnapshotSettings.is_snapshot_sharded.title }}** выключена.
  * `read` для трансфера типа  {{ dt-type-copy-repl }}, если в поле **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.YdbSourceAdvancedSettings.changefeed_settings.title }}** выбрана опция **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.changefeed_settings.custom_feed.title }}**.
  * `write` или `full` в остальных случаях.

{% note info %}

Рекомендуется использовать [токены роботов](../../../../../data-transfer/api-ref/authentication.md), а не личные токены.

{% endnote %}
