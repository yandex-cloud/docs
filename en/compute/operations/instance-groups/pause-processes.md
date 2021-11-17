# Pausing instance group processes

If you want to temporarily disable the [update](../../concepts/instance-groups/deploy/), [auto-healing](../../concepts/instance-groups/autohealing.md), and [scaling](../../concepts/instance-groups/policies/scale-policy.md) of instances in a group, pause them. This will not stop the actual virtual machines.

To pause processes in an instance group:

{% list tabs %}

- Management console

  1. Open the folder page in the management console.
  1. Select **{{ compute-full-name }}**.
  1. On the **Virtual machines** page, go to the **Instance groups** tab.
  1. Select an instance group, click ![image](../../../_assets/horizontal-ellipsis.svg), and select **Pause**.
  1. Confirm the action.

{% endlist %}