To enable access from Nextcloud to the {{ objstorage-name }} bucket, create a [service account](../../../iam/concepts/users/service-accounts.md) and [static access key](../../../iam/concepts/authorization/access-key.md).

1. Create a service account:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Enter a name for the service account: `nextcloud-sa`.
      1. Click ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select [`editor`](../../../iam/roles-reference.md#editor).
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

    {% endlist %}

1. Create a static access key:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. In the left-hand panel, select ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** and select the `nextcloud-sa` service account you created earlier.
      1. In the top panel, click ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
      1. Save the ID and secret key.

          {% note alert %}

          After you close this dialog, the key value will no longer be available.

          {% endnote %}

    {% endlist %}