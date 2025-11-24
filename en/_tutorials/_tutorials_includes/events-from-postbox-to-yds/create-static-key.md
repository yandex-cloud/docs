Create a [static access key](../../../iam/concepts/authorization/access-key.md) to use for sending emails:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}** and then select `postbox-user` from the list of service acounts. In the window that opens, do the following:

      1. In the top panel, click ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
      1. Save the ID and secret key.

          {% note alert %}

          After you close this dialog, the key value will no longer be available.

          {% endnote %}

{% endlist %}