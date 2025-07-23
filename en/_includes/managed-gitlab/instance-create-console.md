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

   1. Select the [instance type](../../managed-gitlab/concepts/index.md#config). After you create an instance, you can [change its type](../../managed-gitlab/operations/instance/instance-update.md) to a higher performing one.
   1. Specify the [availability zone](../../overview/concepts/geo-scope.md). After you create an instance, you cannot change its availability zone.
   1. Specify the [subnet](../../vpc/concepts/network.md#subnet) where the instance will be hosted. Currently, {{ yandex-cloud }} technical restrictions do not allow selecting a subnet with the `192.168.0.0/24` address range.
   1. Select a [security group](../../vpc/concepts/security-groups.md) or create a new one:

      1. Click **{{ ui-key.yacloud.component.network-subnet-select.button_create-security-group }}**.
      1. Enter a name and description for the security group. You can add rules for the security group later in **{{ vpc-name }}**.
      1. Click **{{ ui-key.yacloud.common.create }}**.

      {% include [sg-notes](sg-notes.md) %}

   1. Select the [disk](../../compute/concepts/disk.md) size. After you create an instance, [you can increase](../../managed-gitlab/operations/instance/instance-update.md) its disk size.
   1. Specify the [instance domain name](../../compute/concepts/network.md#hostname): relevant DNS records will be automatically created for it in the `.gitlab.yandexcloud.net` domain.

      {% include [domain-name-format](domain-name-format.md) %}

   1. Set up the retention period for automatic backups (in days).
   1. (Optional) Enable [code approval rules](../../managed-gitlab/concepts/approval-rules.md). To do this, select the appropriate configuration for approval rules.

      {% include [note-approval-rules-pricing](note-approval-rules-pricing.md) %}

1. Under **{{ ui-key.yacloud.gitlab.label_admin-section }}**, specify:
   * **{{ ui-key.yacloud.gitlab.field_admin-email }}**: Email address of the {{ GL }} instance administrator. This is the address to receive the email with a link to create a password.
   * **{{ ui-key.yacloud.gitlab.field_admin-login }}**: Administrator login.
1. (Optional) Under **{{ ui-key.yacloud.gitlab.label_additional-section }}**, enable deletion of untagged images. This setting affects the amount of free disk space on the instance.
1. Click **{{ ui-key.yacloud.common.create }}**.
1. Wait for the instance to get ready: its status on the {{ mgl-name }} dashboard will change to **Running**. This may take some time.
