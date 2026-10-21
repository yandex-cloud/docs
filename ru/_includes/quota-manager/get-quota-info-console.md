1. Выберите облако в [консоли управления]({{ link-console-main }}) или организацию в [{{ cloud-center }}]({{ cloud-center-link }}).

1. На панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud.dashboard.label_quotas_gAtoT }}**.

1. На вкладке **{{ ui-key.yacloud_org.center.quotas.tab_quotas }}** введите в строку поиска название сервиса, название или идентификатор квоты.

1. Раскройте нужный сервис в одной из групп:

   * **{{ ui-key.yacloud_components.Quota-manager.label_quotas-with-usage_dWfzm }}** — потребление хотя бы одной квоты больше нуля.
   * **{{ ui-key.yacloud_components.Quota-manager.label_quotas-without-usage_nAfZB }}** — потребление всех квот равно нулю.

1. В строке квоты посмотрите столбец **{{ ui-key.yacloud_components.Quota-manager.column_usage_jynXV }}**:

   * Числа — [потребление квоты](*quota-usage) / [значение квоты](*quota-limit).
   * **{{ ui-key.yacloud_components.Quota-manager.label_quota-empty_vNSZR }}** — значение квоты не установлено.

1. Чтобы показать только сервисы, в которых квоты близки к исчерпанию, вверху нажмите **{{ ui-key.yacloud_components.Quota-manager.value_usage-status-almost-expired_9NhmR }}**.

Если квоты близки к исчерпанию или не выделены, на этой же странице можно [запросить их изменение](../../quota-manager/operations/set-quotas.md#request-quota-change).
