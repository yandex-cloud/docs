1. In the [management console]({{ link-console-main }}), select the folder where you want to create your registry.
1. [Navigate]({{ link-console-main }}/link/container-registry) to **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
1. Click **{{ ui-key.yacloud.cr.overview.button_create }}**.
1. Name the registry. The naming requirements are as follows:

    {% include [name-format](../name-format.md) %}

1. Optionally, under **{{ ui-key.yacloud.cr.overview.popup-create_field_auto_scan }}**:


    * Disable **{{ ui-key.yacloud.cr.overview.popup-create_scan_push_text }}** to prevent Docker images from being scanned when pushed to the repository.
    * Disable **{{ ui-key.yacloud.cr.overview.popup-create_scan_period_enabled }}** or set the scanning frequency.

      {% include [safe-registry](../container-registry/safe-registry.md) %}

1. Optionally, add labels.
1. Click **{{ ui-key.yacloud.cr.overview.popup-create_button_create }}**.