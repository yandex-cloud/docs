1. (Опционально) В поле **{{ ui-key.yacloud.trino.ClusterForm.SelectorRulesTable.label_user_3spf1 }}** задайте имя пользователя, отправившего запрос, или регулярное выражение Java. Правило срабатывает, если имя пользователя соответствует регулярному выражению. Если параметр не указан, правило срабатывает для запросов от любых пользователей.
1. (Опционально) В поле **{{ ui-key.yacloud.trino.ClusterForm.SelectorRulesTable.label_user-group_qRK1P }}** задайте имя группы пользователя, отправившего запрос, или регулярное выражение Java. Правило срабатывает, если имя группы пользователя соответствует регулярному выражению. Если параметр не указан, правило срабатывает для запросов пользователей любых групп.
1. (Опционально) В поле **{{ ui-key.yacloud.trino.ClusterForm.SelectorRulesTable.label_query-type_69gwq }}** выберите тип запроса. Возможные значения:
   * `SELECT` — запросы `SELECT`.
   * `EXPLAIN` — запросы `EXPLAIN`, кроме `EXPLAIN ANALYZE`.
   * `DESCRIBE` — запросы `DESCRIBE`, `DESCRIBE INPUT` и `DESCRIBE OUTPUT`, а также запросы `SHOW` (например, `SHOW CATALOGS` или `SHOW SCHEMAS`).
   * `INSERT` — запросы `INSERT`, `CREATE TABLE AS` и `REFRESH MATERIALIZED VIEW`.
   * `MERGE` — запросы `MERGE`.
   * `DELETE` — запросы `DELETE`.
   * `ANALYZE` — запросы `ANALYZE`.
   * `DATA_DEFINITION` — запросы `CREATE`, `ALTER` и `DROP` для схем, таблиц, представлений и материализованных представлений, а также запросы управления подготовленными выражениями, правами доступа, сессиями и транзакциями.
   * `ALTER_TABLE_EXECUTE` — запросы вида `ALTER TABLE ... EXECUTE`.

1. (Опционально) В поле **{{ ui-key.yacloud.trino.ClusterForm.SelectorRulesTable.label_source_5knZL }}** задайте имя источника запроса или регулярное выражение Java. Правило срабатывает, если имя источника запроса соответствует регулярному выражению. Если параметр не указан, правило срабатывает для запросов из любых источников.
1. В поле **{{ ui-key.yacloud.trino.ClusterForm.SelectorRulesTable.label_resource-group_qjdHa }}** выберите ресурсную группу, в которой будет запущен запрос. Целевая группа не может иметь дочерних групп.
1. (Опционально) В поле **{{ ui-key.yacloud.trino.ClusterForm.SelectorRulesTable.label-client-tags_eyQNn }}** укажите теги через запятую. Правило срабатывает, только если запрос содержит все указанные теги. Если параметр не указан, правило срабатывает для запросов с любыми тегами.

{% note warning %}

Запрос, не соответствующий ни одному заданному правилу, отклоняется с ошибкой. Чтобы этого не происходило, добавьте в конец описания правило без ограничивающих условий, содержащее только параметр **{{ ui-key.yacloud.trino.ClusterForm.SelectorRulesTable.label_resource-group_qjdHa }}**.

{% endnote %}

Подробнее о правилах маршрутизации в разделе [{#T}](../../managed-trino/concepts/resource-groups.md).
