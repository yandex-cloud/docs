# Getting started with {{ backup-full-name }}

{{ backup-name }} is a service for creating backups and restoring {{ yandex-cloud }} resources and their data.

The service is at the [Preview stage](../overview/concepts/launch-stages.md) and available for [{{ compute-name }} VMs](../compute/concepts/vm.md) running Ubuntu 20.04 or lower installed from [{{ marketplace-name }}](/marketplace).

To get started with {{ backup-name }}:

1. [Request access to the service](#write-to-support).
1. [Activate the service](#activate-provider).
1. [Set up a service account](#prepare-service-account).
1. [Create a VM](#vm-create).
1. [Attach your VM to a backup policy](#add-policy).

## Request access to the service {#write-to-support}

To activate {{ backup-name }}, [request access to the service from the support team]({{ link-console-support }}/create-ticket).

## Activate the service {#activate-provider}

{% note info %}

The minimum folder role required for [activating the service](concepts/index.md#providers) is `backup.editor` (see the [role description](security/index.md#backup-editor)).

{% endnote %}

To activate the service:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to activate the service.
   1. In the list of services, select **{{ backup-name }}**.
   1. Click **Activate**.

{% endlist %}

## Set up a service account {#prepare-service-account}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the service is activated.
   1. Go to the **Service accounts** tab.
   1. Click **Create service account**.
   1. Enter the name of the service account. Name format requirements:

      {% include [name-format](../_includes/name-format.md) %}

   1. Click ![plus-sign](../_assets/plus-sign.svg) **Add role** and select the `backup.editor` [role](security/index.md#backup-editor).
   1. Click **Create**.

{% endlist %}

## Create a VM {#vm-create}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the service is activated.
   1. In the list of services, select **{{ compute-name }}**.
   1. Click **Create VM**.
   1. Under **Basic parameters**:
      1. Enter a name and description for the VM.
      1. Select an [availability zone](../overview/concepts/geo-scope.md) to place the VM in.
   1. Under **Image/boot disk selection**, choose [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts).
   1. Under **Network settings**:
      1. Select the [cloud network](../vpc/concepts/network.md#network) and [subnet](../vpc/concepts/network.md#subnet) to connect the VM to. If you don't have a network, click ![plus-sign](../_assets/plus-sign.svg) **Create network**:
         1. In the resulting window, enter a network name and folder to host the network.
         1. Click **Create**.

         Each network must have at least one subnet. If there is no subnet, create one by selecting ![plus-sign](../_assets/plus-sign.svg) **Add subnet**.
      1. In the **Public address** field, select **Auto**.
      1. Select [appropriate security groups](../vpc/concepts/security-groups.md) (if there is no corresponding field, the VM will be enabled for all incoming and outgoing traffic).
   1. Under **Backup**, select the {{ backup-name }} connection option for your VM.
   1. Under **Access**, specify the information required to access the instance:
      1. Select the service account with the `backup.editor` role.
      1. Enter the username in the **Login** field.
      1. In the **SSH key** field, paste the contents of the public key file.

         You will need to create a key pair for the SSH connection yourself, see [{#T}](../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   1. Click **Create VM**.

{% endlist %}

For more information, see [{#T}](../compute/operations/index.md#vm-create).

## Attach your VM to a {#add-policy} backup policy

When the VM changes to the `Running` status, a {{ backup-name }} agent starts getting installed on it. The installation will take several minutes. After that, you can link your instance to [backup policies](./concepts/policy.md).

To link an instance to a backup policy:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the service is activated.
   1. In the list of services, select **{{ backup-name }}**.
   1. Go to the ![policies](../_assets/backup/policies.svg) **Backup policies** tab.
   1. Select one of the policies created by default.
   1. Under **Virtual machines**, click ![plus-sign](../_assets/plus-sign.svg) **Attach VM**.
   1. Select the appropriate VM and click **Attach**.

{% endlist %}

#### What's next {#what-is-next}

* [Learn about service features](concepts/index.md).
* [See other instructions on how to use the service](operations/index.md).