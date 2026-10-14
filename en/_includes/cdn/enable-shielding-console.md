1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.
1. [Navigate]({{ link-console-main }}/link/cdn) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
1. Click the resource name.
1. Navigate to the ![image](../../_assets/console-icons/file.svg) **{{ ui-key.yacloud.cdn.label_shielding }}** tab.
1. To activate origin shielding, in the top-right corner, click ![image](../../_assets/console-icons/power.svg) **{{ ui-key.yacloud.cdn.button_activate-shielding }}**.
1. In the **{{ ui-key.yacloud.cdn.label_shielding-settings-title }}** window, select the required location in the **{{ ui-key.yacloud.cdn.label_shielding-location }}** field.
1. Click **{{ ui-key.yacloud.cdn.button_activate-shielding }}**.

Once enabled, the shielding status will change from `Not activated` to `Active`.

{% note tip %}

Similarly, you can disable origin shielding. To do this, on the ![image](../../_assets/console-icons/file.svg) **{{ ui-key.yacloud.cdn.label_shielding }}** tab, click ![image](../../_assets/console-icons/square-xmark.svg) **{{ ui-key.yacloud.cdn.button_deactivate-shielding }}** in the top-right corner of the resource page.

Once disabled, the shielding status will change from `Active` to `Not activated`.

{% endnote %}
