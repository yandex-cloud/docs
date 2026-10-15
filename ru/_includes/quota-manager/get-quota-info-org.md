1. В [{{ cloud-center }}]({{ cloud-center-link }}) выберите организацию и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud_org.center.navigation.label_quotas }}**.

1. На вкладке **{{ ui-key.yacloud_org.center.quotas.tab_quotas }}**:
   
   * Введите в строку поиска название сервиса, название или идентификатор квоты.

   * В группе **{{ ui-key.yacloud_components.Quota-manager.label_quotas-with-usage_dWfzm }}** или **{{ ui-key.yacloud_components.Quota-manager.label_quotas-without-usage_nAfZB }}** раскройте раздел нужного сервиса.

1. Посмотрите значение в столбце **{{ ui-key.yacloud_components.Quota-manager.column_usage_jynXV }}**:

   * Два числа — `потребление квоты / значение квоты`. Например, `2 / 20`.
   * Одно число — `лимит`, изменить его нельзя.

1. Чтобы показать только сервисы, в которых квоты близки к исчерпанию, вверху нажмите **{{ ui-key.yacloud_components.Quota-manager.value_usage-status-almost-expired_9NhmR }}**.
