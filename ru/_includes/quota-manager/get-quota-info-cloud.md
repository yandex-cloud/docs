1. В [консоли управления]({{ link-console-main }}) выберите облако и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud.dashboard.label_quotas_gAtoT }}**.

1. На вкладке **{{ ui-key.yacloud_components.Quota-manager.label_quotas-tab_323nV }}**:
   
   * Введите в строку поиска название сервиса, название или идентификатор квоты.

   * В группе **{{ ui-key.yacloud_components.Quota-manager.label_quotas-with-usage_dWfzm }}** или **{{ ui-key.yacloud_components.Quota-manager.label_quotas-without-usage_nAfZB }}** раскройте раздел нужного сервиса.

1. В строке квоты посмотрите значение в столбце **{{ ui-key.yacloud_components.Quota-manager.column_usage_jynXV }}**:

   * Два числа — `потребление квоты / значение квоты`. Например, `2 / 20`.
   * Одно число — `лимит`, изменить его нельзя.

1. Чтобы показать только сервисы, в которых квоты близки к исчерпанию, вверху нажмите **{{ ui-key.yacloud_components.Quota-manager.value_usage-status-almost-expired_9NhmR }}**.
