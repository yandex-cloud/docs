# Configuring security groups

{% note warning %}

You must create and configure security groups before creating an [agent](../concepts/agent.md). This way you can restrict the agent's access.

{% endnote %}

1. [Create](../../vpc/operations/security-group-create.md) a security group.
1. [Add rules](../../vpc/operations/security-group-add-rule.md):

    * One rule each for inbound and outbound traffic:

        * Port range: `{{ port-any }}`.
        * Protocol: `Any`.
        * Source type: `Security group`.
        * Destination: Current security group (`Self`).

    * A separate rule for outgoing HTTPS traffic:

        * Port range: `{{ port-https }}`.
        * Protocol: `TCP`.
        * Source type: `CIDR`.
        * Destination: `0.0.0.0/0`.

        This will enable you to connect the agent to {{ load-testing-name }} to manage tests from the interface and get test results.

If you plan to use multiple security groups for an agent, enable all traffic between these groups.
To assign another security group, [edit](../../compute/operations/vm-control/vm-update.md) the virtual machine network settings in {{ compute-full-name }}.

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

It is important to have security groups properly configured for all subnets hosting traffic-generating agents.

{% endnote %}

