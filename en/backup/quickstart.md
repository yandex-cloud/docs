# Getting started with {{ backup-name }}

{{ backup-name }} is a service for creating backups and restoring {{ yandex-cloud }} resources and their data.

{{ backup-name }} supports backing up [{{ compute-name }} VMs](../compute/concepts/vm.md) running Ubuntu, CentOS, and Windows Server. For more information, see [{#T}](concepts/vm-connection.md#os).

To get started with {{ backup-name }}:
1. [Activate the service](#activate-provider).
1. [Set up a service account](#prepare-service-account).
1. [Create a VM](#vm-create).
1. [Link your VM to a backup policy](#add-policy).

## Activate the service {#activate-provider}

{% note info %}

The minimum [folder](../resource-manager/concepts/resources-hierarchy.md#folder) role required for [activating the service](concepts/index.md#providers) is `backup.editor` (see the [role description](security/index.md#backup-editor)).

{% endnote %}

To activate the service:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to activate the service.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
   1. Click **{{ ui-key.yacloud.backup.button_action-activate }}**.

{% endlist %}

## Set up a service account {#prepare-service-account}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the service is activated.
   1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter a name for the [service account](../iam/concepts/users/service-accounts.md). The name format requirements are as follows:

      {% include [name-format](../_includes/name-format.md) %}

   1. Click ![plus-sign](../_assets/plus-sign.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `backup.editor` [role](security/index.md#backup-editor).
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Create a VM {#vm-create}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the service is activated.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../_assets/compute/vm-pic.svg) **{{ ui-key.yacloud.compute.switch_instances }}** and click **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
      1. Enter a name and description for the VM.
      1. Select an [availability zone](../overview/concepts/geo-scope.md) to place your VM in.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts).
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
      1. Select the [cloud network](../vpc/concepts/network.md#network) and [subnet](../vpc/concepts/network.md#subnet) to connect the VM to. If you do not have a network, click ![plus-sign](../_assets/plus-sign.svg) **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}**:
         1. In the window that opens, enter the network name and specify the folder to host the network.
         1. Click **{{ ui-key.yacloud.component.vpc.create-network-dialog.button_create }}**.

            Each network must have at least one subnet. If there is no subnet, create one by selecting ![plus-sign](../_assets/plus-sign.svg) **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
      1. Set up [network access](concepts/vm-connection.md#vm-network-access) for your VM.
   1. Under **{{ ui-key.yacloud.compute.instances.create.label_backup }}**, select the {{ backup-name }} connection option for your VM.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the instance:
      1. Select the service account with the `backup.editor` role.
        1. Enter the username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
      1. In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the public key file.

         You will need to create a key pair for the SSH connection yourself, see [{#T}](../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

For more information, see [{#T}](../compute/operations/index.md#vm-create).

## Link your VM to a backup policy {#add-policy}

{% include [agent-installation-timespan](../_includes/backup/agent-installation-timespan.md) %}

1. Make sure the {{ backup-name }} agent has been installed:

    {% list tabs %}

    - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where the service is activated.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. Select the appropriate VM.
      1. Check that the value of the **{{ ui-key.yacloud.backup.field_vm-instances }}** field in the **{{ ui-key.yacloud.backup.title_backup }}** section is `{{ ui-key.yacloud.backup.label_create }}`.

   {% endlist %}

   {% include [vm-list](../_includes/backup/vm-list.md) %}

   {% include [agent-installation-failure](../_includes/backup/agent-installation-failure.md) %}

1. Link your VM to a backup policy:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where the service is activated.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
      1. Go to the ![policies](../_assets/backup/policies.svg) **{{ ui-key.yacloud.backup.label_policies }}** tab.
      1. Select one of the policies created by default.
      1. Under **{{ ui-key.yacloud.backup.label_linked-instances }}**, click ![plus-sign](../_assets/plus-sign.svg) **{{ ui-key.yacloud.backup.button_attach-instance }}**.
      1. Select the appropriate VM and click **{{ ui-key.yacloud.backup.button_attach-instance-submit }}**.

   {% endlist %}

   You can also link your VM to a backup policy in {{ compute-name }}:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where the service is activated.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. Select the appropriate VM.
      1. Under **{{ ui-key.yacloud.backup.title_backup }}**, in the **{{ ui-key.yacloud.backup.label_policies }}** field, click **{{ ui-key.yacloud.common.select }}**.
      1. Select one of the policies created by default and click **{{ ui-key.yacloud.common.save }}**.

   {% endlist %}

#### What's next {#what-is-next}

* [Learn about service features](concepts/index.md).
* [See other instructions on how to use the service](operations/index.md).