{% if audience == "draft" %}

Configure all security groups in the cluster to allow incoming traffic from those security groups that contain the virtual machine, on port {{ port-mgp }}. To do this, [create a rule](../../../vpc/operations/security-group-update.md#add-rule) for incoming traffic in these groups:

* Protocol: `TCP`.
* Port range: `{{ port-mgp }}`.
* Source type: `Security group`.
* Source: Security group assigned to the VM. If it is the same as the group being configured, specify `Self` (`Self`).

{% else %}

Set up a cluster's security groups so that they allow any incoming and outgoing traffic over any protocol. To do this, [create rules](../../../vpc/operations/security-group-update.md#add-rule) for incoming and outgoing traffic:

* Protocol: `Any` (`Any`).
* Port range: `0-65535`.
* Source type: `CIDR`.
* Source: `0.0.0.0/0`.

{% endif %}
