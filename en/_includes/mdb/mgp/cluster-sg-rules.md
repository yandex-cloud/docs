{% if audience == "draft" %}

Configure all security groups in the cluster to allow incoming traffic from the security group where the VM is located, on port {{ port-mgp }}. To do this, [create a rule](../../../vpc/operations/security-group-add-rule.md) for incoming traffic in these groups:

* Port range: `{{ port-mgp }}`.
* Protocol: `TCP`.
* Source: `Security group`.
* Security group: If a cluster and a VM are in the same security group, select `Self` (`Self`) as the value. Otherwise, specify the VM security group.

{% else %}

Set up a cluster's security groups so that they allow any incoming and outgoing traffic over any protocol. To do this, {% if audience != "internal" %}[create rules](../../../vpc/operations/security-group-add-rule.md){% else %}create rules{% endif %} for incoming and outgoing traffic:

* Port range: `{{ port-any }}`.
* Protocol: `Any`.
* Source: `CIDR`.
* CIDR blocks: `0.0.0.0/0`.

{% endif %}
