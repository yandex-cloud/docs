# Updating a backup policy

## Changing basic settings {#update-basic-parameters}

To change the basic settings of a [backup policy](../../concepts/policy.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to change the policy.
   1. In the list of services, select **{{ backup-name }}**.
   1. Go to the ![policies](../../../_assets/backup/policies.svg) **Backup policies** tab.
   1. Next to the policy you wish to change, click ![options](../../../_assets/options.svg) and select **Edit**.
   1. Edit the policy parameters:

      {% include [policy-options](../../../_includes/backup/policy-options.md) %}

   1. Click **Save**.

{% endlist %}

## Updating a list of VMs {#update-vm-list}

To update the list of VMs whose backups are created under the current policy:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the policy is located.
   1. In the list of services, select **{{ backup-name }}**.
   1. Go to the ![policies](../../../_assets/backup/policies.svg) **Backup policies** tab.
   1. Select the policy to update the list of VMs for.
   1. Update the VM list:
      * To add a new VM, click ![image](../../../_assets/plus-sign.svg) **Attach VM** under **Virtual machines**. In the window that opens, choose the VM to add to the policy and click **Save**.
      * To remove a VM, under **virtual machines**, click ![options](../../../_assets/options.svg) next to the VM to be detached from the policy and select **Detach from policy**.

{% endlist %}

#### See also {#see-also}

* [{#T}](delete.md)
