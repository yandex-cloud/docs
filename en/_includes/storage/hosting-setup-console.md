1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you want to configure hosting for.
1. In the left-hand panel, select ![image](../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
1. Navigate to the **{{ ui-key.yacloud.storage.bucket.switch_general-settings }}** tab.
1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** and **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** fields, select `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`.
1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.
1. Select the **{{ ui-key.yacloud.storage.bucket.switch_website }}** tab.
1. Under **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}**:
    * In the **{{ ui-key.yacloud.storage.bucket.website.field_index }}** field, specify the absolute path to the file in the bucket for the website home page, e.g., `index.html`.

      {% include [static-site-index-restriction](static-site-index-restriction.md) %}

    * Optionally, in the **{{ ui-key.yacloud.storage.bucket.website.field_error }}** field, specify the absolute path to the file in the bucket to show for 4xx errors, e.g., `pages/error404.html`. By default, {{ objstorage-name }} returns its own page.
1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

Use the link in **{{ ui-key.yacloud.storage.bucket.website.field_link }}** to check the hosting.
