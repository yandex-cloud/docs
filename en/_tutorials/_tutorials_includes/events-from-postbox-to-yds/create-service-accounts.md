1. Create a `yds-functions` service account:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you are going to create your infrastructure.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}** and click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** field, enter `yds-functions` for name.
      1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `yds.editor` and `{{ roles-functions-invoker }}` [roles](../../../iam/concepts/access-control/roles.md).
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

    {% endlist %}

1. Similarly, create a service account named `postbox-user` and assign the `postbox.sender` [role](../../../postbox/security/index.md#postbox-sender) to it.