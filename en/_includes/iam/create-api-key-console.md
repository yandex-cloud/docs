1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
1. Choose a service account and click the row with its name. [Create](../../iam/operations/sa/create.md) a new service account if needed.
1. In the top panel, click ![image](../../_assets/plus-sign.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
1. Enter a description of the key so that you can easily find it in the management console.
1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
1. Save the ID and private key.

{% note alert %}

Once you close the dialog, the private key value will be unavailable.

{% endnote %}