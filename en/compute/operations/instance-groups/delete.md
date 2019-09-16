# Delete an instance group

{% note important %}

Deleting an instance group is an operation that cannot be canceled or reversed. You cannot restore a deleted group. Along with the group, you delete the {{ load-balancer-name }} target group, instances, and disks.

{% endnote %}

To delete an instance group:

{% list tabs %}

- Management console
  
  1. Open the folder page in the management console.
  1. Select **{{ compute-full-name }}**.
  1. On the **Virtual machines** page, go to the **Instance groups** tab.
  1. Click ![image](../../../_assets/vertical-ellipsis.svg) for the group you want to delete and select **Delete**.
  
- CLI
  
  {% include [cli-install.md](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}
  
  1. See the description of the CLI's delete instance group command:
  
      ```
      $ yc compute instance-group delete --help
      ```
  
  1. Get a list of instance groups in the default folder:
  
      {% include [instance-group-list](../../../_includes/instance-groups/instance-group-list.md) %}
  
  1. Select the `ID` or `NAME` of the necessary group (for example, `first-instance-group`).
  
  1. Delete the instance group:
  
      ```
      $ yc compute instance-group delete --name first-instance-group
      ```
  
      {{ ig-name }} starts the operation to delete the instance group.
  
- API
  
  Use the [delete](../../../_api-ref/compute/api-ref/InstanceGroup/delete.md) API method.
  
  To request a list of available groups, use the [listInstances](../../../_api-ref/compute/api-ref/InstanceGroup/listInstances.md) method.
  
{% endlist %}

