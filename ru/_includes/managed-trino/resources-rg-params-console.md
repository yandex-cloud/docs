1. (Опционально) Выберите родительскую группу.
1. Задайте имя ресурсной группы.

   Имя группы может представлять собой шаблон, использующий подстановки переменных в формате `${<имя_переменной>}`. Имя-шаблон может содержать следующие виды переменных:
   * Встроенные: `USER` — имя пользователя, `SOURCE` — источник запроса.
   * Пользовательские: объявляются в параметрах правил маршрутизации **{{ ui-key.yacloud.trino.ClusterForm.SelectorRulesTable.label_user_3spf1 }}** и **{{ ui-key.yacloud.trino.ClusterForm.SelectorRulesTable.label_source_5knZL }}**.

   При маршрутизации запросов {{ mtr-name }} будет создавать экземпляры группы с динамически сформированными именами.

1. В поле **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupDialogContent.field_max-queued_aj14k }}** задайте максимальное число запросов в очереди (должно быть больше `1`). При достижении этого лимита новые запросы будут отклонены с ошибкой.
1. (Опционально) В поле **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupDialogContent.field_soft-concurrency-limit_j5KQC }}** задайте мягкий лимит на число запущенных запросов. При достижении этого лимита новые запросы будут запускаться в группе, только если соседние группы не могут принимать запросы или превысили свои мягкие лимиты. В противном случае новые запросы будут поставлены в очередь.
1. В поле **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupDialogContent.field_hard-concurrency-limit_hjuBf }}** задайте максимальное число запущенных запросов (должно быть больше `1`). При достижении этого лимита новые запросы будут поставлены в очередь.
1. (Опционально) В поле **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupDialogContent.field_soft-memory-limit_1mATZ }}** задайте максимальный процент доступной памяти, который может использоваться группой. При достижении этого лимита новые запросы будут поставлены в очередь.
1. (Опционально) В поле **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupDialogContent.field_soft-cpu-limit_aUwE5 }}** задайте мягкий лимит процессорного времени. При достижении этого лимита максимальное число запущенных запросов будет снижено до окончания текущего периода расчета квоты CPU. Не может быть больше, чем **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupDialogContent.field_hard-cpu-limit_eeDrV }}**. Чтобы задать **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupDialogContent.field_soft-cpu-limit_aUwE5 }}**, нужно также задать **{{ ui-key.yacloud.trino.ClusterView.label_cpu-quota-period_tD5vD }}**.
1. (Опционально) В поле **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupDialogContent.field_hard-cpu-limit_eeDrV }}** задайте жесткий лимит процессорного времени. При достижении этого лимита новые запросы будут поставлены в очередь. Чтобы задать **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupDialogContent.field_hard-cpu-limit_eeDrV }}**, нужно также задать **{{ ui-key.yacloud.trino.ClusterView.label_cpu-quota-period_tD5vD }}**.
1. (Опционально) В поле **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupDialogContent.field_scheduling-policy_5vhLX }}** задайте [политику планирования запросов](../../managed-trino/concepts/resource-groups.md#policy). Возможные значения: `fair`, `weighted`, `weighted_fair`, `query_priority`. Значение по умолчанию — `none` (действует политика `fair`).
1. (Опционально) В поле **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupDialogContent.field_scheduling-weight_fP1ue }}** задайте вес группы, используемый в политиках планирования `weighted` и `weighted_fair`.

Подробнее о дереве групп в разделе [{#T}](../../managed-trino/concepts/resource-groups.md).
