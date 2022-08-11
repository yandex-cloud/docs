1. In the management console, select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a [{{ GL }} instance](../../managed-gitlab/concepts/index.md#instance).
1. Select **{{ mgl-name }}**.
1. Click **Create instance**.
1. Under **General information**, add:
   1. Enter the instance name. It must be unique throughout {{ yandex-cloud }}.

      {% include [name-foramt](../name-format.md) %}

   1. (Optional) Enter a description of the instance.
1. Under **Configuration**:
   1. Select the instance type.
   1. Specify the [subnet](../../vpc/concepts/network.md#subnet) where the instance will be hosted.

      {% note warning %}

      The [default security group](../../vpc/concepts/security-groups.md#default-security-group) for the selected [network](../../vpc/concepts/network.md#network) will be used. You can't create a different security group when creating an instance. You might need to [set up](../../managed-gitlab/operations/connect.md#configuring-security-groups) this default security group to establish a connection.

      {% endnote %}

   1. Select the [disk](../../compute/concepts/disk.md) size.
   1. Specify the [instance domain name](../../compute/concepts/network.md#hostname): relevant DNS records will be created for it in the `.gitlab.yandexcloud.net` domain.

      The domain name must be unique throughout {{ yandex-cloud }}.
      * Its length must be between 5 and 50 characters.
      * It may contain lowercase Latin letters, numbers, and hyphens.
      * It must not begin or end with a dash character.
   1. Set up the retention period for automatic backups (in days).
1. In the **Administrator Data** block specify:
   * **Email**: The email address of the {{ GL }} instance administrator. This mailbox will receive an email with a link for creating a password.
   * **Login**: The administrator's login.
1. Click **Create**.
1. Wait for the instance to get ready: its status on the {{ mgl-name }} dashboard will change to **Running**. This may take some time.