1. In [{{ cloud-center }}]({{ cloud-center-link }}), select an organization and open ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud_org.center.navigation.label_quotas }}** in the left-hand panel.

1. On the **{{ ui-key.yacloud_org.center.quotas.tab_quotas }}** tab:
   
   * In the search bar, enter the service name and the quota name or ID.

   * In the **{{ ui-key.yacloud_components.Quota-manager.label_quotas-with-usage_dWfzm }}** or **{{ ui-key.yacloud_components.Quota-manager.label_quotas-without-usage_nAfZB }}** group, expand the appropriate section.

1. View the **{{ ui-key.yacloud_components.Quota-manager.column_usage_jynXV }}** column value.

   * Two numbers mean `quota usage / quota value`, e.g., `2 / 20`.
   * A single number is a non-adjustable `limit`.

1. To only show services whose quotas are close to being used up, click **{{ ui-key.yacloud_components.Quota-manager.value_usage-status-almost-expired_9NhmR }}** above.
