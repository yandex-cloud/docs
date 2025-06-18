1. In the [management console]({{ link-console-main }}), select the folder where you want to create a registry.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
1. Click **{{ ui-key.yacloud.cr.overview.button_create }}**.
1. Specify a name for the registry. Follow these naming requirements:

    {% include [name-format](../name-format.md) %}

1. Optionally, under **{{ ui-key.yacloud.cr.overview.popup-create_field_auto_scan }}**:


    * Disable **{{ ui-key.yacloud.cr.overview.popup-create_scan_push_text }}** to skip scanning of Docker images at their upload to the repository.
    * Disable **{{ ui-key.yacloud.cr.overview.popup-create_scan_period_enabled }}** or set the scanning frequency.

      {% include [safe-registry](../container-registry/safe-registry.md) %}

1. Optionally, add labels.
1. Click **{{ ui-key.yacloud.cr.overview.popup-create_button_create }}**.