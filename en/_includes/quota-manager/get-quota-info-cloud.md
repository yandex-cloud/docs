1. In the [management console]({{ link-console-main }}), select a cloud and navigate to ![image](../../_assets/console-icons/square-plus.svg)**{{ ui-key.yacloud.dashboard.label_quotas_gAtoT }}** in the left-hand panel.

1. On the **{{ ui-key.yacloud_components.Quota-manager.label_quotas-tab_323nV }}** tab:
   
   * In the search bar, enter the service name and the quota name or ID.

   * In the **{{ ui-key.yacloud_components.Quota-manager.label_quotas-with-usage_dWfzm }}** or **{{ ui-key.yacloud_components.Quota-manager.label_quotas-without-usage_nAfZB }}** group, expand the appropriate section.

1. View the quota value in the **{{ ui-key.yacloud_components.Quota-manager.column_usage_jynXV }}** column.

   * Two numbers mean `quota usage / quota value`, e.g., `2 / 20`.
   * A single number is a non-adjustable `limit`.

1. To only show services whose quotas are close to being used up, click **{{ ui-key.yacloud_components.Quota-manager.value_usage-status-almost-expired_9NhmR }}** above.
