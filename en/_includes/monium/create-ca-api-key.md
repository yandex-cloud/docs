1. In the [management console]({{ link-console-main }}), navigate to the folder where you want to store your telemetry.
1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
1. Enter a name for the service account, e.g., `monium-sa`.
1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and add the `monium.telemetry.writer` [role](../../monium/security/index.md#monium-telemetry-writer).

    If you plan to transfer only particular data types, instead of `monium.telemetry.writer`, select one or more roles with narrower sets of permissions: `monium.metrics.writer`, `monium.logs.writer`, `monium.traces.writer`.
1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
1. In the list that opens, select the service account you created.
1. In the top panel, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-scope }}** for `yc.monium.telemetry.write`.

    If you plan to transfer only particular data types, instead of `yc.monium.telemetry.write`, select one or more narrower [scopes](../../iam/concepts/authorization/api-key.md#scoped-api-keys): `yc.monium.metrics.write`, `yc.monium.logs.write`, `yc.monium.traces.write`.
1. Optionally, set **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-expires-at }}** for the new API key.
1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
1. Save the secret key you got for the next step.

    After you close the window, you will not be able to view the secret key again.
