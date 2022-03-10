# Resuming instance group processes

When resuming, previously paused [update](../../concepts/instance-groups/deploy/), [auto-healing](../../concepts/instance-groups/autohealing.md), and [scaling](../../concepts/instance-groups/policies/scale-policy.md) processes will be resumed in virtual machines, and significant group changes related to the paused processes (such as re-sizing the group or re-configuring instances) will be applied.

To resume processes in an instance group:

{% list tabs %}

- Management console

  1. Open the folder page in the [management console]({{ link-console-main }}).
  1. Select **{{ compute-name }}**.
  1. Go to the **Instance groups** tab.
  1. Select an instance group, click ![image](../../../_assets/horizontal-ellipsis.svg), and select **Resume**.
  1. Confirm the action.

{% endlist %}