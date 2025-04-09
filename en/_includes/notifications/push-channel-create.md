
1. In the [management console]({{ link-console-main }}), select the folder you want to create a notification channel in.
1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
1. Click **{{ ui-key.yacloud.cns.action_create-channel }}**.
1. Select a sending platform in the **{{ ui-key.yacloud.cns.type_mobile }}** tab:

    * `{{ ui-key.yacloud.cns.select_apns-title }}`: For iOS devices.
    * `{{ ui-key.yacloud.cns.select_gcm-title }}`: For Android devices with Google Play services installed.
    * `{{ ui-key.yacloud.cns.select_hms-title }}`: For Android devices with Huawei services installed.
    * `{{ ui-key.yacloud.cns.select_ru-store-title }}`: For Android devices with the RuStore app marketplace installed.

1. Depending on the platform you select, set the authentication parameters:

    {% include [push-channel-platforms-params.md](push-channel-platforms-params.md) %}

1. Enter the notification channel **{{ ui-key.yacloud.cns.field_channel-name }}**. Channel names are unique within the entire {{ cns-short-name }}. It may contain lowercase and uppercase Latin letters, numbers, underscores, hyphens, and periods. It may be from 1 to 256 characters long. For APNs channels, we recommend specifying the bundle ID in the name; for FCM and HMS, the full package name; for RuStore, `packageName`.
1. Optionally, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.cns.button_add-description }}** and enter a description for your notification channel.
1. Click **{{ ui-key.yacloud.common.create }}**.
