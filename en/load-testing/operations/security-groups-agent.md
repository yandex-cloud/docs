# Set up the test agent's security group

{% note warning %}

You must create and configure security groups before creating an [agent](../concepts/agent.md). This way you can restrict the agent's access.

{% endnote %}

{% include [security-groups-agent](../../_includes/load-testing/security-groups-agent.md) %}

If you plan to use multiple security groups for an agent, enable all traffic between these groups.
To assign another security group, [edit](../../compute/operations/vm-control/vm-update.md) the virtual machine network settings in {{ compute-full-name }}.

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

It is important to have security groups properly configured for all subnets hosting traffic-generating agents.

{% endnote %}
