{% note warning %}

Once you have created an instance, you cannot change its network configuration, i.e., availability zone and subnet.

{% endnote %}

1. In the management console, select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a [{{ GL }} instance](../../managed-gitlab/concepts/index.md#instance).
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
1. Click **{{ ui-key.yacloud.gitlab.button_create-instance }}**.
1. At the top of the page:

   1. Enter the instance name. It must be unique throughout {{ yandex-cloud }}.

      {% include [name-format](../name-format.md) %}

   1. (Optional) Enter a description of the instance.
   1. (Optional) Add [tags](../../resource-manager/concepts/labels.md) to break instances into logical groups.
   1. (Optional) Set instance protection against accidental deletion by the user.

1. Under **{{ ui-key.yacloud.gitlab.label_configuration-section }}**:

   1. Select the instance type. After you create an instance, you can [change its type](../../managed-gitlab/operations/instance/instance-update.md) to a higher performing one.
   1. Specify the [availability zone](../../overview/concepts/geo-scope.md). After you create an instance, you cannot change its availability zone.
   1. Specify the [subnet](../../vpc/concepts/network.md#subnet) where the instance will be hosted. Currently, {{ yandex-cloud }} technical restrictions do not allow selecting a subnet with the `192.168.0.0/24` address range.

      The [default security group](../../vpc/concepts/security-groups.md#default-security-group) for the selected [network](../../vpc/concepts/network.md#network) will be used for the instance. If you cannot open the {{ GL }} web interface after you create the instance, [configure](../../managed-gitlab/operations/configure-security-group.md) your security group so that the rules allow incoming and outgoing traffic from required ports and IP addresses.

   1. Select the [disk](../../compute/concepts/disk.md) size. After you create an instance, [you can increase](../../managed-gitlab/operations/instance/instance-update.md) its disk size.
   1. Specify the [instance domain name](../../compute/concepts/network.md#hostname): relevant DNS records will be automatically created for it in the `.gitlab.yandexcloud.net` domain.

      The domain name must be unique throughout {{ yandex-cloud }}.

      * Its length must be between 5 and 50 characters.
      * It may contain lowercase Latin letters, numbers, and hyphens.
      * It must not start or end with a dash character.

   1. Set up the retention period for automatic backups (in days).
   1. (Optional) Enable [code approval rules](../../managed-gitlab/concepts/approval-rules.md). To do this, select the appropriate configuration for approval rules.

      {% include [note-approval-rules-pricing](note-approval-rules-pricing.md) %}

1. Under **{{ ui-key.yacloud.gitlab.label_admin-section }}**, specify:
   * **{{ ui-key.yacloud.gitlab.field_admin-email }}**: Email address of the {{ GL }} instance administrator. This mailbox will receive an email with a link for creating a password.
   * **{{ ui-key.yacloud.gitlab.field_admin-login }}**: Administrator login.
1. (Optional) Under **{{ ui-key.yacloud.gitlab.label_additional-section }}**, enable deletion of untagged images. This setting affects the amount of free disk space on the instance.
1. Click **{{ ui-key.yacloud.common.create }}**.
1. Wait for the instance to get ready: its status on the {{ mgl-name }} dashboard will change to **Running**. This may take some time.
