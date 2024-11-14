1. In the [management console]({{ link-console-main }}), navigate to the folder the service account belongs to.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
1. In the left-hand panel, select ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
1. Select the service account to create an API key for. [Create](../../iam/operations/sa/create.md) a new service account if you need to.
1. In the top panel, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
1. Enter a description of the key so that you can easily find it in the management console.
1. (Optional) Select **Scope**.
1. (Optional) Specify **Expires at**.
1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
1. Save the ID and private key.

  {% note alert %}

  After you close the dialog, the private key value will become unavailable.

  {% endnote %}