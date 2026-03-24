1. In the [management console]({{ link-console-main }}), navigate to the folder where you want to store your telemetry.
1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
1. Enter a name for the service account, e.g., `monium-ca`.
1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and add `monium.telemetry.writer`.
   If you plan to transfer only particular data types, instead of `monium.telemetry.writer`, select one or more of the following roles: `monium.metrics.writer`, `monium.logs.writer`, and `monium.traces.writer`.

1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
1. Select the account you created from the list.
1. In the top panel, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-scope }}**: `yc.monium.telemetry.write`.
1. Optionally, specify **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-expires-at }}**.
1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
1. Save the secret key for the next step.